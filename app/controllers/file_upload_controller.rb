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
    @ruleupload = RuleUpload.new(params.require(:ruleupload).permit(:ruleupload))
    json = JSON.parse(Paperclip.io_adapters.for(@ruleupload.ruleupload).read)
    @ruleupload.write_attribute(:_id, File.basename(@ruleupload.ruleupload.original_filename, File.extname(@ruleupload.ruleupload.original_filename)))
    @ruleupload.write_attribute(:rule, json)
    @ruleupload.write_attribute(:sentence, RuleParser.new.parseJson(json))
    @ruleupload.save
    render :nothing => true
  end

  def create
    @fileupload = FileUpload.new( user_params )
    @rule = params[:rule]
    @file = Paperclip.io_adapters.for(@fileupload.fileupload)
    hashJson = VcfParser.new.fileParse(@file)

    # hashJson.each do | rec |
    #   if (rec.info.SVTYPE == "CNV") && rec.filter
    #
    #   end
    # end


    # @expression = Expression.new(hashJson)
    expressionArray = Interpreter.new.interpret(RuleUpload.find(@rule).sentence)
    # p expressionArray
    # newHash = []
    # expressionArray.each do | expression |
    #    newHash = @expression.testEval(expression)
    #   @expression.filterHash(newHash)
    # end
    # newHash.each do | variant |
    #   p variant
    # end

    render :json => JSON.pretty_generate(hashJson)
  end

  private

  def user_params
    params.require(:fileupload).permit(:fileupload)
  end

end
