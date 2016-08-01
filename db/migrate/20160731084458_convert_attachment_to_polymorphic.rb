class ConvertAttachmentToPolymorphic < ActiveRecord::Migration
  def change
    remove_index :attachments, :question_id
    remove_foreign_key :attachments, :question
    rename_column :attachments, :question_id, :attachable_id
    add_column :attachments, :attachable_type, :string
    add_index :attachments, [:attachable_id, :attachable_type]
  end
end
