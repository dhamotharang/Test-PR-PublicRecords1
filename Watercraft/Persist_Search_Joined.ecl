import did_add, Business_Header_SS, Business_Header;

dJoined
 :=	Watercraft.Mapping_AK_as_Search
 +	Watercraft.Mapping_AL_as_Search
 +	Watercraft.Mapping_AR_as_Search
 +	Watercraft.Mapping_AZ_as_Search
 +	Watercraft.Mapping_CO_as_Search
 +	Watercraft.Mapping_CT_as_Search
 +	Watercraft.Mapping_GA_as_Search
 +	Watercraft.Mapping_IA_as_Search
 +	Watercraft.Mapping_IL_as_Search
 +	Watercraft.Mapping_KS_as_Search
 +	Watercraft.Mapping_MD_as_Search
 +	Watercraft.Mapping_MI_as_Search
 +	Watercraft.Mapping_NV_as_Search
 +	Watercraft.Mapping_WI_as_Search
 +	Watercraft.Mapping_WV_as_Search
 +	Watercraft.Mapping_MA_as_Search
 +	Watercraft.Mapping_ME_as_Search
 +	Watercraft.Mapping_MS_as_Search
 +	Watercraft.Mapping_MT_as_Search
 +	Watercraft.Mapping_NC_as_Search
 +	Watercraft.Mapping_ND_as_Search
 +	Watercraft.Mapping_NE_as_Search
 +	Watercraft.Mapping_OH_as_Search
 +	Watercraft.Mapping_VA_as_Search
 +	Watercraft.Mapping_WY_as_Search
 +	Watercraft.Mapping_MN_as_Search
 +	Watercraft.Mapping_OR_as_Search
 +	Watercraft.Mapping_TX_as_Search
 +	Watercraft.Mapping_NY_as_Search
 ;

dJoinedDist		:=	distribute(dJoined,hash(state_origin,watercraft_key));
dJoinedSort		:=	sort(dJoinedDist,state_origin,watercraft_key,-sequence_key,local);

string8	fEarliestNonZeroDate(string pDate1, string pDate2)
 :=
  if((unsigned8)pDate1 = 0,
	 pDate2,
	 if((unsigned8)pDate2 = 0,
		pDate1,
		if(pDate1 < pDate2,
		   pDate1,
		   pDate2
		  )
	   )
	);

string8	fLatestNonZeroDate(string pDate1, string pDate2)
 :=
  if((unsigned8)pDate1 = 0,
	 pDate2,
	 if((unsigned8)pDate2 = 0,
		pDate1,
		if(pDate1 > pDate2,
		   pDate1,
		   pDate2
		  )
	   )
	);

recordof(dJoinedSort)	tRollupDuplicates(dJoinedSort pLeft, dJoinedSort pRight)
 :=
  transform
	self.date_vendor_first_reported	:=	fEarliestNonZeroDate(pLeft.date_vendor_first_reported,pRight.date_vendor_first_reported);
	self.date_vendor_last_reported	:=	fLatestNonZeroDate(pLeft.date_vendor_last_reported,pRight.date_vendor_last_reported);
	self.date_first_seen			:=	fEarliestNonZeroDate(pLeft.date_first_seen,pRight.date_first_seen);
	self.date_last_seen				:=	fEarliestNonZeroDate(pLeft.date_first_seen,pRight.date_first_seen);
	self							:=	pRight;
  end
 ;

dJoinedRollup	:=	rollup(dJoinedSort,
						   tRollupDuplicates(left,right),
						   record,except date_first_seen,date_last_seen,date_vendor_first_reported,date_vendor_last_reported,history_flag,
						   local
						  );

Watercraft.Layout_Watercraft_Search_Base	tCleanFromBlobs(dJoinedRollup pInput)
 :=
  transform
	self.title					:=	pInput.clean_pname[1..5];
	self.fname					:=	pInput.clean_pname[6..25];
	self.mname					:=	pInput.clean_pname[26..45];
	self.lname					:=	pInput.clean_pname[46..65];
	self.name_suffix			:=	pInput.clean_pname[66..70];
	self.name_cleaning_score	:=	pInput.clean_pname[71..73];
	self.prim_range 			:=	pInput.clean_address[1..10];
	self.predir 				:=	pInput.clean_address[11..12];
	self.prim_name 				:=	pInput.clean_address[13..40];
	self.suffix 				:=	pInput.clean_address[41..44];
	self.postdir 				:=	pInput.clean_address[45..46];
	self.unit_desig 			:=	pInput.clean_address[47..56];
	self.sec_range 				:=	pInput.clean_address[57..64];
	self.p_city_name 			:=	pInput.clean_address[65..89];
	self.v_city_name 			:=	pInput.clean_address[90..114];
	self.st 					:=	pInput.clean_address[115..116];
	self.zip5 					:=	pInput.clean_address[117..121];
	self.zip4 					:=	pInput.clean_address[122..125];
	self.cart 					:=	pInput.clean_address[126..129];
	self.cr_sort_sz 			:=	pInput.clean_address[130];
	self.lot 					:=	pInput.clean_address[131..134];
	self.lot_order 				:=	pInput.clean_address[135];
	self.dpbc 					:=	pInput.clean_address[136..137];
	self.chk_digit 				:=	pInput.clean_address[138];
	self.rec_type				:=	pInput.clean_address[139..140];
	self.ace_fips_st 			:=	pInput.clean_address[141..142];
	self.ace_fips_county		:=	pInput.clean_address[143..145];
	self.geo_lat 				:=	pInput.clean_address[146..155];
	self.geo_long 				:=	pInput.clean_address[156..166];
	self.msa 					:=	pInput.clean_address[167..170];
	self.geo_blk 				:=	pInput.clean_address[171..177];
	self.geo_match 				:=	pInput.clean_address[178];
	self.err_stat 				:=	pInput.clean_address[179..182];
	self.county					:=	pInput.clean_address[143..145];
	self						:=	pInput;
  end
 ;

dAsSearchBase	:=	project(dJoinedRollup,tCleanFromBlobs(left));

rPreDIDRecord
 :=
  record
	Watercraft.Layout_Watercraft_Search_Base;
	integer8	temp_DOB 		:= 0;
	integer8	temp_DID		:= 0;
	integer8	temp_DID_SCORE	:= 0;
	integer8	temp_BDID		:= 0;
	integer8	temp_BDID_SCORE	:= 0;
  end
 ;

rPreDIDRecord tPrepForDIDandBDID(dAsSearchBase pInput)
 :=
  transform
	self.temp_DOB	:=	(integer8)pInput.DOB;
	self			:=	pInput;
  end
 ;

dPreDID	:= project(dAsSearchBase,tPrepForDIDandBDID(left)) : persist('~thor_data400::persist::watercraft_PreDID','thor_dell400_2');
dCleanedPersonOnly	:= dPreDID(company_name='');
dCleanedCompanyOnly	:= dPreDID(company_name<>'');

sDIDMatchSet 	:= ['A','D','S'];

did_Add.MAC_Match_Flex
	(dCleanedPersonOnly, sDIDMatchSet,
	 orig_ssn, temp_DOB, fname, mname, lname, name_suffix,
	 prim_range, prim_name, sec_range, zip5, st, phone_1,
	 temp_DID,
	 rPreDIDRecord,
	 true, temp_DID_Score,		//these should default to zero in definition
	 75,
	 dPostDID);		//try the dedup DIDing

dPostDIDPersist	:=	dPostDID : persist('~thor_data400::persist::watercraft_PostDID','thor_dell400_2');

did_add.MAC_Add_SSN_By_DID(dPostDIDPersist, temp_DID, SSN, dPostDIDandSSN)

business_header.MAC_Source_Match(dCleanedCompanyOnly,dPostBusHdrSourceMatch,
								 false,temp_BDID,
								 false,'AW',	// watercraft is 'AW' everywhere else
								 false,foo,
								 company_name,
								 prim_range,prim_name,sec_range,zip5,
								 false,foo,
								 false,foo
								);

dPostBusHdrSourceMatchPersist	:=	dPostBusHdrSourceMatch : persist('~thor_data400::persist::watercraft_PostBusHdrSourceMatch','thor_dell400_2');

dWithBusHdrSourceMatch			:=	dPostBusHdrSourceMatchPersist(temp_BDID != 0);
dWithNoBusHdrSourceMatch		:=	dPostBusHdrSourceMatchPersist(temp_BDID = 0);
sBDIDMatchSet					:=	['A'];


business_header_ss.MAC_Match_Flex(dWithNoBusHdrSourceMatch,sBDIDMatchSet,
								  company_name,
								  prim_range, prim_name, zip5,
								  sec_range, st,
								  foo,orig_fein,
								  temp_BDID,
								  recordof(dWithNoBusHdrSourceMatch),
								  false,temp_BDID_Score,
								  dPostBDID
								 );

dPostDIDandBDIDPersist	:=	dPostDIDandSSN
						+	dPostBDID
						+	dWithBusHdrSourceMatch
						:	persist('~thor_data400::persist::watercraft_PostDIDandBDID','thor_dell400_2')
						;

Watercraft.Layout_Watercraft_Search_Base tToMoxie(dPostDIDandBDIDPersist pInput)
 :=
  transform
	self.DID		:=	intformat(pInput.temp_DID,12,1);
	self.DID_SCORE	:=	(string3)pInput.temp_DID_SCORE;
	self.BDID		:=	intformat(pInput.temp_BDID,12,1);
	self.dppa_flag	:=	if(pInput.state_origin in Watercraft.sDPPA_Restricted_Watercraft_States,'Y','N');
	self			:=	pInput;
  end
 ;

export Persist_Search_Joined	:=	project(dPostDIDandBDIDPersist,tToMoxie(left)) :	persist('persist::Watercraft_Search_Joined');
