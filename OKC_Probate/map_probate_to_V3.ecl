IMPORT ut, MDR, address, header, RoxieKeyBuild, DID_Add,OKC_Probate, STD;

EXPORT map_probate_to_V3(STRING pVersion	=	(STRING)STD.Date.Today()) := FUNCTION

	ds_probate := OKC_Probate.Files().file_base;
	ds_probate_dedup	:=	DEDUP(SORT(DISTRIBUTE(ds_probate,
																						HASH(	DebtorFirstName,DebtorLastName,DebtorAddress1,DebtorAddress2,DebtorAddressCity,DebtorAddressState,DebtorAddressZipCode,DateOfDeath,DateOfBirth)),
																												DebtorFirstName,DebtorLastName,DebtorAddress1,DebtorAddress2,DebtorAddressCity,DebtorAddressState,DebtorAddressZipCode,DateOfDeath,DateOfBirth,-filedate,LOCAL),
																												DebtorFirstName,DebtorLastName,DebtorAddress1,DebtorAddress2,DebtorAddressCity,DebtorAddressState,DebtorAddressZipCode,DateOfDeath,DateOfBirth,LOCAL);

	layout_probate_did := RECORD
		UNSIGNED6	l_did	:=	0;
		UNSIGNED1	did_score	:=	0;
		ds_probate;
		UNSIGNED4	xadl2_keys_used				:=	0 ;
		STRING				xadl2_keys_desc				:=	'';
		INTEGER2		xadl2_weight							:=	0 ;
		UNSIGNED2	xadl2_Score								:=	0 ;
		UNSIGNED2	xadl2_distance					:=	0 ;
		STRING22		xadl2_matches						:=	'';
		STRING				xadl2_matches_desc	:=	'';
	END;
	
	layout_probate_did	tAddPID(ds_probate_dedup	pInput)	:=	TRANSFORM
		SELF.dob	:=	IF((UNSIGNED)pInput.dob<=19000101,'00000000',pInput.dob);
		SELF.dod	:=	IF((UNSIGNED)pInput.dod<=19000101,'00000000',pInput.dod);
		SELF.persistent_record_ID	:=	HASH32(	
																																							TRIM(pInput.DebtorFirstName,LEFT,RIGHT)+
																																							TRIM(pInput.DebtorLastName,LEFT,RIGHT)+
																																							TRIM(pInput.DebtorAddress1,LEFT,RIGHT)+
																																							TRIM(pInput.DebtorAddress2,LEFT,RIGHT)+
																																							TRIM(pInput.DebtorAddressCity,LEFT,RIGHT)+
																																							TRIM(pInput.DebtorAddressState,LEFT,RIGHT)+
																																							TRIM(pInput.DebtorAddressZipCode,LEFT,RIGHT)+
																																							TRIM(pInput.DateOfDeath,LEFT,RIGHT)+
																																							TRIM(pInput.DateOfBirth,LEFT,RIGHT)
																																						);
		SELF	:=	pInput;
	END;
	
	prep_did	:=	PROJECT(ds_probate_dedup,tAddPID(LEFT));
									 
	//Append Did
	/* matchset := [ 'A' 	// Address
									,'D'	// DOB
									,'S'	// ssn
									,'P'	// phone
									,'Q'	// Address match excluding the fuzzy logic.  Equivalent to setting use_fuzzy = false in previous versions.  Acts the same regardless of whether matchset contains 'A'.
									,'4'	// ssn4 matching (last 4 digits of ssn)
									,'G'	// age matching
									,'Z'	// zip code matching];		
	*/	
	matchset := ['D','A','Z'];

	// did_add.MAC_Match_Flex
		// (prep_did, matchset,					
		 // foo, dob, cln_fname, cln_mname, cln_lname, cln_suffix,
		 // prim_range, prim_name, sec_range, zip_lastres, state,foo, 
		 // l_did, layout_probate_did, 
		 // true, did_Score,90, 
		 // probate_with_dids,TRUE,src );
		 
	DID_Add.Mac_Match_Flex(	prep_did,	// Input Dataset
													matchset,													// BDID Matchset what fields to match on
													foo,																		// SSN or Tax ID
													dob,																		// DOB
													cln_fname,												// First Name
													cln_mname,												// Middle Name
													cln_lname,												// Last Name
													cln_suffix,											// Suffix
													prim_range,											// prim_range
													prim_name,												// prim_name
													sec_range,												// sec_range
													zip,																		// zip5
													st,																			// state
													foo,																		// phone
													l_did,																// did
													layout_probate_did,			// Output Layout
													TRUE,																	// has score field
													did_score,												// did_score
													90,																			// threshold
													probate_with_dids					// Output Dataset
													// TRUE,																	//	has source field
													// src																			//	source field
												);


	header.Layout_Did_Death_MasterV3 map_dmasterv3(probate_with_dids l)	:= TRANSFORM
			self.filedate  							:= l.filedate;
			SELF.did			   								:= INTFORMAT(l.l_did,12,1);
			SELF.did_score								:=	IF((UNSIGNED)SELF.did=0,0,l.did_score);
		 self.rec_type  							:= '';
		 self.rec_type_orig 			:= '';
		 self.ssn 													:= '';
		 self.vorp_code 							:= '';
		 self.st_country_code 	:= l.fips_state;
		 self.crlf 												:= '';
		 self.src      								:= OKC_Probate.Constants().source;
		 self.state_death_flag	:= 'N';
		 self.glb_flag									:= 'N';
			self.dob8													:=	l.dob;
			self.dod8													:=	l.dod;		
		 self.state												:=	l.st;
		 self.zip_lastres						:=	l.zip;
			self.zip_lastpayment		:=	'';	 
		 self.fipscounty   				:= l.fips_county;
			self.fname        				:= l.cln_fname;
		 self.mname        				:= l.cln_mname;
		 self.lname        				:= l.cln_lname;
		 self.name_suffix						:= l.cln_suffix;
		 SELF.death_rec_src  		:= 'OKC';
			SELF.state_death_id			:=  INTFORMAT(l.persistent_record_id,13,1)+SELF.death_rec_src;
			self	:= l;
			self := [];
	end;

	probate_with_dids_sort	:=		SORT(probate_with_dids,l_did):PERSIST(PersistNames.OKCProbateDID);
	ds_probate_dmaterv3	:= project(probate_with_dids_sort,map_dmasterv3(left));

	return ds_probate_dmaterv3;
END;