import ut;
export Fn_Rollup_Base_History(dataset(recordof(Layout_Email.Base)) email_in) := function

//Previous incremental base -  Reset current record flag to false																															
reset_prev_base := project(Email_data.File_Email_Base, transform(recordof(email_in), self.current_rec := false,
                                                                                                self := left));

//Concatenate new and previous base
current_and_prev := if(FileServices.GetSuperFileSubCount('~thor_data400::base::email_data') = 0,
												email_in,
												email_in + reset_prev_base);
current_and_prev_d := distribute(current_and_prev, hash(email_rec_key));
current_and_prev_s := sort(current_and_prev_d, email_rec_key, 
								 clean_name.fname,
       					 clean_name.mname,
								 clean_name.lname,
								 clean_address.prim_range,
								 clean_address.prim_name,
								 clean_address.sec_range,
								 clean_address.zip,
								 email_src,
									 -current_rec, local);

//Rollup files to eliminate duplications and to keep history on when a record was first and last included in the build
recordof(email_in) tRollup(current_and_prev_s le, current_and_prev_s ri) := TRANSFORM
  SELF.current_rec              :=  if(le.current_rec > ri.current_rec, le.current_rec, ri.current_rec);
	SELF := ri;
end;
	
	
Rollup_file   := ROLLUP(current_and_prev_s, tRollup(LEFT, RIGHT),
			           email_rec_key, 
								 clean_name.fname,
       					 clean_name.mname,
								 clean_name.lname,
								 clean_address.prim_range,
								 clean_address.prim_name,
								 clean_address.sec_range,
								 clean_address.zip,
								 email_src,
                                     
  local);


return Rollup_file;
end;