module Post::Contract
  class Import < Reform::Form
    property :file, virtual: true

    validates :file, presence: true, file_content_type: { allow: ['text/csv', 'text/plain'] }
  end
end
