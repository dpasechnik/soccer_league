class ImportDataService
  GOALS_AGAINST_COLUMN = 8
  GOALS_FOR_COLUMN = 6
  TEAM_NAME_COLUMN = 1

  # @return [String]
  attr_reader :file_name

  # @return [void]
  def initialize(file_name)
    @file_name = file_name
  end

  def perform
    raise Error::NoFile, "Unable to find file `#{file_name}` in `lib/data`" unless File.exist?(file_path)

    LeagueResult.transaction do
      goals_info.each { |info| LeagueResult.find_or_create_by!(info) }
    end
  end

  private

  # @return [Integer]
  def goals_difference(row)
    (goals_number_for(row) - goals_number_against(row)).abs
  end

  # @return [File]
  def file_content
    @file_content ||= File.open(file_path, 'r').read.split("\n")
  end

  # @return [Array]
  def goals_info
    @goals_info ||= begin
      valid_rows = file_content.select { |row| valid_entry?(row) }

      valid_rows.map do |row|
        { goals_against: goals_number_against(row), goals_for: goals_number_for(row), goals_difference: goals_difference(row), team_name: team_name(row) }
      end
    end
  end

  # @return [String]
  def file_path
    @file_path ||= File.join('lib/data', file_name)
  end

  # @return [Integer]
  def goals_number_against(row)
    row.split[GOALS_AGAINST_COLUMN].to_i
  end

  # @return [Integer]
  def goals_number_for(row)
    row.split[GOALS_FOR_COLUMN].to_i
  end

  # @return [String]
  def team_name(row)
    row.split[TEAM_NAME_COLUMN]
  end

  # @return [Boolean]
  def valid_entry?(row)
    row.split[0][-1] == '.'
  end
end