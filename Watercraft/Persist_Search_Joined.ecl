import did_add, ut, header_slimsort, header, WatchDog, didville, fair_isaac, Business_Header_SS, Business_Header, Lib_StringLib, AK_Comm_Fish_Vessels,mdr,header,AID,address,idl_header, Watercraft_infutor, watercraft_preprocess, STD;

//New ECL raw conversion process
dJoined_new := dataset('~thor_data400::in::watercraft_search_common',Watercraft_preprocess.Layout_Watercraft_Search_Common,flat);

//Previous process using AbInitio
dJoined
 := Watercraft.Mapping_AK_as_Search
 +  Watercraft.Mapping_AL_as_Search
 +	Watercraft.Mapping_AR_as_Search
 +	Watercraft.Mapping_AZ_as_Search
 +	Watercraft.Mapping_CO_as_Search
 +	Watercraft.Mapping_CT_as_Search
 +	Watercraft.Mapping_GA_as_Search
 +	Watercraft.Mapping_IA_as_Search
 +	Watercraft.Mapping_IA_as_Search_pre20071011
 +	Watercraft.Mapping_IL_as_Search
 +	Watercraft.Mapping_KS_as_Search
 +	Watercraft.Mapping_MD_as_Search
 +	Watercraft.Mapping_MI_as_Search
 +	Watercraft.Mapping_NV_as_Search
 +	Watercraft.Mapping_WI_as_Search
 +	Watercraft.Mapping_WV_as_Search
 +	Watercraft.Mapping_MA_as_Search
 +	Watercraft.Mapping_ME_as_Search
 +	Watercraft.Mapping_ME_as_Search_pre20060330
 +	Watercraft.Mapping_ME_as_Search_pre20080415
 +	Watercraft.Mapping_MS_as_Search
 +	Watercraft.Mapping_MT_as_Search
 +	Watercraft.Mapping_NC_as_Search
 +	Watercraft.Mapping_ND_as_Search
 +	Watercraft.Mapping_NE_as_Search
 +	Watercraft.Mapping_OH_as_Search
 +	Watercraft.Mapping_VA_as_Search
 +	Watercraft.Mapping_WY_as_Search
 +	Watercraft.Mapping_MN_as_Search
 +	Watercraft.Mapping_TX_as_Search_pre20060330 // Including data in old layout despite Infolink layout change
 +	Watercraft.Mapping_TX_as_Search
 +	Watercraft.Mapping_NY_as_Search
 +	Watercraft.Mapping_NH_as_Search
 +	Watercraft.Mapping_TN_as_Search
 +	Watercraft.Mapping_SC_as_Search
 +	Watercraft.Mapping_UT_as_Search
 +	Watercraft.Mapping_CG_as_Search_pre20080415
 +	Watercraft.Mapping_CG_as_Search
 +	Watercraft.Mapping_FL_as_Search
 +	Watercraft.Mapping_MO_as_Search
 +	Watercraft.Mapping_KY_as_Search
 +  Watercraft.mapping_KY_infolink_as_Search
 +	Watercraft.Mapping_OR_as_Search_pre20080415
 +	Watercraft.Mapping_OR_as_Search 
 +  AK_Comm_Fish_Vessels.Mapping_Watercraft_Search_Group_AK_Comm_Fishing_Vessels 
 +  Watercraft.Mapping_WY_new_as_Search
 +	Watercraft.Mapping_WA_as_Search
 +	Watercraft.Map_watercraft_infutor_search;

dJoined2 :=Watercraft.fn_clnName(dJoined);

//Project the previous input files into the layout used by the new conversion process
pJoined_convert := project(dJoined2,transform(watercraft_preprocess.Layout_Watercraft_Search_Common, self := left, self := [];));

//Combine both input files for processing
dCombineJoin	:= 	pJoined_convert + dJoined_new;

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

dJoinedNotBlank	:=	dCombineJoin(clean_pname[46..65] <> '' or company_name <> '');
dJoinedDist		  :=	distribute(dJoinedNotBlank,hash64(state_origin,watercraft_key));
dJoinedSort		  :=	sort(dJoinedDist,state_origin,
												 source_code,//Added because now CG records have "CG" as source_code, versus previously "AW"
												 watercraft_key,
												 -sequence_key,
												 orig_name,
												 orig_name_last,
												 orig_name_first,
												 orig_name_middle,
												 orig_name_suffix,
			//									 orig_zip,
												 orig_state,
												 orig_city,
												 orig_address_1,
												 orig_address_2,
												 dob,
												 orig_name_type_code,
												 -date_vendor_last_reported,
												 local);
												 
recordof(dJoinedSort)	tRollupDuplicates(dJoinedSort pLeft, dJoinedSort pRight) :=
  transform
	self.date_vendor_first_reported	:=	fEarliestNonZeroDate(pLeft.date_vendor_first_reported,pRight.date_vendor_first_reported);
	self.date_vendor_last_reported	:=	fLatestNonZeroDate(pLeft.date_vendor_last_reported,pRight.date_vendor_last_reported);
	self.date_first_seen					  :=	fEarliestNonZeroDate(pLeft.date_first_seen,pRight.date_first_seen);
	self.date_last_seen							:=	fLatestNonZeroDate(pLeft.date_last_seen,pRight.date_last_seen);
	self.orig_name_type_code				:=	if(pLeft.orig_name_type_code <> pRight.orig_name_type_code
																					or Lib_StringLib.StringLib.StringFind(pLeft.orig_name_type_code + pRight.orig_name_type_code,'B',1) <> 0,
																					 'B',
																					 pRight.orig_name_type_code
																					);
	self.orig_name_type_description	:=	case(self.orig_name_type_code,
																					 'O'	=>	'OWNER',
																					 'R'	=>	'REGISTRANT',
																					 'B'	=>	'OWNER/REGISTRANT',
																					 ''
																					);
	self														:=	pRight;
end;

dJoinedRollup	:=	rollup(dJoinedSort,
												 tRollupDuplicates(left,right),
												 state_origin,
												 source_code,//Added because now CG records have "CG" as source_code, versus previously "AW"
												 watercraft_key,
												 sequence_key,
												 orig_name,
												 orig_name_last,
												 orig_name_first,
												 orig_name_middle,
												 orig_name_suffix,
					//						   orig_zip,
												 orig_state,
												 orig_city,
												 orig_address_1,
												 orig_address_2,
												 dob,
												 local
												);

dJoinedRollupPreAID  					:= project(dJoinedRollup, transform({dJoinedRollup, unsigned8 RawAID:=0}, 
						 t_orig_city 			:= if(trim(left.orig_city,left,right)= 'UNDELIVERABLE' , '',trim(left.orig_city,left,right));  
						 t_orig_state 		:= if(trim(left.orig_state,left,right)='RE' , '', trim(left.orig_state,left,right)); 
	           t_orig_zip 			:= if(trim(left.orig_zip,left,right)[1..5]='88888' , '', trim(left.orig_zip,left,right)[1..5]); 
						 t_address_2 			:= lib_StringLib.StringLib.StringCleanSpaces(trim(t_orig_city,left,right) + if(t_orig_city <> '',', ',' ') + trim(t_orig_state,left,right) + ' ' + t_orig_zip); 
						 t_addr0 					:= lib_StringLib.StringLib.StringCleanSpaces( trim(left.orig_address_1,left,right) +' '+ trim(left.orig_address_2,left,right));
						 t_addr1 					:= StringLib.StringFindReplace(StringLib.StringFilterOut(StringLib.StringToUpperCase(t_addr0),',.;*!\''),'P O BOX' , 'PO BOX');
						 t1_addr1 				:= StringLib.StringFindReplace(t_addr1, 'POBOX',  'PO BOX');
						 t2_addr1				 	:= StringLib.StringFindReplace(t1_addr1, 'PO BOX BOX', 'PO BOX');
						 tempPrepAddress1	:= ut.CleanSpacesAndUpper(IF(left.prep_address_situs <> '',left.prep_address_situs,t2_addr1));
						 tempPreAddress2	:= ut.CleanSpacesAndUpper(IF(left.prep_address_last_situs <> '',left.prep_address_last_situs,t_address_2));
						 self.prep_address_situs 				:= Address.fn_addr_clean_prep(tempPrepAddress1, 'first'); 
						 self.prep_address_last_situs 	:= Address.fn_addr_clean_prep(tempPreAddress2, 'last'); 
						 self:= left)); 
// Append AID 
unsigned4	lFlags 			:= AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

AID.MacAppendFromRaw_2Line(dJoinedRollupPreAID, prep_address_situs, prep_address_last_situs, RawAID, CleanAid, lFlags);

CurrentDate := (string8)STD.Date.Today();
Watercraft.Layout_Watercraft_Search_Base	tCleanFromBlobs(CleanAid pInput)
 :=transform
  
  //Dates 1 month in the future are acceptable
  string temp_date_first_seen            	:= if((pInput.date_first_seen            between '1' and '189999') or pInput.date_first_seen[1..6] > (string)((integer)CurrentDate[1..6] +1), '', pInput.date_first_seen);
  string temp_date_last_seen             	:= if((pInput.date_last_seen        between '1' and '189999') or pInput.date_last_seen [1..6]>(string)((integer)CurrentDate[1..6] +1), '', pInput.date_last_seen);
  string temp_date_vendor_first_reported 	:= if((pInput.date_vendor_first_reported between '1' and '189999') or pInput.date_vendor_first_reported[1..6]>(string)((integer)CurrentDate[1..6] +1), '', pInput.date_vendor_first_reported);
  string temp_date_vendor_last_reported  	:= if((pInput.date_vendor_last_reported  between '1' and '189999') or pInput.date_vendor_last_reported[1..6]>(string)((integer)CurrentDate[1..6] +1), '', pInput.date_vendor_last_reported);
  string temp_date_first_seen2            := if((unsigned6)temp_date_first_seen            = 0,temp_date_last_seen,             temp_date_first_seen            ); 
  string temp_date_last_seen2             := if((unsigned6)temp_date_last_seen              =  0,temp_date_first_seen,            temp_date_last_seen             );
  string temp_date_vendor_first_reported2 := if((unsigned6)temp_date_vendor_first_reported = 0,temp_date_vendor_last_reported,  temp_date_vendor_first_reported );
  string temp_date_vendor_last_reported2  := if((unsigned6)temp_date_vendor_last_reported  = 0,temp_date_vendor_first_reported, temp_date_vendor_last_reported  );
  self.date_first_seen            				:= if(temp_date_first_seen2            < temp_date_last_seen2,             temp_date_first_seen2,            temp_date_last_seen2);
	self.date_last_seen             				:= if(temp_date_last_seen2             > temp_date_first_seen2,            temp_date_last_seen2,             temp_date_first_seen2);
	self.date_vendor_first_reported 				:= if(temp_date_vendor_first_reported2 < temp_date_vendor_last_reported2,  temp_date_vendor_first_reported2, temp_date_vendor_last_reported2);
	self.date_vendor_last_reported  				:= if(temp_date_vendor_last_reported2  > temp_date_vendor_first_reported2, temp_date_vendor_last_reported2,  temp_date_vendor_first_reported2);
	self.title															:=	pInput.clean_pname[1..5];
	self.fname															:=	pInput.clean_pname[6..25];
	self.mname															:=	pInput.clean_pname[26..45];
	self.lname															:=	pInput.clean_pname[46..65];
	self.name_suffix												:=	pInput.clean_pname[66..70];
	self.name_cleaning_score								:=	pInput.clean_pname[71..73];
	self.prim_range		        							:=	pInput.AIDWork_AceCache.prim_range;
  self.predir				    									:=	pInput.AIDWork_AceCache.predir;
	self.prim_name		        							:=	pInput.AIDWork_AceCache.prim_name;
	self.suffix				    									:=	pInput.AIDWork_AceCache.addr_suffix;
	self.postdir			    									:=	pInput.AIDWork_AceCache.postdir;
	self.unit_desig		       								:=	pInput.AIDWork_AceCache.unit_desig;
	self.sec_range		        							:=	pInput.AIDWork_AceCache.sec_range;
	self.p_city_name	        							:=	pInput.AIDWork_AceCache.p_city_name;
	self.v_city_name	        							:=	pInput.AIDWork_AceCache.v_city_name;
	self.st																	:=	pInput.AIDWork_AceCache.st;
	self.zip5 															:=	pInput.AIDWork_AceCache.zip5;
	self.zip4 															:=	pInput.AIDWork_AceCache.zip4;
	self.cart 															:=	pInput.AIDWork_AceCache.cart;
	self.cr_sort_sz 												:=	pInput.AIDWork_AceCache.cr_sort_sz;
	self.lot 															  :=	pInput.AIDWork_AceCache.lot;
	self.lot_order 													:=	pInput.AIDWork_AceCache.lot_order;
	self.dpbc 															:=	pInput.AIDWork_AceCache.dbpc;
	self.chk_digit 													:=	pInput.AIDWork_AceCache.chk_digit;
	self.rec_type														:=	pInput.AIDWork_AceCache.rec_type;
	self.ace_fips_st 												:=	pInput.AIDWork_AceCache.county[1..2];
	self.ace_fips_county										:=	pInput.AIDWork_AceCache.county[3..5];
	self.geo_lat 														:=	pInput.AIDWork_AceCache.geo_lat;
	self.geo_long 													:=	pInput.AIDWork_AceCache.geo_long;
	self.msa 																:=	pInput.AIDWork_AceCache.msa;
	self.geo_blk 														:=	pInput.AIDWork_AceCache.geo_blk;
	self.geo_match 													:=	pInput.AIDWork_AceCache.geo_match;
	self.err_stat 													:=	pInput.AIDWork_AceCache.err_stat;
	self.county															:=	pInput.AIDWork_AceCache.county[3..5];
	self.RawAID                 						:=	pInput.AIDWork_RawAID;
	self																    :=	pInput;
  end;

dAsSearchBase	:=	project(CleanAid,tCleanFromBlobs(left));

// Apply Flip name macro
ut.mac_flipnames(dAsSearchBase,fname,mname,lname,dBaseFlipOut);

rPreDIDRecord:=record
	Watercraft.Layout_Watercraft_Search_Base;
	integer8	temp_DOB 				:= 0;
	integer8	temp_DID				:= 0;
	integer8	temp_DID_SCORE	:= 0;
	integer8	temp_BDID				:= 0;
	integer8	temp_BDID_SCORE	:= 0;
	unsigned6	temp_BID				:= 0;
	unsigned1	temp_BID_SCORE	:= 0;
end;

rPreDIDRecord tPrepForDIDandBDID(dAsSearchBase pInput):=transform
	self.temp_DOB	:=	(integer8)pInput.DOB;
	self			    :=	pInput;
end ;

dPreDID							  := project(dBaseFlipOut,tPrepForDIDandBDID(left)): persist('~thor_data400::persist::watercraft_PreDID');
//** source record id logic
PreviousBase   				:= distribute(Watercraft.File_Base_Search_Prod(trim(watercraft_key) <> ''),hash64(state_origin,source_code,watercraft_key));
Update_Base     			:= distribute(dPreDID(trim(watercraft_key) <> ''),hash64(state_origin,source_code,watercraft_key));
     
rPreDIDRecord  trans_recID(rPreDIDRecord l,Watercraft.Layout_Watercraft_Search_Base r):=transform
	 self.source_rec_id := r.source_rec_id;
	 self               := l;
end;
Append_recID    := join(Update_Base ,PreviousBase,
											  ut.CleanSpacesAndUpper(left.watercraft_key  ) 					 =  ut.CleanSpacesAndUpper(right.watercraft_key   )  and   
												// ut.CleanSpacesAndUpper(left.sequence_key  )						 =  ut.CleanSpacesAndUpper(right.sequence_key   )  and   
												ut.CleanSpacesAndUpper(left.state_origin  ) 						 =  ut.CleanSpacesAndUpper(right.state_origin   )  and   
												ut.CleanSpacesAndUpper(left.source_code  ) 						 =  ut.CleanSpacesAndUpper(right.source_code   )  and   
												// ut.CleanSpacesAndUpper(left.dppa_flag  ) 							 =  ut.CleanSpacesAndUpper(right.dppa_flag   )  and   
												ut.CleanSpacesAndUpper(left.orig_name  )       				 =  ut.CleanSpacesAndUpper(right.orig_name   )  and   
												//ut.CleanSpacesAndUpper(left.orig_name_type_code  ) 		 =  ut.CleanSpacesAndUpper(right.orig_name_type_code   )  and   
												// ut.CleanSpacesAndUpper(left.orig_name_type_description) =  ut.CleanSpacesAndUpper(right.orig_name_type_description   )  and   
												ut.CleanSpacesAndUpper(left.orig_name_first  )					 =  ut.CleanSpacesAndUpper(right.orig_name_first   )  and   
												ut.CleanSpacesAndUpper(left.orig_name_middle  ) 				 =  ut.CleanSpacesAndUpper(right.orig_name_middle   )  and   
												ut.CleanSpacesAndUpper(left.orig_name_last  ) 					 =  ut.CleanSpacesAndUpper(right.orig_name_last     )  and   
												ut.CleanSpacesAndUpper(left.orig_name_suffix  ) 				 =  ut.CleanSpacesAndUpper(right.orig_name_suffix    )  and   
												ut.CleanSpacesAndUpper(left.orig_address_1  ) 					 =  ut.CleanSpacesAndUpper(right.orig_address_1   )  and   
												ut.CleanSpacesAndUpper(left.orig_address_2  )           =  ut.CleanSpacesAndUpper(right.orig_address_2   )  and   
												ut.CleanSpacesAndUpper(left.orig_city  ) 							 =  ut.CleanSpacesAndUpper(right.orig_city   )  and   
												ut.CleanSpacesAndUpper(left.orig_state  )               =  ut.CleanSpacesAndUpper(right.orig_state   )  and   
												ut.CleanSpacesAndUpper(left.orig_zip  )                 =  ut.CleanSpacesAndUpper(right.orig_zip     )  and   
												ut.CleanSpacesAndUpper(left.orig_fips  )                =  ut.CleanSpacesAndUpper(right.orig_fips    )  and   
												// ut.CleanSpacesAndUpper(left.orig_province   )           =  ut.CleanSpacesAndUpper(right. orig_province  )  and   
												// ut.CleanSpacesAndUpper(left.orig_country    )           =  ut.CleanSpacesAndUpper(right.orig_country   )  and   
												ut.CleanSpacesAndUpper(left.dob  )                      =  ut.CleanSpacesAndUpper(right.dob   )  and   
												ut.CleanSpacesAndUpper(left.ssn  )                 			=  ut.CleanSpacesAndUpper(right.ssn   )  and   
												ut.CleanSpacesAndUpper(left.orig_fein  )                =  ut.CleanSpacesAndUpper(right.orig_fein    ),  
												//ut.CleanSpacesAndUpper(left.gender  )                   =  ut.CleanSpacesAndUpper(right.gender   )  and   
												// ut.CleanSpacesAndUpper(left.phone_1  )                  =  ut.CleanSpacesAndUpper(right.phone_1   )  and   
												// ut.CleanSpacesAndUpper(left.phone_2  )                  =  ut.CleanSpacesAndUpper(right.phone_2   ),
												// ut.CleanSpacesAndUpper(left.Reg_Owner_Name_2)           =  ut.CleanSpacesAndUpper(right.Reg_Owner_Name_2 ),
												trans_recID(left,right), left outer, lookup, local); 
												 
//*** End of source rec_id logic 

dCleanedPersonOnly	  := Append_recID(company_name='');
dCleanedCompanyOnly   := Append_recID(company_name<>'');

//add src 
src_rec := record
	header_slimsort.Layout_Source;
	rPreDIDRecord;
end;

DID_Add.Mac_Set_Source_Code(dCleanedPersonOnly, src_rec, MDR.sourceTools.str_convert_WC, dCleanedPersonOnly_src)

sDIDMatchSet 	:= ['A','D','S'];

did_Add.MAC_Match_Flex
	(dCleanedPersonOnly_src, sDIDMatchSet,
	 orig_ssn, temp_DOB, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip5, st, phone_1, 
	 temp_DID,
	 src_rec, 
	 true, temp_DID_Score,		//these should default to zero in definition
	 75,
	 dPostDID_src,true,src);		//try the dedup DIDing

dPostDID 				:= project(dPostDID_src, transform(rPreDIDRecord, self := left));

dPostDIDPersist	:=	dPostDID : persist('~thor_data400::persist::watercraft_PostDID');

did_add.MAC_Add_SSN_By_DID(dPostDIDPersist, temp_DID, SSN, dPostDIDandSSN)

dCleanedCompanyOnly_w_source := table(dCleanedCompanyOnly,{dCleanedCompanyOnly, string source := MDR.sourceTools.fWatercraft(source_code, state_origin)});

business_header.MAC_Source_Match( dCleanedCompanyOnly_w_source			   							 // infile
																	,dPostBusHdrSourceMatch														// outfile
																	,FALSE																				   // bool_bdid_field_is_string12
																	,temp_BDID																	    // bdid_field
																	,true																		     	 // bool_infile_has_source_field
																	,source         															// source_type_or_field
																	,FALSE																	     // bool_infile_has_source_group
																	,foo													         		  // source_group_field
																	,company_name											         // company_name_field
																	,prim_range											          // prim_range_field
																	,prim_name										           // prim_name_field
																	,sec_range									  					// sec_range_field
																	,zip5										   						 // zip_field
																	,false										            // bool_infile_has_phone
																	,foo			                  				 // phone_field
																	,false							                // bool_infile_has_fein
																	,foo   				                     // fein_field
																	);

Watercraft_bdid_SourceMatch	:=dPostBusHdrSourceMatch : persist('~thor_data400::persist::watercraft_PostBusHdrSourceMatch');

sBDIDMatchSet		   :=	['A'];
Business_Header_SS.MAC_Add_BDID_Flex( Watercraft_bdid_SourceMatch							
																			,sBDIDMatchSet                               // Input Dataset         
																			,company_name        		             		    // company_name	              
																			,prim_range		                             // prim_range		              
																			,prim_name		                            // prim_name		              
																			,zip5 					                         // zip5					              
																			,sec_range		                          // sec_range		              
																			,st				                             // state				              
																			,foo				           							  // phone				              
																			,orig_fein                           // fein              
																			,temp_BDID											 		// bdid												
																			,recordof(Watercraft_bdid_SourceMatch) // Output Layout 
																			,false                         		// output layout has bdid score field?                       
																			,temp_BDID_Score              	 // bdid_score                 
																			,dPostBDID                   	  // Output Dataset   
																			,														   // deafult threscold
																			,													    // use prod version of superfiles
																			,													   // default is to hit prod from dataland, and on prod hit prod.		
																			,BIPV2.xlink_version_set    // Create BIP Keys only
																			,           						   // Url
																			,								          // Email
																			,p_City_name					   // City
																			,fname							    // fname
																			,mname							   // mname
																			,lname						    // lname
																			,                    //	ssn
																			,source             //sourceField
																			,source_rec_id     //persistent_rec_id
																			,true             //Call sourceMatch macro before Flex 
																		);
dPostFlex_reformat 			:= project(dPostBDID,transform(recordof(dCleanedCompanyOnly),self:=left;));
dPostFlex_Total         := dPostDIDandSSN + dPostFlex_reformat;
WC_Post_Did_Flex				:= distribute(dPostFlex_Total  ,hash64(state_origin,source_code,watercraft_key));
WC_out_Base	 						:= sort( WC_Post_Did_Flex, watercraft_key, sequence_key, state_origin, source_code, dppa_flag, orig_name, orig_name_type_code
																 , orig_name_type_description, orig_name_first,orig_name_middle, orig_name_last, orig_name_suffix 
																 , orig_address_1, orig_address_2, orig_city, orig_state, orig_zip, orig_fips, orig_province 
																 , orig_country  , dob, orig_ssn, orig_fein, gender, phone_1, phone_2,Reg_Owner_Name_2,local);
																 
recordof(dCleanedCompanyOnly)	rollup_rec(recordof(dCleanedCompanyOnly)  l , recordof(dCleanedCompanyOnly) r) := transform
	self.date_vendor_first_reported  	:=  if(l.date_vendor_first_reported > r.date_vendor_first_reported, r.date_vendor_first_reported, l.date_vendor_first_reported);
  self.date_vendor_last_reported   	:= 	if(l.date_vendor_last_reported  < r.date_vendor_last_reported,  r.date_vendor_last_reported,  l.date_vendor_last_reported);
	self.date_first_seen							:=	if(l.date_first_seen > r.date_first_seen, r.date_first_seen, l.date_first_seen);
	self.date_last_seen								:=	if(l.date_last_seen  < r.date_last_seen,  r.date_last_seen,  l.date_last_seen);
	self.source_rec_id   						  := 	if(l.source_rec_id  <> 0 and l.source_rec_id < r.source_rec_id, l.source_rec_id, r.source_rec_id);
	self 													  	:= l;
end;
WC_rollupBase := rollup(WC_out_Base
											  , rollup_rec(left, right)
											  , ut.CleanSpacesAndUpper(watercraft_key), ut.CleanSpacesAndUpper(sequence_key), ut.CleanSpacesAndUpper(state_origin), ut.CleanSpacesAndUpper(source_code), ut.CleanSpacesAndUpper(dppa_flag), ut.CleanSpacesAndUpper(orig_name), ut.CleanSpacesAndUpper(orig_name_type_code)
											  , ut.CleanSpacesAndUpper(orig_name_type_description), ut.CleanSpacesAndUpper(orig_name_first),ut.CleanSpacesAndUpper(orig_name_middle), ut.CleanSpacesAndUpper(orig_name_last), ut.CleanSpacesAndUpper(orig_name_suffix) 
											  , ut.CleanSpacesAndUpper(orig_address_1), ut.CleanSpacesAndUpper(orig_address_2), ut.CleanSpacesAndUpper(orig_city), ut.CleanSpacesAndUpper(orig_state), ut.CleanSpacesAndUpper(orig_zip), ut.CleanSpacesAndUpper(orig_fips), ut.CleanSpacesAndUpper(orig_province) 
											  , ut.CleanSpacesAndUpper(orig_country)  ,trim(dob,left,right), trim(orig_ssn,left,right), trim(orig_fein,left,right), ut.CleanSpacesAndUpper(gender), trim(phone_1,left,right), trim(phone_2,left,right) ,ut.CleanSpacesAndUpper(Reg_Owner_Name_2)
											  ,local);

//*** appending the source record ids for the newer records.																			
ut.MAC_Append_Rcid (WC_rollupBase,source_rec_id,out_Append_recID);

dPostDIDandBDIDPersist	:=out_Append_recID	:	persist('~thor_data400::persist::watercraft_PostDIDandBDID');

ut.mac_suppress_by_phonetype(dPostDIDandBDIDPersist,phone_1,st,phone_1_suppressed,true,temp_did);
ut.mac_suppress_by_phonetype(phone_1_suppressed,    phone_2,st,phone_2_suppressed,true,temp_did);

f1 := dPostDIDandBDIDPersist(phone_1<>'' or phone_2<>'');

r1 := record
 f1.watercraft_key;
 f1.sequence_key;
 f1.state_origin;
 f1.source_code;
 f1.orig_name;
 f1.phone_1;
 f1.phone_2;
end;

ta1             := distribute(table(f1,r1),      hash64(watercraft_key,sequence_key,state_origin,source_code,orig_name));
phone_out3_dist := distribute(phone_2_suppressed,hash64(watercraft_key,sequence_key,state_origin,source_code,orig_name));

r1 t1(ta1 le, phone_2_suppressed ri) := transform
 self := le;
end;

j1 := join(ta1,phone_2_suppressed,left.watercraft_key=right.watercraft_key and 
                                  left.sequence_key  =right.sequence_key   and
																	left.state_origin  =right.state_origin   and
																	left.source_code   =right.source_code    and
																	left.orig_name     =right.orig_name      and
                                  (left.phone_1<>right.phone_1 or
																	left.phone_2<>right.phone_2),t1(left,right),local);
							   
output(j1,named('phones_that_should_be_suppressed_in_the_output'));
	
Watercraft.Layout_Watercraft_Search_Base tToMoxie(phone_2_suppressed pInput):=transform
  self.watercraft_key  := stringlib.stringtouppercase(pInput.watercraft_key);
	self.DID						 :=	intformat(pInput.temp_DID,12,1);
	self.DID_SCORE			 :=	(string3)pInput.temp_DID_SCORE;
	self.BDID						 :=	intformat(pInput.temp_BDID,12,1);
	self.dppa_flag			 :=	if(pInput.state_origin in Watercraft.sDPPA_Restricted_Watercraft_States,'Y','N');
	self								 :=	pInput;
  end ;

optout := ['CTC59611E505CORRECT CRAFT INC2','CTC59611E505CORRECT CRAFT2005']; //JIRA DF-16610 - Peter Kirn - CO address - opt out
export Persist_Search_Joined	:=	project(dPostDIDandBDIDPersist,tToMoxie(left))(watercraft_key not in optout) :	persist('persist::Watercraft_Search_Joined');