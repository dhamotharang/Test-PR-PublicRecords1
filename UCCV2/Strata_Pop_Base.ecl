import STRATA,uccv2;

export Strata_Pop_Base(string pVersion) := function

dMainin:=File_ucc_Main_Base;
dPartyin:=UCCV2.File_UCC_Party_Base_AID;


layoutState:=record
dMainin.tmsid;
dMainin.rmsid;
dMainin.Filing_Jurisdiction;
end;

dLookup:=dedup(table(dmainin,layoutState),all);

LayoutDparty :=record
recordof(dPartyin);
String11 sourceGroup;
string11 StateGroup;
end;
LayoutDMain :=record
recordof(dMainin);
String11 sourceGroup;
string11 StateGroup;
end;

LayoutDparty Transf(dPartyin pleft, dlookup pright):=Transform
self.StateGroup :=MAP(pright.Filing_Jurisdiction ='TXD' =>'TX-Dallas',
	                  pright.Filing_Jurisdiction='TXH' =>'TX-Harrise',
					  pright.Filing_Jurisdiction);
self.sourceGroup:=MAP(pleft.tmsid[1..3]='TXD' =>'TX-Dallas',
	                  pleft.tmsid[1..3]='TXH' =>'TX-Harrise',
					  pleft.tmsid[1..3]='DNB' =>'DNB', pleft.tmsid[1..2]);
self                    :=pleft;
end;

LayoutDmain TransfM(dmainin pInput):=Transform

self.StateGroup :=MAP(pInput.Filing_Jurisdiction ='TXD' =>'TX-Dallas',
	                  pInput.Filing_Jurisdiction='TXH' =>'TX-Harrise',
					  pInput.Filing_Jurisdiction);
self.sourceGroup:=MAP(pInput.tmsid[1..3]='TXD' =>'TX-Dallas',
	                  pInput.tmsid[1..3]='TXH' =>'TX-Harrise',
					  pInput.tmsid[1..3]='DNB' =>'DNB', pinput.tmsid[1..2]);
self            :=pInput;
end;
dMain :=project(dMainin,transfm(left));
dparty:=join(dPartyin,dLookup,left.tmsid=right.tmsid and left.rmsid=right.rmsid, transf(left,right));

rPopulationStats_dMain
 :=
  record
    integer countGroup := count(group);
	dMAIN.StateGroup  ;
    dMain.SourceGroup;                                                         
	tmsid_CountNonBlank                                  := sum(group,if(dMain.tmsid<>'',1,0));
    rmsid_CountNonBlank                                  := sum(group,if(dMain.rmsid<>'',1,0));
    process_date_CountNonBlank                           := sum(group,if(dMain.process_date<>'',1,0));
    static_value_CountNonBlank                           := sum(group,if(dMain.static_value<>'',1,0));
    date_vendor_removed_CountNonBlank                    := sum(group,if(dMain.date_vendor_removed<>'',1,0));
    date_vendor_changed_CountNonBlank                    := sum(group,if(dMain.date_vendor_changed<>'',1,0));
    Filing_Jurisdiction_CountNonBlank                    := sum(group,if(dMain.Filing_Jurisdiction<>'',1,0));
    orig_filing_number_CountNonBlank                     := sum(group,if(dMain.orig_filing_number<>'',1,0));
    orig_filing_type_CountNonBlank                       := sum(group,if(dMain.orig_filing_type<>'',1,0));
    orig_filing_date_CountNonBlank                       := sum(group,if(dMain.orig_filing_date<>'',1,0));
    orig_filing_time_CountNonBlank                       := sum(group,if(dMain.orig_filing_time<>'',1,0));
    filing_number_CountNonBlank                          := sum(group,if(dMain.filing_number<>'',1,0));
    filing_number_indc_CountNonBlank                     := sum(group,if(dMain.filing_number_indc<>'',1,0));
    filing_type_CountNonBlank                            := sum(group,if(dMain.filing_type<>'',1,0));
    filing_date_CountNonBlank                            := sum(group,if(dMain.filing_date<>'',1,0));
    filing_time_CountNonBlank                            := sum(group,if(dMain.filing_time<>'',1,0));
    filing_status_CountNonBlank                          := sum(group,if(dMain.filing_status<>'',1,0));
    Status_type_CountNonBlank                            := sum(group,if(dMain.Status_type<>'',1,0));
    page_CountNonBlank                                   := sum(group,if(dMain.page<>'',1,0));
    expiration_date_CountNonBlank                        := sum(group,if(dMain.expiration_date<>'',1,0));
    contract_type_CountNonBlank                          := sum(group,if(dMain.contract_type<>'',1,0));
    vendor_entry_date_CountNonBlank                      := sum(group,if(dMain.vendor_entry_date<>'',1,0));
    vendor_upd_date_CountNonBlank                        := sum(group,if(dMain.vendor_upd_date<>'',1,0));
    statements_filed_CountNonBlank                       := sum(group,if(dMain.statements_filed<>'',1,0));
    continuious_expiration_CountNonBlank                 := sum(group,if(dMain.continuious_expiration<>'',1,0));
    microfilm_number_CountNonBlank                       := sum(group,if(dMain.microfilm_number<>'',1,0));
    amount_CountNonBlank                                 := sum(group,if(dMain.amount<>'',1,0));
    irs_serial_number_CountNonBlank                      := sum(group,if(dMain.irs_serial_number<>'',1,0));
    effective_date_CountNonBlank                         := sum(group,if(dMain.effective_date<>'',1,0));
    Signer_Name_CountNonBlank                            := sum(group,if(dMain.Signer_Name<>'',1,0));
    title_CountNonBlank                                  := sum(group,if(dMain.title<>'',1,0));
    filing_agency_CountNonBlank                          := sum(group,if(dMain.filing_agency<>'',1,0));
    address_CountNonBlank                                := sum(group,if(dMain.address<>'',1,0));
    city_CountNonBlank                                   := sum(group,if(dMain.city<>'',1,0));
    state_CountNonBlank                                  := sum(group,if(dMain.state<>'',1,0));
    county_CountNonBlank                                 := sum(group,if(dMain.county<>'',1,0));
    zip_CountNonBlank                                    := sum(group,if(dMain.zip<>'',1,0));
    duns_number_CountNonBlank                            := sum(group,if(dMain.duns_number<>'',1,0));
    cmnt_effective_date_CountNonBlank                    := sum(group,if(dMain.cmnt_effective_date<>'',1,0));
    description_CountNonBlank                            := sum(group,if(dMain.description<>'',1,0));
    collateral_desc_CountNonBlank                        := sum(group,if(dMain.collateral_desc<>'',1,0));
    prim_machine_CountNonBlank                           := sum(group,if(dMain.prim_machine<>'',1,0));
    sec_machine_CountNonBlank                            := sum(group,if(dMain.sec_machine<>'',1,0));
    manufacturer_code_CountNonBlank                      := sum(group,if(dMain.manufacturer_code<>'',1,0));
    manufacturer_name_CountNonBlank                      := sum(group,if(dMain.manufacturer_name<>'',1,0));
    model_CountNonBlank                                  := sum(group,if(dMain.model<>'',1,0));
    model_year_CountNonBlank                             := sum(group,if(dMain.model_year<>'',1,0));
    model_desc_CountNonBlank                             := sum(group,if(dMain.model_desc<>'',1,0));
    collateral_count_CountNonBlank                       := sum(group,if(dMain.collateral_count<>'',1,0));
    manufactured_year_CountNonBlank                      := sum(group,if(dMain.manufactured_year<>'',1,0));
    new_used_CountNonBlank                               := sum(group,if(dMain.new_used<>'',1,0));
    serial_number_CountNonBlank                          := sum(group,if(dMain.serial_number<>'',1,0));
    Property_desc_CountNonBlank                          := sum(group,if(dMain.Property_desc<>'',1,0));
    borough_CountNonBlank                                := sum(group,if(dMain.borough<>'',1,0));
    block_CountNonBlank                                  := sum(group,if(dMain.block<>'',1,0));
    lot_CountNonBlank                                    := sum(group,if(dMain.lot<>'',1,0));
    collateral_address_CountNonBlank                     := sum(group,if(dMain.collateral_address<>'',1,0));
    air_rights_indc_CountNonBlank                        := sum(group,if(dMain.air_rights_indc<>'',1,0));
    subterranean_rights_indc_CountNonBlank               := sum(group,if(dMain.subterranean_rights_indc<>'',1,0));
    easment_indc_CountNonBlank                           := sum(group,if(dMain.easment_indc<>'',1,0));
  end;

rPopulationStats_dParty
 :=
  record
    integer countGroup := count(group);
	dParty.StateGroup  ;
    dParty.SourceGroup;                                   
    tmsid_CountNonBlank                                  := sum(group,if(dParty.tmsid<>'',1,0));
    rmsid_CountNonBlank                                  := sum(group,if(dParty.rmsid<>'',1,0));
    Orig_name_CountNonBlank                              := sum(group,if(dParty.Orig_name<>'',1,0));
    Orig_lname_CountNonBlank                             := sum(group,if(dParty.Orig_lname<>'',1,0));
    Orig_fname_CountNonBlank                             := sum(group,if(dParty.Orig_fname<>'',1,0));
    Orig_mname_CountNonBlank                             := sum(group,if(dParty.Orig_mname<>'',1,0));
    Orig_suffix_CountNonBlank                            := sum(group,if(dParty.Orig_suffix<>'',1,0));
    duns_number_CountNonBlank                            := sum(group,if(dParty.duns_number<>'',1,0));
    hq_duns_number_CountNonBlank                         := sum(group,if(dParty.hq_duns_number<>'',1,0));
    ssn_CountNonBlank                                    := sum(group,if(dParty.ssn<>'',1,0));
    fein_CountNonBlank                                   := sum(group,if(dParty.fein<>'',1,0));
    Incorp_state_CountNonBlank                           := sum(group,if(dParty.Incorp_state<>'',1,0));
    corp_number_CountNonBlank                            := sum(group,if(dParty.corp_number<>'',1,0));
    corp_type_CountNonBlank                              := sum(group,if(dParty.corp_type<>'',1,0));
    Orig_address1_CountNonBlank                          := sum(group,if(dParty.Orig_address1<>'',1,0));
    Orig_address2_CountNonBlank                          := sum(group,if(dParty.Orig_address2<>'',1,0));
    Orig_city_CountNonBlank                              := sum(group,if(dParty.Orig_city<>'',1,0));
    Orig_state_CountNonBlank                             := sum(group,if(dParty.Orig_state<>'',1,0));
    Orig_zip5_CountNonBlank                              := sum(group,if(dParty.Orig_zip5<>'',1,0));
    Orig_zip4_CountNonBlank                              := sum(group,if(dParty.Orig_zip4<>'',1,0));
    Orig_country_CountNonBlank                           := sum(group,if(dParty.Orig_country<>'',1,0));
    Orig_province_CountNonBlank                          := sum(group,if(dParty.Orig_province<>'',1,0));
    Orig_postal_code_CountNonBlank                       := sum(group,if(dParty.Orig_postal_code<>'',1,0));
    foreign_indc_CountNonBlank                           := sum(group,if(dParty.foreign_indc<>'',1,0));
    Party_type_CountNonBlank                             := sum(group,if(dParty.Party_type<>'',1,0));
    dt_first_seen_CountNonZero                           := sum(group,if(dParty.dt_first_seen<>0,1,0));
    dt_last_seen_CountNonZero                            := sum(group,if(dParty.dt_last_seen<>0,1,0));
    dt_vendor_last_reported_CountNonZero                 := sum(group,if(dParty.dt_vendor_last_reported<>0,1,0));
    dt_vendor_first_reported_CountNonZero                := sum(group,if(dParty.dt_vendor_first_reported<>0,1,0));
    process_date_CountNonBlank                           := sum(group,if(dParty.process_date<>'',1,0));
    title_CountNonBlank                                  := sum(group,if(dParty.title<>'',1,0));
    fname_CountNonBlank                                  := sum(group,if(dParty.fname<>'',1,0));
    mname_CountNonBlank                                  := sum(group,if(dParty.mname<>'',1,0));
    lname_CountNonBlank                                  := sum(group,if(dParty.lname<>'',1,0));
    name_suffix_CountNonBlank                            := sum(group,if(dParty.name_suffix<>'',1,0));
    name_score_CountNonBlank                             := sum(group,if(dParty.name_score<>'',1,0));
    company_name_CountNonBlank                           := sum(group,if(dParty.company_name<>'',1,0));
    prim_range_CountNonBlank                             := sum(group,if(dParty.prim_range<>'',1,0));
    predir_CountNonBlank                                 := sum(group,if(dParty.predir<>'',1,0));
    prim_name_CountNonBlank                              := sum(group,if(dParty.prim_name<>'',1,0));
    suffix_CountNonBlank                                 := sum(group,if(dParty.suffix<>'',1,0));
    postdir_CountNonBlank                                := sum(group,if(dParty.postdir<>'',1,0));
    unit_desig_CountNonBlank                             := sum(group,if(dParty.unit_desig<>'',1,0));
    sec_range_CountNonBlank                              := sum(group,if(dParty.sec_range<>'',1,0));
    p_city_name_CountNonBlank                            := sum(group,if(dParty.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                            := sum(group,if(dParty.v_city_name<>'',1,0));
    st_CountNonBlank                                     := sum(group,if(dParty.st<>'',1,0));
    zip5_CountNonBlank                                   := sum(group,if(dParty.zip5<>'',1,0));
    zip4_CountNonBlank                                   := sum(group,if(dParty.zip4<>'',1,0));
    county_CountNonBlank                                 := sum(group,if(dParty.county<>'',1,0));
    cart_CountNonBlank                                   := sum(group,if(dParty.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                             := sum(group,if(dParty.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                    := sum(group,if(dParty.lot<>'',1,0));
    lot_order_CountNonBlank                              := sum(group,if(dParty.lot_order<>'',1,0));
    dpbc_CountNonBlank                                   := sum(group,if(dParty.dpbc<>'',1,0));
    chk_digit_CountNonBlank                              := sum(group,if(dParty.chk_digit<>'',1,0));
    rec_type_CountNonBlank                               := sum(group,if(dParty.rec_type<>'',1,0));
    ace_fips_st_CountNonBlank                            := sum(group,if(dParty.ace_fips_st<>'',1,0));
    ace_fips_county_CountNonBlank                        := sum(group,if(dParty.ace_fips_county<>'',1,0));
    geo_lat_CountNonBlank                                := sum(group,if(dParty.geo_lat<>'',1,0));
    geo_long_CountNonBlank                               := sum(group,if(dParty.geo_long<>'',1,0));
    msa_CountNonBlank                                    := sum(group,if(dParty.msa<>'',1,0));
    geo_blk_CountNonBlank                                := sum(group,if(dParty.geo_blk<>'',1,0));
    geo_match_CountNonBlank                              := sum(group,if(dParty.geo_match<>'',1,0));
    err_stat_CountNonBlank                               := sum(group,if(dParty.err_stat<>'',1,0));
    bdid_CountNonZero                                    := sum(group,if(dParty.bdid<>0,1,0));
    did_CountNonZero                                     := sum(group,if(dParty.did<>0,1,0));
    did_score_CountNonZero                               := sum(group,if(dParty.did_score<>0,1,0));
    bdid_score_CountNonZero                              := sum(group,if(dParty.bdid_score<>0,1,0));
		  //BIPV2 fields have been added for Strata
	  source_rec_id_CountNonZeros	   											 := sum(group,if(dParty.source_rec_id<>0,1,0));
		DotID_CountNonZeros	 																 := sum(group,if(dParty.DotID<>0,1,0));
		DotScore_CountNonZeros	   													 := sum(group,if(dParty.DotScore<>0,1,0));
		DotWeight_CountNonZeros	 														 := sum(group,if(dParty.DotWeight<>0,1,0));
		EmpID_CountNonZeros	   															 := sum(group,if(dParty.EmpID<>0,1,0));
 		EmpScore_CountNonZeros	 														 := sum(group,if(dParty.EmpScore<>0,1,0));
		EmpWeight_CountNonZeros	 									           := sum(group,if(dParty.EmpWeight<>0,1,0));
		POWID_CountNonZeros	                                 := sum(group,if(dParty.POWID<>0,1,0));
		POWScore_CountNonZeros	                             := sum(group,if(dParty.POWScore<>0,1,0));
		POWWeight_CountNonZeros	                             := sum(group,if(dParty.POWWeight<>0,1,0));
		ProxID_CountNonZeros	                               := sum(group,if(dParty.ProxID<>0,1,0));
		ProxScore_CountNonZeros	                             := sum(group,if(dParty.ProxScore<>0,1,0));
		ProxWeight_CountNonZeros	                           := sum(group,if(dParty.ProxWeight<>0,1,0));
		SELEID_CountNonZeros	                        			 := sum(group,if(dParty.SELEID<>0,1,0));
		SELEScore_CountNonZeros	                      			 := sum(group,if(dParty.SELEScore<>0,1,0));
		SELEWeight_CountNonZeros	                    			 := sum(group,if(dParty.SELEWeight<>0,1,0));
		OrgID_CountNonZeros	                                 := sum(group,if(dParty.OrgID<>0,1,0));
		OrgScore_CountNonZeros	                             := sum(group,if(dParty.OrgScore<>0,1,0));
		OrgWeight_CountNonZeros	                             := sum(group,if(dParty.OrgWeight<>0,1,0));
		UltID_CountNonZeros	                                 := sum(group,if(dParty.UltID<>0,1,0));
		UltScore_CountNonZeros	                             := sum(group,if(dParty.UltScore<>0,1,0));
		UltWeight_CountNonZeros	                             := sum(group,if(dParty.UltWeight<>0,1,0));
  end;



rDIDstats_dParty := record
  integer countGroup := count(group);
  dparty.sourceGroup;
  dparty.StateGroup;
  Has_DID 	 := sum(group,IF((unsigned6)dParty(lname <> '').did <> 0,1,0))/sum(group,IF(dParty.lname <> '',1,0)) * 100;
  has_bdid   := sum(group,IF((unsigned6)dParty(company_name <> '').bdid <> 0,1,0))/sum(group,IF(dParty.company_name <> '',1,0)) * 100;
end;

//output main stats
	dPopulationStats_dMain := table(dMain, rPopulationStats_dMain, StateGroup, sourceGroup,few);

	STRATA.createXMLStats(dPopulationStats_dMain
	                     ,'UCC  V2'
						 ,'Main'
						 ,pVersion
						 ,''
						 ,zMainStats
						 ,'view'
						 ,'PopulationV2');

//output party stats
	dPopulationStats_dParty := table(dParty,rPopulationStats_dParty,StateGroup, sourceGroup, few);
	
	STRATA.createXMLStats(dPopulationStats_dParty
	                     ,'UCC  V2'
						 ,'Party_Base'
						 ,pVersion
						 ,''
						 ,zPartyStats
						 ,'view'
					 ,'PopulationV2');
					 
//output party DID stats	
				 
	dDIDstats_dParty := table(dParty,rDIDstats_dParty,StateGroup, sourceGroup,few);
    
	STRATA.createXMLStats(dDIDstats_dParty
	                     ,'UCC  V2'
						 ,'Party'
						 ,pVersion
						 ,''
						 ,zPartyDIDStats
						 ,'view'
					     ,'DIDStats');

zOut := parallel(zMainStats,/*zPartyStats,*/zPartyDIDStats);
return zout; 
end;