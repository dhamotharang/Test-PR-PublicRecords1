#workunit('name','OneKey.Build_All');
/*
  We are expecting to digest files in the following location and file naming formats:
  
  file location     = '/data/prod_data_build_10/production_data/business_headers/onekey/data/{filedate}'

  a_file (Verified) = 'OneKey_LexisNexisA.csv'

  b_file (Nixie)    = 'OneKey_LexisNexisB.csv'
*/

filedate          := '20200317';	// modify to current date

OneKey.Build_All( filedate );