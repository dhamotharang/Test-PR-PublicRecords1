IMPORT Autokey_batch, NID;

EXPORT fn_add_xtra_dc_matchcodes(
	DATASET(layout_Death_Batch_out) ds,
	DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ds_comp,
	UNSIGNED3 did_score_threshold=Constants.Death.DEFAULT_DID_SCORE_THRESHOLD,
	BOOLEAN matchcode_adl_append=TRUE,
	BOOLEAN usePartialName=FALSE) := FUNCTION

	/* name match */
	NameMatchCond() := MACRO
		LEFT.fname!='' AND LEFT.lname!='' AND
		left_fname_trim[1..4]=right_fname_trim[1..4] AND
		left_lname_trim[1..10]=right_lname_trim[1..10]
	ENDMACRO;

	/* full SSN match */
	SSNMatchCond() := MACRO
		RIGHT.ssn!='' AND
		(LENGTH(right_ssn_trim)=8 OR LENGTH(right_ssn_trim)=9) AND
		left_ssn_trim=right_ssn_trim
	ENDMACRO;

	/* address match */
	AddressMatchCond() := MACRO
		(RIGHT.prim_range+RIGHT.predir+RIGHT.prim_name+RIGHT.addr_suffix+RIGHT.postdir+RIGHT.unit_desig+RIGHT.sec_range!='') AND
		 ((TRIM(LEFT.prim_range,LEFT,RIGHT) = TRIM(RIGHT.prim_range,LEFT,RIGHT) OR RIGHT.prim_range='') AND 
			(TRIM(LEFT.predir,LEFT,RIGHT) = TRIM(RIGHT.predir,LEFT,RIGHT) OR RIGHT.predir='') AND 
			(TRIM(LEFT.prim_name,LEFT,RIGHT) = TRIM(RIGHT.prim_name,LEFT,RIGHT)) AND 
			(TRIM(LEFT.addr_suffix,LEFT,RIGHT) = TRIM(RIGHT.addr_suffix,LEFT,RIGHT) OR RIGHT.addr_suffix='') AND 
			(TRIM(LEFT.postdir,LEFT,RIGHT) = TRIM(RIGHT.postdir,LEFT,RIGHT) OR RIGHT.postdir='') AND 
			(TRIM(LEFT.unit_desig,LEFT,RIGHT) = TRIM(RIGHT.unit_desig,LEFT,RIGHT) OR RIGHT.unit_desig='') AND 
			(TRIM(LEFT.sec_range,LEFT,RIGHT) = TRIM(RIGHT.sec_range,LEFT,RIGHT) OR RIGHT.sec_range=''))
	ENDMACRO;

	/* city state match */
	CityStMatchCond() := MACRO
		LEFT.p_city_name!='' AND LEFT.state!='' AND
		TRIM(LEFT.p_city_name,LEFT,RIGHT)=TRIM(RIGHT.p_city_name,LEFT,RIGHT) AND 
		TRIM(LEFT.state,LEFT,RIGHT)=TRIM(RIGHT.st,LEFT,RIGHT)
	ENDMACRO;

	/* zip match */
	ZIPMatchCond() := MACRO
		LEFT.zip_lastres!='' AND
		LEFT.zip_lastres=RIGHT.z5
	ENDMACRO;

	/* phonetic last name match */
	NameMatchesWithLastNamePhonetic(fname1,lname1,fname2,lname2) := MACRO
		(LENGTH(TRIM(fname1,LEFT,RIGHT))>0 AND LENGTH(TRIM(lname1,LEFT,RIGHT))>0  AND
		 LENGTH(TRIM(fname2,LEFT,RIGHT))>0 AND LENGTH(TRIM(lname2,LEFT,RIGHT))>0) AND
		StringLib.StringCompareIgnoreCase(
			NID.PreferredFirstNew(TRIM(REGEXREPLACE('\\W',fname1,' '),LEFT,RIGHT),TRUE)[1..4],
			NID.PreferredFirstNew(TRIM(REGEXREPLACE('\\W',fname2,' '),LEFT,RIGHT),TRUE)[1..4])=0 AND
		StringLib.StringCompareIgnoreCase(
			MetaphoneLib.DMetaphone1(TRIM(REGEXREPLACE('\\W',lname1,' '),ALL)),
			MetaphoneLib.DMetaphone1(TRIM(REGEXREPLACE('\\W',lname2,' '),ALL)))=0
	ENDMACRO;

	PhoneticLastNameMatchCond(matchcode) := MACRO	
		NOT REGEXFIND(MatchCodes.name,matchcode) // mutually exclusive to name match code 'N'
		AND NameMatchesWithLastNamePhonetic(LEFT.fname,LEFT.lname,RIGHT.name_first,RIGHT.name_last) AND 
		(REGEXFIND(MatchCodes.ssn_full,matchcode) OR (REGEXFIND(MatchCodes.zip,matchcode) AND
		 TRIM(LEFT.zip4,ALL)=TRIM(RIGHT.zip4,ALL))) // requires full SSN match code 'S' or full 9 zip match
	ENDMACRO;

	/* ADL match */
	ADLMatchCond() := MACRO
		LEFT.isdeepdive AND 
		(((UNSIGNED6)LEFT.did)=RIGHT.did AND
		 ((UNSIGNED6)LEFT.did)!=0)
	ENDMACRO;

	/* SSN + partial name match */
	LastNameMatchCond() := MACRO
		LEFT.lname!='' AND left_lname_trim=right_lname_trim
	ENDMACRO;
	FirstInitialMatchCond() := MACRO
		LEFT.fname!='' AND left_fname_trim[1]=right_fname_trim[1]
	ENDMACRO;
	FirstNameMatchCond() := MACRO
		LEFT.fname!='' AND left_fname_trim=right_fname_trim
	ENDMACRO;
	LastInitialMatchCond() := MACRO
		LEFT.lname!='' AND left_lname_trim[1]=right_lname_trim[1]
	ENDMACRO;

	SsnPartialNameMatchCond(matchcode) := MACRO	
		NOT REGEXFIND(MatchCodes.name,matchcode) // mutually exclusive to name match code 'N'
		AND REGEXFIND(MatchCodes.ssn_full,matchcode) AND // requires full SSN match code 'S'
		 ((LastNameMatchCond() AND FirstInitialMatchCond()) OR
		  (FirstNameMatchCond() AND LastInitialMatchCond()) OR
		   LastNameMatchCond() OR FirstNameMatchCond())
	ENDMACRO;

	ds_mc := JOIN(ds,ds_comp,LEFT.acctno=RIGHT.acctno,TRANSFORM(layout_Death_Batch_out,
		// STRIP TRIM UPPER PREFERRED NAMEs
		left_fname_strip  := REGEXREPLACE('\\W',LEFT.fname,' ');
		left_fname_trim   := StringLib.StringToUpperCase(NID.PreferredFirstNew(TRIM(left_fname_strip,LEFT,RIGHT),TRUE));
		left_lname_strip  := REGEXREPLACE('\\W',LEFT.lname,' ');
		left_lname_trim   := StringLib.StringToUpperCase(TRIM(left_lname_strip,ALL));
		right_fname_strip := REGEXREPLACE('\\W',RIGHT.name_first,' ');
		right_fname_trim  := StringLib.StringToUpperCase(NID.PreferredFirstNew(TRIM(right_fname_strip,LEFT,RIGHT),TRUE));
		right_lname_strip := REGEXREPLACE('\\W',RIGHT.name_last,' ');
		right_lname_trim  := StringLib.StringToUpperCase(TRIM(right_lname_strip,ALL));
		// TRIM SSNs
		right_ssn_trim := TRIM(RIGHT.ssn,LEFT,RIGHT);
		left_ssn_trim  := TRIM(LEFT.ssn,LEFT,RIGHT);
		// MATCH CODES
		STRING mc_name  := IF(NameMatchCond(),MatchCodes.name,'');
		STRING mc_ssn   := IF(SSNMatchCond(),mc_name+MatchCodes.ssn_full,mc_name);
		STRING mc_addr  := IF(AddressMatchCond(),mc_ssn+MatchCodes.addr,mc_ssn);
		STRING mc_city  := IF(CityStMatchCond(),mc_addr+MatchCodes.city,mc_addr);
		STRING mc_zip   := IF(ZIPMatchCond(),mc_city+MatchCodes.zip,mc_city);
    // PhoneticLastNameMatchCond() has dependency on mc_name, mc_ssn and mc_zip
		STRING mc_pname := IF(PhoneticLastNameMatchCond(mc_zip),mc_zip+MatchCodes.name,mc_zip);
		STRING mc_did   := IF(ADLMatchCond(),mc_pname+MatchCodes.did,mc_pname);
    // SsnPartialNameMatchCond() has dependency on mc_name, mc_pname and mc_ssn
		STRING mc_spn   := IF(usePartialName AND SsnPartialNameMatchCond(mc_did),mc_did+MAP(
										LastNameMatchCond() AND FirstInitialMatchCond() => MatchCodes.last_fi,
										LastNameMatchCond() => MatchCodes.lastname,
										FirstNameMatchCond() AND LastInitialMatchCond() => MatchCodes.first_li,
										FirstNameMatchCond() => MatchCodes.firstname,''),mc_did);
		SELF.matchcode := mc_spn;
		SELF:=LEFT),
		LEFT OUTER);

	/*	order match code	*/
	ds_ordered_mc := PROJECT(ds_mc,TRANSFORM(layout_Death_Batch_out,
										SELF.matchcode:=Functions.fn_reorder_matchcode(LEFT.matchcode),
										SELF:=LEFT));
										
	/*	ADL address match code append - see Bug 51541	*/
	ds_adl_append := JOIN(ds_ordered_mc,ds_comp,LEFT.acctno=RIGHT.acctno,
		TRANSFORM(layout_Death_Batch_out,
			SELF.matchcode:=IF(matchcode_adl_append,
				Functions.fn_augment_addr_matchcode(LEFT.matchcode,
					RIGHT.prim_range+RIGHT.predir+RIGHT.prim_name+RIGHT.addr_suffix+RIGHT.postdir,
					RIGHT.p_city_name,RIGHT.st,RIGHT.z5,RIGHT.score,,did_score_threshold,),
				StringLib.StringFilterOut(LEFT.matchcode,MatchCodes.did));
			SELF:=LEFT));

	ds_ddp := DEDUP(SORT(ds_adl_append,acctno,state_death_id,-matchcode),acctno,state_death_id,matchcode);	
	
	// DEBUGS
	// OUTPUT(ds, 					NAMED('ds'));
	// OUTPUT(ds_comp, 			NAMED('ds_comp'));
	// output(ds_mc, 				NAMED('ds_mc'));
	// OUTPUT(ds_ordered_mc,		NAMED('ds_ordered_mc'));
	// OUTPUT(ds_adl_append,		NAMED('ds_adl_append'));
	// OUTPUT(ds_ddp,				NAMED('ds_ddp'));

	return ds_ddp;
end;