import UPIN, doxie;

file_in := UPIN.File_UPIN_base;

filtered_UPIN_name := file_in(Physician_Clean_lname<>'');
											 
dist_UPIN_base := distribute(filtered_UPIN_name, hash(Physician_Clean_lname));
sort_UPIN_base := sort(dist_UPIN_base, except did, did_score, local);
dedup_UPIN_base := dedup(sort_UPIN_base, except did, did_score, local);

export Key_UPIN_st_name := index(dedup_UPIN_base, 
                       {l_lname := Physician_Clean_lname, l_fname := Physician_Clean_fname, l_mname := Physician_Clean_mname, l_st := physician_Clean_st},
					   {dedup_UPIN_base},'~thor_data400::key::UPIN::name_' + doxie.Version_SuperKey);
								
								



