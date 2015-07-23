require 'csv'
require 'json'

class FileUploadController < ApplicationController


  skip_before_filter :verify_authenticity_token

  def index
  end

  def new
  end

  def show
  end

  def new_rule
    json = ActiveSupport::JSON.encode(params)
    json = ActiveSupport::JSON.decode(json)
    @ruleupload = RuleUpload.new(json)
    @ruleParser = RuleParser.new()
    @ruleParser.parse(json)
    #@ruleupload.save
    render :nothing => true
  end

  def create
    @fileupload = FileUpload.new( user_params )
    @file = Paperclip.io_adapters.for(@fileupload.fileupload)
    hashJson = Parser.new.parse(@file)
    render :json => JSON.pretty_generate(hashJson)

  end

  private

  def user_params
    params.require(:fileupload).permit(:fileupload)
  end

end
