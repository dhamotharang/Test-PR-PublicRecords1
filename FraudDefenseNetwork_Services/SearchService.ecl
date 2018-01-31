/*--SOAP--
<message name="FraudDefenseNetwork_Service">
  <part name="FDNSearchRequest" type="tns:Xmldataset" cols="70" rows="10" />
  <part name="Request" type="tns:XmlDataSet" cols="200" rows="20" />
</message>
*/ 
IMPORT iesp, doxie, address, UT, FraudShared_Services;

EXPORT SearchService() := MACRO

  // Get XML input 
  rec_in := iesp.frauddefensenetwork.t_FDNSearchRequest;
  ds_input := DATASET([],rec_in) : STORED('FDNSearchRequest',FEW);  

  ds_in := ds_input[1];
  
  gc_id_in := ds_in.FDNUser.GlobalCompanyId;
  ind_type_in := ds_in.FDNUser.IndustryType;
  product_code_in := ds_in.FDNUser.ProductCode;

	//Checking that gc_id, industry type, and product code have some values - they are required.
	IF(gc_id_in = 0, FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FDN_GC_ID));
	IF(ind_type_in = 0, FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FDN_INDUSTRY_TYPE));
	IF(product_code_in = 0, FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FDN_PRODUCT_CODE));
  
  ds_excl_ind := ds_in.Options.ExcludedIndTypes;
  ds_rec_file := ds_in.Options.FileTypes;
  
  // delta_use     : 1=check delta, 0=do not chec delta, default: 0
  // delta_strict : 1=fail if delta query fails, 0=do not fail if delta query fails, default: 0
  DeltaUse := ds_in.Options.DeltaUse;
  DeltaStrict := ds_in.Options.DeltaStrict;
  
  FraudDefenseNetwork_Services.Layouts.batch_search_rec xform2(iesp.frauddefensenetwork.t_FDNSearchRequest L) := TRANSFORM
  
    FullAddrInput := IF(L.SearchBy.Address.StreetAddress1 <> '', TRUE, FALSE);
    Clean_Address := IF(FullAddrInput, Address.CleanAddress182(TRIM(L.SearchBy.Address.StreetAddress1) + ' ' +
                                       TRIM(L.SearchBy.Address.StreetAddress2), 
                                       L.SearchBy.Address.city + ' ' +
                                       L.SearchBy.Address.state + ' ' +
                                       L.SearchBy.Address.zip5),'');  
    FormattedAddress := Address.CleanAddressFieldsFips(Clean_Address).addressrecord;
                                       
                                       
    SELF.prim_range := IF(FullAddrInput, FormattedAddress.prim_range, L.SearchBy.Address.StreetNumber);
    SELF.predir := IF(FullAddrInput, FormattedAddress.predir, L.SearchBy.Address.StreetPreDirection);
    SELF.prim_name := IF(FullAddrInput, FormattedAddress.prim_name, L.SearchBy.Address.StreetName);
    SELF.addr_suffix := IF(FullAddrInput, FormattedAddress.addr_suffix, L.SearchBy.Address.StreetSuffix);
    SELF.postdir := IF(FullAddrInput, FormattedAddress.postdir, L.SearchBy.Address.StreetPostDirection);
    SELF.unit_desig := IF(FullAddrInput, FormattedAddress.unit_desig, L.SearchBy.Address.UnitDesignation);
    SELF.sec_range := IF(FullAddrInput, FormattedAddress.sec_range, L.SearchBy.Address.UnitNumber);
    SELF.v_city_name := L.SearchBy.Address.city;
    SELF.st := L.SearchBy.Address.state;
    SELF.zip5 := L.SearchBy.Address.zip5;
    SELF.seq := 0;
    SELF.zip4 := '';
    SELF.did := (UNSIGNED6)L.SearchBy.UniqueId;
    SELF.phone10 := L.SearchBy.Phone10;
    SELF.ssn := L.SearchBy.ssn;
    SELF.seleid := L.SearchBy.seleid;
    SELF.orgid := L.SearchBy.orgid;
    SELF.ultid := L.SearchBy.ultid;
    SELF.appendedproviderid := L.SearchBy.appendedproviderid;
    SELF.lnpid := L.SearchBy.lnpid;
    SELF.tin := L.SearchBy.tin;
    SELF.npi := L.SearchBy.npi;
    SELF.emailaddress := L.SearchBy.emailaddress;
    SELF.ipaddress := L.SearchBy.ipaddress;
    SELF.deviceid := L.SearchBy.deviceid;
    SELF.professionalid := L.SearchBy.professionalid;
    SELF.filterby_StartingReportedDate := L.FilterBy.StartingReportedDate; 
    SELF.filterby_EndingReportedDate := L.FilterBy.EndingReportedDate; 
    SELF.filterby_StartingEventDate := L.FilterBy.StartingEventDate; 
    SELF.filterby_EndingEventDate := L.FilterBy.EndingEventDate; 
    SELF.filterby_Disposition := L.FilterBy.Disposition; 
    SELF.filterby_Mitigated := L.FilterBy.Mitigated; 
    SELF.filterby_NameType := L.FilterBy.NameType; 
    SELF.filterby_State := L.FilterBy.State; 
    SELF.filterby_PhoneNumber := L.FilterBy.PhoneNumber; 
    SELF.filterby_InService := L.FilterBy.InService; 
    SELF.filterby_ProfessionType := L.FilterBy.ProfessionType; 
    SELF.filterby_LicensedPrState := L.FilterBy.LicensedPrState; 
    SELF.filterby_SourceTypeId := L.FilterBy.SourceTypeId; 
    SELF.filterby_PrimarySourceEntityId := L.FilterBy.PrimarySourceEntityId; 
    SELF.filterby_ExpectationOfVictimEntitiesId := L.FilterBy.ExpectationOfVictimEntitiesId; 
    SELF.filterby_IndustrySegment := L.FilterBy.IndustrySegment; 
    SELF.filterby_SuspectedDiscrepancyId := L.FilterBy.SuspectedDiscrepancyId; 
    SELF.filterby_ConfidenceThatActivityWasDeceitfulId := L.FilterBy.ConfidenceThatActivityWasDeceitfulId; 
    SELF.filterby_WorkflowStageCommittedId := L.FilterBy.WorkflowStageCommittedId; 
    SELF.filterby_WorkflowStageDetectedId := L.FilterBy.WorkflowStageDetectedId; 
    SELF.filterby_ChannelsId := L.FilterBy.ChannelsId; 
    SELF.filterby_CategoryOrFraudType := L.FilterBy.CategoryOrFraudType; 
    SELF.filterby_ThreatId := L.FilterBy.ThreatId; 
    SELF.filterby_AlertLevelId := L.FilterBy.AlertLevelId; 
    SELF.filterby_EntityTypeId := L.FilterBy.EntityTypeId; 
    SELF.filterby_EntitySubTypeId := L.FilterBy.EntitySubTypeId; 
    SELF.filterby_RoleId := L.FilterBy.RoleId; 
    SELF.filterby_EvidenceId := L.FilterBy.EvidenceId; 
    SELF.filterby_FileType := L.FilterBy.FileType; 
    SELF.filterby_Did := L.FilterBy.Did;
  END;  
  
  ds_seq := PROJECT(ds_input, xform2(LEFT));

  // Validate at least one search param is provided  (It's coded as a batch, why only the first record checked)
  IF (~FraudDefenseNetwork_Services.Functions.IsFirstRecordValid(ds_seq),
    FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FDN_NO_INPUT_PROVIDED));

  // #store some standard input parameters (generally, for search purpose)
  iesp.ECL2ESP.SetInputBaseRequest(ds_in);
  
  //Common Point for Service Call and Internal Call
  ds_res := FraudDefenseNetwork_Services.Search_Records(
    ds_seq, gc_id_in, ind_type_in, product_code_in, ds_excl_ind, ds_rec_file, DeltaUse, DeltaStrict);

  //Check Data Permission Mask to see if contributory data is allowed or
  // if the data is inquiry data (for which the DRM was already checked)
  ds_res_filter := ds_res(
    doxie.DataPermission.use_FDNContributoryData 
    OR classification_Permissible_use_access.file_type <> FraudShared_Services.Constants.FileTypeCodes.CONTRIBUTORY);

	Royalties := Royalty.RoyaltyFDNCoRR.GetOnlineRoyalties(ds_res_filter,true);
		
  results := FraudDefenseNetwork_Services.GetResults(ds_res_filter);
  
  // OUTPUT(ds_res_filter ,NAMED('ds_res_filter'));
  // OUTPUT(ds_seq ,NAMED('Flat_Request'));
  // OUTPUT(ds_res ,NAMED('Search_Records'));
	OUTPUT(Royalties, NAMED('RoyaltySet'));
  OUTPUT(results, NAMED('Results'));

  
ENDMACRO;