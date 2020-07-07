Import risk_indicators, PublicRecords_KEL, gateway, STD, Models;

// this function needs the original input (indata)
// and appends the TMX gateway results to the end of Layout_Output
// will eventually need the mod_access passed in here as well to know if we turn on the PIIPersistence and the merchant name/ID

EXPORT iid_append_ThreatMetrix( DATASET(risk_indicators.layout_input) indata, 
                                grouped DATASET(risk_indicators.Layout_Output) InstantID_function_results,
                                dataset(Gateway.Layouts.Config) gateways,
                                string20 companyID = '',
																string DataRestriction = ''
                                ) := function

  in_slim := project(indata, transform(PublicRecords_KEL.ECL_Functions.Input_Layout_Slim, 
                                      // self.account:=left.seq;
                                      self.G_ProcUID:=left.seq;
                                      self.historydate := (string)left.historydate; 
                                      self.FirstName:= left.fname;
                                      self.MiddleName:= left.mname;
                                      self.LastName:= left.lname;
                                      self.email:= left.email_address;
                                      self.homephone:= left.phone10;
                                      self.StreetAddressLine1:= left.in_streetAddress;
                                      self.City := left.in_city;
                                      self.State:= left.in_state;
                                      self.Zip := left.in_zipcode;
                                      self.SSN:= left.ssn;
                                      self.DateOfBirth:=left.dob;
                                      self.WorkPhone:= left.wphone10;
                                      self.DLNumber:= left.dl_number;
                                      Self.DLState:= left.dl_state;
                                      SELF.LexID:= (String)left.did;
                                      self := left,
                                      self := []));

  // Echo input
  InputEcho := PublicRecords_KEL.ECL_Functions.Fn_InputEcho_Roxie( in_slim );	

  // Clean input
  cleanInput := PublicRecords_KEL.ECL_Functions.Fn_CleanInput_Roxie( InputEcho );

  //Check to see if we should be running a test threatmetrix call
  Is_threatmetrix_test := exists(gateways(STD.STR.ToLowerCase(trim(servicename)) = 'threatmetrix_test'));

  //Put the threatmetrix_test service name back to the correct name
  Gateway.Layouts.Config gw_prep(Gateway.Layouts.Config le) := transform  
    self.servicename := map(STD.STR.ToLowerCase(trim(le.servicename)) = 'threatmetrix_test' => 'threatmetrix',
                                                                                               le.servicename);
    self := le;
  end;

  gateways_prep := project(gateways, gw_prep(left));

  //----------------------------------------------------------------------------
  // These settings are just for the Digital Insights project right now
  // Test runs will not provide a value for EventType
  // And Production runs will always be EventType = ACCOUNT_CREATION
  // IF this changes in the future, or other projects start using Threatmetrix,
  // will need to add additional logic here
  //----------------------------------------------------------------------------

  MechantID         := IF(Is_threatmetrix_test, 'LNRS_testMerchantID', 'LNRS_' + companyID);
  MerchantName      := IF(Is_threatmetrix_test, 'LNRS','LNRS');
  OrgId             := IF(Is_threatmetrix_test, '3pcswafw', '1gwz8sdd');
  ApiKey            := IF(Is_threatmetrix_test, 'mv7tckajjsddojys', '6kwspzdjvezpb5rj');
  Policy            := IF(Is_threatmetrix_test, 'FP_Digital Insights_test_v1', 'FP_Digital Insights_prod_v1');
  EventType         := IF(Is_threatmetrix_test, '', 'ACCOUNT_CREATION');
  NoPIIPersistence  := IF(Is_threatmetrix_test, True, False);
  DigitalIdReadOnly := IF(Is_threatmetrix_test, True, False);

  TMX_input := Risk_indicators.prep_for_TMX(cleanInput, MechantID, MerchantName, OrgId, ApiKey, Policy, EventType, NoPIIPersistence, DigitalIdReadOnly); //Don't have access to Merchent name so just passing in LNRS prefix for now

  TMX_results := Risk_Indicators.getThreatMetrix(TMX_input, gateways_prep );  

  with_TMX_results := join(InstantID_function_results, tmx_results, left.seq=right.seq,
    transform(risk_indicators.layout_output,	
      self.ThreatMetrix := right;
      self := left), left outer);

DRM_threatmetrix:= DataRestriction[Risk_indicators.iid_constants.IncludeDigitalIdentity]=Risk_indicators.iid_constants.sFalse;

//  For ThreatMetrix reasoncodes
with_TMX_model := if(DRM_threatmetrix, Models.IID1906_0_0(with_TMX_results), with_TMX_results);
 
	return group(with_TMX_model, seq);
	
end;
