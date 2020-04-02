/*--SOAP--
<message name="AML Attributes" wuTimeout="300000">
  <part name="AntiMoneyLaunderingRiskAttributesRequest" type="tns:XmlDataSet" cols="80" rows="50"/>
  <part name="HistoryDateYYYYMM" type="xsd:integer"/>
  <part name="gateways" type="tns:XmlDataSet" cols="110" rows="4"/>
  <part name="DataPermissionMask" type="xsd:string"/>
   </message>
*/

IMPORT iesp, AML, AutoStandardI, Gateway;

EXPORT AML_Service := MACRO

//The following macro defines the field sequence on WsECL page of query.
  WSInput.MAC_AML_Service();

  // Get XML input
  ds_in           := dataset([], iesp.amlrattributes.t_AntiMoneyLaunderingRiskAttributesRequest)    : stored('AntiMoneyLaunderingRiskAttributesRequest', few);
  gateways        := Gateway.Configuration.Get();

  optionsIn       := GLOBAL(ds_in[1].options);
  userIn          := ds_in[1].user;

/* **********************************************
   *  Fields needed for improved Scout Logging  *
   **********************************************/
  string32 _LoginID               := ''  : STORED('_LoginID');
  outofbandCompanyID              := '' : STORED('_CompanyID');
  string20 CompanyID              := if(userIn.CompanyId != '', userIn.CompanyId, outofbandCompanyID);
  string20 FunctionName           := '' : STORED('_LogFunctionName');
  string50 ESPMethod              := '' : STORED('_ESPMethodName');
  string10 InterfaceVersion       := '' : STORED('_ESPClientInterfaceVersion');
  string5 DeliveryMethod          := '' : STORED('_DeliveryMethod');
  string5 DeathMasterPurpose      := '' : STORED('__deathmasterpurpose');
  BOOLEAN DisableOutcomeTracking  := False : STORED('OutcomeTrackingOptOut');
  BOOLEAN ArchiveOptIn            := False : STORED('instantidarchivingoptin');

  //Look up the industry by the company ID.
  Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.AML__AML_Service);
/* ************* End Scout Fields **************/


  string6 outOfBandHistoryDate := '' : STORED('HistoryDateYYYYMM');
  integer3 history_date    :=  MAP(  (integer3)(optionsIn.historyDateYYYYMM) <> 0  => (Integer3)optionsIn.historyDateYYYYMM,
                                            TRIM(outOfBandHistoryDate)  <> ''  => (integer3)outOfBandHistoryDate,
                                            999999);

  BOOLEAN IncludeNewsProfile := ~optionsIn.ExcludeNewsAttributes;

  // '0' - do not call XG5
  // '1' - full XG5 response will be returned for AML report
  // '2' - Call Bridger XG5 for KRIs but not full response

  // Always call Bridger XG5 for KRIs but not full response
  UseXG5 := '2';


  TestDataEnabled         := userIn.TestDataEnabled;
  TestDataTableName       := Trim(userIn.TestDataTableName);

  attribsVersionUC := STD.Str.ToUpperCase(optionsIn.AttributesVersionRequest);

  attributesVersion := Map(
                            attribsVersionUC= 'AMLRBUSATTRV1' => 'BUS',
                            attribsVersionUC= 'AMLRBUSATTRV2' => 'BUSV2',
                            attribsVersionUC= 'AMLRINDVATTRV1' => 'IND',
                            attribsVersionUC= 'AMLRINDVATTRV2' => 'INDV2',
                          'INVALID');

  IncludeNegativeNews := FALSE; // should never be called


  STRING50 outOfBandDataPermissionMask 	:= '' : STORED('DataPermissionMask');


  mod_pre := AML.IParam.GetAmlInputModule();
  mod_aml := MODULE(PROJECT(mod_pre, AML.IParam.IAml))
    EXPORT unsigned1 dppa := (unsigned1)userIn.DLPurpose;
    EXPORT unsigned1 glb := (unsigned1)userIn.GLBPurpose;
    EXPORT string DataRestrictionMask := IF(TRIM(userIn.DataRestrictionMask) <> '', userIn.DataRestrictionMask, mod_pre.DataRestrictionMask);
    EXPORT string DataPermissionMask := IF(TRIM(userIn.DataPermissionMask) <> '', userIn.DataPermissionMask, mod_pre.DataPermissionMask);
    EXPORT boolean suppress_dmv := userIn.ExcludeDMVPII;
    EXPORT string ssn_mask := IF(userIn.SSNMask != '', userIn.SSNMask, mod_pre.ssn_mask);
    EXPORT unsigned1 dob_mask := IF(userIn.DOBMask != '', suppress.date_mask_math.MaskIndicator (userIn.DOBMask), mod_pre.dob_mask);
    EXPORT unsigned1 dl_mask := IF(userIn.DLMask, 1, 0);

    EXPORT unsigned1 bs_version := MAP(attributesVersion = 'IND' => 41,
                                       attributesVersion =  'INDV2' => 50,
                                       50);
  END;


  requestIn := ds_in;
  firstRow := requestIn[1] : INDEPENDENT; // Since this is realtime and not batch, should only have one row on input.
  search := GLOBAL(firstRow.SearchBy);

  boolean IndFNameCheck     := TRIM(search.Individual.name.full) <>'' or (TRIM(search.Individual.name.first) <> '');
  boolean IndFAddrCheck     := TRIM(search.Individual.address.streetaddress1)<>'' or (TRIM(search.Individual.address.streetnumber) <> '' or TRIM(search.Individual.address.streetname) <>'');
  boolean IndFLastCheck     := TRIM(search.Individual.name.full)<>''  or TRIM(search.Individual.name.last)<>'';
  boolean IndZipCheck       := TRIM(search.Individual.address.zip5) <>'';
  boolean IndSSNCheck       := TRIM(search.Individual.ssn)<>'';
  boolean BusTaxIDCheck     := TRIM(search.Business.FEIN)<>'';
  boolean BusAddrCheck      := TRIM(search.Business.address.streetaddress1)<>'' or (TRIM(search.Business.address.streetnumber)<>'' and TRIM(search.Business.address.streetname)<>'');
  boolean BusZipCheck       := TRIM(search.Business.address.zip5)<>'';
  boolean BusNameCheck      := TRIM(search.Business.CompanyName)<>'' or TRIM(search.Business.AlternateCompanyName)<>'';
  boolean LexIDCheck        := TRIM(search.Individual.UniqueId)<>'';
  boolean BDIDCheck         := TRIM(search.Business.BusinessId)<>'';
  boolean DPPACheck         := TRIM(userIn.DLPurpose)<>'' and ((integer)(userIn.DLPurpose) >= 0 and (integer)(userIn.DLPurpose) < 8);
  boolean GLBCheck          := TRIM(userIn.GLBPurpose)<>''  and ((integer)(userIn.GLBPurpose) >= 0 and (integer)(userIn.GLBPurpose) < 8 or (integer)(userIn.GLBPurpose)=11 or (integer)(userIn.GLBPurpose)=12);


boolean IndividualInvalid :=  if (attributesVersion in ['IND', 'INDV2'] and (~(IndFNameCheck and IndFAddrCheck and IndFLastCheck and IndZipCheck) and ~(IndSSNCheck and IndFNameCheck and IndFLastCheck) and ~LexIDCheck), 1, 0);
boolean BusinessInvalid :=  if (attributesVersion in ['BUS', 'BUSV2'] and (~(BusNameCheck and BusAddrCheck and BusZipCheck) and ~(BusTaxIDCheck and BusNameCheck) and ~BDIDCheck), 1, 0);
boolean RequestInvalid :=  if (attributesVersion= 'INVALID' , 1, 0);
boolean PermissionGLB := if(~GLBCheck,  1 , 0);
boolean PermissionDPPA := if(~DPPACheck, 1 , 0);

if(IndividualInvalid, FAIL( 'Customer type is Individual: Please input the minimum input required fields: \n Option 1: SSN, Last Name, and First Name OR \n Option 2: Last Name, First Name, Street Address, and Zip OR \n Option 3:  Unique ID '));
If(BusinessInvalid, FAIL('Customer Type is Business: Please input the minimum required fields: \n Option 1:  FEIN and Company Name  OR \n Option 2:  Company Name, Street Address, and Zip OR \n Option 3: Business ID '));
if(RequestInvalid,FAIL('Please enter a valid attributes version: AMLRBUSATTRV1 or AMLRINDVATTRV1 or AMLRBUSATTRV2 or AMLRINDVATTRV2'));
if(PermissionGLB,FAIL('Not an allowable GLB permissible purpose'));
if(PermissionDPPA,FAIL('Not an allowable DPPA permissible purpose'));

  layout_acctseq := record
    integer4 seq;
    ds_in;
  end;
  wseq := project( ds_in, transform( layout_acctseq, self.seq := counter, self := left ) );

  // IID and Boca Shell
  Risk_Indicators.Layout_Input into(wseq l) := TRANSFORM
    self.did := (integer)l.searchby.Individual.UniqueId;
    self.seq := l.seq;
    self.historydate := history_date;
    self.ssn := l.searchby.Individual.ssn;
    dob :=                    l.searchby.Individual.dob.year
        + intformat((integer1)l.searchby.Individual.dob.month, 2, 1)
        + intformat((integer1)l.searchby.Individual.dob.day,   2, 1);
    self.dob := if((unsigned)dob=0, '', dob);
    self.age := (STRING3)ut.Age((unsigned8)dob, (unsigned)risk_indicators.iid_constants.myGetDate(history_date));

    fullname := trim(l.searchby.Individual.name.full);
    cleanname := address.CleanPerson73( fullname );
    title  := if(l.searchby.Individual.name.prefix='' and fullname!='', trim((cleanname[1..5]))  , l.searchby.Individual.name.prefix);
    fname  := if(l.searchby.Individual.name.first ='' and fullname!='', trim((cleanname[6..25])) , l.searchby.Individual.name.first );
    mname  := if(l.searchby.Individual.name.middle='' and fullname!='', trim((cleanname[26..45])), l.searchby.Individual.name.middle);
    lname  := if(l.searchby.Individual.name.last  ='' and fullname!='', trim((cleanname[46..65])), l.searchby.Individual.name.last  );
    suffix := if(l.searchby.Individual.name.suffix='' and fullname!='', trim((cleanname[66..70])), l.searchby.Individual.name.suffix);

    self.title  := STD.Str.ToUpperCase(title);
    self.fname  := STD.Str.ToUpperCase(fname);
    self.mname  := STD.Str.ToUpperCase(mname);
    self.lname  := STD.Str.ToUpperCase(lname);
    self.suffix := STD.Str.ToUpperCase(suffix);

    addr_value := if(trim(l.searchby.Individual.address.streetaddress1)!='', l.searchby.Individual.address.streetaddress1,
        Address.Addr1FromComponents(l.searchby.Individual.address.streetnumber, l.searchby.Individual.address.streetpredirection, l.searchby.Individual.address.streetname,
          l.searchby.Individual.address.streetsuffix, l.searchby.Individual.address.streetpostdirection, l.searchby.Individual.address.unitdesignation, l.searchby.Individual.address.unitnumber));

    clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, l.searchby.Individual.address.city, l.searchby.Individual.address.state, l.searchby.Individual.address.zip5);

    self.in_streetAddress:= addr_value;
    self.in_city         := l.searchby.Individual.address.city;
    self.in_state        := l.searchby.Individual.address.state;
    self.in_zipCode      := l.searchby.Individual.address.zip5;
    self.prim_range      := clean_a2[1..10];
    self.predir          := clean_a2[11..12];
    self.prim_name       := clean_a2[13..40];
    self.addr_suffix     := clean_a2[41..44];
    self.postdir         := clean_a2[45..46];
    self.unit_desig      := clean_a2[47..56];
    self.sec_range       := clean_a2[57..64];
    self.p_city_name     := clean_a2[90..114];
    self.st              := clean_a2[115..116];
    self.z5              := clean_a2[117..121];
    self.zip4            := clean_a2[122..125];
    self.lat             := clean_a2[146..155];
    self.long            := clean_a2[156..166];
    self.addr_type       := risk_indicators.iid_constants.override_addr_type(addr_value, clean_a2[139],clean_a2[126..129]);
    self.addr_status     := clean_a2[179..182];
    self.county          := clean_a2[143..145];
    self.geo_blk         := clean_a2[171..177];

    self.dl_number       := '';
    self.dl_state        := '';;
    self.phone10         := l.searchby.Individual.Phone;
    self.wphone10        := '';
    self.email_address   := '';
    self.ip_address      := '';
    self.in_country      := '';
    self.country         := '';
    // self := [];
  END;
  iid_prep := PROJECT(wseq, into(left));

//  TEST SEEDS
  risk_indicators.layout_input intoTestPrep(wseq l) := transform
    self.seq := l.seq;
    self.ssn := l.searchby.Individual.ssn;
    self.phone10 := l.searchby.Individual.Phone;
    self.fname := STD.Str.ToUpperCase(l.searchby.Individual.name.first);
    self.lname := STD.Str.ToUpperCase(l.searchby.Individual.name.last);
    SELF.in_zipCode := l.searchby.Individual.address.zip5;
    self := [];
  end;
  test_prep := PROJECT(wseq, intoTestPrep(LEFT));


  consumerAttributes := IF(TestDataEnabled, AML.AMLRiskAttributes_TestSeed_Function(test_prep, TestDataTableName),
                                  AML.getAMLattributes(iid_prep,
                                             mod_aml,
                                             gateways,
                                             IncludeNegativeNews
                                                                                         ));  // will be in  final layout when returned  boca shell


  consumerAttributesV2 :=  IF(TestDataEnabled, AML.AMLRiskAttributesV2_TestSeed_Function(test_prep, TestDataTableName),
                                AML.getAMLAttributesV2(iid_prep,
                                             mod_aml,
                                             gateways,
                                             UseXG5,
                                             IncludeNewsProfile));


iesp.share.t_NameValuePair createrec(consumerAttributes le, integer C) := TRANSFORM
      self.Name:= case( C,
        1 => 'IndCitizenshipIndex' ,
        2 => 'IndMobilityIndex' ,
        3 => 'IndLegalEventsIndex' ,
        4 => 'IndAccesstoFundsIndex',
        5 => 'IndBusinessAssocationIndex',
        6 => 'IndHighValueAssetIndex',
        7 => 'IndGeographicIndex',
        8 => 'IndAssociatesIndex',
        9 => 'IndAgeRange',
        10 => 'IndAMLNegativeNews90',
        11 => 'IndAMLNegativeNews24',
              'Invalid');
      self.Value:=  case(C,
       1 =>  le.AMLAttributes.IndCitizenshipIndex ,
       2 =>  le.AMLAttributes.IndMobilityIndex ,
       3 =>  le.AMLAttributes.IndLegalEventsIndex ,
       4 =>  le.AMLAttributes.IndAccesstoFundsIndex,
       5 =>  le.AMLAttributes.IndBusinessAssocationIndex ,
       6 =>  le.AMLAttributes.IndHighValueAssetIndex ,
       7 =>  le.AMLAttributes.IndGeographicIndex ,
       8 =>  le.AMLAttributes.IndAssociatesIndex ,
       9 =>  le.AMLAttributes.IndAgeRange ,
      10 =>  le.AMLAttributes.IndAMLNegativeNews90 ,
      11 =>  le.AMLAttributes.IndAMLNegativeNews24 ,

        'Invalid');

  END;

  IndIndex := normalize(ungroup(consumerAttributes), 11,createrec(LEFT,COUNTER ));

iesp.amlrattributes.t_AntiMoneyLaunderingRiskAttributesResponse IntoConsumerAttributes(wseq le,consumerAttributes ri ) := Transform
      // self.Result.InputEcho.Individual.UniqueId := (string)ri.did;
      self.Result.InputEcho := le.searchby;
      SELF.Result.AttributeGroup.attributes :=  IndIndex;
      self.Result.UniqueId := (string)ri.did;
      self.Result.AttributeGroup.Name := 'AMLRINDVATTRV1';
      self := le;
      self := [];
END;


  IndAttributes := join(wseq,   consumerAttributes,
                       right.seq = left.seq,
                       IntoConsumerAttributes(LEFT, RIGHT));

// Version 2
iesp.share.t_NameValuePair createrecV2(consumerAttributesV2 le, integer C) := TRANSFORM
      self.Name:= case( C,
        1 => 'IndHighValueAssetsV2' ,
        2 => 'IndAccessToFundsV2' ,
        3 => 'IndGeographicRiskV2' ,
        4 => 'IndMobilityV2',
        5 => 'IndLegalEventsV2',
        6 => 'IndHighRiskNewsProfilesV2',
        7 => 'IndHighRiskNewsProfileTypeV2',
        8 => 'IndAgeRangeV2',
        9 => 'IndIdentityRiskV2',
        10 => 'IndResidencyRiskV2',
        11 => 'IndMatchLevelV2',
        12 => 'IndPersonalAssocRiskV2',
        13 => 'IndAssocResidencyRiskV2',
        14 => 'IndProfessionalRiskV2',
        15 => 'IndBusExecOffAssocRiskV2',
              'Invalid');
      self.Value:=  case(C,
       1 =>  le.IndHighValueAssets ,
       2 =>  le.IndAccesstoFunds ,
       3 =>  le.IndGeographicRisk ,
       4 =>  le.IndMobility,
       5 =>  le.IndLegalEvents ,
       6 =>  le.IndHighRiskNewsProfiles ,
       7 =>  le.IndHighRiskNewsProfileType ,
       8 =>  le.IndAgeRange ,
       9 =>  le.IndIdentityRisk ,
      10 =>  le.IndResidencyRisk ,
      11 =>  le.IndMatchLevel ,
      12 =>  le.IndPersonalAssocRisk ,
      13 =>  le.IndAssocResidencyRisk ,
      14 =>  le.IndProfessionalRisk ,
      15 =>  le.IndBusExecOffAssocRisk ,

        'Invalid');

  END;

  IndIndexV2 := normalize(ungroup(consumerAttributesV2), 15,createrecV2(LEFT,COUNTER ));

iesp.amlrattributes.t_AntiMoneyLaunderingRiskAttributesResponse IntoConsumerAttributesV2(wseq le,consumerAttributesV2 ri ) := Transform
      self.Result.InputEcho := le.searchby;
      SELF.Result.AttributeGroup.attributes :=  IndIndexV2;
      self.Result.UniqueId := (string)ri.did;
      self.Result.AttributeGroup.Name := 'AMLRINDVATTRV2';
      self := le;
      self := [];
END;


  IndAttributesV2 := join(wseq,   consumerAttributesV2,
                       right.seq = left.seq,
                       IntoConsumerAttributesV2(LEFT, RIGHT));

//  BUSINESS ATTRIBUTES STARTS HERE********************************************************


business_risk.Layout_Input into_input(wseq L) := transform
  self.seq := l.seq;
  self.bdid := (integer)l.searchby.Business.BusinessId;
  self.historydate := history_date;
  self.Account := (string)l.seq;
  self.company_name := if(STD.Str.ToUpperCase(l.searchby.Business.CompanyName) <> '',STD.Str.ToUpperCase(l.searchby.Business.CompanyName), STD.Str.ToUpperCase(l.searchby.Business.AlternateCompanyName));

    addr_value := if(trim(l.searchby.Business.address.streetaddress1)!='', l.searchby.Business.address.streetaddress1,
        Address.Addr1FromComponents(l.searchby.Business.address.streetnumber, l.searchby.Business.address.streetpredirection, l.searchby.Business.address.streetname,
          l.searchby.Business.address.streetsuffix, l.searchby.Business.address.streetpostdirection, l.searchby.Business.address.unitdesignation, l.searchby.Business.address.unitnumber));

    clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, l.searchby.Business.address.city, l.searchby.Business.address.state, l.searchby.Business.address.zip5);

    self.prim_range      := clean_a2[1..10];
    self.predir          := clean_a2[11..12];
    self.prim_name       := clean_a2[13..40];
    self.addr_suffix     := clean_a2[41..44];
    self.postdir         := clean_a2[45..46];
    self.unit_desig      := clean_a2[47..56];
    self.sec_range       := clean_a2[57..64];
    self.p_city_name     := clean_a2[90..114];
    self.st              := clean_a2[115..116];
    self.z5              := clean_a2[117..121];
    self.zip4            := clean_a2[122..125];
    self.lat             := clean_a2[146..155];
    self.long            := clean_a2[156..166];
    self.addr_type       := clean_a2[139];
    self.addr_status     := clean_a2[179..182];
    self.county          := clean_a2[143..145];
    self.geo_blk         := clean_a2[171..177];
    self.fein            := l.searchby.Business.fein;
    self.phone10         := l.searchby.Business.phone;

end;

busInput := project(wseq,into_input(LEFT));



business_risk.Layout_Input into_test_Busnprep(wseq l) := transform
  self.seq := l.seq;
  self.historydate := history_date;
  self.Account := (string)l.seq;
  self.company_name := STD.Str.ToUpperCase(l.searchby.Business.CompanyName);
  self.z5              := l.searchby.business.address.zip5;
  self.fein            := l.searchby.Business.FEIN;
  self.phone10         := l.searchby.Business.phone;
  self := [];
END;
  test_Busnprep := PROJECT(wseq, into_test_Busnprep(LEFT));

businessResults :=  if(TestDataEnabled, AML.AMLRiskAttributes_BusnTestSeed_Function(test_Busnprep, TestDataTableName),
                      AML.AMLBusinessShellFunction(busInput,
                                                mod_aml,
                                                IncludeNegativeNews
                                                ));


businessResultsV2 :=  if(TestDataEnabled, AML.AMLRiskAttributesV2_BusnTestSeed_Function(test_Busnprep, TestDataTableName),
                      AML.GetAMLAttribBusnV2(busInput,
                      mod_aml,
                      gateways,
                      UseXG5,
                      IncludeNewsProfile));

iesp.share.t_NameValuePair BusnCreateRec(businessResults le, integer C) := TRANSFORM
      self.Name:= case(c,
       1 => 'BusValidityIndex',
       2 => 'BusStabilityIndex',
       3 => 'BusLegalEventsIndex',
       4 => 'BusAccesstoFundsIndex',
       5 => 'BusGeographicIndex',
       6 => 'BusAssociatesIndex',
       7 => 'BusIndustryRiskIndex',
       8 => 'BusAMLNegativeNews90',
       9 => 'BusAMLNegativeNews24',
            'Invalid');
      self.Value:= case(c,
       1 =>  le.BusValidityIndex,
       2 =>  le.BusStabilityIndex,
       3 =>  le.BusLegalEventsIndex,
       4 =>  le.BusAccesstoFundsIndex,
       5 =>  le.BusGeographicIndex,
       6 =>  le.BusAssociatesIndex,
       7 =>  le.BusIndustryRiskIndex,
       8 =>  le.BusAMLNegativeNews90,
       9 =>  le.BusAMLNegativeNews24,
            'Invalid');
END;

  BusnIndex := normalize(businessResults, 9 ,BusnCreateRec(LEFT,COUNTER ));

iesp.amlrattributes.t_AntiMoneyLaunderingRiskAttributesResponse IntoBusnAttributes(wseq le,businessResults ri ) := Transform
      self.result.inputecho := le.searchby;
      SELF.Result.AttributeGroup.attributes :=  BusnIndex;
      self.Result.BusinessId  := (string)ri.bdid;
      self.Result.AttributeGroup.Name := 'AMLRBUSATTRV1';
      self := le;
      self := [];
END;


  BusnAttributes := join(wseq,   businessResults,
                        right.seq = left.seq,
                        IntoBusnAttributes(LEFT, RIGHT));

//version 2
iesp.share.t_NameValuePair BusnCreateRecV2(businessResultsV2 le, integer C) := TRANSFORM
      self.Name:= case(c,
       1 => 'BusHighValueAssets',
       2 => 'BusAccessToFunds',
       3 => 'BusGeographicRisk',
       4 => 'BusValidityRisk',
       5 => 'BusStabilityRisk',
       6 => 'BusIndustryRisk',
       7 => 'BusShellShelfRisk',
       8 => 'BusStructureType',
       9 => 'BusSOSAgeRange',
       10 => 'BusPublicRecordAgeRange',
       11 => 'BusMatchLevel',
       12 => 'BusLegalEvents',
       13 => 'BusHighRiskNewsProfiles',
       14 => 'BusHighRiskNewsProfileType',
       15 => 'BusLinkedBusRisk',
       16 => 'BusExecOfficersRisk',
       17 => 'BusExecOfficersResidencyRisk',
            'Invalid');
      self.Value:= case(c,
       1 =>  le.BusHighValueAssets,
       2 =>  le.BusAccessToFunds,
       3 =>  le.BusGeographicRisk,
       4 =>  le.BusValidityRisk,
       5 =>  le.BusStabilityRisk,
       6 =>  le.BusIndustryRisk,
       7 =>  le.BusShellShelfRisk,
       8 =>  le.BusStructureType,
       9 =>  le.BusSOSAgeRange,
       10 =>  le.BusPublicRecordAgeRange,
       11 =>  le.BusMatchLevel,
       12 =>  le.BusLegalEvents,
       13 =>  le.BusHighRiskNewsProfiles,
       14 =>  le.BusHighRiskNewsProfileType,
       15 =>  le.BusLinkedBusRisk,
       16 =>  le.BusExecOfficersRisk,
       17 =>  le.BusExecOfficersResidencyRisk,
            'Invalid');
END;

  BusnIndexV2 := normalize(businessResultsV2, 17 ,BusnCreateRecV2(LEFT,COUNTER ));

iesp.amlrattributes.t_AntiMoneyLaunderingRiskAttributesResponse IntoBusnAttributesV2(wseq le,businessResultsV2 ri ) := Transform
      // SELF.Result.InputEcho.Business.BusinessId  := (string)ri.bdid;
      self.result.inputecho := le.searchby;
      SELF.Result.AttributeGroup.attributes :=  BusnIndexV2;
      self.Result.BusinessId  := (string)ri.OrigBdid;
      self.Result.AttributeGroup.Name := 'AMLRBUSATTRV2';
      self := le;
      self := [];
END;


  BusnAttributesV2 := join(wseq,   businessResultsV2,
                        right.seq = left.seq,
                        IntoBusnAttributesV2(LEFT, RIGHT));

// debugging section
// output(test_Busnprep, named('test_Busnprep'));
// output(search, named('search'));

// output(IndFNameCheck, named('IndFNameCheck'));
// output(IndFAddrCheck, named('IndFAddrCheck'));
// output(IndFLastCheck, named('IndFLastCheck'));
// output(IndZipCheck, named('IndZipCheck'));
// output(IndSSNCheck, named('IndSSNCheck'));  b
// output(BusTaxIDCheck, named('BusTaxIDCheck'));
// output(BusAddrCheck, named('BusAddrCheck'));
// output(BusZipCheck, named('BusZipCheck'));
// output(BusNameCheck, named('BusNameCheck'));

AttrVersionInd := if(attributesVersion = 'IND',IndAttributes, IndAttributesV2);
AttrVersionBus := if(attributesVersion = 'BUS',Busnattributes, BusnattributesV2);

FINAL := IF(attributesVersion in ['IND', 'INDV2'], (AttrVersionInd), (AttrVersionBus));
output(final,NAMED('Results'));

//Log to Deltabase
Deltabase_Logging_prep := project(FINAL, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
                                                  self.company_id := (Integer)CompanyID,
                                                  self.login_id := _LoginID,
                                                  self.product_id := Risk_Reporting.ProductID.AML__AML_Service,
                                                  self.function_name := FunctionName,
                                                  self.esp_method := ESPMethod,
                                                  self.interface_version := InterfaceVersion,
                                                  self.delivery_method := DeliveryMethod,
                                                  self.date_added := (STRING8)Std.Date.Today(),
                                                  self.death_master_purpose := DeathMasterPurpose,
                                                  self.ssn_mask := mod_aml.ssn_mask,
                                                  self.dob_mask := suppress.date_mask_math.MaskValue(mod_aml.dob_mask),
                                                  self.dl_mask := (String)(Integer)(mod_aml.dl_mask >0),
                                                  self.exclude_dmv_pii := (String)(Integer)mod_aml.suppress_dmv,
                                                  self.scout_opt_out := (String)(Integer)DisableOutcomeTracking,
                                                  self.archive_opt_in := (String)(Integer)ArchiveOptIn,
                                                  self.glb := mod_aml.glb,
                                                  self.dppa := mod_aml.dppa,
                                                  self.data_restriction_mask := mod_aml.DataRestrictionMask,
                                                  self.data_permission_mask := mod_aml.DataPermissionMask,
                                                  self.industry := Industry_Search[1].Industry,
                                                  self.i_attributes_name := optionsIn.AttributesVersionRequest,
                                                  self.i_ssn := search.Individual.SSN,
                                                  dob_temp :=           search.Individual.dob.year
                                                  + intformat((integer1)search.Individual.dob.month, 2, 1)
                                                  + intformat((integer1)search.Individual.dob.day,   2, 1);
                                                  self.i_dob := if((unsigned)dob_temp=0, '', dob_temp),
                                                  self.i_name_full := search.Individual.Name.Full,
                                                  self.i_name_first := search.Individual.Name.First,
                                                  self.i_name_last := search.Individual.Name.Last,
                                                  self.i_lexid := (Integer)search.Individual.UniqueId,
                                                  self.i_address := If(trim(search.Individual.address.streetaddress1)!='',
                                                                        trim(search.Individual.address.streetaddress1 + ' ' + search.Individual.address.streetaddress2),
                                                                           Address.Addr1FromComponents(search.Individual.address.streetnumber,
                                                                           search.Individual.address.streetpredirection, search.Individual.address.streetname,
                                                                           search.Individual.address.streetsuffix, search.Individual.address.streetpostdirection,
                                                                           search.Individual.address.unitdesignation, search.Individual.address.unitnumber)),
                                                  self.i_city := search.Individual.address.City,
                                                  self.i_state := search.Individual.address.State,
                                                  self.i_zip := search.Individual.address.Zip5,
                                                  self.i_home_phone := search.Individual.Phone;
                                                  self.i_tin := search.Business.FEIN,
                                                  self.i_bus_name := search.Business.CompanyName,
                                                  self.i_alt_bus_name := search.Business.AlternateCompanyName,
                                                  self.i_bus_address := If(trim(search.Business.address.streetaddress1)!='',
                                                                            trim(search.Business.address.streetaddress1 + ' ' + search.Business.address.streetaddress2),
                                                                               Address.Addr1FromComponents(search.Business.address.streetnumber,
                                                                               search.Business.address.streetpredirection, search.Business.address.streetname,
                                                                               search.Business.address.streetsuffix, search.Business.address.streetpostdirection,
                                                                               search.Business.address.unitdesignation, search.Business.address.unitnumber)),
                                                  self.i_bus_city  := search.Business.address.City,
                                                  self.i_bus_state := search.Business.address.State,
                                                  self.i_bus_zip   := search.Business.address.Zip5,
                                                  self.i_bus_phone := search.Business.phone,
                                                  self.o_lexid     := (Integer)left.Result.UniqueId,
                                                  self.o_bdid      := left.Result.BusinessId,
                                                  self := left,
                                                  self := [] ));
Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
// #stored('Deltabase_Log', Deltabase_Logging);

//Improved Scout Logging
IF(~DisableOutcomeTracking and ~TestDataEnabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));

ENDMACRO;
