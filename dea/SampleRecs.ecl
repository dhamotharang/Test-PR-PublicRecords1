import DEA;

new_base := sort(dea.File_DEA_Modified, dea_registration_number); 
prev_base := sort(dataset('~thor_data400::base::dea_father', dea.Layout_DEA_OUT_baseV2, flat),dea_registration_number) ;

newrecords_layout := RECORD
dea.Layout_DEA_OUT_base;
END;

newrecords_layout newrecords_output(new_base l, prev_base r) := TRANSFORM
SELF := l;
END;

//New Records Join by DEA Registration Numbers
newrecords := join(new_base, prev_base,
							left.dea_registration_number = right.dea_registration_number
						,newrecords_output(LEFT,RIGHT)
						,LEFT ONLY
						);
						
EXPORT SampleRecs := output(choosen(newrecords, 1000), named('SampleRecords'));