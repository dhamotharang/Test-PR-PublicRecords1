import ut;

//TODO -- I think this may ONLY need to be done for APPEND data mode - replace data mode would not do this??

EXPORT z_Fn_Rollup_Base_History_ORIG(dataset(recordof(_layouts.Base)) email_in) := FUNCTION

		//Previous incremental base -  Reset current record flag to false																															
		reset_prev_base := project(_files.File_Email_Base_DS, transform(recordof(email_in), self.current_rec := false,
																																																		self := left));

		//Concatenate new and previous base
		current_and_prev := if(nothor(FileServices.GetSuperFileSubCount(_constants.baseSuperFileString)) = 0,
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
										 current_rec, local);

		//Rollup files to eliminate duplications and to keep history on when a record was first and last included in the build
		recordof(email_in) tRollup(current_and_prev_s le, current_and_prev_s ri) := TRANSFORM
			SELF.current_rec              :=  if(le.current_rec > ri.current_rec, le.current_rec, ri.current_rec);
			SELF.process_date							:=	ri.date_last_seen;  //Populate process_date since not all sets have it and it is not mapped
			self.date_first_seen 						:= (string)ut.EarliestDate((unsigned)le.date_first_seen, (unsigned)ri.date_first_seen);
			self.date_last_seen  						:= (string)ut.LatestDate((unsigned)le.date_last_seen, (unsigned)ri.date_last_seen);
			self.date_vendor_first_reported := (string)ut.EarliestDate((unsigned)le.date_vendor_first_reported, (unsigned)ri.date_vendor_first_reported);
			self.date_vendor_last_reported	:= (string)ut.LatestDate((unsigned)le.date_vendor_last_reported, (unsigned)ri.date_vendor_last_reported);
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


		RETURN Rollup_file;
END;