# vcf_rules

[ ![Codeship Status for CBIIT/vcf_rules](https://codeship.com/projects/90adf210-f295-0132-0361-7ec9b9682570/status?branch=master)](https://codeship.com/projects/85203)

[![Code Climate](https://codeclimate.com/github/CBIIT/vcf_rules/badges/gpa.svg)](https://codeclimate.com/github/CBIIT/vcf_rules)

[![Test Coverage](https://codeclimate.com/github/CBIIT/vcf_rules/badges/coverage.svg)](https://codeclimate.com/github/CBIIT/vcf_rules/coverage)

http://localhost:3000/rule/index for a list of Rule Files
cd ~/git/vcf_rules/vcf_ruler/public/rulefiles
curl -F "fileupload[fileupload]=@EML4_ALK_cosf479.vcf;type=text/directory" http://localhost:3000/file_upload/create
