module ApplicationHelper
def emojify(content)
  h(content).to_str.gsub(/:([\w+-]+):/) do |match|
    if emoji = Emoji.find_by_alias($1)
      %(<img alt="#$1" src="#{image_path("emoji/#{emoji.image_filename}")}" style="vertical-align:middle" width="20" height="20" />)
    else
      match
    end
  end.html_safe if content.present?
end
def gravatar_url(user)
  gravatar_id = Digest::MD5::hexdigest(user.email).downcase
  url = "https://gravatar.com/avatar/#{gravatar_id}.png"
end
end
