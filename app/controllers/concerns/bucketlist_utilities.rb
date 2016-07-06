module BucketlistUtilities
  private

  def set_bucketlist(id)
    @bucketlist = Bucketlist.find_by!(id: id)
  end
end
