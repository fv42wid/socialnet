module AlbumsHelper

  def album_thumbnail(album)
    if album.pictures.count > 0
      image_tag album.pictures.first.location, :class => 'img-responsive'
    else
      image_tag 'http://placehold.it/150x100', :class => 'img-responsive'
    end
  end
end
