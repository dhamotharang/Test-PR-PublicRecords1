export out_util_samples(string filedate) := function
File_util_daily_did := dataset('~thor_data400::in::utility::'+filedate+'::daily_did',utilfile.Layout_DID_Out,flat);

return output(choosen(File_util_daily_did( record_date = filedate),500),named('Util_QA_Samples'));
end;