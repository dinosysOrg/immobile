require 'aws-sdk'
require 'mini_magick'
require 'base64'

class Photo < ActiveRecord::Base
  belongs_to :house

  def self.create_photo(house, userId, params)
    if params[:img].present?
      s3 = Aws::S3::Resource.new
      bucket = s3.bucket(Constant::S3_BUCKET)
      (params[:img]).each do |img|
        name = Base64.urlsafe_encode64(Base64.encode64(img.original_filename))
        path = userId.to_s+'/'+house.id.to_s+'/'+name
        bucket.object(path).put(body: img.read)

        photo = Photo.new
        photo.user_id = userId
        photo.house_id = house.id
        photo.photo_url = '/photo/'+path
        photo.save
      end
    end
  end

  def self.create_avatar(userId, params)
    s3 = Aws::S3::Resource.new
    bucket = s3.bucket(Constant::S3_BUCKET)
    img = params[:img]
    path = userId.to_s+'/avatar.jpg'
    bucket.object(path).put(body: img.read)

    return '/photo/'+path
  end

  def delete_photo
    path = self.photo_url.gsub('/photo/', '')

    s3 = Aws::S3::Resource.new
    bucket = s3.bucket(Constant::S3_BUCKET)
    bucket.object(path).delete
    self.delete
  end

end
