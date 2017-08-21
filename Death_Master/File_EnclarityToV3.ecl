IMPORT	Enclarity, MDR, Header, ut, Address;

//**********************PROJECT ENCLARITY DATA****************************//
// record_type='C' means the record is current versus 'H' which is historical
dEnclarityIn				:=	DISTRIBUTE(Enclarity.files(,TRUE).individual_base.qa(did > 0 AND record_type='C' AND provider_status IN ['D','U','U1']),HASH(did));
dEnclarityIn_srt		:=	SORT(dEnclarityIn, did,-dt_vendor_last_reported,-best_ssn,-best_dob,LOCAL);

Header.Layout_Did_Death_MasterV3	tStandardizeEnclarity(Enclarity.layouts.individual_base	pInput)	:=
TRANSFORM
	SELF.did									:=	(STRING)INTFORMAT(pInput.did,12,1);
	SELF.did_score						:=	pInput.did_score;
	SELF.filedate							:=	(STRING)pInput.dt_vendor_last_reported;
	SELF.rec_type							:=	''; 
	SELF.rec_type_orig				:=	'';
	SELF.ssn									:=	pInput.clean_ssn;
	SELF.lname								:=	pInput.lname;
	SELF.name_suffix					:=	pInput.name_suffix;
	SELF.fname								:=	pInput.fname;
	SELF.mname								:=	pInput.mname;
	SELF.vorp_code						:=	'';
	SELF.dod8									:=	pInput.date_of_death;
	SELF.dob8									:=	pInput.clean_dob;
	SELF.zip_lastres					:=	pInput.zip;
	SELF.zip_lastpayment			:=	'';
	SELF.state								:=	pInput.st;
	// Fill FIPS State and County if it's not already filled by Enclarity
	STRING182 clean_address1	:=	Address.CleanAddress182('',SELF.zip_lastres);
	SELF.st_country_code			:=	IF(pInput.fips_st<>'',
																	pInput.fips_st,
																	Address.CleanAddressFieldsFips(clean_address1).fips_state);
	SELF.fipscounty						:=	IF(pInput.fips_county<>'',
																	pInput.fips_county,
																	Address.CleanAddressFieldsFips(clean_address1).fips_county);
	SELF.crlf									:=	'';
	SELF.state_death_flag 		:=	'N';
	SELF.death_rec_src				:=	'ENC';
	SELF.state_death_id				:=	SELF.did+SELF.lname[1]+SELF.death_rec_src;
	SELF.src									:=	pInput.src;
	SELF.GLB_flag							:=	'N';
end;

dEnclarityInV3	:=	PROJECT(dEnclarityIn_srt,tStandardizeEnclarity(LEFT),LOCAL);

// Collect the maximum amount of information from Duplicate records
Header.Layout_Did_Death_MasterV3	tRollupEnclarity(dEnclarityInV3	L, dEnclarityInV3 R)	:=
TRANSFORM
	SELF.filedate					:=	IF(L.filedate					<>	'', L.filedate,					R.filedate);
	SELF.ssn							:=	IF(L.ssn							<>	'', L.ssn,							R.ssn);
	SELF.lname						:=	IF(L.lname						<>	'', L.lname,						R.lname);
	SELF.name_suffix			:=	IF(L.name_suffix			<>	'', L.name_suffix,			R.name_suffix);
	SELF.fname						:=	IF(L.fname						<>	'', L.fname,						R.fname);
	SELF.mname						:=	IF(L.mname						<>	'', L.mname,						R.mname);
	SELF.dod8							:=	IF(L.dod8							<>	'', L.dod8,							R.dod8);
	SELF.dob8							:=	IF(L.dob8							<>	'', L.dob8,							R.dob8);
	SELF.zip_lastres			:=	IF(L.zip_lastres			<>	'', L.zip_lastres,			R.zip_lastres);
	SELF.state						:=	IF(L.state						<>	'', L.state,						R.state);
	SELF.st_country_code	:=	IF(L.st_country_code	<>	'', L.st_country_code,	R.st_country_code);
	SELF.fipscounty				:=	IF(L.fipscounty				<>	'', L.fipscounty,				R.fipscounty);
	SELF.state_death_id		:=	IF(L.state_death_id		<>	'', L.state_death_id,		R.state_death_id);
	SELF									:=	L;
end;

dEnclarityRollupInV3	:=	ROLLUP(	dEnclarityInV3,
																		(UNSIGNED6)LEFT.did	=	(UNSIGNED6)RIGHT.did,
																	tRollupEnclarity(LEFT, RIGHT),LOCAL);

//temp reformat dob, did, and ssn to be able to run Mac_Dodgy_SSN_and_DOB_suppression
dodgyLayout := RECORD
	Header.Layout_Did_Death_MasterV3 AND NOT [did, ssn];
	INTEGER4	dob;
	UNSIGNED6	did;
	QSTRING9	ssn;
end;

dEnclarityInDodgyLayout := PROJECT(dEnclarityRollupInV3, TRANSFORM(	dodgyLayout, 
																																		SELF.dob	:= (INTEGER4)		LEFT.dob8, 
																																		SELF.did	:= (UNSIGNED6)	LEFT.did,
																																		SELF.ssn	:= (QSTRING9)		LEFT.ssn,
																																		SELF			:= LEFT),LOCAL);

//Use Mac_Dodgy_SSN_and_DOB_suppression to remove conflicting ssns and dobs
dHeader	:=	header.file_headers;

Death_Master.Mac_Dodgy_SSN_and_DOB_suppression(dHeader,dEnclarityInDodgyLayout, [MDR.sourceTools.src_Enclarity], dOutfile)

//reformat back to Death Master V3 format
persistV3EnclarityFilename	:=	'~thor_data400::persist::death_master::dCleanEnclarityDeathMasterDIDV3';
dEnclarityOutV3 := PROJECT(	dOutfile,
														TRANSFORM(	Header.Layout_Did_Death_MasterV3,
																				SELF.dob8	:=	IF(LEFT.dob > 0,(STRING) LEFT.dob, ''),
																				SELF.did	:=	(STRING) INTFORMAT(LEFT.did,12,1),
																				SELF.ssn	:=	LEFT.ssn,
																				SELF			:=	LEFT)):PERSIST(persistV3EnclarityFilename);

EXPORT File_EnclarityToV3	:=	dEnclarityOutV3;
