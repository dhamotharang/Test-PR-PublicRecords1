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

string8 fValidProcessDate(string8 pDate1, string8 pDate2, string8 pDate3, string8 pDate4)
 := if((integer8)pDate1 >= 19600000,
	   pDate1,
	   if((integer8)pDate2 >= 19600000,
		  pDate2,
		  if((integer8)pDate3 >= 19600000,
			 pDate3,
			 if((integer8)pDate4 >= 19600000,
				pDate4,
				''
			   )
			)
		 )
	   );

dBusinessDistributed	:= distribute(Watercraft_UMF.File_In_Business,hash(STATE_ORIGIN,GROUP_KEY));
dBusinessSorted			:= sort(dBusinessDistributed,STATE_ORIGIN,GROUP_KEY,business_info_SEQUENCE,-business_info_entity_name_name,local);
dBusinessDedup			:= dedup(dBusinessSorted,STATE_ORIGIN,GROUP_KEY,business_info_SEQUENCE,false,local);

dWatercraftDistributed	:= distribute(Watercraft_UMF.File_In_Watercraft,hash(STATE_ORIGIN,GROUP_KEY));
dWatercraftSorted		:= sort(dWatercraftDistributed,STATE_ORIGIN,GROUP_KEY,local);
dWatercraftDedup		:= dedup(dWatercraftSorted,STATE_ORIGIN,GROUP_KEY,local);

Watercraft.Layout_Watercraft_Search_Base tBusinessANdWatercraftAsSearch(dBusinessDedup pBusiness,dWatercraftSorted pWatercraft)
 :=
  transform
	self.watercraft_key				:=	Watercraft_UMF.fConstruct_Watercraft_Key(pBusiness.GROUP_KEY,pWatercraft.boat_HULL_ID);
	self.sequence_key				:=	Watercraft_UMF.fConstruct_Sequence_Key(pBusiness.GROUP_KEY);
	self.date_first_seen			:=	fValidProcessDate(self.Sequence_Key,pWatercraft.registration_ISSUE_DATE,pWatercraft.title_ISSUE_DATE,pWatercraft.lien_LIEN_EFFECTIVE_DATE);
	self.date_last_seen				:=	fValidProcessDate(self.Sequence_Key,pWatercraft.registration_ISSUE_DATE,pWatercraft.title_ISSUE_DATE,pWatercraft.lien_LIEN_EFFECTIVE_DATE);
	self.date_vendor_first_reported	:=	fValidProcessDate(self.Sequence_Key,pWatercraft.registration_ISSUE_DATE,pWatercraft.title_ISSUE_DATE,pWatercraft.lien_LIEN_EFFECTIVE_DATE);
	self.date_vendor_last_reported	:=	fValidProcessDate(self.Sequence_Key,pWatercraft.registration_ISSUE_DATE,pWatercraft.title_ISSUE_DATE,pWatercraft.lien_LIEN_EFFECTIVE_DATE);
	self.state_origin				:=	pBusiness.STATE_ORIGIN;
	self.source_code				:=	'AW';
	self.dppa_flag					:=	if(pBusiness.STATE_ORIGIN in Watercraft.sDPPA_Restricted_Watercraft_States,'Y','');
	self.orig_name					:=	if(pBusiness.business_info_entity_name_NAME<>'',
										   pBusiness.business_info_entity_name_NAME,
										   pBusiness.business_info_business_name_COMPANY_NAME
										  );
	self.orig_name_type_code		:=	pBusiness.business_info_OWNERSHIP_TYPE;
	self.orig_name_type_description	:=	case(pBusiness.business_info_OWNERSHIP_TYPE,
											 'O' => 'OWNER',
											 'R' => 'REGISTRANT',
											 'B' => 'OWNER-REGISTRANT',
											 ''
											);
	self.orig_name_first			:=	'';
	self.orig_name_middle			:=	'';
	self.orig_name_last				:=	'';
	self.orig_name_suffix			:=	'';
	self.orig_address_1				:=	pBusiness.business_info_address_STR_ADDR_1;
	self.orig_address_2				:=	pBusiness.business_info_address_STR_ADDR_2;
	self.orig_city					:=	pBusiness.business_info_address_CITY;
	self.orig_state					:=	pBusiness.business_info_address_STATE;
	self.orig_zip					:=	fZipPartsToZip(pBusiness.business_info_address_ZIP_5,pBusiness.business_info_address_ZIP_4);
	self.orig_fips					:=	'';
	self.dob						:=	'';
	self.orig_ssn					:=	'';
	self.orig_fein					:=	pBusiness.business_info_FEIN;
	self.gender						:=	'';
	self.phone_1					:=	fPhonePartsToPhone(pBusiness.business_info_telephone_AREA_CODE,pBusiness.business_info_telephone_TELEPHONE);
	self.phone_2					:=	'';	// denormalize from multiple phone records
	self.title						:=	'';	// ** clean name **;
	self.fname						:=	'';	// ** clean name **;
	self.mname						:=	'';	// ** clean name **;
	self.lname						:=	'';	// ** clean name **;
	self.name_suffix				:=	'';	// ** clean name **;
	self.name_cleaning_score		:=	'';	// ** clean name **;
	self.company_name				:=	lib_stringlib.StringLib.stringtouppercase(if(pBusiness.business_info_entity_name_NAME<>'',
										   pBusiness.business_info_entity_name_NAME,
										   pBusiness.business_info_business_name_COMPANY_NAME
										  ));
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

dBusinessAndWatercraftAsSearch := join(dBusinessDedup,dWatercraftDedup,
									   left.state_origin = right.state_origin
								   and left.group_key = right.group_key,
									   tBusinessAndWatercraftAsSearch(left,right),
									   left outer,
									   local
									  );

export Business_as_Moxie_Search := dBusinessAndWatercraftAsSearch;
