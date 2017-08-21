import Watercraft, Address, did_add, ut, header_slimsort, header, VehicleCodes, WatchDog, didville, fair_isaac, Business_Header_SS;

rMoxieRecord	:= Watercraft.Layout_Watercraft_Search_Base;

rCleanRecord
 :=
  record
	Watercraft_UMF.Individual_as_Moxie_Search;
	string73	temp_CLEAN_NAME 	:= '';
	string182	temp_CLEAN_ADDRESS 	:= '';
  end
 ;

rCleanRecord tAppendCleanBlobs(rMoxieRecord pInput, boolean pCleanNamesFlag=false)
 :=
  transform
	self.temp_CLEAN_NAME	:= if(pCleanNamesFlag,
								  Address.CleanPersonFML73(pInput.orig_name_first + ' '
																			+ pInput.orig_name_middle + ' '
																			+ pInput.orig_name_last + ' '
																			+ pInput.orig_name_suffix),
								  ''
								 );
	self.temp_CLEAN_ADDRESS	:= Address.CleanAddress182(trim(pInput.orig_address_1 + trim(' ' + pInput.orig_address_2)),
																		  trim(pInput.orig_city + trim(' ' + pInput.orig_state) + trim(' ' + pInput.orig_zip))
																		 );
	self					:= pInput;
  end
 ;

dCleanedWithBlobs := project(Watercraft_UMF.Individual_as_Moxie_Search,tAppendCleanBlobs(left,true))
				  +	 project(Watercraft_UMF.Business_as_Moxie_Search,tAppendCleanBlobs(left))
				  ;

rPreDIDRecord
 :=
  record
	rMoxieRecord;
	integer8	temp_DOB 		:= 0;
	integer8	temp_DID		:= 0;
	integer8	temp_DID_SCORE	:= 0;
	integer8	temp_BDID		:= 0;
	integer8	temp_BDID_SCORE	:= 0;
  end
 ;

rPreDIDRecord tExtractFromBlobs(rCleanRecord pInput)
 :=
  transform
	self.title 						:= pInput.temp_CLEAN_NAME[01..05];
	self.fname 						:= pInput.temp_CLEAN_NAME[06..25];
	self.mname 						:= pInput.temp_CLEAN_NAME[26..45];
	self.lname 						:= pInput.temp_CLEAN_NAME[46..65];
	self.name_suffix 				:= pInput.temp_CLEAN_NAME[66..70];
	self.name_cleaning_score		:= pInput.temp_CLEAN_NAME[71..73];
	self.prim_range  				:= pInput.temp_CLEAN_ADDRESS[001..010];
	self.predir      				:= pInput.temp_CLEAN_ADDRESS[011..012];
	self.prim_name   				:= pInput.temp_CLEAN_ADDRESS[013..040];
	self.suffix      				:= pInput.temp_CLEAN_ADDRESS[041..044];
	self.postdir     				:= pInput.temp_CLEAN_ADDRESS[045..046];
	self.unit_desig  				:= pInput.temp_CLEAN_ADDRESS[047..056];
	self.sec_range   				:= pInput.temp_CLEAN_ADDRESS[057..064];
	self.p_city_name 				:= pInput.temp_CLEAN_ADDRESS[065..089];
	self.v_city_name 				:= pInput.temp_CLEAN_ADDRESS[090..114];
	self.st							:= pInput.temp_CLEAN_ADDRESS[115..116]; 
	self.zip5						:= pInput.temp_CLEAN_ADDRESS[117..121];
	self.zip4						:= pInput.temp_CLEAN_ADDRESS[122..125];
	self.cart						:= pInput.temp_CLEAN_ADDRESS[126..129];
	self.cr_sort_sz					:= pInput.temp_CLEAN_ADDRESS[130..130];
	self.lot						:= pInput.temp_CLEAN_ADDRESS[131..134];
	self.lot_order					:= pInput.temp_CLEAN_ADDRESS[135..135];
	self.dpbc						:= pInput.temp_CLEAN_ADDRESS[136..137];
	self.chk_digit   				:= pInput.temp_CLEAN_ADDRESS[138..138];
	self.rec_type    				:= pInput.temp_CLEAN_ADDRESS[139..140];
	self.ace_fips_st 				:= pInput.temp_CLEAN_ADDRESS[141..142];
	self.county      				:= pInput.temp_CLEAN_ADDRESS[143..145];
	self.geo_lat     				:= pInput.temp_CLEAN_ADDRESS[146..155];
	self.geo_long    				:= pInput.temp_CLEAN_ADDRESS[156..166];
	self.msa         				:= pInput.temp_CLEAN_ADDRESS[167..170];
	self.geo_blk     				:= pInput.temp_CLEAN_ADDRESS[171..177];
	self.geo_match   				:= pInput.temp_CLEAN_ADDRESS[178..178];
	self.err_stat    				:= pInput.temp_CLEAN_ADDRESS[179..182];
	self.temp_DOB					:= (integer8)pInput.dob;
	self 							:= pInput;
  end
 ;

dCleanedAndFilled	:= project(dCleanedWithBlobs,tExtractFromBlobs(left));
//dCleanedPersonOnly	:= dCleanedAndFilled(company_name='');
//dCleanedCompanyOnly	:= dCleanedAndFilled(company_name<>'');

sDIDMatchSet 	:= ['A','D','S'];

did_Add.MAC_Match_Flex
//	(dCleanedPersonOnly, sDIDMatchSet,
	(dCleanedAndFilled, sDIDMatchSet,
	 orig_ssn, temp_DOB, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip5, st, phone_1, 
	 temp_DID,
	 rPreDIDRecord, 
	 true, temp_DID_Score,		//these should default to zero in definition
	 75,
	 dCleanedWithDID)		//try the dedup DIDing

did_add.MAC_Add_SSN_By_DID(dCleanedWithDID, temp_DID, SSN, dCleanedWithDIDandSSN)
/*
sBDIDMatchSet := ['N','A','F'];

Business_Header_SS.MAC_Match_Flex(
	dCleanedCompanyOnly, sBDIDMatchSet,
	company_name,
	prim_range, prim_name, zip5,
	sec_range, st,
	junk, orig_fein,
	temp_BDID,	
	rPreDIDRecord,
	true, temp_BDID_Score,  //these should default to zero in definition
	dCleanedWithDIDandBDID,
	50)
*/
rMoxieRecord tToMoxie(dCleanedWithDIDandSSN pInput)
 :=
  transform
	self.DID		:= intformat(pInput.temp_DID,12,1);
	self.DID_SCORE	:= (string3)pInput.temp_DID_SCORE;
	self.BDID		:= intformat(pInput.temp_BDID,12,1);
	self			:= pInput;
  end
 ;

dSearch := project(dCleanedWithDIDandSSN,tToMoxie(left));
dMain	:= Watercraft_UMF.Vehicle_as_Moxie_Main;
dCGuard	:= watercraft_UMF.Vehicle_as_Moxie_Coastguard;

dSearchDist	:= distribute(dSearch,hash(state_origin,watercraft_key,sequence_key));
dSearchSort	:= sort(dSearchDist,state_origin,watercraft_key,sequence_key,local);
dMainDist	:= distribute(dMain,hash(state_origin,watercraft_key,sequence_key));
dMainSort	:= sort(dMainDist,state_origin,watercraft_key,sequence_key,local);
dCGuardDist	:= distribute(dCGuard,hash(state_origin,watercraft_key,sequence_key));
dCGuardSort	:= sort(dCGuardDist,state_origin,watercraft_key,sequence_key,local);

Watercraft.Layout_Watercraft_Search_Base tPullFromMain(dSearchSort pSearch, dMainSort pMain)
 :=
  transform
	self.watercraft_key				:= pMain.watercraft_key;
	self.sequence_key				:= pMain.sequence_key;
	self							:= pSearch;
  end
 ;

dSearchAndMain := join(dSearchSort,dMainSort,
					   left.state_origin = right.state_origin and left.watercraft_key = right.watercraft_key and left.sequence_key = right.sequence_key,
					   tPullFromMain(left,right),
					   keep(1),
					   left outer,
					   local
					  );

export Combined_as_Search := dSearchAndMain : persist('persist::watercraft_umf_as_search');
