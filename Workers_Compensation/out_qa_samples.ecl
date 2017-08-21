file_base_in := Workers_Compensation.Files().Base_Full.qa;

file_base_in_father := 		dataset( '~thor_data400::base::workers_compensation_full::father'
                                           ,Workers_Compensation.layouts.Base_Full,thor);																			 
dist_file_in := distribute(file_base_in,HASH32(Master_UID,RMID));
dist_file_in_var := distribute(file_base_in_father,HASH32(Master_UID,RMID));

Workers_Compensation.layouts.Base_Full join_tr(dist_file_in le,dist_file_in_var re) := transform
self := le;
end;

jout := join(dist_file_in,dist_file_in_var,LEFT.Master_UID = RIGHT.Master_UID AND LEFT.RMID = RIGHT.RMID ,join_tr(LEFT,RIGHT),left only,local);

//sort_in := sort(jout,-Policy_Eff_Date);

export out_qa_samples := output(topn(jout,100,-Policy_Eff_Date),,NAMED('WCQASAMPLES'));