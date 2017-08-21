import AID, ut, Business_Header, Business_Header_SS, did_add,address,mdr, BIPV2;

export BDID_Non_Member(
	
	 string																		pversion
	,dataset(Layouts_Files.Input.NonMember	)	pInputFile
	,dataset(Layouts_Files.Base.NonMember_BIP		)	pBaseFile
	,string																		pPersistname = PersistNames.BDIDNonMember
	
) := 
function

BBB_Non_Member_Base 	:= pBaseFile;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Clear bdid field
//////////////////////////////////////////////////////////////////////////////////////////////
#if(BBB_Init_Flag = false)
Layouts_Files.Base.NonMember_BIP ClearBDIDBase(BBB_Non_Member_Base l) := 
transform
	self.bdid 	:= 0;
	BIPV2.IDlayouts.l_xlink_ids;
	self 				:= l;
end;

BBB_Non_Member_clear_bdid_base := project(BBB_Non_Member_Base, ClearBDIDBase(left));

BBB_Non_Member_combined := Clean_Non_Member(pversion,pInputFile) + BBB_Non_Member_clear_bdid_base;
#else
BBB_Non_Member_combined := Clean_Non_Member(pversion,pInputFile);
#end

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Clean and Standardizes all Addresses using the AID address cleaning
//////////////////////////////////////////////////////////////////////////////////////////////
HasAddress	:= trim(BBB_Non_Member_combined.prep_addr_line_last, left,right) != '';
								
dWith_address			:= BBB_Non_Member_combined(HasAddress);
dWithout_address	:= BBB_Non_Member_combined(not(HasAddress));

unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_line_last, Raw_AID, dNon_Member_withAID, lFlags);

dNonMember_Aid_Cleaned := project(
	dNon_Member_withAID
	,transform(
		Layouts_Files.Base.NonMember_BIP
		,
		self.ace_aid				:= left.aidwork_acecache.aid					;
		self.raw_aid				:= left.aidwork_rawaid								;
		self.prim_range			:= left.aidwork_acecache.prim_range		;
		self.predir					:= left.aidwork_acecache.predir				;
		self.prim_name			:= left.aidwork_acecache.prim_name		;
		self.addr_suffix		:= left.aidwork_acecache.addr_suffix	;
		self.postdir				:= left.aidwork_acecache.postdir			;
		self.unit_desig			:= left.aidwork_acecache.unit_desig		;
		self.sec_range			:= left.aidwork_acecache.sec_range		;
		self.p_city_name		:= left.aidwork_acecache.p_city_name	;
		self.v_city_name		:= left.aidwork_acecache.v_city_name	;
		self.st							:= left.aidwork_acecache.st						;
		self.zip						:= left.aidwork_acecache.zip5					;
		self.zip4						:= left.aidwork_acecache.zip4					;
		self.cart						:= left.aidwork_acecache.cart					;
		self.cr_sort_sz			:= left.aidwork_acecache.cr_sort_sz		;
		self.lot						:= left.aidwork_acecache.lot					;
		self.lot_order			:= left.aidwork_acecache.lot_order		;
		self.dbpc						:= left.aidwork_acecache.dbpc					;
		self.chk_digit			:= left.aidwork_acecache.chk_digit		;
		self.rec_type				:= left.aidwork_acecache.rec_type			;
		self.fips_state 		:= left.aidwork_acecache.county[1..2]	;
		self.fips_county		:= left.aidwork_acecache.county[3..]	;
		self.geo_lat				:= left.aidwork_acecache.geo_lat			;
		self.geo_long				:= left.aidwork_acecache.geo_long			;
		self.msa						:= left.aidwork_acecache.msa					;
		self.geo_blk				:= left.aidwork_acecache.geo_blk			;
		self.geo_match			:= left.aidwork_acecache.geo_match		;
		self.err_stat				:= left.aidwork_acecache.err_stat			;
						
		self								:= left																;
	)
) + dWithout_address;


//////////////////////////////////////////////////////////////////////////////////////////////
// -- Add Sequence Number to Combined File
//////////////////////////////////////////////////////////////////////////////////////////////
layout_BBB_Non_Member_seq := 
record
	unsigned4 seq;
	string2 source;
	Layouts_Files.Base.NonMember_BIP;
end;

layout_BBB_Non_Member_seq AddSeqNum(Layouts_Files.Base.NonMember_BIP l, unsigned4 cnt) :=
transform
	self.seq 		:= cnt;
	self.source_rec_id := HASH64(ut.CleanSpacesAndUpper(l.company_name) +
															 ut.CleanSpacesAndUpper(l.address) +
															 ut.CleanSpacesAndUpper(l.country) +
															 ut.CleanSpacesAndUpper(l.phone) +
															 ut.CleanSpacesAndUpper(l.phone_type) +
															 ut.CleanSpacesAndUpper(l.non_member_title) +
															 ut.CleanSpacesAndUpper(l.non_member_category)
															);
	self.source	:= mdr.sourceTools.src_BBB_Non_Member; 
	self 				:= l;
end;

BBB_Non_Member_seq := sort(distribute(project(dNonMember_Aid_Cleaned, AddSeqNum(left, counter)),seq),seq,local);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Slim Record for BDIDing, add BDID field
//////////////////////////////////////////////////////////////////////////////////////////////
layout_BBB_Non_Member_bdid := 
record
	unsigned6 bdid := 0;
	BIPV2.IDlayouts.l_xlink_ids;
	BBB_Non_Member_seq.source; 
  BBB_Non_Member_seq.source_rec_id;	
	BBB_Non_Member_seq.seq;
	BBB_Non_Member_seq.Company_Name;
	BBB_Non_Member_seq.prim_range;
	BBB_Non_Member_seq.prim_name;
	BBB_Non_Member_seq.sec_range;
	BBB_Non_Member_seq.st;
	BBB_Non_Member_seq.zip;
	BBB_Non_Member_seq.phone10;
	BBB_Non_Member_seq.p_city_name;
	BBB_Non_Member_seq.bbb_id;
end;

BBB_Non_Member_to_bdid := table(BBB_Non_Member_seq, layout_BBB_Non_Member_bdid);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- BDID records First Pass
//////////////////////////////////////////////////////////////////////////////////////////////
Business_Header.MAC_Source_Match(BBB_Non_Member_to_bdid, BBB_Non_Member_bdid_init,
                        false, bdid,
                        false, MDR.sourceTools.src_BBB_Non_Member,
                        true,  bbb_id,
                        company_name,prim_range, prim_name, sec_range, zip,
                        true,  phone10,
                        false, fein_field,
				    false,  vendor_id);


BDID_Matchset 				:= ['A','P'];

//////////////////////////////////////////////////////////////////////////////////////////////
// -- BDID records Second Pass on address and phone
//////////////////////////////////////////////////////////////////////////////////////////////
Business_Header_SS.MAC_Add_BDID_Flex(BBB_Non_Member_bdid_init     // Input Dataset
                                     ,BDID_Matchset               // BDID Matchset
                                     ,company_name                // company_name
                                     ,prim_range                  // prim_range
																		 ,prim_name                   // prim_name
																		 ,zip                         // zip5
                                     ,sec_range                   // sec_range
																		 ,st                          // state
                                     ,phone10                     // phone
																		 ,fein_field                  // fein
                                     ,bdid                        // bdid
																		 ,layout_BBB_Non_Member_bdid  // Output Layout
                                     ,FALSE                       // output layout has bdid score field?
																		 ,BDID_score_field            // bdid_score
                                     ,BBB_Non_Member_bdid_all     // Output Dataset   
	                                   ,												    // deafult threscold
	                                   ,											      // use prod version of superfiles
                                     ,												    // default is to hit prod from dataland, and on prod hit prod.		
	                                   ,BIPV2.xlink_version_set     // Create BIP Keys only
	                                   ,           					   	    // Url
	                                   ,								            // Email
	                                   ,p_city_name			    		    // City
	                                   ,              		          // fname
                                     ,              	      	    // mname
	                                   ,              	            // lname
  																	 ,                            // contact_ssn
																		 ,source                      // source - MDR.sourceTools
																		 ,source_rec_id               // source_record_id
																		 ,TRUE                        // src_matching_is_priority
                                     );

BBB_Non_Member_All_sort := sort(distribute(BBB_Non_Member_bdid_all,seq),seq,local);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Join back to input file and append BDIDs to create base file
//////////////////////////////////////////////////////////////////////////////////////////////
Layouts_Files.Base.NonMember_BIP JoinBack(layout_BBB_Non_Member_seq L, layout_BBB_Non_Member_bdid R) :=
transform
	self.bdid				:= R.bdid;
	self.ultid      := R.ultid;
  self.orgid      := R.orgid;
  self.seleid     := R.seleid;
  self.proxid     := R.proxid;
  self.powid      := R.powid;
  self.empid      := R.empid;
  self.dotid      := R.dotid;
  self.ultscore   := R.ultscore;
  self.orgscore   := R.orgscore;
  self.selescore  := R.selescore;
  self.proxscore  := R.proxscore;
  self.powscore   := R.powscore;
  self.empscore   := R.empscore;
  self.dotscore   := R.dotscore;
  self.ultweight  := R.ultweight;
  self.orgweight  := R.orgweight;
  self.seleweight := R.seleweight;
  self.proxweight := R.proxweight;
  self.powweight  := R.powweight;
  self.empweight  := R.empweight;
  self.dotweight  := R.dotweight;
	self 						:= L;
END;

jBBB_Non_Member   := join(BBB_Non_Member_seq,
													BBB_Non_Member_All_sort,
													left.seq = right.seq,
													JoinBack(left,right),
													left outer,
													local);

//////////////////////////////////////////////////////////////////////////////////////////
// -- Rollup on Raw Fields, setting date_first_seen, date_last_seen
//////////////////////////////////////////////////////////////////////////////////////////
Layouts_Files.Base.NonMember_BIP RollupBase(Layouts_Files.Base.NonMember_BIP L, Layouts_Files.Base.NonMember_BIP R) :=
transform
	self.date_first_seen 		     	:= ut.EarliestDate(
										ut.EarliestDate(L.date_first_seen,R.date_first_seen),
										ut.EarliestDate(L.date_last_seen,R.date_last_seen));
	self.date_last_seen 			    := max(L.date_last_seen, R.date_last_seen);
	self.dt_vendor_first_reported	:= ut.EarliestDate(
										ut.EarliestDate(L.dt_vendor_first_reported,R.dt_vendor_first_reported),
										ut.EarliestDate(L.dt_vendor_last_reported,R.dt_vendor_last_reported));
	self.dt_vendor_last_reported 	:= max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
	self.process_date_first_seen	:= ut.EarliestDate(	L.process_date_first_seen,R.process_date_first_seen);
	self.process_date_last_seen 	:= max(L.process_date_last_seen, R.process_date_last_seen);
	self                          := L;
END;

BBB_Non_Member_dist := distribute(jBBB_Non_Member,hash(bbb_id,company_name));
BBB_Non_Member_sort := sort(BBB_Non_Member_dist, 
						bbb_id,
						company_name,
						address,
						country,
						phone,
						phone_type,
//						report_date,
						http_link,
						non_member_title,
						-process_date_last_seen,
						local);

BBB_Non_Member_rollup := rollup(BBB_Non_Member_sort,
					left.bbb_id 		    	= right.bbb_id 				and
					left.company_name 		= right.company_name 		and
					left.address 		    	= right.address 			and
					left.country		    	= right.country 			and
			    left.phone				    = right.phone 				and
			    left.phone_type 	  	= right.phone_type 			and
//			        left.report_date 		= right.report_date 		and
			    left.http_link 	   		= right.http_link 			and
			    left.non_member_title	= right.non_member_title,
					RollupBase(left, right),
					local);

//////////////////////////////////////////////////////////////////////////////////////////
// -- Set Record Type flag
//////////////////////////////////////////////////////////////////////////////////////////
BBB_Non_Member_Grpd 		:= GROUP(BBB_Non_Member_rollup, bbb_id, LOCAL);
BBB_Non_Member_Grpd_Sort 	:= SORT(BBB_Non_Member_Grpd, -process_date_last_seen);

Layouts_Files.Base.NonMember_BIP SetRecordType(BBB_Non_Member_Grpd_Sort l, BBB_Non_Member_Grpd_Sort r) :=
transform
	self.record_type 	:= if(l.record_type = '', 'C', 'H');
	SELF 			        := r;
END;


BBB_Non_Member_Prop := GROUP(ITERATE(BBB_Non_Member_Grpd_Sort, SetRecordType(LEFT, RIGHT)));

BBB_Non_Member_Out :=  BBB_Non_Member_Prop : persist(pPersistname);

return BBB_Non_Member_Out;

end;
