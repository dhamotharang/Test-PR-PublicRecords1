import strata, ut;

export Strata_Pop_Base(string pVersion) := function
dsBin := FBNV2.File_FBN_Business_Base_AID;
dsCin := File_FBN_contact_Base;

layoutState:=record
dSBin.tmsid;
dSBin.rmsid;
dSBin.Filing_Jurisdiction;
end;

dLookup:=dedup(table(dSBin,layoutState),all);

LayoutdsC :=record
recordof(dSCin);
String11 sourceGroup;
string11 StateGroup;
end;
LayoutdsB :=record
recordof(dSBin);
String11 sourceGroup;
string11 StateGroup;
end;

LayoutdSC Transf(dSCin pleft, dlookup pright):=Transform
self.StateGroup :=MAP(pright.Filing_Jurisdiction ='TXD' =>'TX-Dallas',
	                  pright.Filing_Jurisdiction='TXH' =>'TX-Harrise',
					  pright.Filing_Jurisdiction);
self.sourceGroup:=MAP(pleft.tmsid[1..3]='TXD' =>'TX-Dallas',
	                  pleft.tmsid[1..3]='TXH' =>'TX-Harrise',
					  pleft.tmsid[1..3]='INF' =>'INFOUSA', pleft.tmsid[1..2]);
self                    :=pleft;
end;

LayoutdSB TransfM(dSBin pInput):=Transform

self.StateGroup :=MAP(pInput.Filing_Jurisdiction ='TXD' =>'TX-Dallas',
	                  pInput.Filing_Jurisdiction='TXH' =>'TX-Harrise',
					  pInput.Filing_Jurisdiction);
self.sourceGroup:=MAP(pInput.tmsid[1..3]='TXD' =>'TX-Dallas',
	                  pInput.tmsid[1..3]='TXH' =>'TX-Harrise',
					  pInput.tmsid[1..3]='INF' =>'INFOUSA', pinput.tmsid[1..2]);
self            :=pInput;
end;
dSB :=project(dSBin,transfm(left));
dSC:=join(dSCin,dLookup,left.tmsid=right.tmsid and left.rmsid=right.rmsid, transf(left,right));

rBDIDstats_dSC := record
  integer countGroup := count(group);
  dSC.sourceGroup;
  dSC.StateGroup;
  BDID_nonzero := sum(group, if(dSC.bdid <> 0, 1, 0));
  //has_bdid   := sum(group,IF((unsigned6)dSC(lname = '').bdid <> 0,1,0))/sum(group,IF(dSC.lname = '',1,0)) * 100;
end;

rDIDstats_dSC := record
  integer countGroup := count(group);
  dSC.sourceGroup;
  dSC.StateGroup;
  DID_nonzero := sum(group, if(dsc.did <> 0, 1, 0));
  //Has_DID 	 := sum(group,IF((unsigned6)dSC(lname <> '').did <> 0,1,0))/sum(group,IF(dSC.lname <> '',1,0)) * 100;
end;

rPopulationStats_FBNV2_business
 :=
  record
   
    integer countGroup := count(group);
	  dSB.StateGroup  ;
    dSB.SourceGroup;  
	  Tmsid_CountNonZero                                   := sum(group,if(dsB.Tmsid<>'',1,0));
    Rmsid_CountNonZero                                   := sum(group,if(dsB.Rmsid<>'',1,0));
    dt_first_seen_CountNonZero                           := sum(group,if(dsb.dt_first_seen<>0,1,0));
    dt_last_seen_CountNonZero                            := sum(group,if(dsb.dt_last_seen<>0,1,0));
    dt_vendor_first_reported_CountNonZero                := sum(group,if(dsb.dt_vendor_first_reported<>0,1,0));
    dt_vendor_last_reported_CountNonZero                 := sum(group,if(dsb.dt_vendor_last_reported<>0,1,0));
    Filing_Jurisdiction_CountNonZero                     := sum(group,if(dsb.Filing_Jurisdiction<>'',1,0));
    FILING_NUMBER_CountNonZero                           := sum(group,if(dsb.FILING_NUMBER<>'',1,0));
    Filing_date_CountNonZero                             := sum(group,if(dsb.Filing_date<>0,1,0));
    EXPIRATION_DATE_CountNonZero                         := sum(group,if(dsb.EXPIRATION_DATE<>0,1,0));
    CANCELLATION_DATE_CountNonZero                       := sum(group,if(dsb.CANCELLATION_DATE<>0,1,0));
    ORIG_FILING_NUMBER_CountNonZero                      := sum(group,if(dsb.ORIG_FILING_NUMBER<>'',1,0));
    ORIG_FILING_DATE_CountNonZero                        := sum(group,if(dsb.ORIG_FILING_DATE<>0,1,0));
    BUS_NAME_CountNonZero                                := sum(group,if(dsb.BUS_NAME<>'',1,0));
    bus_comm_dATE_CountNonZero                           := sum(group,if(dsb.bus_comm_dATE<>0,1,0));
    bus_statUS_CountNonZero                              := sum(group,if(dsb.bus_statUS<>'',1,0));
    orig_FEIN_CountNonZero                               := sum(group,if(dsb.orig_FEIN<>0,1,0));
    BUS_PHONE_NUM_CountNonBlank                          := sum(group,if(dsb.BUS_PHONE_NUM<>'',1,0));
    SIC_CODE_CountNonZero                                := sum(group,if(dsb.SIC_CODE<>'',1,0));
    BUS_TYPE_DESC_CountNonZero                           := sum(group,if(dsb.BUS_TYPE_DESC<>'',1,0));
    BUS_ADDRESS1_CountNonZero                            := sum(group,if(dsb.BUS_ADDRESS1<>'',1,0));
    BUS_ADDRESS2_CountNonZero                            := sum(group,if(dsb.BUS_ADDRESS2<>'',1,0));
    BUS_COUNTY_CountNonZero                              := sum(group,if(dsb.BUS_COUNTY<>'',1,0));
    BUS_STATE_CountNonZero                               := sum(group,if(dsb.BUS_STATE<>'',1,0));
    BUS_ZIP_CountNonZero                                 := sum(group,if(dsb.BUS_ZIP<>0,1,0));
    BUS_ZIP4_CountNonZero                                := sum(group,if(dsb.BUS_ZIP4<>0,1,0));
    BUS_COUNTRY_CountNonZero                             := sum(group,if(dsb.BUS_COUNTRY<>'',1,0));
    MAIL_STREET_CountNonZero                             := sum(group,if(dsb.MAIL_STREET<>'',1,0));
    MAIL_CITY_CountNonZero                               := sum(group,if(dsb.MAIL_CITY<>'',1,0));
    MAIL_STATE_CountNonZero                              := sum(group,if(dsb.MAIL_STATE<>'',1,0));
    MAIL_ZIP_CountNonZero                                := sum(group,if(dsb.MAIL_ZIP<>'',1,0));
    prim_range_CountNonBlank                             := sum(group,if(dsb.prim_range<>'',1,0));
    prim_name_CountNonBlank                              := sum(group,if(dsb.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                            := sum(group,if(dsb.addr_suffix<>'',1,0));
    postdir_CountNonBlank                                := sum(group,if(dsb.postdir<>'',1,0));
    unit_desig_CountNonBlank                             := sum(group,if(dsb.unit_desig<>'',1,0));
    sec_range_CountNonBlank                              := sum(group,if(dsb.sec_range<>'',1,0));
    v_city_name_CountNonBlank                            := sum(group,if(dsb.v_city_name<>'',1,0));
		st_CountNonBlank                                     := sum(group,if(dsb.st<>'',1,0));
    zip5_CountNonBlank                                   := sum(group,if(dsb.zip5<>'',1,0));
    zip4_CountNonBlank                                   := sum(group,if(dsb.zip4<>'',1,0));
    addr_rec_type_CountNonBlank                          := sum(group,if(dsb.addr_rec_type<>'',1,0));
    fips_state_CountNonBlank                             := sum(group,if(dsb.fips_state<>'',1,0));
    fips_county_CountNonBlank                            := sum(group,if(dsb.fips_county<>'',1,0));
    geo_lat_CountNonBlank                                := sum(group,if(dsb.geo_lat<>'',1,0));
    geo_long_CountNonBlank                               := sum(group,if(dsb.geo_long<>'',1,0));
    geo_blk_CountNonBlank                                := sum(group,if(dsb.geo_blk<>'',1,0));
    geo_match_CountNonBlank                              := sum(group,if(dsb.geo_match<>'',1,0));
    err_stat_CountNonBlank                               := sum(group,if(dsb.err_stat<>'',1,0));
    mail_prim_range_CountNonBlank                        := sum(group,if(dsb.mail_prim_range<>'',1,0));
    mail_predir_CountNonBlank                            := sum(group,if(dsb.mail_predir<>'',1,0));
    mail_prim_name_CountNonBlank                         := sum(group,if(dsb.mail_prim_name<>'',1,0));
    mail_addr_suffix_CountNonBlank                       := sum(group,if(dsb.mail_addr_suffix<>'',1,0));
    mail_postdir_CountNonBlank                           := sum(group,if(dsb.mail_postdir<>'',1,0));
    mail_unit_desig_CountNonBlank                        := sum(group,if(dsb.mail_unit_desig<>'',1,0));
    mail_sec_range_CountNonBlank                         := sum(group,if(dsb.mail_sec_range<>'',1,0));
    mail_v_city_name_CountNonBlank                       := sum(group,if(dsb.mail_v_city_name<>'',1,0));
    mail_st_CountNonBlank                                := sum(group,if(dsb.mail_st<>'',1,0));
    mail_zip5_CountNonBlank                              := sum(group,if(dsb.mail_zip5<>'',1,0));
    mail_zip4_CountNonBlank                              := sum(group,if(dsb.mail_zip4<>'',1,0));
    mail_addr_rec_type_CountNonBlank                     := sum(group,if(dsb.mail_addr_rec_type<>'',1,0));
    mail_fips_state_CountNonBlank                        := sum(group,if(dsb.mail_fips_state<>'',1,0));
    mail_fips_county_CountNonBlank                       := sum(group,if(dsb.mail_fips_county<>'',1,0));
    mail_geo_lat_CountNonBlank                           := sum(group,if(dsb.mail_geo_lat<>'',1,0));
    mail_geo_long_CountNonBlank                          := sum(group,if(dsb.mail_geo_long<>'',1,0));
    mail_cbsa_CountNonBlank                              := sum(group,if(dsb.mail_cbsa<>'',1,0));
    mail_geo_blk_CountNonBlank                           := sum(group,if(dsb.mail_geo_blk<>'',1,0));
    mail_geo_match_CountNonBlank                         := sum(group,if(dsb.mail_geo_match<>'',1,0));
    mail_err_stat_CountNonBlank                          := sum(group,if(dsb.mail_err_stat<>'',1,0));
    bdid_CountNonZero                                    := sum(group,if(dsb.bdid<>0,1,0));
    bdid_score_CountNonZero                              := sum(group,if(dsb.bdid_score<>0,1,0));	
		//BIPV2 fields have been added for Strata
		source_rec_id_CountNonZeros	   											 := sum(group,if(dsb.source_rec_id<>0,1,0));
		DotID_CountNonZeros	 																 := sum(group,if(dsb.DotID<>0,1,0));
		DotScore_CountNonZeros	  													 := sum(group,if(dsb.DotScore<>0,1,0));
		DotWeight_CountNonZeros	 														 := sum(group,if(dsb.DotWeight<>0,1,0));
		EmpID_CountNonZeros	   															 := sum(group,if(dsb.EmpID<>0,1,0));
 		EmpScore_CountNonZeros	 														 := sum(group,if(dsb.EmpScore<>0,1,0));
		EmpWeight_CountNonZeros	 									           := sum(group,if(dsb.EmpWeight<>0,1,0));
		POWID_CountNonZeros	                                 := sum(group,if(dsb.POWID<>0,1,0));
		POWScore_CountNonZeros	                             := sum(group,if(dsb.POWScore<>0,1,0));
		POWWeight_CountNonZeros	                             := sum(group,if(dsb.POWWeight<>0,1,0));
		ProxID_CountNonZeros	                               := sum(group,if(dsb.ProxID<>0,1,0));
		ProxScore_CountNonZeros	                             := sum(group,if(dsb.ProxScore<>0,1,0));
		ProxWeight_CountNonZeros	                           := sum(group,if(dsb.ProxWeight<>0,1,0));
		SELEID_CountNonZeros	                        			 := sum(group,if(dsb.SELEID<>0,1,0));
		SELEScore_CountNonZeros	                      			 := sum(group,if(dsb.SELEScore<>0,1,0));
		SELEWeight_CountNonZeros	                    			 := sum(group,if(dsb.SELEWeight<>0,1,0));
		OrgID_CountNonZeros	                                 := sum(group,if(dsb.OrgID<>0,1,0));
		OrgScore_CountNonZeros	                             := sum(group,if(dsb.OrgScore<>0,1,0));
		OrgWeight_CountNonZeros	                             := sum(group,if(dsb.OrgWeight<>0,1,0));
		UltID_CountNonZeros	                                 := sum(group,if(dsb.UltID<>0,1,0));
		UltScore_CountNonZeros	                             := sum(group,if(dsb.UltScore<>0,1,0));
		UltWeight_CountNonZeros	                             := sum(group,if(dsb.UltWeight<>0,1,0));
  end;
		

rPopulationStats_fbnv2_Contact
 :=
  record
    integer countGroup := count(group);
	dSC.StateGroup  ;
    dSC.SourceGroup;  
    Tmsid_CountNonZero                                   := sum(group,if(dsc.Tmsid<>'',1,0));
    Rmsid_CountNonZero                                   := sum(group,if(dsc.Rmsid<>'',1,0));
    dt_first_seen_CountNonZero                           := sum(group,if(dsc.dt_first_seen<>0,1,0));
    dt_last_seen_CountNonZero                            := sum(group,if(dsc.dt_last_seen<>0,1,0));
    dt_vendor_first_reported_CountNonZero                := sum(group,if(dsc.dt_vendor_first_reported<>0,1,0));
    dt_vendor_last_reported_CountNonZero                 := sum(group,if(dsc.dt_vendor_last_reported<>0,1,0));
    CONTACT_TYPE_CountNonBlank                           := sum(group,if(dsc.CONTACT_TYPE<>'',1,0));
    CONTACT_NAME_CountNonBlank                           := sum(group,if(dsc.CONTACT_NAME<>'',1,0));
    CONTACT_STATUS_CountNonBlank                         := sum(group,if(dsc.CONTACT_STATUS<>'',1,0));
    CONTACT_PHONE_CountNonBlank                          := sum(group,if(dsc.CONTACT_PHONE<>'',1,0));
    CONTACT_NAME_FORMAT_CountNonBlank                    := sum(group,if(dsc.CONTACT_NAME_FORMAT<>'',1,0));
    CONTACT_ADDR_CountNonBlank                           := sum(group,if(dsc.CONTACT_ADDR<>'',1,0));
    CONTACT_CITY_CountNonBlank                           := sum(group,if(dsc.CONTACT_CITY<>'',1,0));
    CONTACT_STATE_CountNonBlank                          := sum(group,if(dsc.CONTACT_STATE<>'',1,0));
    CONTACT_ZIP_CountNonZero                             := sum(group,if(dsc.CONTACT_ZIP<>0,1,0));
    CONTACT_COUNTRY_CountNonBlank                        := sum(group,if(dsc.CONTACT_COUNTRY<>'',1,0));
    CONTACT_FEI_NUM_CountNonZero                         := sum(group,if(dsc.CONTACT_FEI_NUM<>0,1,0));
    CONTACT_CHARTER_NUM_CountNonBlank                    := sum(group,if(dsc.CONTACT_CHARTER_NUM<>'',1,0));
    SEQ_NO_CountNonZero                                  := sum(group,if(dsc.SEQ_NO<>0,1,0));
    WITHDRAWAL_DATE_CountNonZero                         := sum(group,if(dsc.WITHDRAWAL_DATE<>0,1,0));
    title_CountNonZero                                   := sum(group,if(dsc.title<>'',1,0));
    fname_CountNonZero                                   := sum(group,if(dsc.fname<>'',1,0));
    mname_CountNonZero                                   := sum(group,if(dsc.mname<>'',1,0));
    lname_CountNonZero                                   := sum(group,if(dsc.lname<>'',1,0));
    name_suffix_CountNonZero                             := sum(group,if(dsc.name_suffix<>'',1,0));
    name_score_CountNonZero                              := sum(group,if(dsc.name_score<>'',1,0));
    prim_range_CountNonBlank                             := sum(group,if(dsc.prim_range<>'',1,0));
    prim_name_CountNonBlank                              := sum(group,if(dsc.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                            := sum(group,if(dsc.addr_suffix<>'',1,0));
    postdir_CountNonBlank                                := sum(group,if(dsc.postdir<>'',1,0));
    unit_desig_CountNonBlank                             := sum(group,if(dsc.unit_desig<>'',1,0));
    sec_range_CountNonBlank                              := sum(group,if(dsc.sec_range<>'',1,0));
    v_city_name_CountNonBlank                            := sum(group,if(dsc.v_city_name<>'',1,0));
    addr_rec_type_CountNonBlank                          := sum(group,if(dsc.addr_rec_type<>'',1,0));
    fips_state_CountNonBlank                             := sum(group,if(dsc.fips_state<>'',1,0));
    fips_county_CountNonBlank                            := sum(group,if(dsc.fips_county<>'',1,0));
    geo_lat_CountNonBlank                                := sum(group,if(dsc.geo_lat<>'',1,0));
    geo_long_CountNonBlank                               := sum(group,if(dsc.geo_long<>'',1,0));
    geo_blk_CountNonBlank                                := sum(group,if(dsc.geo_blk<>'',1,0));
    geo_match_CountNonBlank                              := sum(group,if(dsc.geo_match<>'',1,0));
    err_stat_CountNonBlank                               := sum(group,if(dsc.err_stat<>'',1,0));    
    did_score_CountNonZero                               := sum(group,if(dsc.did_score<>0,1,0));
    bdid_CountNonZero                                    := sum(group,if(dsc.bdid<>0,1,0));
    bdid_score_CountNonZero                              := sum(group,if(dsc.bdid_score<>0,1,0));
  end;

 	dPopulationStats_DSB := table(DSB,rPopulationStats_FBNV2_business,StateGroup, sourceGroup,few);

	STRATA.createXMLStats(dPopulationStats_DSB
	                     ,'FBN  V2'
						 ,'BusinessFile'
						 ,pVersion
						 ,''
						 ,zBusinessStats
						 ,'view'
						 ,'PopulationV2');

//output Contact stats
	dPopulationStats_dContact := table(dSC,rPopulationStats_fbnv2_Contact,StateGroup, sourceGroup,few);
                                    
	STRATA.createXMLStats(dPopulationStats_dContact
	                     ,'FBN  V2'
						 ,'Contact'
						 ,pVersion
						 ,''
						 ,zContactStats
						 ,'view'
					 ,'PopulationV2');
					 
//output Contact DID stats	
	
	dDIDstats_dContact := table(dSC(lname <> ''),rDIDstats_dSC ,StateGroup, sourceGroup, few);				
	// dDIDstats_dContact := table(dSC,rDIDstats_dSC ,StateGroup, sourceGroup, few);
    
	STRATA.createXMLStats(dDIDstats_dContact
	                     ,'FBN  V2'
						 ,'Contact'
						 ,pVersion
						 ,''
						 ,zContactDIDStats
						 ,'view'
					     ,'DIDStats2');

zOut := parallel(zBusinessStats,zContactStats,zContactDIDStats);
return zout; 
end;