require 'csv'
require 'json'

class FileUploadController < ApplicationController
  include ParseFactory

  skip_before_filter :verify_authenticity_token

  @expression

  def index
  end

  def moi
    begin
      raise Errors::NotFound if params[:rule].nil? || params[:vcf_file].nil?
      @rule = params[:rule]
      @file = params[:vcf_file]
      @expression = Expression.new(FileUpload.find(@file).data)
      expressionArray = Interpreter.new.interpret(RuleUpload.find(@rule).sentence)
      newHash = []
      expressionArray.each do | expression |
        p expression
        newHash = @expression.testEval(expression)
        # p newHash
        @expression.filterHash(newHash)
      end
      render :json => JSON.pretty_generate(newHash)
      # logger.info "Find moi has successfully executed on #{@file} using #{@rule}"
    end
  end

  def show
  end

  def new_rule
    begin
    @ruleupload = RuleUpload.new(params.require(:ruleupload).permit(:ruleupload))
    json = JSON.parse(Paperclip.io_adapters.for(@ruleupload.ruleupload).read)
    @ruleupload.write_attribute(:_id, File.basename(@ruleupload.ruleupload.original_filename, File.extname(@ruleupload.ruleupload.original_filename)))
    @ruleupload.write_attribute(:rule, json)
    @ruleupload.write_attribute(:sentence, RuleParser.new.parseJson(json))
    @ruleupload.save
    logger.info "New rule json has been successfully uploaded to MOIP at #{Time.now}"
    rescue
      logger.error "An issue has occured when uploading rule #{@ruleupload.ruleupload.original_filename}"
    end
    render :nothing => true
  end

  def vcf_upload
    begin
      @fileupload = FileUpload.new( user_params )
      @fileupload.write_attribute(:_id, File.basename(@fileupload.fileupload.original_filename, File.extname(@fileupload.fileupload.original_filename)))
      @rule = params[:rule]
      @file = Paperclip.io_adapters.for(@fileupload.fileupload)
      hashJson = VcfParser.new.fileParse(@file)
      @fileupload.write_attribute(:data, hashJson)
      @fileupload.save
      logger.info "New vcf file has been successfully uploaded to MOIP at #{Time.now}"
    rescue
      logger.error "An issue has occured when uploading #{@fileupload.fileupload.original_filename} at #{Time.now}"
    end
    render :json => JSON.pretty_generate(hashJson)
  end

  private

  def user_params
    params.require(:fileupload).permit(:fileupload)
  end

end
