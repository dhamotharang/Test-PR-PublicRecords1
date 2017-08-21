import Lib_StringLib, Watercraft;

string10 fZipPartsToZip(string5 pZip5, string4 pZip4)
 := if((integer)pZip5 <> 0,
	   pZip5 + if((integer)pZip4<>0,
				  '-' + pZip4,
				  ''
				 ),
	   ''
	  )
 ;

string fGetNumberOnly(string pStringIn) := lib_stringlib.StringLib.stringfilter(pStringIn,'0123456789'); 

string10 fPhonePartsToPhone(string pAreaCode, string pPhone)
 := if(fGetNumberOnly(pPhone)<>'',
	   if(length(trim(fGetNumberOnly(pAreaCode))) >= 3,
		  fGetNumberOnly(pAreaCode)[1..3],
		  ''
		 ) + fGetNumberOnly(pAreaCode)[1..7],
	   ''
	  )
 ;

string8 fValidProcessDate(string8 pDate1, string8 pDate2, string8 pDate3, string8 pDate4, string8 pDate5)
 := if((unsigned)(pDate1[1..4]) >= 1960,
	   pDate1,
	   if((unsigned2)(pDate2[1..4]) >= 1960,
		  pDate2,
		  if((unsigned2)(pDate3[1..4]) >= 1960,
			 pDate3,
			 if((unsigned2)(pDate4[1..4]) >= 1960,
				pDate4,
				if((unsigned2)(pDate5[1..4]) >= 1960,
				   pDate5,
				   ''
			      )
			   )
			)
		 )
	   );

dIndividualDistributed	:= distribute(Watercraft_UMF.File_In_Individual,hash(STATE_ORIGIN,GROUP_KEY));
dIndividualSorted		:= sort(dIndividualDistributed,STATE_ORIGIN,GROUP_KEY,INDIVIDUAL_SEQUENCE,-individual_entity_name_name,individual_NAME_ORIGIN,local);
dIndividualDedup		:= dedup(dIndividualSorted,STATE_ORIGIN,GROUP_KEY,INDIVIDUAL_SEQUENCE,false,local);

dWatercraftDistributed	:= distribute(Watercraft_UMF.File_In_Watercraft,hash(STATE_ORIGIN,GROUP_KEY));
dWatercraftSorted		:= sort(dWatercraftDistributed,STATE_ORIGIN,GROUP_KEY,local);
dWatercraftDedup		:= dedup(dWatercraftSorted,STATE_ORIGIN,GROUP_KEY,local);

Watercraft.Layout_Watercraft_Search_Base tIndividualAndWatercraftAsSearch(dIndividualDedup pIndividual, dWatercraftSorted pWatercraft)
 :=
  transform
	self.watercraft_key				:=	Watercraft_UMF.fConstruct_Watercraft_Key(pIndividual.GROUP_KEY,pWatercraft.boat_HULL_ID);
	self.sequence_key				:=	Watercraft_UMF.fConstruct_Sequence_Key(pIndividual.GROUP_KEY);
	self.date_first_seen			:=	fValidProcessDate(self.Sequence_Key,pWatercraft.registration_ISSUE_DATE,pWatercraft.title_ISSUE_DATE,pWatercraft.vehicle_DATE_CHANGED,pWatercraft.vehicle_DATE_ADDED);
	self.date_last_seen				:=	fValidProcessDate(self.Sequence_Key,pWatercraft.registration_ISSUE_DATE,pWatercraft.title_ISSUE_DATE,pWatercraft.vehicle_DATE_CHANGED,pWatercraft.vehicle_DATE_ADDED);
	self.date_vendor_first_reported	:=	fValidProcessDate(self.Sequence_Key,pWatercraft.registration_ISSUE_DATE,pWatercraft.title_ISSUE_DATE,pWatercraft.vehicle_DATE_CHANGED,pWatercraft.vehicle_DATE_ADDED);
	self.date_vendor_last_reported	:=	fValidProcessDate(self.Sequence_Key,pWatercraft.registration_ISSUE_DATE,pWatercraft.title_ISSUE_DATE,pWatercraft.vehicle_DATE_CHANGED,pWatercraft.vehicle_DATE_ADDED);
	self.state_origin				:=	pIndividual.STATE_ORIGIN;                                                                                               
	self.source_code				:=	'AW';
	self.dppa_flag					:=	if(pIndividual.STATE_ORIGIN in Watercraft.sDPPA_Restricted_Watercraft_States,'Y','');
	self.orig_name					:=	if(pIndividual.individual_entity_name_NAME<>'',
										   pIndividual.individual_entity_name_NAME,
										   pIndividual.individual_NAME_FULL
										  );
	self.orig_name_type_code		:=	pIndividual.individual_OWNERSHIP_TYPE;
	self.orig_name_type_description	:=	case(pIndividual.individual_OWNERSHIP_TYPE,
											 'O' => 'OWNER',
											 'R' => 'REGISTRANT',
											 'B' => 'OWNER-REGISTRANT',
											 ''
											);
	self.orig_name_first			:=	pIndividual.individual_name_FIRST;
	self.orig_name_middle			:=	pIndividual.individual_name_MIDDLE;
	self.orig_name_last				:=	pIndividual.individual_name_LAST;
	self.orig_name_suffix			:=	pIndividual.individual_name_SUFFIX;
	self.orig_address_1				:=	pIndividual.individual_address_STR_ADDR_1;
	self.orig_address_2				:=	pIndividual.individual_address_STR_ADDR_2;
	self.orig_city					:=	pIndividual.individual_address_CITY;
	self.orig_state					:=	pIndividual.individual_address_STATE;
	self.orig_zip					:=	fZipPartsToZip(pIndividual.individual_address_ZIP_5,pIndividual.individual_address_ZIP_4);
	self.orig_fips					:=	'';
	self.dob						:=	pIndividual.individual_DOB;
	self.orig_ssn					:=	pIndividual.individual_SSN;
	self.orig_fein					:=	'';
	self.gender						:=	pIndividual.individual_GENDER;
	self.phone_1					:=	fPhonePartsToPhone(pIndividual.individual_telephone_AREA_CODE,pIndividual.individual_telephone_TELEPHONE);
	self.phone_2					:=	'';	// denormalize from multiple phone records
	self.title						:=	'';	// ** clean name **;
	self.fname						:=	'';	// ** clean name **;
	self.mname						:=	'';	// ** clean name **;
	self.lname						:=	'';	// ** clean name **;
	self.name_suffix				:=	'';	// ** clean name **;
	self.name_cleaning_score		:=	'';	// ** clean name **;
	self.company_name				:=	''; // ** clean name **;
	self.prim_range					:=	'';	// ** clean address **;
	self.predir						:=	'';	// ** clean address **;
	self.prim_name					:=	'';	// ** clean address **;
	self.suffix						:=	'';	// ** clean address **;
	self.postdir					:=	'';	// ** clean address **;
	self.unit_desig					:=	'';	// ** clean address **;
	self.sec_range					:=	'';	// ** clean address **;
	self.p_city_name				:=	'';	// ** clean address **;
	self.v_city_name				:=	'';	// ** clean address **;
	self.st							:=	'';	// ** clean address **;
	self.zip5						:=	'';	// ** clean address **;
	self.zip4						:=	'';	// ** clean address **;
	self.county						:=	'';	// ** clean address **;
	self.cart						:=	'';	// ** clean address **;
	self.cr_sort_sz					:=	'';	// ** clean address **;
	self.lot						:=	'';	// ** clean address **;
	self.lot_order					:=	'';	// ** clean address **;
	self.dpbc						:=	'';	// ** clean address **;
	self.chk_digit					:=	'';	// ** clean address **;
	self.rec_type					:=	'';	// ** clean address **;
	self.ace_fips_st				:=	'';	// ** clean address **;
	self.ace_fips_county			:=	'';	// ** clean address **;
	self.geo_lat					:=	'';	// ** clean address **;
	self.geo_long					:=	'';	// ** clean address **;
	self.msa						:=	'';	// ** clean address **;
	self.geo_blk					:=	'';	// ** clean address **;
	self.geo_match					:=	'';	// ** clean address **;
	self.err_stat					:=	'';	// ** clean address **;
	self.bdid						:=	''; // ** bdid **;
	self.fein						:=	''; // ** bdid **;
	self.did						:=	'';	// ** did **;
	self.did_score					:=	'';	// ** did **;
	self.ssn						:=	'';	// ** did **;
	self.history_flag				:=	'';
  end
 ;

dIndividualAndWatercraftAsSearch := join(dIndividualDedup,dWatercraftDedup,
										 left.state_origin = right.state_origin
									 and left.group_key = right.group_key,
										 tIndividualAndWatercraftAsSearch(left,right),
										 left outer,
										 local
										);

export Individual_as_Moxie_Search := dIndividualAndWatercraftAsSearch;
