module Profiler
  class FlatPrinter < AbstractPrinter
    private

    def print_result(options)
      string = result_to_string
      options[:output].puts(string)
    end

    def result_to_string
      lines = []
      lines << get_header
      lines += get_body
      lines << get_footer
      lines.join("\n")
    end

    def get_header
      columns_to_line([
        'Time',
        'Calls',
        'Path'
      ])
    end

    def get_body
      column_lengths = get_column_lengths
      result.paths_durations.map do |path, duration|
        count = result.paths_counts[path]
        columns = [
          duration.round(5),
          count,
          path_to_displayed_path(path)
        ]
        columns_to_line(columns)
      end
    end

    def get_footer
      ["Total time: #{result.paths_durations.values.reduce(&:+)}"]
    end

    def columns_to_line(columns)
      columns = columns.map.with_index do |column, index|
        column.to_s.ljust(column_lengths[index])
      end
      columns.join(' ')
    end

    def column_lengths
      @column_lengths ||= get_column_lengths
    end

    def get_column_lengths
      [
        9,
        5,
        get_longest_path_length + 1
      ]
    end

    def get_longest_path_length
      result.paths_durations.keys.map { |path| path_to_displayed_path(path).length }.sort.last
    end

    # For example, convert 'results_html_haml___3582891738431186295_70358606312040' to 'results_html_haml'
    def path_to_displayed_path(path)
      path.gsub(/___[\d_]+/, '')
    end
  end
end
