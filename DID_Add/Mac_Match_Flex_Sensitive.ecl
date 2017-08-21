//MATCHSET should be set of char1's indicating matchfields
/*
   matchset   -    should be set of char1's indicating the indicatives in infile
                          'A' = Address
                          'D' = DOB
                          'S' = ssn
                          'P' = phone
						  'Q' = exclude fuzzy logic

this macro is essentially the same, in this version, as the old match_flex
with the exception of using sensitive DOB matching.

perhaps a flag on the old macro would serve the same purpose.

*/


export Mac_Match_Flex_Sensitive
	(infile, matchset,						//see above
	 ssn_field, dob_field, fname_field, mname_field,lname_field, suffix_field, 
	 prange_field, pname_field, srange_field, zip_field, state_field, phone_field, //year_of_residence_field, not ready for release yet
	 DID_field,   			
	 outrec, 
	 bool_outrec_has_score, DID_Score_field,	//these should default to zero in definition
	 low_score_threshold,	//dids with a score below here will be dropped
	 outfile,
	 bool_clean_addr = 'false', // re-cleans addresses before trying match. 
	 predir_field = 'predir',addr_suffix_field = 'addr_suffix',postdir_field = 'postdir',
	 udesig_field = 'unit_desig',city_field = 'p_city_name',zip4_field = 'zip4') 
	:= macro

#uniquename(use_fuzzy)
%use_fuzzy% := 'Q' not in matchset;

#uniquename(inf) 	
#if (bool_clean_addr)
	#uniquename(pre_clean_rec)
	#uniquename(addr1)
	#uniquename(addr2)
	%pre_clean_rec% := record
		infile;
		string120	%addr1%;
		string120	%addr2%;
	end;

	#uniquename(into_clean)
	%pre_clean_rec% %into_clean%(infile L) := transform
		self.%addr1% := address.Addr1FromComponents(L.prange_field,L.predir_field,
									L.pname_field,L.addr_suffix_field,L.postdir_field,
									L.udesig_field,L.srange_field);
		self.%addr2% := address.Addr2FromComponents(l.city_field,L.state_field,L.zip_field+L.zip4_field);
		self := L;
	end;

	#uniquename(file_pre_clean)
	%file_pre_clean% := project(infile,%into_clean%(LEFT));

	#uniquename(file_cleaned)
	address.MAC_Address_Clean(%file_pre_clean%,%addr1%,%addr2%,true,%file_cleaned%)

	#uniquename(clean_fill)
	infile %clean_fill%(%file_cleaned% L) := transform
		self.prange_field := l.clean[1..10];
		self.Predir_field := l.clean[11..12];
		self.pname_field := l.clean[13..40];
		self.addr_Suffix_field := l.clean[41..44];
		self.Postdir_field := l.clean[45..46];
		self.udesig_field := l.clean[47..56];
		self.SRange_field := l.clean[57..64];
		self.City_field := l.clean[65..89];
		self.State_field := l.clean[115..116];
		self.Zip_field := l.clean[117..121];
		self.Zip4_field := l.clean[122..125];
		self := L;
	end;

	%inf% := project(%file_cleaned%,%clean_fill%(LEFT));
#else
	%inf% := infile;
#end

#uniquename(did_score)
#uniquename(pg_score)
#uniquename(id_layout)
%id_layout% := record
	unsigned6 temp_ID;
	unsigned1 %did_score% := 0;	//i will use my scoring fields regardless, and then assign at the end
	outrec;
end;

#uniquename(make_id_layout)
%id_layout% %make_id_layout%(%inf% l) := transform
	self.temp_ID := 0;
	self := l;
end;

#uniquename(infile_pre_id)
#uniquename(pre_infile_id)
%infile_pre_id% := project(%inf%, %make_id_layout%(left));			
ut.MAC_Sequence_Records(%infile_pre_id%,temp_ID,%pre_infile_id%)	

#uniquename(infile_id)	


	#uniquename(infile_dist)
    %infile_dist% := distribute(%pre_infile_id%(~(fname_field = '' and lname_field = '')), hash(
		#if('S' in matchset)
			ssn_field, 
		#end
		#if('D' in matchset)
			dob_field, 
		#end
		fname_field, mname_field,lname_field, suffix_field, 
		#if('A' in matchset or 'Q' in matchset)
			prange_field, pname_field, srange_field, state_field, 
		#end
		#if('A' in matchset or 'Q' in matchset or 'D' in matchset)
			zip_field, 
		#end
		#if('P' in matchset)
			phone_field,
		#end
		1));	//the one just keeps the commas from messing it up
	#uniquename(infile_srtd)
    %infile_srtd% := sort(%infile_dist%, 
		#if('S' in matchset)
			ssn_field, 
		#end
		#if('D' in matchset)
			dob_field, 
		#end
		fname_field, mname_field,lname_field, suffix_field, 
		#if('A' in matchset or 'Q' in matchset)
			prange_field, pname_field, srange_field, state_field, 
		#end
		#if('A' in matchset or 'Q' in matchset or 'D' in matchset)
			zip_field, 
		#end
		#if('P' in matchset)
			phone_field, 
		#end
		local);	
#uniquename(infile_grpd)
    %infile_grpd% := group(%infile_srtd%, 
		#if('S' in matchset)
			ssn_field, 
		#end
		#if('D' in matchset)
			dob_field, 
		#end
		fname_field, mname_field,lname_field, suffix_field, 
		#if('A' in matchset or 'Q' in matchset)
			prange_field, pname_field, srange_field, state_field, 
		#end
		#if('A' in matchset or 'Q' in matchset or 'D' in matchset)
			zip_field, 
		#end
		#if('P' in matchset)
			phone_field, 
		#end
		local);
	#uniquename(rid_em)
    %id_layout% %rid_em%(%id_layout% l, %id_layout% r) := transform
		self.temp_id := if (l.temp_id = 0, r.temp_id, l.temp_id);
		self := r;
	end;
	
	#uniquename(infile_iter)
	#uniquename(infile_slim)
	#uniquename(infile_slim_rec)
    %infile_iter% := iterate(%infile_grpd%, %rid_em%(left, right));	//this is where i will slap the DIDs back on
	%infile_slim_rec% := record
		%infile_iter%.temp_id;
		%infile_iter%.did_field;
		%infile_iter%.%did_score%;
		%infile_iter%.fname_field; 
		%infile_iter%.mname_field;
		%infile_iter%.lname_field;
		%infile_iter%.suffix_field; 
		#if('S' in matchset)
			%infile_iter%.ssn_field; 
		#end
		#if('D' in matchset)
			%infile_iter%.dob_field; 
		#end
		#if('A' in matchset or 'Q' in matchset)
			%infile_iter%.prange_field; 
			%infile_iter%.pname_field;
			%infile_iter%.srange_field;
			%infile_iter%.state_field;
		#end
		#if('A' in matchset or 'Q' in matchset or 'D' in matchset)
			%infile_iter%.zip_field; 
		#end
		#if('P' in matchset)
			%infile_iter%.phone_field;
		#end

	end;
	%infile_slim% := table(%infile_iter%, %infile_slim_rec%);
	%infile_id% := group(dedup(%infile_slim%, temp_id,all));


// IF SSN MATCH WANTED
#uniquename(outfile_ssn)
#uniquename(pre_outfile_ssn)

#if('S' in matchset)
	did_add.Mac_Match_NmSSN(%infile_id%,%pre_outfile_ssn%,
		did_field,%did_score%,
		fname_field,mname_field,lname_field,suffix_field,ssn_field,
		%use_fuzzy%)	
	did_add.mac_dedup_uid_did(%pre_outfile_ssn%, did_field, %outfile_ssn%)
#else
	%outfile_ssn% := %infile_id%;
#end

// IF ADDRESS MATCH WANTED
#uniquename(outfile_addr)
#uniquename(pre_outfile_addr)

#if('A' in matchset)
	did_add.Mac_Match_NmAddr_sensitive(%outfile_ssn%,%pre_outfile_addr%, 
		did_field,%did_score%,
		fname_field,mname_field,lname_field,suffix_field,
		prange_field,pname_field,srange_field,zip_field,state_field,
		%use_fuzzy%)	
	did_add.mac_dedup_uid_did(%pre_outfile_addr%, did_field, %outfile_addr%)
#else
	%outfile_addr% := %outfile_ssn%;
#end

// IF DOB MATCH WANTED
#uniquename(outfile_dob)
#uniquename(pre_outfile_dob)

#if('D' in matchset)
	did_add.Mac_Match_NmDayOBZip_Sensitive(%outfile_addr%,%pre_outfile_dob%,
		did_field,%did_score%,
		fname_field,mname_field,lname_field,suffix_field,dob_field,zip_field,
		%use_fuzzy%)	
	did_add.mac_dedup_uid_did(%pre_outfile_dob%, did_field, %outfile_dob%)
#else
	%outfile_dob% := %outfile_addr%;
#end


// IF PHONE MATCH WANTED
#uniquename(outfile_phone)

#if('P' in matchset)
	did_add.Mac_Match_NmPhone(%outfile_dob%,%outfile_phone%,
		did_field,%did_score%,
		fname_field,mname_field,lname_field,suffix_field,phone_field)	
	//don't need dedup here cause it's the last one
#else
	%outfile_phone% := %outfile_dob%;
#end



//****** Dedup the matches
#uniquename(pre_all_recs_clean)
did_Add.MAC_Dedup_DIDs(%outfile_phone%, temp_id, did_field, %did_score%,
					   %pre_all_recs_clean%)
#uniquename(all_recs_clean)


//****** Take the DID and score off the dedupped rec and put it back on the orig
	#uniquename(arc_dist)
    %arc_dist% := distribute(%pre_all_recs_clean%, hash(temp_id));
/*
		#if('S' in matchset)
			ssn_field, 
		#end
		#if('D' in matchset)
			dob_field, 
		#end
		fname_field, mname_field,lname_field, suffix_field, 
		#if('A' in matchset or 'Q' in matchset)
			prange_field, pname_field, srange_field, state_field,
		#end
		#if('A' in matchset or 'Q' in matchset or 'D' in matchset)
			zip_field, 
		#end
		#if('P' in matchset)
			phone_field,
		#end
		1));	//the one just keeps the commas from messing it up
*/	

	#uniquename(putemback)
    %id_layout% %putemback%(%id_layout% l, %arc_dist% r) := transform
		self.did_field := r.did_field;
		self.%did_score% := r.%did_score%;
		self := l;
	end;

	
	%all_recs_clean% := join(distribute(%infile_iter%,hash(temp_id)), %arc_dist%,
						     left.temp_id = right.temp_id,
							 %putemback%(left, right), left outer, local) + %pre_infile_id%(fname_field = '' and lname_field= '');



//****** Strip off the temp_id (and optionally assign the scores)
#uniquename(strip_id)

outrec %strip_id%(%id_layout% l) := transform
	self.did_field := if(l.%did_score% < low_score_threshold, 0, l.did_field);
	#if(bool_outrec_has_score)
			self.DID_Score_field := l.%did_score%;
	#end
	self := l;
end;


//*********************
//****** 		ROXIE route
//*********************
/*
#uniquename(roxprep)
did_add.Layout_Did_InBatch %roxprep%(%pre_infile_id% l) := transform
	#if('S' in matchset)
		self.ssn := (qSTRING9)l.ssn_field;
	#end
	#if('D' in matchset)
		self.dob:= (qSTRING8)l.dob_field;
	#end
	#if('A' in matchset)
		self.prim_range := (qSTRING10)l.prange_field;
		self.predir := '';
		self.prim_name := (qSTRING28)l.pname_field;
		self.addr_suffix := '';
		self.postdir := '';
		self.unit_desig := '';
		self.sec_range := (qSTRING8)l.srange_field; 
	#end
	#if('A' in matchset or 'D' in matchset)
		self.z5 := (qSTRING5)l.zip_field;
	#end
	#if('P' in matchset)
		self.phone10 := (qstring10)l.phone_field;
	#end
	self.seq := l.temp_id;
	self.fname := (qSTRING20)l.fname_field;
	self.mname := (qSTRING20)l.mname_field;
	self.lname := (qSTRING20)l.lname_field;
	self.suffix := (qSTRING5)l.suffix_field; 
	self.title := '';
	self.p_city_name := '';
	self.st := (qSTRING2)'';
	self.zip4 := '';
end;

#uniquename(roxin)
%roxin% := project(%pre_infile_id%, %roxprep%(left));

#uniquename(roxout)
did_add.MAC_Match_Roxie(%roxin%, %roxout%, outrec)

//** Reappend the full rec
#uniquename(postrox)
typeof(%pre_infile_id%) %postrox%(%pre_infile_id% l, %roxout% r) := transform
	self.did_field := r.did;
	self.%did_score% := r.score;
	self := l;
end;

#uniquename(roxplus)
%roxplus% := join(%pre_infile_id%, %roxout%,
				left.temp_id = right.seq,
				%postrox%(left, right), 
				lookup);

//****** Pick which route to go
#uniquename(force)
string4 %force% := '' : stored('did_add_force');

#uniquename(preclean)
%preclean% := if(%force% = 'thor' or (count(infile) > 2000000 and %force% <> 'roxi'),
			     %all_recs_clean%,
			     %roxplus%);


outfile := project(%preclean%, %strip_id%(left));
*/

outfile := project(%all_recs_clean%, %strip_id%(left));

endmacro;