require 'csv'
require 'json'

class FileUploadController < ApplicationController
  include ParseFactory

  skip_before_filter :verify_authenticity_token

  def index
  end

  def new
  end

  def show
  end

  def new_rule
    # params[:file_upload].delete
    json = ActiveSupport::JSON.encode(params)
    json = ActiveSupport::JSON.decode(json)
    json.delete('file_upload')
    json.delete('controller')
    json.delete('action')
    RuleParser.new.parseJson(json)
    @ruleupload.save
    render :nothing => true
  end

  def create
    @fileupload = FileUpload.new( user_params )
    @file = Paperclip.io_adapters.for(@fileupload.fileupload)
    hashJson = VcfParser.new.fileParse(@file)
    @expression = Expression.new(hashJson)
    # [{"and"=>["RAW_CN >= 2.5", "REF_CN >= 2"]}]
    expressionArray = Interpreter.new.interpret(["FILTER == PASS", "CN >= 7", {"and"=>["ID != ", "ID != ."]}])
    newHash = []
    expressionArray.each do | expression |
       newHash = @expression.testEval(expression)
      @expression.filterHash(newHash)
    end
    p newHash

    render :json => JSON.pretty_generate(hashJson)
  end

  private

  def user_params
    params.require(:fileupload).permit(:fileupload)
  end

end
