module Paperclip
  class PptThumbnail < Processor
    def initialize file, options = {}, attachment = nil
      @file = file
      @options = options
      @instance = attachment.instance
      @current_format = File.extname(attachment.instance.attachment_file_name)
      @basename = File.basename(@file.path, @current_format)
      @whiny = options[:whiny].nil? ? true : options[:whiny]
    end

    def make
      begin
        src_path = File.expand_path(@src.path)
        @dst_path = Dir.tmpdir
        @pages = @options[:pages] || [1]
        @options = @options.merge(:output => @dst_path)

        Docsplit.extract_images(src_path, @options)

      rescue Exception => e
        # Rails.logger.info "PPT thmbnail exception"
        Rails.logger.info "Error due to #{e.inspect}"
        raise Paperclip::Error, "There was an error extracting images from #{@basename}"
      end

      destination_file
    end

    def destination_file
      File.open(File.join(@dst_path, "#{@basename}_#{@pages.first}.jpg"))
    end

  end
end