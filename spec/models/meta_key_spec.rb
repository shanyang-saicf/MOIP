require 'rails_helper'

RSpec.describe "Metakey::MetaKey", type: :model do

  it "meta_key_module, identifies a key" do
    line = "##fileformat=VCFv4.1"
    MetaKeyFactory.is_key(line)
    expect(MetaKeyFactory.is_key(line)).to eq(TRUE)

  end

  it "meta_key, sets the class id" do
    line = "##fileformat=VCFv4.1"
    @metaClass = MetaKeyFactory.new
    @class = @metaClass.findModel(line)
    expect(@class.id).to eq("fileformat")
  end

end
