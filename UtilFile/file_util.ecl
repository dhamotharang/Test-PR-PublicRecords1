/*2017-08-10T00:04:21Z (Wendy Ma)
bug# DF-19884
*/
import ut, header,data_services;
export file_util := module
//file for keys has DID but no rawid and nameflag
full_did_ := dataset(data_services.foreign_prod + 'thor_data400::base::utility_DID', UtilFile.Layout_DID_Out, flat);
//blank out invalid dates in DID file
UtilFile.mac_cleandates(full_did_, full_did_clean_dates)
//Exclude data that is older than 7 years
export full_did := full_did_clean_dates(~header.IsOldUtil(ut.GetDate, false, record_date,,7));
utilfile.mac_convert_util_type(full_did, full_did_out)
export full_did_for_index := full_did_out;
//file has rawid and nameflag but no DID
full_base_ := dataset(data_services.foreign_prod +'thor_data400::base::utility_file', UtilFile.layout_util.base, flat);
//Exclude data that is older than 7 years
//blank out invalid dates in base file 
UtilFile.mac_cleandates(full_base_, full_base_clean_dates)
export full_base := full_base_clean_dates(~header.IsOldUtil(ut.GetDate, false, record_date,,7));
utilfile.mac_convert_util_type(full_base, full_base_out)
export full_base_for_index := full_base_out;

end;