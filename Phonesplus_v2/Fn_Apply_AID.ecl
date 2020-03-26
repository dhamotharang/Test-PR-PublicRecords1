import aid, address;
export Fn_Apply_AID (dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

temp_layout := record
	recordof(phplus_in);
	string address1_;
	string address2_;
end;

temp_layout t_clean_adrr (phplus_in le) := TRANSFORM
	self.address1_ :=  StringLib.StringCleanSpaces(trim(trim(stringlib.stringtouppercase(le.Address1), left, right) + ' ' +
										     trim(stringlib.stringtouppercase(le.Address2), left, right) + ' ' +
										     trim(stringlib.stringtouppercase(le.Address3), left, right)
												 , left, right));
																				;
	self.address2_ := StringLib.StringCleanSpaces(Address.Addr2FromComponents(
																						 stringlib.stringtouppercase(le.OrigCity)	
																						,stringlib.stringtouppercase(le.OrigState						)	
																						,stringlib.stringtouppercase(le.OrigZip[..5] 				)
																				));
	self := le;
end;

phones_clean_add := PROJECT(phplus_in, t_clean_adrr(LEFT));

// AID
			unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords | AID.Common.eReturnValues.NoNewCacheFiles; //Jira DF-23863
	    AID.MacAppendFromRaw_2Line(phones_clean_add, address1_, address2_, RawAID, withAID, lFlags);
			
recordof(phplus_in) t_append_aid (withAID input):= Transform
		 self.RawAID      := 		input.aidwork_rawaid; 
		 self.cleanaid 		:=    input.aidwork_acecache.cleanaid;
		 self             :=    input;
end;

phoneswithAID := project(withAID, t_append_aid(left));

//Filter Results w/o States
noPhState := phoneswithAID(trim(state, left, right)='');
phState		:= phoneswithAID(trim(state, left, right)<>'');

phonesWithAID addSt(noPhState l):= transform
		self.state 	:= ziplib.ziptostate2(l.zip5);
		self 				:= l;
end;

addState 	:= project(noPhState, addSt(left));
allRec		:= addState + phState;

return allRec;
end;