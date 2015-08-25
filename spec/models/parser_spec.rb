require 'rails_helper'
include ParseFactory

RSpec.describe "Parser::ParseFactory", type: :model do

  it "parse_factory, Parse CHROM" do
    line = {}
    line["CHROM"] = parseFactory("CHROM", "chr1")
    expect(line["CHROM"]).to eq("chr1")
  end

  it "parse_factory, Parse POS" do
    line = {}
    line["POS"] = parseFactory("POS", "11184539")
    expect(line["POS"]).to eq("11184539")
  end

  it "parse_factory, Parse ID" do
    line = {}
    line["ID"] = parseFactory("ID", "MCH4")
    expect(line["ID"]).to eq("MCH4")
  end

  it "parse_factory, Parse IDs" do
    line = {}
    line["ID"] = parseFactory("ID", "COSM1686998;COSM20417")
    expect(line["ID"][1]).to eq("COSM20417")
  end

  it "parse_factory, Parse REF" do
    line = {}
    line["REF"] = parseFactory("REF", "G")
    expect(line["REF"]).to eq("G")
  end

  it "parse_factory, Parse ALT" do
    line = {}
    line["ALT"] = parseFactory("ALT", "G")
    expect(line["ALT"]).to eq("G")
  end

  it "parse_factory, Parse ALT with ," do
    line = {}
    line["ALT"] = parseFactory("ALT", "C,G,T")
    expect(line["ALT"][2]).to eq("T")
  end

  it "parse_factory, Parse QUAL" do
    line = {}
    line["QUAL"] = parseFactory("QUAL", "201.94")
    expect(line["QUAL"]).to eq("201.94")
  end

  it "parse_factory, Parse FILTER" do
    line = {}
    line["FILTER"] = parseFactory("FILTER", "PASS")
    expect(line["FILTER"]).to eq("PASS")
  end

  it "parse_factory, Parse INFO without FUNC" do
    line = {}
    line["INFO"] = parseFactory("INFO", 'PRECISE=FALSE;SVTYPE=CNV;END=65312407;LEN=54127868;NUMTILES=26;CDF_MAPD=0.025000:1.811614,0.050000:1.825542,0.100000:1.841732,0.200000:1.861530,0.250000:1.869107,0.500000:1.900000,0.750000:1.931404,0.800000:1.939265,0.900000:1.960111,0.950000:1.977495,0.975000:1.992698;CDF_LD=0.025000:1.851119,0.050000:1.854235,0.100000:1.860468,0.200000:1.872932,0.250000:1.879164,0.500000:1.910325,0.750000:1.941485,0.800000:1.947717,0.900000:1.995053,0.950000:2.022631,0.975000:2.036420;REF_CN=2;CI=0.05:1.82554,0.95:2.02263;RAW_CN=1.9')
    # expect(line["INFO"]).to eq("PASS")
    expect(line["INFO"]["SVTYPE"]).to eq("CNV")
  end


  it "parse_factory, Parse INFO with FUNC" do
    line = {}
    line["INFO"] = parseFactory("INFO", "AF=0;AO=0;DP=1542;FAO=0;FDP=1534;FR=.,REALIGNEDx0.01361;FRO=1534;FSAF=0;FSAR=0;FSRF=1006;FSRR=528;FWDB=-9.64204E-4;FXX=0.00583276;HRUN=1;HS;LEN=1;MLLD=202.909;QD=0.526561;RBI=0.00632446;REFB=-3.87243E-7;REVB=-0.00625053;RO=1535;SAF=0;SAR=0;SRF=1001;SRR=534;SSEN=0;SSEP=0;SSSB=0;STB=0.5;STBP=1;TYPE=snp;VARB=0;OID=MCH4;OPOS=11184568;OREF=G;OALT=A;OMAPALT=A;FUNC=[{\'transcript\':\'NM_004958.3\',\'gene\':\'MTOR\',\'location\':\'exonic\',\'exon\':\'47\'}]")
    # expect(line["INFO"]).to eq("PASS")
    expect(line["INFO"]["AF"]).to eq("0")
  end

  it "parse_factory, Parse FORMAT" do
    line = {}
    line["FORMAT"] = parseFormat("GT:GQ:CN", "./.:0:1.9")
    expect(line["FORMAT"]["CN"]).to eq("1.9")
  end

  it "parse_factory, Parse FORMAT no :" do
    line = {}
    line["FORMAT"] = parseFormat("CN", "1.9")
    expect(line["FORMAT"]["CN"]).to eq("1.9")
  end

end