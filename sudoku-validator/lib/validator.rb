class Validator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    @puzzle_string = @puzzle_string.delete("-+| ")
    sudoku = []
    sub_arr = []

    complete = true

    #pārveido .sudoku failu par masīvu
    @puzzle_string.split('').each {|item|
      if item == "\n"
        if sub_arr.length != 0
          sudoku.push(sub_arr)
          sub_arr = []
        end
        next
      else
        sub_arr.push(item)
      end
    }

    #pārbauda, vai rindas ir pareizas
    valid_rows = true
    for item in sudoku do
      arr = []
      item.each {|value|
        if value == "0"
          complete = false
        elsif arr.include? value
          valid_rows = false
          break
        else
          arr.push(value)
        end
      }
    end
   
    #pārbauda, vai kolonnas ir pareizas
    arr = []
    row = 0
    col = 0
    valid_cols = true
    9.times {
      9.times {
        if sudoku[row][col] == "0"
          complete = false
        elsif arr.include? sudoku[row][col]
          valid_cols = false
          break
        else
          arr.push(sudoku[row][col])
        end
        row+=1
      }
      break if !valid_cols
      row = 0
      col+=1
      arr = []
    }
  
    #pārbauda, vai 3x3 laukumi ir pareizi
    valid_sq = true
    
    start_indexes = [[0,0], [0,3], [0,6], [3,0], [3,3], [3,6], [6,0], [6,3], [6,6]]
    start_indexes.each{ |pair|
      start_row_index = pair[0]
      arr = []

      3.times{
        start_col_index = pair[1]
        3.times{
          value = sudoku[start_row_index][start_col_index]
            if value == "0"
              complete = false
            elsif arr.include? value
              valid_sq = false
              break
            else
              arr.push(value)
            end
          start_col_index+=1
        }
        break if !valid_sq
        start_row_index+=1
      } 
      break if !valid_sq 
    }


    if valid_cols && valid_rows && valid_sq
      if complete
        return "Sudoku is valid."
      else
        return "Sudoku is valid but incomplete."
      end
    else
      return "Sudoku is invalid."
    end
  end
end