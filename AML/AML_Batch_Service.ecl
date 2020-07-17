IMPORT Risk_indicators, Riskwise, Business_risk, gateway, AML, STD;

EXPORT AML_Batch_Service() := FUNCTION

#WEBSERVICE(FIELDS(
                'batch_in',
                'GLBPurpose',
                'DPPAPurpose',
                'AttributesVersion',
                'IncludeNewsProfile',
                'DataRestrictionMask',
                'DataPermissionMask',
                'gateways',
                'LexIdSourceOptout',
                '_TransactionId',
                '_BatchUID',
                '_GCID'
                ));

  #STORED('GLBPurpose', 5);
  #STORED('DataRestrictionMask', risk_indicators.iid_constants.default_DataRestriction);

  batch_in  := dataset( [], AML.layouts.AMLBatchInLayout ) : stored('batch_in');
  unsigned1 glba                      := 5  : stored('GLBPurpose');
  unsigned1 dppa                      := 3  : stored('DPPAPurpose');
  unsigned1 AttributesVersion         := 1  : stored('AttributesVersion'); // keep for customer still using ver 1
  Boolean  IncludeNegNewsCounts       := FALSE;
  Boolean  IncludeNewsProfile         := TRUE  : stored('IncludeNewsProfile');
  gateways                            := Gateway.Configuration.Get();

  mod_pre := AML.IParam.GetAmlInputModule();
  mod_aml := MODULE(PROJECT(mod_pre, AML.IParam.IAml))
    EXPORT unsigned1 dppa := ^.dppa;
    EXPORT unsigned1 glb := glba;
    EXPORT string DataRestrictionMask := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
    EXPORT unsigned1 bs_version := if(AttributesVersion = 1, 41, 50);
    //TODO: masking?
  END;

  wseq := project( batch_in, transform( AML.Layouts.AMLBatchInLayout, self.seq := counter, self := left ) );

  IndRecs :=  wseq(STD.Str.ToUpperCase(CustType) = 'INDIVIDUAL');
  BusRecs :=  wseq(STD.Str.ToUpperCase(CustType) = 'BUSINESS');

  // '0' - do not call XG5
  // '1' - full XG5 response will be returned for AML report
  // '2' - Call Bridger XG5 for KRIs but not full response


  UseXG5 := '2';

  // IID and Boca Shell
Risk_Indicators.Layout_Input into(IndRecs l) := TRANSFORM
    self.did := (integer)l.LexId;
    self.seq := l.seq;
    self.historydate := if(l.historyDateYYYYMM=0, 999999, l.historyDateYYYYMM);
    self.ssn := l.ssn;
    dob_val := riskwise.cleandob(l.dob);
    dob :=    dob_val;
    self.dob := if((unsigned)dob=0, '', dob);

    fname  :=  l.Name_First ;
    mname  :=  l.Name_Middle;
    lname  :=  l.Name_Last ;

    self.fname  := STD.Str.touppercase(fname);
    self.mname  := STD.Str.touppercase(mname);
    self.lname  := STD.Str.touppercase(lname);
    self.suffix := l.Name_Suffix;

    addr_value := trim(l.street_addr);

    clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, l.City_name, l.st, l.z5);

    self.in_streetAddress:= addr_value;
    self.in_city         := l.City_name;
    self.in_state        := l.st;
    self.in_zipCode      := l.z5;
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
    self.addr_type := risk_indicators.iid_constants.override_addr_type(l.street_addr, clean_a2[139],clean_a2[126..129]);
    self.addr_status     := clean_a2[179..182];
    self.county          := clean_a2[143..145];
    self.geo_blk         := clean_a2[171..177];
    self.phone10          := l.Phone;

    self := [];
  END;
  iid_prep := PROJECT(IndRecs, into(left));



 consumerAttributesV1 := AML.getAMLattributes(iid_prep,
                                             mod_aml,
                                             gateways,
                                             IncludeNegNewsCounts
                                             );


consumerAttributesV2 := AML.getAMLAttributesV2(iid_prep,
                                             mod_aml,
                                             gateways,
                                             UseXG5,
                                             IncludeNewsProfile
                                             );

  AML.Layouts.AMLBatchOut IndMapOut(consumerAttributesV1 le, wseq ri) := TRANSFORM
  self.acctNo                        := ri.acctNo;
  self.IndCitizenshipIndex           := le.AMLAttributes.IndCitizenshipIndex;
  self.IndMobilityIndex              := le.AMLAttributes.IndMobilityIndex;
  self.IndLegalEventsIndex           := le.AMLAttributes.IndLegalEventsIndex;
  self.IndAccesstoFundsIndex         := le.AMLAttributes.IndAccesstoFundsIndex;
  self.IndBusinessAssocationIndex    := le.AMLAttributes.IndBusinessAssocationIndex;
  self.IndHighValueAssetIndex        := le.AMLAttributes.IndHighValueAssetIndex;
  self.IndGeographicIndex            := le.AMLAttributes.IndGeographicIndex;
  self.IndAssociatesIndex            := le.AMLAttributes.IndAssociatesIndex;
  self.IndAgeRange                   := le.AMLAttributes.IndAgeRange;
  self.IndAMLNegativeNews90          := le.AMLAttributes.IndAMLNegativeNews90;
  self.IndAMLNegativeNews24          := le.AMLAttributes.IndAMLNegativeNews24;
  self.RoyaltySrc                    := if(~IncludeNegNewsCounts, '0', if(IncludeNegNewsCounts and (le.AMLAttributes.IndAMLNegativeNews90 = ''), '0', '1'));
  self := [];
END;


INDIndexV1 := join(consumerAttributesV1, IndRecs,
            left.seq = right.seq,
            IndMapOut(left, right), left outer);

  AML.Layouts.AMLBatchOut IndMapOutV2(consumerAttributesV2 le, wseq ri) := TRANSFORM
  self.acctNo                            := ri.acctNo;
  self.IndHighValueAssetsV2              := le.IndHighValueAssets;
  self.IndAccessToFundsV2                := le.IndAccessToFunds;
  self.IndGeographicRiskV2               := le.IndGeographicRisk;
  self.IndMobilityV2                     := le.IndMobility;
  self.IndLegalEventsV2                  := le.IndLegalEvents;
  self.IndHighRiskNewsProfilesV2         := le.IndHighRiskNewsProfiles;
  self.IndHighRiskNewsProfileTypeV2      := le.IndHighRiskNewsProfileType;
  self.IndAgeRangeV2                     := le.IndAgeRange;
  self.IndIdentityRiskV2                 := le.IndIdentityRisk;
  self.IndResidencyRiskV2                := le.IndResidencyRisk;
  self.IndMatchLevelV2                   := le.IndMatchLevel;
  self.IndPersonalAssocRiskV2            := le.IndPersonalAssocRisk;
  self.IndAssocResidencyRiskV2           := le.IndAssocResidencyRisk;
  self.IndProfessionalRiskV2             := le.IndProfessionalRisk;
  self.IndBusExecOffAssocRiskV2          := le.IndBusExecOffAssocRisk;
  self.RoyaltySrc                        := '0';
  self.lexID                             := le.DID;
  self := [];
END;


INDIndexV2 := join(consumerAttributesV2, IndRecs,
            left.seq = right.seq,
            IndMapOutV2(left, right), left outer);

INDIndex  :=  if(AttributesVersion = 2, INDIndexV2, INDIndexV1);


//  BUSINESS ATTRIBUTES STARTS HERE********************************************************


Business_risk.Layout_Input into_input(BusRecs L) := transform
  self.seq := l.seq;
  self.bdid := (integer)l.LexId;
  self.historydate := if(l.historyDateYYYYMM=0, 999999, l.historyDateYYYYMM);
  self.Account := l.AcctNo;
  self.company_name := if(STD.Str.touppercase(l.Business_Name)<>'',STD.Str.touppercase(l.Business_Name),STD.Str.touppercase(l.DBA)) ;

  addr_value := trim(l.street_addr);

    clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, l.City_name, l.st, l.z5);

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
    self.fein            := l.Taxid;
    self.phone10         := l.phone;

end;

busInput := project(BusRecs,into_input(LEFT));


  businessResultsV1 := group(AML.AMLBusinessShellFunction(busInput,
                                                        mod_aml,
                                                        IncludeNegNewsCounts
                                                        ));


   businessResultsV2 := group(AML.GetAMLAttribBusnV2(busInput,
                                                        mod_aml,
                                                        gateways,
                                                        UseXG5,
                                                        IncludeNewsProfile));

AML.Layouts.AMLBatchOut BusMapOut(businessResultsV1 le, BusRecs ri) := TRANSFORM
  self.acctNo                 := ri.acctNo;
  self.BusValidityIndex       :=  le.BusValidityIndex;
  self.BusStabilityIndex      :=  le.BusStabilityIndex;
  self.BusLegalEventsIndex    :=  le.BusLegalEventsIndex;
  self.BusAccesstoFundsIndex  :=  le.BusAccesstoFundsIndex;
  self.BusGeographicIndex     :=  le.BusGeographicIndex;
  self.BusAssociatesIndex     :=  le.BusAssociatesIndex;
  self.BusIndustryRiskIndex   :=  le.BusIndustryRiskIndex;
  self.BusAMLNegativeNews90   :=  le.BusAMLNegativeNews90;
  self.BusAMLNegativeNews24   :=  le.BusAMLNegativeNews24;
  self.RoyaltySrc             := if(~IncludeNegNewsCounts, '0', if(IncludeNegNewsCounts and (le.BusAMLNegativeNews90 = ''), '0', '1'));
  self := [];
END;

BusIndexV1 := join(businessResultsV1, BusRecs,
                left.seq = right.seq,
                BusMapOut(left, right), left outer);

AML.Layouts.AMLBatchOut BusMapOutV2(businessResultsV2 le, BusRecs ri) := TRANSFORM
  self.acctNo                  := ri.acctNo;
  self.BusHighValueAssetsV2    := le.BusHighValueAssets;
  self.BusAccessToFundsV2      := le.BusAccessToFunds;
  self.BusGeographicRiskV2     := le.BusGeographicRisk;
  self.BusValidityRiskV2       := le.BusValidityRisk;
  self.BusStabilityRiskV2      := le.BusStabilityRisk;
  self.BusIndustryRiskV2       := le.BusIndustryRisk;
  self.BusShellShelfRiskV2     := le.BusShellShelfRisk;
  self.BusShellShelfRiskRPT    := If(le.BusShellShelfRisk[1..2] = '-1', le.BusShellShelfRisk[1..2], le.BusShellShelfRisk[1]);
  self.BusStructureTypeV2      := le.BusStructureType;
  self.BusSOSAgeRangeV2        := le.BusSOSAgeRange;
  self.BusPublicRecordAgeRangeV2  := le.BusPublicRecordAgeRange;
  self.BusMatchLevelV2    := le.BusMatchLevel;
  self.BusLegalEventsV2        := le.BusLegalEvents;
  self.BusHighRiskNewsProfilesV2   := le.BusHighRiskNewsProfiles;
  self.BusHighRiskNewsProfileTypeV2   := le.BusHighRiskNewsProfileType;
  self.BusLinkedBusRiskV2    := le.BusLinkedBusRisk;
  self.BusExecOfficersRiskV2   := le.BusExecOfficersRisk;
  self.BusExecOfficersResidencyRiskV2   := le.BusExecOfficersResidencyRisk;
  self.RoyaltySrc             := '0';
  self := [];
END;

BusIndexV2 := join(businessResultsV2, BusRecs,
                left.seq = right.seq,
                BusMapOutV2(left, right), left outer);



BusIndex :=  if(AttributesVersion = 2, BusIndexV2, BusIndexV1);

FINAL :=  ungroup(INDIndex) + ungroup(BusIndex);

// output(UseXG5, named('UseXG5'));
// output(gateways, named('gateways'));
// output(batch_in, named('batch_inBatch'));
// output(wseq, named('wseqBatch'));
// output(IndRecs, named('IndRecsBatch'));
// output(BusRecs, named('BusRecsBatch'));
// output(iid_prep, named('iidPrepBatch'));
// output(busInput, named('busInputBatch'));
// output(businessResultsV2, named('businessResultsV2'));


RETURN FINAL;

END;

/*--SOAP--
<message name="AML Attributes"  wuTimeout="300000">
  <part name="batch_in"  type="tns:XmlDataSet" cols="80" rows="50"/>
  <part name="AttributesVersion" type="xsd:integer"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBAPurpose" type="xsd:byte"/>
  <part name="DataRestriction" type="xsd:string"/>
  <part name="DataPermissionMask" type="xsd:string"/>
  <part name="IncludeNewsProfile" type="xsd:boolean"/>
  <part name="gateways" type="tns:XmlDataSet" cols="110" rows="4"/>
 </message>
*/
/*--INFO-- AML Batch Service*/
