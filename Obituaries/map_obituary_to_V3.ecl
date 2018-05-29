import	Obituaries,Header,ut,address,DID_Add, lib_ziplib, RoxieKeyBuild,	STD;
#stored('did_add_force','thor');

EXPORT map_obituary_to_V3(string filedate) := FUNCTION

//Tributes raw base file
ds_tributes := Obituaries.files_raw_base.Tributes;

//ObituaryData raw base file
ds_obituary := Obituaries.files_raw_base.Obituary;

//Clean Tributes raw file for DID
Header.Layout_Did_Death_MasterV3 TributesCln(Obituaries.layouts.layout_reor_tribute l) := TRANSFORM
	tempdod										:=	l.death_year + l.death_month + l.death_day;
	tempdob1									:=	l.birth_year + l.birth_month + l.birth_day;
	tempdob										:=	IF((l.birth_year='') and (l.age<>'')
																	, (Std.Date.Today() DIV 10000 - (integer)trim(l.age,left,right))+'0000'
																	, tempdob1
																);
	self.dob8									:=	tempdob;
	self.dod8									:=	tempdod;
	STRING182 clean_address1	:=	Address.CleanAddress182('',StringLib.StringToUpperCase(TRIM(l.location_city,LEFT,RIGHT) + ', ' + 
																																									 TRIM(l.location_state,LEFT,RIGHT) )
																												);
																												
	self.state								:=	Address.CleanAddressFieldsFips(clean_address1).st;
	self.zip_lastres					:=	Address.CleanAddressFieldsFips(clean_address1).zip;
	self.st_country_code			:=	Address.CleanAddressFieldsFips(clean_address1).fips_state;
	self.fipscounty						:=	Address.CleanAddressFieldsFips(clean_address1).fips_county;
	self.state_death_flag			:=	'N';
	self.GLB_flag							:=	'N';
	self.src									:=	'TR';
	self.death_rec_src				:=	'TRB';
	self.state_death_id				:=	SELF.src+intformat((integer)l.person_id,14,1);
	self											:=	l;
	self											:=	[];
END;

TributesClean_out := project(ds_tributes,TributesCln(left));

//Clean ObituaryData raw file for DID
Header.Layout_Did_Death_MasterV3 ObituaryCln(Obituaries.layouts.Obituary_raw_base l) := TRANSFORM
	self.dob8									:=	l.DateOfBirth;
	self.dod8									:=	l.DateOfDeath;
	STRING182 clean_address1	:=	Address.CleanAddress182('',StringLib.StringToUpperCase(TRIM(l.city_in,LEFT,RIGHT) + ', ' + 
																																									 TRIM(l.state_in,LEFT,RIGHT) )
																												);
	self.state								:=	Address.CleanAddressFieldsFips(clean_address1).st;
	self.zip_lastres					:=	Address.CleanAddressFieldsFips(clean_address1).zip;
	self.st_country_code			:=	Address.CleanAddressFieldsFips(clean_address1).fips_state;
	self.fipscounty						:=	Address.CleanAddressFieldsFips(clean_address1).fips_county;
	self.state_death_flag			:=	'N';
	self.GLB_flag							:=	'N';
	self.src									:=	'OB';
	self.death_rec_src				:=	'OBD';
	self.state_death_id				:=	SELF.src+intformat((integer)l.person_id,14,1);
	self											:=	l;
	self											:=	[];
END;

ObituaryClean_out := project(ds_obituary,ObituaryCln(left));

//Combine Tributes and Obituary cleaned files for DID
CommonCombine :=	TributesClean_out + ObituaryClean_out;
NameClean			:=	Obituaries.fn_cleanName(CommonCombine);
dObitDist			:=	DISTRIBUTE(NameClean,HASH(lname,fname)); 
dObitSort			:=	SORT(dObitDist,lname,fname,mname[1],dod8,dob8,zip_lastres,-filedate,-state_death_id,LOCAL); 

// Rollup to remove duplicate records
RECORDOF(dObitSort) tRollupRecords(dObitSort L, dObitSort R) := 
TRANSFORM 	
	SELF.state						:=	IF(L.state <>'', L.state, R.state); 
	SELF.st_country_code	:=	IF(L.st_country_code <>'', L.st_country_code, R.st_country_code); 
	SELF.fipsCounty				:=	IF(L.fipsCounty <>'', L.fipsCounty, R.fipsCounty); 
	SELF									:=	L; 
END; 

dObitOut		:= ROLLUP(dObitSort,	LEFT.lname						=	RIGHT.lname							AND 
																	LEFT.fname						=	RIGHT.fname							AND 
																	LEFT.mname[1]					=	RIGHT.mname[1]					AND 
																	LEFT.dod8							=	RIGHT.dod8							AND 
																	LEFT.dob8							=	RIGHT.dob8							AND 														
																	LEFT.zip_lastres			=	RIGHT.zip_lastres				AND 
																	LEFT.src							=	RIGHT.src								AND 
																	LEFT.state_death_flag	=	RIGHT.state_death_flag,
																	tRollupRecords(LEFT, RIGHT), LOCAL):persist('death_obit_rollup');
																	
layout_obit_did := RECORD
	UNSIGNED6	l_did	:=	0;
	Header.Layout_Did_Death_MasterV3;
	UNSIGNED4	xadl2_keys_used			:=	0 ;
	STRING		xadl2_keys_desc			:=	'';
	INTEGER2	xadl2_weight				:=	0 ;
	UNSIGNED2	xadl2_Score					:=	0 ;
	UNSIGNED2	xadl2_distance			:=	0 ;
	STRING22	xadl2_matches				:=	'';
	STRING		xadl2_matches_desc	:=	'';
END;

DIDCombine	:=	PROJECT(dObitOut,TRANSFORM(layout_obit_did, SELF:=LEFT));
matchset		:=	['D','G','Z'];
DID_Add.MAC_Match_Flex(	DIDCombine,matchset,
												foo,dob8,
												fname,mname,lname,name_suffix,
												foo,foo,foo,zip_lastres,state,foo,
												l_did,layout_obit_did,
												TRUE,did_score,90,
												obits_with_dids,TRUE,src);

//Map to death_masterv3 output 
header.Layout_Did_Death_MasterV3 map_to_dmastv3(obits_with_dids l)	:= TRANSFORM
	mymatches				:=	DID_Add.matches(TRIM(l.xadl2_matches,ALL));
	// self.did				:=	INTFORMAT(l.l_did,12,1);
	// Filter out LexIDs where the matching is name and state only and the weight is low.
	SELF.did				:=	IF(
												mymatches.isNameStOnlyMatch 
												,INTFORMAT(0,12,1)
												,INTFORMAT(l.l_did,12,1)
											);
	SELF.did_score	:=	IF((UNSIGNED)SELF.did=0,0,l.did_score);
	SELF						:=	l;
	SELF						:=	[];
END;

obits_with_dids_DIST	:=	SORT(DISTRIBUTE(obits_with_dids),RECORD,LOCAL):PERSIST('~thor_data400::persist::death_master::obit_did');
ds_obituary_dmasterv3	:=	DEDUP(PROJECT(obits_with_dids_DIST,map_to_dmastv3(LEFT),LOCAL));

RoxieKeyBuild.Mac_SF_BuildProcess(ds_obituary_dmasterv3,'~thor_data400::base::did_death_masterv3_obituary','~thor_data400::base::did_death_masterv3_obituary_'+filedate, build_obit_d_mastv3,3,,TRUE);

return sequential(build_obit_d_mastv3);

END;
