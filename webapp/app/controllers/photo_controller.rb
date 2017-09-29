class PhotoController < ApplicationController

  # ************************** #
  # Layout
  # ************************** #

  def load_photo
    s3_client = Aws::S3::Client.new
    url = Aws::S3::Object.new(
        key: params[:user_id].to_s+'/'+params[:house_id].to_s+'/'+params[:name].to_s,
        bucket_name: Constant::S3_BUCKET,
        client: s3_client
    ).presigned_url(:get, expires_in: 60 * 60);

    # resize
    puts(url)
    image = MiniMagick::Image.open(url)
    if params[:width] != nil and params[:width] != '0'
      image.resize params[:width]+'x'+params[:width]
    end

    # using media.type as mimetype for sending to client
    send_data image.to_blob, type: 'image/jpg', disposition: 'inline'
  end

  def load_avatar
    s3_client = Aws::S3::Client.new
    url = Aws::S3::Object.new(
        key: params[:user_id].to_s+'/'+params[:name]+'.jpg',
        bucket_name: Constant::S3_BUCKET,
        client: s3_client
    ).presigned_url(:get, expires_in: 60 * 60);

    # resize
    puts(url)
    image = MiniMagick::Image.open(url)
    if params[:width] != nil and params[:width] != '0'
      image.resize params[:width]+'x'+params[:width]
    end

    # using media.type as mimetype for sending to client
    send_data image.to_blob, type: 'image/jpg', disposition: 'inline'
  end


  # ************************** #
  # API
  # ************************** #

  def delete
    authorize! :delete_photo, :photo
    response = Response.new(Constant::MESSAGE_FAIL, Constant::MESSAGE_FAIL)

    userId = current_user.id
    photo = Photo.find(params[:id])
    if photo.user_id == userId
      photo.delete_photo

      response.set_message(Constant::MESSAGE_SUCCESS)
      response.set_status_code(Constant::STATUS_CODE_SUCCESS)
    end

    render json: response
  end



end
