#encoding:utf-8
module ApplicationHelper
  
  def getResult(recordbook)
    if recordbook.win == 1
      ret = "win"
    elsif recordbook.loss == 1
      ret = "loss"
    else
      ret = "tie"
    end
    ret
  end     
  
  def status_label(status)
    case status
    when "pending"
      "warning"
    when "progress"
      "success"
    when "cancel"
      ""
    when "after"
      "info"
    end
  end
  
  def status_in_korean(status)
    case status
    when "pending"
      "대기"
    when "progress"
      "진행"
    when "cancel"
      "취소"
    when "after"
      "종료"
    end
  end
  
  def profile_photo(user, size, width)
    if user.profile_photo
      image_tag(user.profile_photo.image.url(size), :width => width)
    elsif user.avatar
      image_tag(user.avatar.url(size), :width => width)
    else
      image_tag('/assets/default_profile.png', :width => width)
    end
  end
  
 
end
