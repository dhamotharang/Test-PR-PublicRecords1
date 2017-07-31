export Mac_Update_Base (file_in, incr_update = true, file_out) := macro
import ExperianCred;
#uniquename(exp_phone_base)
%exp_phone_base% := Experian_Phones.Files.Base;
#uniquename(expcred_base)
%expcred_base% := ExperianCred.Files.Base_File_Out;
#uniquename(exp_phone_layout)
%exp_phone_layout% := recordof(%exp_phone_base%);

#uniquename(curr_plus_prev)
%curr_plus_prev% := if(nothor(FileServices.GetSuperFileSubCount(Filenames.Base) = 0),
									 file_in,
									 if(~incr_update,
									 file_in + project(%exp_phone_base%, transform(Experian_Phones.Layouts.base, self.is_current := false, self := left)),									
									 file_in + 
									 join(distribute(%exp_phone_base%,  hash(Encrypted_Experian_PIN)),
												distribute(file_in,  hash(Encrypted_Experian_PIN)),
												left.Encrypted_Experian_PIN = right.Encrypted_Experian_PIN,
												transform(Experian_Phones.Layouts.base,
																	self.is_current := if(right.Encrypted_Experian_PIN <> '', false, left.is_current),
																	self := left),
												left outer,
												local)));
//append did from experiancred
#uniquename(t_append)

%exp_phone_layout% %t_append% (%curr_plus_prev% le,  %expcred_base% ri) := transform
self.did := ri.did,
self.did_score := ri.did_score_field;
self.rec_type := ri.nametype;
self := le;
end;

#uniquename(append_did)
%append_did% := join(distribute(%curr_plus_prev%, hash(Encrypted_Experian_PIN)),
									 dedup(sort(distribute(%expcred_base% (did > 0 ), hash(Encrypted_Experian_PIN)), Encrypted_Experian_PIN, did, nametype, local), Encrypted_Experian_PIN, did, local),
									 left.Encrypted_Experian_PIN = right.Encrypted_Experian_PIN,
									 %t_append%(left, right),
									 left outer,
									 local);
									 
#uniquename(append_pin_name)
%append_pin_name% := join(distribute(%append_did%, hash(Encrypted_Experian_PIN)),
									  dedup(sort(distribute(%expcred_base% (nametype <> 'SP1' and trim(lname+fname,all) <> ''), hash(Encrypted_Experian_PIN)),Encrypted_Experian_PIN, nametype, -date_last_seen, local),Encrypted_Experian_PIN, local),
										left.Encrypted_Experian_PIN = right.Encrypted_Experian_PIN,
										transform(%exp_phone_layout%,
															self.PIN_did := right.did;
															self.PIN_title := right.title;
															self.PIN_fname := right.fname;
															self.PIN_mname := right.mname;
															self.PIN_lname := right.lname;
															self.PIN_name_suffix := right.name_suffix;
															self := left),
										left outer,
										local);
									 						 
	
//Rollup with previous base to keep history
#uniquename(experianP_base_s)
%experianP_base_s% := sort(%append_pin_name%, 
					Encrypted_Experian_PIN,
					phone_pos,
					Phone_digits,	
					Phone_type,
					Phone_Source,
					did,
					rec_type,
					-Phone_Last_Updt,
					-date_vendor_last_reported,
					-date_last_seen,
					local);
					
#uniquename(t_rollup)
%exp_phone_layout% %t_rollup% (%experianP_base_s% le, %experianP_base_s% ri) := transform
 self.date_first_seen 			 		 :=  ut.min2(le.date_first_seen, ri.date_first_seen);
 self.date_last_seen 			   		 :=  ut.max2(le.date_last_seen, ri.date_last_seen);
 self.date_vendor_first_reported := ut.min2(le.date_vendor_first_reported, ri.date_vendor_first_reported);
 self.date_vendor_last_reported  := ut.max2(le.date_vendor_last_reported, ri.date_vendor_last_reported);
 self.is_current		     := (boolean)ut.max2((unsigned)le.is_current, (unsigned)ri.is_current);
 self.Phone_Last_Updt    := (string)ut.max2((unsigned)le.Phone_Last_Updt , (unsigned)ri.Phone_Last_Updt );
 self := le;
end;

#uniquename(Experian_Phones_base)
%Experian_Phones_base% := rollup(%experianP_base_s%, 
					%t_rollup%(left, right), 
					Encrypted_Experian_PIN,
					phone_pos,
					Phone_digits,	
					Phone_type,
					Phone_Source,
					did,
					rec_type,
  				local);

file_out := %Experian_Phones_base%:INDEPENDENT;
endmacro;
