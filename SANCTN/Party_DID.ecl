IMPORT bankrupt,did_add,fair_isaac,didville,ut,header_slimsort,watchdog, Business_Header, Business_Header_SS;

df := SANCTN.file_out_party_cleaned;

temprec := record
	df;
	string		blk := '';
	unsigned6	did_temp := 0;
	unsigned1 	did_score_temp := 0;
	string9		ssn_appended_temp := '';
end;

df2 := table(df,temprec);


myset := ['A','D','S','Q','Z'];

did_add.MAC_Match_Flex(df2
                      ,myset
					  ,SSNUMBER
					  ,blk
					  ,fname
					  ,mname
					  ,lname
					  ,name_suffix
					  ,prim_range
					  ,prim_name
					  ,sec_range
					  ,zip5
					  ,state
					  ,blk
					  ,did_temp
					  ,temprec
					  ,true
					  ,did_score_temp
					  ,70
					  ,outf)

did_add.MAC_Add_SSN_By_DID(outf
                          ,did_temp
						  ,ssn_appended_temp
						  ,out2
						  ,true)	
				
typeof(df) into(out2 L) := transform
	self.did := L.did_temp; //if (L.did_temp = 0,'',intformat(L.did_temp,12,1));
	self.did_score := intformat(L.did_score_temp,3,1);
	self := L;
end;

out4 := project(out2,into(LEFT)) : PERSIST(SANCTN.cluster + 'persist::SANCTN::party_did');

export Party_DID := out4;
