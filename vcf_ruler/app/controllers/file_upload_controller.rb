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
        else
          data = line.split("\t")
          hashMap = {'CHROM' => '',	'POS' => '',	'ID' => '',	'REF' => '',	'ALT' => '', 'QUAL' => '',	'FILTER' => '',	'INFO' => {},	'FORMAT' => '',	'Mock_rep1_DNA' => ''}
          hashMap['CHROM'] = data[0]
          hashMap['POS'] = data[1]
          hashMap['ID'] = data[2]
          hashMap['REF'] = data[3]
          hashMap['ALT'] = data[4]
          hashMap['QUAL'] = data[5]
          hashMap['FILTER'] = data[6]
          if !data[7].nil?
            infoHash = {}
            infoArray = data[7].split(";")
            infoArray.each do | infoLine |
              data = infoLine.split("=")
              if data[0] == "FUNC"
                p data[1][1..data[1].length-2]
              else
                infoHash.store(data[0], data[1])
              end
            end
          end
          hashMap['INFO'] = infoHash
          hashMap['FORMAT'] = data[8]
          hashMap['Mock_rep1_DNA'] = data[9]
          hashJson << hashMap
        end
      end
    end

    @expression = Expression.new(hashJson)
    @expression.testEval(And.new(Equals.new("FXX", "0.00267019"), Not.new(Equals.new("POS", "10032611165"))))  #Same as @expression.testEval((Equals.new("FXX", "0.00267019") & Equals.new("POS", "100611165")))
    @expression.testEval((Equals.new("FXX", "0.00267019") & (Equals.new("POS", "100611165"))))
    #p "123 = 123 " + @expression.evaluate(Equals.new("123", "123")).to_s
    #p "345 > 344 " + @expression.evaluate(GreaterThan.new("345", "344")).to_s
    #p "123 < 321 " + @expression.evaluate(LessThan.new("123", "321")).to_s
    #p "true || false " + @expression.evaluate(Or.new(true, false)).to_s
    #p "123 = 123 && 345 > 344 " + @expression.evaluate(Equals.new("123", "123") & GreaterThan.new("345", "344")).to_s
    #p "345 >= 344 " + @expression.evaluate(Or.new(Equals.new("345", "344"), GreaterThan.new("345", "344"))).to_s
    #p "123 != 123 " + @expression.evaluate(Not.new(Equals.new("123", "123"))).to_s
    #p "!(345 > 344 && 123 < 321) " + @expression.evaluate(Not.new(GreaterThan.new("345", "344")) & LessThan.new("123", "321")).to_s

    #p @expression.evaluate(Equals.new("FilterType", "") & GreaterThan.new("CopyNumber", "7"))

    render :json => JSON.pretty_generate(hashJson)

  end


  private

  def user_params
    params.require(:fileupload).permit(:fileupload)
  end

end
