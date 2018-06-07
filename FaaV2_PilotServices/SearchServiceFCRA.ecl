/*--SOAP--
<message name="SearchServiceFCRA">
  <part name="did"                 type="xsd:string"/>
  <part name="gateways" type="tns:XmlDataSet" cols="70" rows="4"/>
  <part name="FcraPilotSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Returns FAA Pilot Search records.*/

// so in general approach is 
// 1.  define input attrs from interfaces or via direct call to :STORED
// 2.  using input attrs get ids
// 3. filter ids
// 4. pentalize based on record etc in order to filter more
// 4.5 filter out pentalties that are larger than CERTAIN VALUE.
// 5. dedup.
// 6. format results
// 7. return results.

import FaaV2_PilotServices, iesp, AutoStandardI, fcra, FFD;

export SearchServiceFCRA := macro
  #onwarning(4207, ignore);
  #constant('NoDeepDive', true);
  
  rec_in := iesp.faapilot_fcra.t_FCRAPilotSearchRequest;
  // "FEW" keyword set to make data read more efficient
  ds_in := DATASET ([], rec_in) : STORED ('FcraPilotSearchRequest', FEW);
  // "independent" keyword used here to make statement atomic and a signal to 
  // code generator to not combine it with other lines of code.
  first_row := ds_in[1] : independent;
  //set options
  search_by := global (first_row.SearchBy);
  
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);
  
  #constant ('PenaltThreshold', 10);
  iesp.ECL2ESP.SetInputReportBy(row(first_row.searchby,transform(iesp.bpsreport.t_BpsReportBy,self:=left,self:=[])));
  iesp.ECL2ESP.SetInputSearchOptions (first_row.options);
  
  //soap call for remote DIDs
  //------------------------------------------------------------------------------------
  //Hack to skip a soapcall if DID is the input and just DID info was requested.
 // If we don't pass in the DID here, soapcall will be executed regardless due to a platform bug.
  FCRA.MAC_GetPickListRecords (ds_in, res_esdl);
  //------------------------------------------------------------------------------------

  rdid := res_esdl[1].Records[1].UniqueId;
  
  input_params := AutoStandardI.GlobalModule(true);
  tempmod := module(project(input_params,FaaV2_PilotServices.SearchService_Records.params,opt))
    export string14 did := rdid;
    export string32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
    export integer8 FFDOptionsMask := FFD.FFDMask.Get(first_row.options.FFDOptionsMask);
    export integer FCRAPurpose := FCRA.FCRAPurpose.Get(first_row.options.FCRAPurpose);
  end;
  
	input_consumer := FFD.MAC.PrepareConsumerRecord(rdid, true, search_by);

  pilot_res := FaaV2_PilotServices.SearchService_Records.fcra_val(tempmod); 
   
  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(pilot_res.Records, results, iesp.faapilot_fcra.t_fcraPilotSearchResponse);
     
  FFD.MAC.AppendConsumerAlertsAndStatements(results, results_out, pilot_res.Statements, pilot_res.ConsumerAlerts, input_consumer, iesp.faapilot_fcra.t_fcraPilotSearchResponse);                                               
   
  output(results_out, named('Results'));      
  
endmacro;

// SearchServiceFCRA ();

/*
<PilotSearchRequest>
<row>
<User>
  <ReferenceCode></ReferenceCode>
  <BillingCode></BillingCode>
  <QueryId></QueryId>
  <GLBPurpose></GLBPurpose>
  <DLPurpose></DLPurpose>
  <EndUser>
    <CompanyName></CompanyName>
    <StreetAddress1></StreetAddress1>
    <City></City>
    <State></State>
    <Zip5></Zip5>
  </EndUser>
  <MaxWaitSeconds></MaxWaitSeconds>
</User>

<SearchBy>
  <Name>
    <Full></Full>
    <First></First>
    <Middle></Middle>
    <Last></Last>
    <Suffix></Suffix>
    <Prefix></Prefix>
  </Name>
  <Address>
    <StreetName></StreetName>
    <StreetNumber></StreetNumber>
    <StreetPreDirection></StreetPreDirection>
    <StreetPostDirection></StreetPostDirection>
    <StreetSuffix></StreetSuffix>
    <UnitDesignation></UnitDesignation>
    <UnitNumber></UnitNumber>
    <StreetAddress1></StreetAddress1>
    <StreetAddress2></StreetAddress2>
    <State></State>
    <City></City>
    <Zip5></Zip5>
    <Zip4></Zip4>
    <County></County>
    <PostalCode></PostalCode>
    <StateCityZip></StateCityZip>
  </Address>
</SearchBy>
<Options>
  <ReturnCount>10</ReturnCount>
  <StartingRecord>1</StartingRecord>
  <UseNicknames>1</UseNicknames>
  <IncludeAlsoFound>0</IncludeAlsoFound>
  <UsePhonetics>0</UsePhonetics>
  <StrictMatch>0</StrictMatch>
</Options>
</row>
</PilotSearchRequest>
*/