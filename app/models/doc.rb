class Doc
  include Mongoid::Document
  include Mongoid::Paperclip

  embedded_in :user, :inverse_of => :docs

  has_mongoid_attached_file :attachment
  do_not_validate_attachment_file_type :attachment

end
