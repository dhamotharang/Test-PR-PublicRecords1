IMPORT  address, fbnv2,  did_add,  didville, ut, header_slimsort, business_header, Business_Header_SS, watchdog, MDR, aid, PromoteSupers;

export   Proc_Build_FBN_Business_Base(string source) := FUNCTION

dBusinessInputs := 
                   //commented sources have not been sent by vendor in a long time, unsure of format
                   map(trim(source,left,right) in ['Filing','Event'] => ungroup(Mapping_FBN_FL_Business),
									               // trim(source,left,right) = 'Dallas' => ungroup(Mapping_FBN_TXD_Business),
				                         // trim(source,left,right) = 'InfoUSA'   => ungroup(Mapping_FBN_InfoUSA_Business),
				                         // trim(source,left,right) = 'San_Bernardino'   => ungroup(Mapping_FBN_CA_San_Bernardino_Business),
				                         trim(source,left,right) = 'San_Diego'   => ungroup(Mapping_FBN_CA_San_Diego_Business),
																 trim(source,left,right) = 'Santa_Clara' => ungroup(Mapping_FBN_CA_Santa_Clara_Business),
														     trim(source,left,right) = 'Harris' => ungroup(Mapping_FBN_TX_Harris_Business),
														     // trim(source,left,right) = 'NY' => ungroup(Mapping_FBN_NY_Business),
																 trim(source,left,right) = 'Orange' => ungroup(Mapping_FBN_CA_Orange_Business),
																 trim(source,left,right) = 'Ventura' => ungroup(Mapping_FBN_CA_Ventura_Business),
																 trim(source,left,right) = 'Experian' => ungroup(Mapping_FBN_Experian_Business));

Previous_Base	  := distribute(FBNV2.File_FBN_Business_Base_AID, hash64(tmsid));
	
dBusinessBaseInputs :=  
                ungroup(Mapping_FBN_BUSREG_Business)+	
								Previous_Base;

dBusiness :=  dBusinessInputs + dBusinessBaseInputs;

Layout_Bus_temp := record
	unsigned8		unique_id;
	recordof(dBusiness);
end;

Layout_Bus_temp	getUniqIds(dBusiness l, unsigned8 cnt) := transform
		self.unique_id	:= cnt;
		self 						:= l;
end;

dBusiness_w_ids := project(dBusiness, getUniqIds(left, counter));

/*//////////////////////////////////////////////////////////////////////////////////
-- Second, pass addresses to macro for cleaning
-- normalize address out into one file with address1, address2, type, and uniqueid, then pass to macro
//////////////////////////////////////////////////////////////////////////////////*/
addresslayout :=
record
	unsigned8										unique_id			;	//	to tie back to original record
	unsigned8										rawaid				;
	unsigned8										ACEaid				;			
	unsigned4										addr_type	;			// 	primary and mailing addresses
	string100 									address1			;
	string50										address2			;
end;

addresslayout tNormalizeAddress(Layout_Bus_temp l, unsigned4 cnt) :=
transform

	self.unique_id							:= l.unique_id;
	self.addr_type							:= cnt;
	self.address1								:= choose(cnt	,l.prep_addr_line1
																						,l.prep_mail_addr_line1																						
																				);
	self.address2								:= choose(cnt	,l.prep_addr_line_last
																						,l.prep_mail_addr_line_last
																			 ); 
	self.rawaid									:= choose(cnt	,if(l.RawAid != 0, l.RawAid, 0)
																						,if(l.mail_RawAid != 0, l.mail_RawAid, 0)
																				);
	self.aceaid									:= choose(cnt	,if(l.ACEAid != 0, l.ACEAid, 0)
																						,if(l.mail_ACEAid != 0, l.mail_ACEAid, 0)
																				);	
end;

dBusiness_addr_norm	:= normalize(dBusiness_w_ids, if(trim(left.prep_mail_addr_line1,left,right)      <>'' and
                                                     trim(left.prep_mail_addr_line_last,left,right)  <>'' 
                                                  ,2,1),
                                 tNormalizeAddress(left,counter));


HasAddress	:=	trim(dBusiness_addr_norm.address1, left,right) != '' and 
								trim(dBusiness_addr_norm.address2, left,right) != '';
									
dBus_With_address			:= dBusiness_addr_norm(HasAddress);
dBus_Without_address	:= dBusiness_addr_norm(not(HasAddress));

unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

AID.MacAppendFromRaw_2Line(dBus_With_address, address1, address2, RawAID, dwithAID, lFlags);

/*-- match back to dStandardizedFirstPass and append address*/
dBusiness_w_ids_dist			 	:= distribute(dBusiness_w_ids	,unique_id);
dAddressStandardized_dist		:= distribute(dwithAID		,unique_id);

Address.Layout_Clean182_fips fReformatAceCache(AID.Layouts.rACECache	pRow) :=
transform
	self.fips_state		:= pRow.county[1..2];
	self.fips_county	:= pRow.county[3..]	;
	self.zip					:= pRow.zip5				;
	self							:= pRow							;
end;

Layout_Bus_temp tGetStandardizedAddress(Layout_Bus_temp l	,dAddressStandardized_dist r) :=
transform

	aidwork_acecache := row(fReformatAceCache(r.aidwork_acecache));

	self.RawAid							:= if(r.addr_type = 1	,r.AIDWork_RawAID	,l.RawAid);
	self.ACEAid							:= if(r.addr_type = 1	,r.aidwork_acecache.aid	,l.ACEAid);			
	self.prim_range					:= if(r.addr_type = 1	,aidwork_acecache.prim_range	,l.prim_range);
	self.predir							:= if(r.addr_type = 1	,aidwork_acecache.predir	,l.predir);
	self.prim_name					:= if(r.addr_type = 1	,aidwork_acecache.prim_name	,l.prim_name);
	self.addr_suffix				:= if(r.addr_type = 1	,aidwork_acecache.addr_suffix	,l.addr_suffix);
	self.postdir						:= if(r.addr_type = 1	,aidwork_acecache.postdir	,l.postdir);
	self.unit_desig					:= if(r.addr_type = 1	,aidwork_acecache.unit_desig	,l.unit_desig);
	self.sec_range					:= if(r.addr_type = 1	,aidwork_acecache.sec_range	,l.sec_range);
	/*self.p_city_name			:= if(r.addr_type = 1	,aidwork_acecache.p_city_name	,l.p_city_name);*/
	
	self.v_city_name				:= if(r.addr_type = 1	,aidwork_acecache.v_city_name	,l.v_city_name);	
	self.st									:= if(r.addr_type = 1	,aidwork_acecache.st	,l.st);
	self.zip5								:= if(r.addr_type = 1	,aidwork_acecache.zip	,l.zip5);
	self.zip4								:= if(r.addr_type = 1	,aidwork_acecache.zip4	,l.zip4);
	
  /*self.cart								:= if(r.addr_type = 1	,aidwork_acecache.cart	,l.cart);
	self.cr_sort_sz					:= if(r.addr_type = 1	,aidwork_acecache.cr_sort_sz	,l.cr_sort_sz);
	self.lot								:= if(r.addr_type = 1	,aidwork_acecache.lot	,l.lot);
	self.lot_order					:= if(r.addr_type = 1	,aidwork_acecache.lot_order	,l.lot_order);
	self.dbpc								:= if(r.addr_type = 1	,aidwork_acecache.dbpc	,l.dbpc);
	self.chk_digit					:= if(r.addr_type = 1	,aidwork_acecache.chk_digit	,l.chk_digit);*/	
	self.addr_rec_type			:= if(r.addr_type = 1	,aidwork_acecache.rec_type	,l.addr_rec_type);
	self.fips_state					:= if(r.addr_type = 1	,aidwork_acecache.fips_state	,l.fips_state);
	self.fips_county				:= if(r.addr_type = 1	,aidwork_acecache.fips_county	,l.fips_county);
	self.geo_lat						:= if(r.addr_type = 1	,aidwork_acecache.geo_lat	,l.geo_lat);
	self.geo_long						:= if(r.addr_type = 1	,aidwork_acecache.geo_long	,l.geo_long);
	self.cbsa								:= if(r.addr_type = 1	,aidwork_acecache.msa	,l.cbsa);
	self.geo_blk						:= if(r.addr_type = 1	,aidwork_acecache.geo_blk	,l.geo_blk);
	self.geo_match					:= if(r.addr_type = 1	,aidwork_acecache.geo_match	,l.geo_match);
	self.err_stat						:= if(r.addr_type = 1	,aidwork_acecache.err_stat	,l.err_stat);
		

	self.Mail_RawAid				:= if(r.addr_type = 2	,r.AIDWork_RawAID	,l.Mail_RawAid);
	self.Mail_ACEAid				:= if(r.addr_type = 2	,r.aidwork_acecache.aid	,l.Mail_ACEAid);				
	self.Mail_prim_range		:= if(r.addr_type = 2	,aidwork_acecache.prim_range	,l.Mail_prim_range);
	self.Mail_predir				:= if(r.addr_type = 2	,aidwork_acecache.predir	,l.Mail_predir);
	self.Mail_prim_name			:= if(r.addr_type = 2	,aidwork_acecache.prim_name	,l.Mail_prim_name);
	self.Mail_addr_suffix		:= if(r.addr_type = 2	,aidwork_acecache.addr_suffix	,l.Mail_addr_suffix);
	self.Mail_postdir				:= if(r.addr_type = 2	,aidwork_acecache.postdir	,l.Mail_postdir);
	self.Mail_unit_desig		:= if(r.addr_type = 2	,aidwork_acecache.unit_desig	,l.Mail_unit_desig);
	self.Mail_sec_range			:= if(r.addr_type = 2	,aidwork_acecache.sec_range	,l.Mail_sec_range);
	
	self.Mail_v_city_name		:= if(r.addr_type = 2	,aidwork_acecache.v_city_name	,l.Mail_v_city_name);	
	self.Mail_st						:= if(r.addr_type = 2	,aidwork_acecache.st	,l.Mail_st);
	self.Mail_zip5					:= if(r.addr_type = 2	,aidwork_acecache.zip	,l.Mail_zip5);
	self.Mail_zip4					:= if(r.addr_type = 2	,aidwork_acecache.zip4	,l.Mail_zip4);
	

	/*self.Mail_cart					:= if(r.addr_type = 2	,aidwork_acecache.cart	,l.Mail_cart);
	self.Mail_cr_sort_sz		:= if(r.addr_type = 2	,aidwork_acecache.cr_sort_sz	,l.Mail_cr_sort_sz);
	self.Mail_lot						:= if(r.addr_type = 2	,aidwork_acecache.lot	,l.Mail_lot);
	self.Mail_lot_order			:= if(r.addr_type = 2	,aidwork_acecache.lot_order	,l.Mail_lot_order);
	self.Mail_dbpc					:= if(r.addr_type = 2	,aidwork_acecache.dbpc	,l.Mail_dbpc);
	self.Mail_chk_digit			:= if(r.addr_type = 2	,aidwork_acecache.chk_digit	,l.Mail_chk_digit);*/
	self.Mail_addr_rec_type	:= if(r.addr_type = 2	,aidwork_acecache.rec_type	,l.Mail_addr_rec_type);
	self.Mail_fips_state		:= if(r.addr_type = 2	,aidwork_acecache.fips_state	,l.Mail_fips_state);
	self.Mail_fips_county		:= if(r.addr_type = 2	,aidwork_acecache.fips_county	,l.Mail_fips_county);
	self.Mail_geo_lat				:= if(r.addr_type = 2	,aidwork_acecache.geo_lat	,l.Mail_geo_lat);
	self.Mail_geo_long			:= if(r.addr_type = 2	,aidwork_acecache.geo_long	,l.Mail_geo_long);
	self.Mail_cbsa					:= if(r.addr_type = 2	,aidwork_acecache.msa	,l.Mail_cbsa);
	self.Mail_geo_blk				:= if(r.addr_type = 2	,aidwork_acecache.geo_blk	,l.Mail_geo_blk);
	self.Mail_geo_match			:= if(r.addr_type = 2	,aidwork_acecache.geo_match	,l.Mail_geo_match);
	self.Mail_err_stat			:= if(r.addr_type = 2	,aidwork_acecache.err_stat	,l.Mail_err_stat);
	self 										:= l;
end;

dBusiness_denom_Addr	:= denormalize(
														 dBusiness_w_ids_dist
														,dAddressStandardized_dist
														,left.unique_id = right.unique_id
														,tGetStandardizedAddress(left,right)
														,local
													);
													
/**** End of AID process.*/

/** FBN builds,Base File by processing all raw-inputs each time
below we are using previous baseFile in order to populate "source_rec_id" to the records */
  
Update_Base		  := distribute(dBusiness_denom_Addr, hash64(tmsid));
// Previous_Base	  := distribute(FBNV2.File_FBN_Business_Base_AID, hash64(tmsid));
						
Layout_Bus_temp     trans_get_src_recIDs(Layout_Bus_temp l,Layout_Common.Business_AID r):=transform
self.source_rec_id := r.source_rec_id;
self               := l;
end;

Append_recID:= join(Update_Base,Previous_Base,
										trim(left.tmsid,left,right)                 =  trim(right.tmsid  ,left,right) and
										trim(left.rmsid,left,right)                 =  trim(right.rmsid  ,left,right) and
/*** removed all these clean address ids that can change overtime (due to improvements made to address cleaners) in tern effects the source record ids.
												 left.rawaid        										=  			right.rawaid  and
												 left.Mail_RawAID                       = 			right.Mail_RawAID and
												 left.ACEAID        										=  			right.ACEAID  and
												 left.Mail_ACEAID                       = 			right.Mail_ACEAID and */												 
										trim(left.Filing_Jurisdiction,left,right)		=  trim(right.Filing_Jurisdiction,left,right) and
										trim(left.FILING_NUMBER	,left,right)        =  trim(right.FILING_NUMBER  ,left,right) and
												 left.Filing_date                       =       right.Filing_date  and
										trim(left.FILING_TYPE,left,right)           =  trim(right.FILING_TYPE  ,left,right) and
												 left.EXPIRATION_DATE       						=  			right.EXPIRATION_DATE   and
												 left.CANCELLATION_DATE     						= 			right.CANCELLATION_DATE  and
										trim(left.ORIG_FILING_NUMBER,left,right)    =  trim(right.ORIG_FILING_NUMBER  ,left,right) and
												 left.ORIG_FILING_DATE                  =  			right.ORIG_FILING_DATE  and
										trim(left.BUS_NAME,left,right)              =  trim(right.BUS_NAME  ,left,right) and
										trim(left.LONG_BUS_NAME,left,right)         =  trim(right.LONG_BUS_NAME  ,left,right) and
												 left.bus_comm_dATE                     =       right.bus_comm_dATE  and
										trim(left.bus_statUS,left,right)            =  trim(right.bus_statUS  ,left,right) and
												 left.orig_FEIN							            =  			right.orig_FEIN  and
										trim(left.BUS_PHONE_NUM,left,right)         =  trim(right.BUS_PHONE_NUM  ,left,right) and
										trim(left.SIC_CODE,left,right)              =  trim(right.SIC_CODE  ,left,right) and
										trim(left.BUS_TYPE_DESC,left,right)         =  trim(right.BUS_TYPE_DESC,left,right) and
										trim(left.BUS_ADDRESS1,left,right)          =  trim(right.BUS_ADDRESS1  ,left,right) and
										trim(left.BUS_ADDRESS2,left,right)          =  trim(right.BUS_ADDRESS2  ,left,right) and
										trim(left.BUS_CITY,left,right)              =  trim(right.BUS_CITY  ,left,right) and
										trim(left.BUS_COUNTY,left,right)            =  trim(right.BUS_COUNTY  ,left,right) and
										trim(left.BUS_STATE,left,right)             =  trim(right.BUS_STATE  ,left,right) and
												 left.BUS_ZIP               						=  			right.BUS_ZIP  and
												 left.BUS_ZIP4              						=  			right.BUS_ZIP4 and
										trim(left.BUS_COUNTRY,left,right)           =  trim(right.BUS_COUNTRY  ,left,right) and
										trim(left.MAIL_STREET,left,right)           =  trim(right.MAIL_STREET  ,left,right) and
										trim(left.MAIL_CITY,left,right)             =  trim(right.MAIL_CITY  ,left,right) and
										trim(left.MAIL_STATE,left,right)            =  trim(right.MAIL_STATE  ,left,right) and
										trim(left.MAIL_ZIP,left,right)              =  trim(right.MAIL_ZIP  ,left,right) and
												 left.SEQ_NO							              =  			right.SEQ_NO  ,
							trans_get_src_recIDs(left,right),left outer,local);
/*** End of source rec_id logic*/ 

slim_cont_rec := record
		Layout_Common.Contact_AID.tmsid;
		Layout_Common.Contact_AID.rmsid;
		Layout_Common.Contact_AID.fname;
		Layout_Common.Contact_AID.lname;
		Layout_Common.Contact_AID.mname;
end;

ds_company 			:= dedup(sort(distribute(Append_recID,hash64(tmsid)),record,local),record,local);

dcontacts				:= project(FBNV2.File_FBN_Contact_Base_AID, transform(slim_cont_rec, self := left));
dcontacts_ded		:= dedup(sort(distribute(dcontacts,hash64(tmsid)),record,local),record,local);

Layout_Company_Exd:=record
  Layout_Bus_temp;
  slim_cont_rec -tmsid -rmsid;
end;

Layout_Company_Exd x8( Layout_Bus_temp L, slim_cont_rec R) := transform
  self.fname				:=r.fname;
  self.mname				:=r.mname;
  self.lname				:=r.lname;
  self							:=	l;
end;

ds_Company_Exd := join(	ds_company
                        ,dcontacts_ded	
                        ,left.tmsid=right.tmsid and 
                         left.rmsid=right.rmsid
                        ,x8(left,right)
                        ,left outer
                        ,local
                       );

/**  Appending the BDID and BIPV2 Ids.*/                       
sBDIDMatchSet		   :=	['A','F','P'];

/*-- Add source code so can do a source match to business headers
-- Bug: 36599 - Business Header/Header Source code sync up */
ds_Company_Exd_source := table(ds_Company_Exd , { ds_Company_Exd ;string2 source := MDR.sourceTools.fFBNV2(tmsid)}); 
	
Business_Header_SS.MAC_Add_BDID_Flex(
           ds_Company_Exd_source									 			  // Input Dataset						
          ,sBDIDMatchSet                                 // BDID Matchset           
          ,Bus_name        		             		          // company_name	              
          ,prim_range		                               // prim_range		              
          ,prim_name		                         			// prim_name		              
          ,zip5 					                       		 // zip5					              
          ,sec_range		                            // sec_range		              
          ,st				                               // state				              
          ,BUS_PHONE_NUM			           					// phone				              
          ,orig_fein                             // fein              
          ,bdid											 					  // bdid												
          ,recordof(ds_Company_Exd_source)	   // Output Layout 
          ,false                         			// output layout has bdid score field?                       
          ,BDID_Score                        // bdid_score                 
          ,dPostFlex          						  // Output Dataset   
          ,																 // deafult threscold
          ,													 			// use prod version of superfiles
          ,															 // default is to hit prod from dataland, and on prod hit prod.		
          ,BIPV2.xlink_version_set 			// Create BIP Keys only
          ,           								 // Url
          ,								            // Email
          ,v_city_name							 // City
          ,fname							      // fname
          ,mname									 // mname
          ,lname						 			// lname
					,                    	 //	ssn
					,source             	//sourceField
					,source_rec_id       //persistent_rec_id
					,false            	//Call Flex before sourceMatch 
);


/*deduping multiple xlinkID records & keeping only highest score xlinkID's for business records*/
dPostBDID_dedup			     := dedup(sort(distribute(dPostFlex, unique_id),unique_id,-proxscore,-selescore,-orgscore,-ultscore,-powscore,-empscore,-dotscore, local),unique_id, local);

dWithBdids          := dPostBDID_dedup(BDID != 0);
dWithNoBdids        := dPostBDID_dedup(BDID = 0);

business_header.MAC_Source_Match(
		   dWithNoBdids      											            	// infile
			,dPostSource_BDID												 						 // outfile
			,FALSE																							// bool_bdid_field_is_string12
			,BDID														 									 // bdid_field
			,true																							// bool_infile_has_source_field
			,source 										   									 // source_type_or_field
			,FALSE																					// bool_infile_has_source_group
			,corp_key										 									 // source_group_field
			,Bus_name																			// company_name_field
			,prim_range								 									 // prim_range_field
			,prim_name																	// prim_name_field
			,sec_range							 									 // sec_range_field
			,zip5																			// zip_field
			,TRUE																		 // bool_infile_has_phone
			,BUS_PHONE_NUM			  									// phone_field
			,true								 									 // bool_infile_has_fein
			,Orig_fein     												// fein_field
			,FALSE															 // bool_infile_has_vendor_id	 
			,corp_key		  											// vendor_id_field	
			);
			
dPostBDID_reformat 			 := project(dWithBdids + dPostSource_BDID, transform(layout_common.Business_AID, self := left));

ds_bdid_match            := sort(distribute(dPostBDID_reformat ,hash64(tmsid)),record, except dt_first_seen, dt_last_seen, dt_vendor_first_reported, dt_vendor_last_reported, source_rec_id, local);

fbnv2.Layout_Common.Business_AID rolluprecs(ds_bdid_match l, ds_bdid_match r) := transform
   		self.dt_first_seen 						:= ut.min2(l.dt_first_seen, r.dt_first_seen);
   		self.dt_last_seen  						:= MAX(l.dt_last_seen, r.dt_last_seen);
   		self.dt_vendor_first_reported := ut.min2(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
   		self.dt_vendor_last_reported  := MAX(l.dt_vendor_last_reported, r.dt_vendor_last_reported);	
			self.source_rec_id            := if(l.source_rec_id<>0, l.source_rec_id, r.source_rec_id);
   		self 													:= l;
end;
rolledup_recs := rollup(ds_bdid_match, rolluprecs(left,right),
                        RECORD, except dt_first_seen, dt_last_seen, dt_vendor_first_reported, dt_vendor_last_reported,source_rec_id, local);

/*** appending the source record ids for the newer records.  */                                                                                                                                                 
ut.MAC_Append_Rcid (rolledup_recs,source_rec_id,out_file);                                                                                    
										 
dPostDIDandBDIDPersist	:=	out_file:persist(fbnv2.cluster.cluster_out+'persist::FBNv2::Business');
					
PromoteSupers.MAC_SF_BuildProcess(dPostDIDandBDIDPersist,fbnv2.cluster.cluster_out+'base::FBNv2::Business',Out, 3,pCompress:=true);
				
return out;	

END;
