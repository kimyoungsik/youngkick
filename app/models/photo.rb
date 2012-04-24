class Photo < ActiveRecord::Base
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  
  belongs_to :user
  belongs_to :photoable, :polymorphic => true
  
  validates :image_file_name, :presence => true
  validates :image_content_type, :presence => true
  validates :image_file_size, :presence => true
  
  validates_attachment_content_type :image, :content_type => /image/
  validates_attachment_size :image, :less_than => 5.megabytes

  # Paperclip
    has_attached_file :image,     
      :path => ":rails_root/public/system/:attachment/:id/:style/:normalized_image_file_name",
      :url => "/system/:attachment/:id/:style/:normalized_image_file_name",
      :styles => { :thumb => {:geometry => "50x50#", :processors => [:cropper]},
                  :small => {:geometry => "100x100#", :processors => [:cropper]},
                  :large => "640x640>"}

    after_update :reprocess_image, :if => :cropping?
    default_scope :order => 'photos.created_at DESC'
    before_save :user_info

    def user_info
      if self.user_id.nil?
        self.user_id = photoable.user.id
      end
    end

    def cropping?
      !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
    end

    def image_geometry(style = :original)
      @geometry ||= {}
      @geometry[style] ||= Paperclip::Geometry.from_file(image.path(style))
    end

    Paperclip.interpolates :normalized_image_file_name do |attachment, style|
       attachment.instance.normalized_image_file_name
     end

     def normalized_image_file_name
       "#{self.id}-#{self.image_file_name.gsub( /[^a-zA-Z0-9_\.]/, '_')}" 
     end

     private

     def reprocess_image
       image.reprocess!
     end
end
