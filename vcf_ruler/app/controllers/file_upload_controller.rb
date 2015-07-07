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
    @ruleupload.save
    render :nothing => true
  end

  def create
    @fileupload = FileUpload.new( user_params )
    #@fileupload.save
    @file = Paperclip.io_adapters.for(@fileupload.fileupload)
    hashJson = []
    begin
      File.open(@file.path).each do |line|
        if MetaKeyFactory.is_key(line)
          metaClass = MetaKeyFactory.new.findModel(line)
        end
        if !line.match("OMAPALT=A").nil?
          data = line.split("\t")
          hashMap = {'CHROM' => '',	'POS' => '',	'ID' => '',	'REF' => '',	'ALT' => '', 'QUAL' => '',	'FILTER' => '',	'INFO' => '',	'FORMAT' => '',	'Mock_rep1_DNA' => ''}
          hashMap['CHROM'] = data[0]
          hashMap['POS'] = data[1]
          hashMap['ID'] = data[2]
          hashMap['REF'] = data[3]
          hashMap['ALT'] = data[4]
          hashMap['QUAL'] = data[5]
          hashMap['FILTER'] = data[6]
          hashMap['INFO'] = data[7]
          hashMap['FORMAT'] = data[8]
          hashMap['Mock_rep1_DNA'] = data[9]
          hashJson << hashMap
        end

      end
    end
    render :json => JSON.pretty_generate(hashJson)

  end


  private

  def user_params
    params.require(:fileupload).permit(:fileupload)
  end

end
