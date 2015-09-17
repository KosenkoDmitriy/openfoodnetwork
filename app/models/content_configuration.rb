require 'open_food_network/paperclippable'

class ContentConfiguration < Spree::Preferences::FileConfiguration
  include OpenFoodNetwork::Paperclippable

  # Header
  preference :logo, :file
  preference :logo_mobile, :file
  preference :logo_mobile_svg, :file
  has_attached_file :logo, :default_url => "/assets/home/logo.jpeg" #640x130
  has_attached_file :logo_mobile, :default_url => "/assets/home/logo_mobile.jpeg" #75x26
  has_attached_file :logo_mobile_svg, :default_url => "/assets/home/logo.jpeg"

  # Home page
  preference :home_hero, :file
  preference :home_show_stats, :boolean, default: true
  has_attached_file :home_hero, :default_url => "/assets/home/romanesco.png"

  # Producer sign-up page
  preference :producer_signup_pricing_table_html, :text, default: "(TODO: Pricing table)"
  preference :producer_signup_case_studies_html, :text, default: "(TODO: Case studies)"
  preference :producer_signup_detail_html, :text, default: "(TODO: Detail)"

  # Hubs sign-up page
  preference :hub_signup_pricing_table_html, :text, default: "(TODO: Pricing table)"
  preference :hub_signup_case_studies_html, :text, default: "(TODO: Case studies)"
  preference :hub_signup_detail_html, :text, default: "(TODO: Detail)"

  # Groups sign-up page
  preference :group_signup_pricing_table_html, :text, default: "(TODO: Pricing table)"
  preference :group_signup_case_studies_html, :text, default: "(TODO: Case studies)"
  preference :group_signup_detail_html, :text, default: "(TODO: Detail)"

  # Footer
  preference :footer_logo, :file
  has_attached_file :footer_logo, :default_url => "/assets/home/logo_footer.jpeg" #220x76
  # has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  has_attached_file :avatar, :default_url => "/assets/home/logo.png" #where logo.png is original .jpeg file

  preference :footer_facebook_url, :string, default: "https://www.facebook.com/Open-Food-Network-SA-891306990883565/timeline/?ref=hl"
  preference :footer_twitter_url, :string, default: "htps://twitter.com/ofn_sa"
  preference :footer_instagram_url, :string, default: ""
  preference :footer_linkedin_url, :string, default: ""
  preference :footer_googleplus_url, :string, default: ""
  preference :footer_pinterest_url, :string, default: ""
  preference :footer_email, :string, default: "ofn@kandu.co.za"
  preference :footer_links_md, :text, default: <<-EOS
[Newsletter sign-up](/)

[News](/)

[Calendar](/)
EOS

  preference :footer_about_url, :string, default: "http://ofn.kandu.co.za/about"
  preference :footer_tos_url, :string, default: "/Terms-of-service.pdf"
end
