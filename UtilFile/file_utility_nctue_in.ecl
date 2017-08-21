import ut, UtilFile;

EXPORT file_utility_nctue_in := module

 export raw_20130531 := dataset(ut.foreign_prod + 'thor_data400::in::utility::20130531::nctue',utilfile.layout_utility_nctue_in,flat);
 export raw_20131216 := dataset(ut.foreign_prod + 'thor_data400::in::utility::20131216::headerdailyln_onetime', UtilFile.layout_util.daily_in_new, flat);
 export did_20130531 := dataset('~thor_data400::in::utility::20130531::nctue_hist_did',utilfile.Layout_DID_Out,flat); 
 export did_20131216 := dataset('~thor_data400::in::utility::20131216::nctue_hist_did',utilfile.Layout_DID_Out,flat);
 export base := dataset(ut.foreign_dataland + 'thor_data400::in::nctue_utils_hist_cleanphone_20130531',utilfile.Layout_Util.base, flat) +
dataset(ut.foreign_dataland + 'thor_data400::in::nctue_utils_hist_cleanphone_20131216a',utilfile.Layout_Util.base, flat);
 export raw_20121219:= dataset('~thor_data400::in::utility::NCTUE_full',utilfile.layout_utility_nctue_in,flat);
 
 rec := record
 
 string10 digit_Old_ref_nbr;
 string10 digit_New_ref_nbr;
 string1 lf;
 end;
 
 export lookupfile := dataset('~thor_data400::in::utility::headerdailyln_xref_20131216', {string10 digit_Old_ref_nbr, string1 seperator, string10 digit_New_ref_nbr,  string1 lf}, flat);
 end;
 
