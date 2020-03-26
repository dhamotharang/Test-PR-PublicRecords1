#workunit('name','BusData.Proc_Spray_Build_SKA');
/*
  We are expecting to digest files in the following location and file naming formats:
  
  file location     = '/data/prod_data_build_10/production_data/business_headers/ska/data/'

  a_file (Verified) = filedate + '/om' + OM_number + 'a_' + filedate_m_d_yyyy + '_final_Final.txt'

  b_file (Nixie)    = filedate + '/om' + OM_number + 'b_' + filedate_m_d_yyyy + '_final_Final.txt'
*/

filedate          := '20190305';	// modify to current date
OM_number         := '379725';    // vendor identifier which they've recently changed
filedate_m_d_yyyy := '3-5-2019';  // file date in m-d-yyyy format to match vendor file naming convention

BusData.Proc_Spray_Build_SKA( filedate, OM_number, filedate_m_d_yyyy );
