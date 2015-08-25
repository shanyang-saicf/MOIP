require 'rails_helper'

RSpec.describe "Metakey::MetaKey", type: :model do

  it "meta_key_module, identifies a key" do
    line = "##fileformat=VCFv4.1"
    expect(MetaKeyFactory.is_key(line)).to eq(TRUE)
  end

  it "meta_key_module, identifies not a key" do
    line = "#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	Mock-rep1-DNA"
    expect(MetaKeyFactory.is_key(line)).to eq(FALSE)
  end

  it "meta_key_module, identifies a header" do
    line = "#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	Mock-rep1-DNA"
    expect(MetaKeyFactory.is_header(line)).to eq(TRUE)
  end

  it "meta_key_module, identifies not a header" do
    line = "##fileformat=VCFv4.1"
    expect(MetaKeyFactory.is_header(line)).to eq(FALSE)
  end

  it "meta_key_module, line_formatter" do
    # TODO
    # line = "##fileformat=VCFv4.1"
    # expect(MetaKeyFactory.is_header(line)).to eq(FALSE)
  end

  it "meta_key, sets the class id of unknown" do
    line = "##fileformat=VCFv4.1"
    @metaClass = MetaKeyFactory.new
    @class = @metaClass.findModel(line)
    expect(@class.id).to eq("fileformat")
  end

  it "meta_key_info, sets the class id of known" do
    line = '##INFO=<ID=SVTYPE,Number=1,Type=String,Description="Type of structural variant">'
    @metaClass = MetaKeyFactory.new
    @class = @metaClass.findModel(line)
    expect(@class.id).to eq("SVTYPE")
    expect(@class.number).to eq("1")
  end

  it "meta_key_alt, should parse" do
    line = '##ALT=<ID=CNV,Description="Copy number variable region">'
    @metaClass = MetaKeyFactory.new
    @class = @metaClass.findModel(line)
    expect(@class.id).to eq("CNV")
    expect(@class.description).to eq("\"Copy number variable region\"")
  end

  it "meta_key_contig, should parse" do
    line = '##contig=<ID=chr1,length=249250621,assembly=hg19>'
    @metaClass = MetaKeyFactory.new
    @class = @metaClass.findModel(line)
    expect(@class.id).to eq("chr1")
    expect(@class.length).to eq("249250621")
    expect(@class.assembly).to eq("hg19")
  end

  it "meta_key_format, should parse" do
    line = '##FORMAT=<ID=CN,Number=1,Type=Float,Description="Copy number genotype for imprecise events">'
    @metaClass = MetaKeyFactory.new
    @class = @metaClass.findModel(line)
    expect(@class.id).to eq("CN")
  end


end
