require 'open-uri'

class RepositoryController < ApplicationController
  
  layout 'internal_layout'
  
  def index
    @commits = JSON.parse(open('https://api.github.com/repos/PUC-IIC2513/teachr/commits').read)
  end
end
