require 'redmine'

Redmine::Plugin.register :redmine_git_list do
  name 'Redmine Git List plugin'
  author 'harry'
  description 'just for list git repos'
  version '0.0.1'

  menu :top_menu, :gits, { :controller => 'gits', :action => 'index' }, :caption => 'Gits'
end
