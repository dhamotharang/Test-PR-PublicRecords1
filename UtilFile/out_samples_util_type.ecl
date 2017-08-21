export out_samples_util_type(string filedate, string p_util_type) := function
File_util_daily_did := dataset('~thor_data400::in::utility::'+filedate+'::daily_did',utilfile.Layout_DID_Out,flat);
v_txt := 'Util_QA_Samples_util_type_' + p_util_type;
return output(choosen(File_util_daily_did( record_date = filedate, util_type = p_util_type),200),named(v_txt));
end;
