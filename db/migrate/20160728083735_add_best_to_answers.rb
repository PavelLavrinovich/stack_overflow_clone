class AddBestToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :best, :boolean, index: true, default: false
  end
end
