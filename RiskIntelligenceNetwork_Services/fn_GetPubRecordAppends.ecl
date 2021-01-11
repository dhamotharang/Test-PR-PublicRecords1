IMPORT Address, Advo_Services, AppendIpMetadata, Autokey_batch, BatchServices, CriminalRecords_BatchService, DriversV2, DriversV2_Services, dx_PhonesInfo,
  FraudShared_Services, Gateway, risk_indicators, RiskIntelligenceNetwork_Services, Std, ut;

EXPORT fn_GetPubRecordAppends(DATASET(FraudShared_Services.Layouts.BatchInExtended_rec) ds_in,
                              RiskIntelligenceNetwork_Services.IParam.Params params) := MODULE

 EXPORT GetCriminal() := FUNCTION
  // As per GRP-247 only following offense Categories needs to be returned.
  crim_batch_params := MODULE(CriminalRecords_BatchService.IParam.batch_params)
    EXPORT BOOLEAN IncludeBadChecks := TRUE;
    EXPORT BOOLEAN IncludeBribery := TRUE;
    EXPORT BOOLEAN IncludeBurglaryComm := TRUE;
    EXPORT BOOLEAN IncludeBurglaryRes := TRUE;
    EXPORT BOOLEAN IncludeBurglaryVeh := TRUE;
    EXPORT BOOLEAN IncludeComputer := TRUE;
    EXPORT BOOLEAN IncludeCounterfeit := TRUE;
    EXPORT BOOLEAN IncludeFraud := TRUE;
    EXPORT BOOLEAN IncludeIdTheft := TRUE;
    EXPORT BOOLEAN IncludeMVTheft := TRUE;
    EXPORT BOOLEAN IncludeRobberyComm := TRUE;
    EXPORT BOOLEAN IncludeRobberyRes := TRUE;
    EXPORT BOOLEAN IncludeShoplift := TRUE;
    EXPORT BOOLEAN IncludeStolenProp := TRUE;
    EXPORT BOOLEAN IncludeTheft := TRUE;
    EXPORT BOOLEAN IncludeAtLeast1Offense := TRUE; //This is internal option for Crim Batch Record which needs to be set true if any of the offense categories are TRUE...
  END;

  ds_crim_in := PROJECT(ds_in, TRANSFORM(CriminalRecords_BatchService.Layouts.batch_in, SELF := LEFT, SELF := []));
  ds_criminal := CriminalRecords_BatchService.BatchRecords(crim_batch_params, ds_crim_in);

  RETURN ds_criminal.Records;
 END;

 EXPORT GetAdvo := FUNCTION
  ds_advo_in := PROJECT(ds_in,
                  TRANSFORM(Advo_Services.Advo_Batch_Service_Layouts.Batch_In,
                   SELF.acctno := LEFT.acctno,
                   SELF.addr   := LEFT.addr,
                   SELF.city   := LEFT.p_city_name,
                   SELF.state  := LEFT.st,
                   SELF.zip    := LEFT.z5
                ));
  ds_advo := Advo_Services.Advo_Batch_Service_Records(ds_advo_in, true, true);
  return ds_advo;
 END;

 EXPORT GetPrepaidPhone := FUNCTION
  ds_prepaidphone := JOIN(ds_in, dx_PhonesInfo.Key_Phones_Type,
                      KEYED(LEFT.phoneno = RIGHT.phone) AND
                      RIGHT.prepaid = RiskIntelligenceNetwork_Services.Constants.PREPAID_VALUE,
                      TRANSFORM(RiskIntelligenceNetwork_Services.Layouts.prepaid_phone_layout,
                        SELF.acctno := LEFT.acctno,
                        SELF := RIGHT),
                     LIMIT(RiskIntelligenceNetwork_Services.Constants.MAX_JOIN_LIMIT));
  return ds_prepaidphone;
 END;

 EXPORT GetDL := FUNCTION
  dl_params := MODULE(DriversV2_Services.GetDLParams.batch_params)
    EXPORT useAllLookups := TRUE;
    EXPORT skip_set := DriversV2.Constants.autokey_skipSet;
    EXPORT RunDeepDive := FALSE;
    EXPORT boolean return_current_only := TRUE;
  END;

  ds_dl_in := PROJECT(ds_in,
               TRANSFORM(Autokey_batch.Layouts.rec_inBatchMaster,
                SELF.homephone := LEFT.phoneno,
                SELF := LEFT,
                SELF := []));
  ds_dl_pre := DriversV2_Services.Batch_Service_Records(ds_dl_in, dl_params);
  ds_dl := PROJECT(ds_dl_pre, RiskIntelligenceNetwork_Services.Layouts.dl_layout);
  return ds_dl;
 END;

 EXPORT GetBocaShell := FUNCTION

  risk_indicators.Layout_Input tFormat2IIDIn(FraudShared_Services.Layouts.BatchInExtended_rec L)	:= TRANSFORM
   self.score := if(L.did != 0,100,0);
   self.in_StreetAddress :=	L.addr;
   self.in_city := L.p_city_name;
   self.in_state :=	L.st;
   self.in_zipcode :=	L.z5;
   self.ssn := if((integer)L.ssn = 0,'',L.ssn);	// blank out social if it is all 0's
   self.z5 :=	L.z5;
   self.phone10 :=	L.phoneno;
   self.age :=	(STRING3)ut.Age((integer)L.dob);
   self.historydate :=	999999;
   self :=	L;
   self :=	[];
  end;

  dFormat2IIDIn	:= PROJECT(ds_in, tFormat2IIDIn(left));

  // InstantID & Boca shell constants
  dGateways :=	Gateway.Constants.void_gateway;
  boolean isUtility :=	false;
  boolean isLn :=	false;
  boolean ofac_only :=	true;
  boolean suppressNearDups :=	false;
  boolean require2Ele :=	false;
  boolean doRelatives :=	true;
  boolean doDL :=	false;
  boolean doVehicle :=	false;
  boolean doDerogs :=	true;
  boolean doScore :=	false;
  boolean nugen :=	true;
  boolean isFCRA := false;
  boolean from_biid :=	false;
  boolean excludewatchlists := false;
  boolean from_IT1O := false;
  unsigned1	OFACVersion := 1;
  boolean IncludeOfac := false;
  boolean addtl_watchlists := false;
  real gwThreshold := 0.84;
  integer2 dobradius :=	-1;
  boolean IncludeDLverification	:= true;
  unsigned bsVersion := 55;

  // InstantID function
  dIID := risk_indicators.InstantID_Function(dFormat2IIDIn,
                                             dGateways,
                                             params.dppa,
                                             params.glb,
                                             isUtility,
                                             isLn,
                                             ofac_only,
                                             suppressNearDups,
                                             require2Ele,
                                             from_biid,
                                             isFCRA,
                                             excludewatchlists,
                                             from_IT1O,
                                             OFACVersion,
                                             IncludeOfac,
                                             addtl_watchlists,
                                             gwThreshold,
                                             dobradius,
                                             BSversion,
                                             in_runDLverification := IncludeDLverification,
                                             in_DataRestriction := params.DataRestrictionMask,
                                             in_DataPermission := params.DataPermissionMask);

  // BocaShell function
  dBocaShell :=	Risk_Indicators.Boca_Shell_Function(dIID,
                                                    dGateways,
                                                    params.dppa,
                                                    params.glb,
                                                    isUtility,
                                                    isLn,
                                                    doRelatives,
                                                    doDL,
                                                    doVehicle,
                                                    doDerogs,
                                                    bsVersion,
                                                    doScore,
                                                    nugen,
                                                    DataRestriction	:= params.DataRestrictionMask,
                                                    DataPermission := params.DataPermissionMask);
  return ungroup(dBocaShell);
 END;

 EXPORT GetIPMetaData := Function
  slim_ip_rec := RECORD
    string20 acctno;
    string25 ip_address;
  END;
  
  slim_ip_in := PROJECT(ds_in, TRANSFORM(slim_ip_rec, SELF := LEFT));
  raw_ipmetadata := AppendIpMetadata.macAppendIPMetadata(slim_ip_in,ip_address); 
  ds_IPMetaData := PROJECT(raw_ipmetadata, TRANSFORM(BatchServices.IP_Metadata_Layouts.batch_out, 
                                              SELF.acctno := LEFT.acctno,
                                              SELF.ip_address := LEFT.ip_address,
                                              SELF.ip_rng_beg := LEFT.iprngbeg,
                                              SELF.ip_rng_end := LEFT.iprngend,
                                              SELF.edge_country := LEFT.edgecountry,
                                              SELF.edge_region := LEFT.edgeregion,
                                              SELF.edge_city := LEFT.edgecity,
                                              SELF.edge_conn_speed := LEFT.edgeconnspeed,
                                              SELF.edge_metro_code := LEFT.edgemetrocode,
                                              SELF.edge_latitude := LEFT.edgelatitude,
                                              SELF.edge_longitude := LEFT.edgelongitude,
                                              SELF.edge_postal_code := LEFT.edgepostalcode,
                                              SELF.edge_country_code := LEFT.edgecountrycode,
                                              SELF.edge_region_code := LEFT.edgeregioncode,
                                              SELF.edge_city_code := LEFT.edgecitycode,
                                              SELF.edge_continent_code := LEFT.edgecontinentcode,
                                              SELF.edge_two_letter_country := LEFT.edgetwolettercountry,
                                              SELF.edge_internal_code := LEFT.edgeinternalcode,
                                              SELF.edge_area_codes := LEFT.edgeareacodes,
                                              SELF.edge_country_conf := LEFT.edgecountryconf,
                                              SELF.edge_region_conf := LEFT.edgeregionconf,
                                              SELF.edge_city_conf := LEFT.edgecitycong,
                                              SELF.edge_postal_conf := LEFT.edgepostalconf,
                                              SELF.edge_gmt_offset := LEFT.edgegmtoffset,
                                              SELF.edge_in_dst := LEFT.edgeindst,
                                              SELF.sic_code := LEFT.siccode,
                                              SELF.domain_name := LEFT.domainname,
                                              SELF.isp_name := LEFT.ispname,
                                              SELF.homebiz_type := LEFT.homebiztype,
                                              SELF.asn := LEFT.asn,
                                              SELF.asn_name := LEFT.asnname,
                                              SELF.primary_lang := LEFT.primarylang,
                                              SELF.secondary_lang := LEFT.secondarylang,
                                              SELF.proxy_type := LEFT.proxytype,
                                              SELF.proxy_description := LEFT.proxydescription,
                                              SELF.is_an_isp := LEFT.isanisp,
                                              SELF.company_name := LEFT.companyname,
                                              SELF.ranks := LEFT.ranks,
                                              SELF.households := LEFT.households,
                                              SELF.women := LEFT.women,
                                              SELF.w18_34 := LEFT.women18to34,
                                              SELF.w35_49 := LEFT.women35to49,
                                              SELF.men := LEFT.men,
                                              SELF.m18_34 := LEFT.men18to34,
                                              SELF.m35_49 := LEFT.men35to49,
                                              SELF.teens := LEFT.teens,
                                              SELF.kids := LEFT.kids,
                                              SELF.naics_code := LEFT.naicscode,
                                              SELF.cbsa_code := LEFT.cbsacode,
                                              SELF.cbsa_title := LEFT.cbsatitle,
                                              SELF.cbsa_type := LEFT.cbsatype,
                                              SELF.csa_code := LEFT.csacode,
                                              SELF.csa_title := LEFT.csatitle,
                                              SELF.md_code := LEFT.mdcode,
                                              SELF.md_title := LEFT.mdtitle,
                                              SELF.organization_name := LEFT.organizationname,
                                              SELF.orig_acctno := LEFT.acctno));
  
  return ds_IPMetaData;
 END;

END;