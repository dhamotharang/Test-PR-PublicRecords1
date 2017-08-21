/*2017-08-10T00:03:23Z (Wendy Ma)
bug# DF-19884
*/
import ut,header;

export file_util_bus := module

Util_daily_bus_recs := UtilFile.Util_daily_bus_with_bdid;

utilfile.mac_convert_util_type(Util_daily_bus_recs, full_DID_out)
export full_BDID_for_index := full_DID_out;
//Exclude data that is older than 7 years
utilfile.mac_convert_util_type(utilfile.Files().base.built, full_base_out)
export full_base_for_index := full_base_out(~header.IsOldUtil(ut.GetDate, false, record_date,, 7));

end;