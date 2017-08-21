import ut;
flc3v_v2_in := dataset(ut.foreign_prod + '~thor_data400::sprayed::flcrash3v'
									,FLAccidents.Layout_FLCrash2v_v3, csv(Heading(1),separator(','),terminator(['\n','\r\n']),quote('')));


flc3v_v2_rec := FLAccidents.Layout_FLCrash3v_v2;

flc3v_v2_rec flc3v_convert_to_old(flc3v_v2_in l) := transform
self. rec_type_3                    :=  '3';                        
self.towed_trlr_veh_owner_name		:=	trim(trim(l.towed_trlr_veh_owner_lname,left,right)+' '+trim(l.towed_trlr_veh_owner_fname,left,right)+' '+trim(l.towed_trlr_veh_owner_mname,left,right),left,right);
self.towed_trlr_veh_owner_st_city      :=  trim(l.towed_trlr_veh_owner_st_city,left,right); 
self                                := l;
self                                := [];

end;

 export InFile_FLCrash3v_v3 := project(flc3v_v2_in(trim(towed_trlr_make) <> ''),flc3v_convert_to_old(left));
 
