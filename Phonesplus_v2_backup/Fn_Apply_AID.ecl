import aid, address;
export Fn_Apply_AID (dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

temp_layout := record
	recordof(phplus_in);
	string address1;
	string address2;
end;

temp_layout t_clean_adrr (phplus_in le) := TRANSFORM
	self.address1 :=  StringLib.StringCleanSpaces(trim(trim(stringlib.stringtouppercase(le.orig_address1), left, right) + ' ' +
										     trim(stringlib.stringtouppercase(le.orig_address2), left, right) + ' ' +
										     trim(stringlib.stringtouppercase(le.orig_address3), left, right)
												 , left, right));
																				;
	self.address2 := StringLib.StringCleanSpaces(Address.Addr2FromComponents(
																						 stringlib.stringtouppercase(le.orig_city)	
																						,stringlib.stringtouppercase(le.orig_state						)	
																						,stringlib.stringtouppercase(le.orig_zip[..5] 				)
																				));
	self := le;
end;

phones_clean_add := PROJECT(phplus_in, t_clean_adrr(LEFT));

// AID
			unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
	    AID.MacAppendFromRaw_2Line(phones_clean_add, address1, address2, RawAID, withAID, lFlags);
			
recordof(phplus_in) t_append_aid (withAID input):= Transform
		 self.RawAID      := 		input.aidwork_rawaid; 
		 self.cleanaid 		:=    input.aidwork_acecache.cleanaid;
		 self             :=    input;
end;

phoneswithAID := project(withAID, t_append_aid(left));

return phoneswithAID;
end;