export MAC_Match_Fast(infile, matchset, outfile, for_moxie = 'true', add_ssns = 'true', glb = 'true')
	:= macro

#uniquename(outrec)
%outrec% := record
	infile;
	#if(for_moxie)
		string12 did_string := '';
		string3	 did_score := '';
	#else
		unsigned6 	did := 0;
		unsigned1	did_score := 0;
	#end
		unsigned1	score_any_ssn := 0;
		unsigned1	score_any_dob := 0;
		unsigned1	score_any_phn := 0;
		unsigned1	score_any_addr := 0;
		unsigned1	score_any_fzzy := 0;
	#if(add_ssns)
		string9 best_ssn := '';
	#end
end;

//****** Add a temp field for carrying the DID
#uniquename(rec)
%rec% := record
	%outrec%;
	unsigned6 temp_did;
	unsigned1 temp_score;
end;
	
#uniquename(addtemp)
%rec% %addtemp%(infile l) := transform	
	self.temp_did := 0;
    self.temp_score := 0;
	self := l;
end;
	
#uniquename(inmac)
%inmac% := project(infile, %addtemp%(left));

//****** Add the DIDs
#uniquename(wdid)
did_Add.MAC_Match_Flex
	(%inmac%, matchset,						
	 ssn, dob, fname, mname,lname, suffix, 
	 prim_range, prim_name, sec_range, z5, st, phone10, 
	 temp_DID,   			
	 %rec%, 
	 true, temp_Score, 	
	 0,	
	 %wdid%,true,true,score_any_addr,score_any_dob,score_any_ssn,score_any_phn,score_any_fzzy)

//****** Add the SSN (if desired)
#uniquename(wssn)
#if(add_ssns)
	did_add.MAC_Add_SSN_By_DID(%wdid%, temp_DID, best_ssn, %wssn%, glb)
#else
	%wssn% := %wdid%;
#end

//****** Transfer from the temp field to the outgoing DID field
#uniquename(tra)
%outrec% %tra%(%wssn% l) := transform
	#if(for_moxie)
		self.did_string := intformat(l.temp_DID, 12, 1);
		self.did_score := intformat(L.temp_score,3,1);
	#else
		self.did := l.temp_did;
		self.did_score := l.temp_score;
	#end
	self := l;
end;

outfile := project(%wssn%, %tra%(left));

endmacro;