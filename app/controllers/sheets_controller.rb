require 'roo'

class SheetsController < ApplicationController
    def new
        @sheet = Sheet.new
    end

    def create
        @sheet = Sheet.new(sheet_params)

        if @sheet.save
          import = @sheet

          import.file.open do |file|
            spreadsheet = Roo::Spreadsheet.open(file.path)

            sheet = spreadsheet.sheet(0) # first sheet

            sheet.each_row_streaming(offset: 1) do |row|
              Card.create!(question: row[0], answer: row[1], deck: import.title)
            end
          end



          redirect_to cards_path(params: @sheet.title), notice: 'File was successfully uploaded.'
        else
          render :new
        end
    end

    def show
      @sheet = Sheet.find(params[:id])
    end


    private

    def sheet_params
      params.require(:sheet).permit(:title, :file)
    end
end
