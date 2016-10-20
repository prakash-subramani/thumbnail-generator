class AddAttachmentMediaToAttachments < ActiveRecord::Migration
  def self.up
    change_table :attachments do |t|
      t.attachment :media
    end
  end

  def self.down
    remove_attachment :attachments, :media
  end
end
