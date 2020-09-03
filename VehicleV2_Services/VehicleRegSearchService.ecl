/*--SOAP--
<message name="VehicleRegSearchService" wuTimeout="300000">
  <part name = 'BDID' type = 'xsd:string'/>
  <part name = 'DID' type = 'xsd:string'/>
  <part name="DriversLicense" type = 'xsd:string' />
  <part name="ExcludeLessors" type='xsd:boolean'/>
  <part name="Tag" type = 'xsd:string' />
  <part name="UseTagBlur" type = 'xsd:boolean' />
  <part name="TitleNumber" type = 'xsd:string' />
  <part name="VIN" type = 'xsd:string' />
  <part name="VehicleKey" type="xsd:string"/>
  <part name="IterationKey" type="xsd:string"/>
  <part name="SequenceKey" type="xsd:string"/>
  <part name="SSN" type = 'xsd:string' />
  <part name="SSNMask" type = 'xsd:string' />
  <part name="UnParsedFullName" type="xsd:string"/>
  <part name="FirstName" type='xsd:string' />
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="MiddleName" type='xsd:string' />
  <part name="LastName" type = 'xsd:string' />
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="NameSuffix" type = 'xsd:string' />
  <part name="ProfessionSuffix" type = 'xsd:string' />
  <part name="CompanyName" type='xsd:string' />
  <part name="Addr" type='xsd:string' />
  <part name="City" type="xsd:string" />
  <part name="State" type='xsd:string' />
  <part name="Zip" type = 'xsd:string' />
  <part name="County" type="xsd:string"/>
  <part name="TitleIssueDate" type = 'xsd:string' />
  <part name="PreviousTitleIssueDate" type = 'xsd:string' />
  <part name="Year" type = 'xsd:string' />
  <part name="Make" type = 'xsd:string' />
  <part name="Model" type = 'xsd:string' />
  <part name="DataSource" type = 'xsd:string' />
  <part name="RealTimePermissibleUse" type = 'xsd:string' />
  <part name ="GLBPurpose" type = 'xsd:byte'/>
  <part name ="DPPAPurpose" type = 'xsd:byte'/>
  <part name ="DataRestrictionMask" type="xsd:string"/>
  <part name ="DataPermissionMask" type="xsd:string"/>

  <part name="PenaltThreshold" type="xsd:unsignedInt"/>
  <part name="MaxResults" type = 'xsd:unsignedInt' />
  <part name="MaxResultsThisTime" type = 'xsd:unsignedInt' />
  <part name="SkipRecords" type = 'xsd:unsignedInt' />
  <part name="NoDeepDive" type = 'xsd:boolean'/>
  <part name="DoCombined" type='xsd:boolean'/>
  <part name="includeDevelopedVehicles" type='xsd:boolean'/>
  <part name="IncludeCriminalIndicators" type='xsd:boolean'/>
  <part name="IncludeNonRegulatedVehicleSources" type='xsd:boolean'/>

  <part name="gateways" type="tns:XmlDataSet" cols="100" rows="6"/>

  <part name="MotorVehicleRegistrationSearchRequest" type="tns:XmlDataSet" cols="80" rows="20" />

</message>
*/
/*--INFO-- This service combines the results of the regular MVR search and searches across
all Vehicle datafiles including files used in MVR wildcard search to return results */
IMPORT iesp, Royalty;

EXPORT VehicleRegSearchService() := MACRO
  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  #CONSTANT('SearchIgnoresAddressOnly',TRUE);
  #CONSTANT('getBdidsbyExecutive',FALSE);
  #CONSTANT('DisplayMatchedParty',TRUE);

  ds_in := DATASET ([], iesp.motorvehicleRegistration.t_MotorVehicleRegistrationSearchRequest) : STORED ('MotorVehicleRegistrationSearchRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;
  iesp.ECL2ESP.SetInputBaseRequest(first_row);
  VehicleV2_Services.IParam.SetInputSearchByMVRRegistration(first_row.SearchBy);
  VehicleV2_Services.IParam.SetInputSearchOptionsMVRRegistration(first_row.Options);
  // passing in TRUE here to set noFail to true so that particular input sets
  // e.g. H1*11, PA don't fail in the experian gateway call
  // that takes place in this call: VehicleV2_Services.Get_VehicleReg_records
  // and so that Wildcard Search which is called after the regular MVR search in this query
  // is able to be run.
  //
  tempmod := VehicleV2_Services.IParam.getSearchModule(TRUE);
  BOOLEAN raw_records := FALSE : STORED('Raw');

  BOOLEAN returnIesp := COUNT(ds_in) > 0;

  getVehRegRecs := VehicleV2_Services.Get_VehicleReg_records(tempMod,returnIESP,raw_records);

  RegVeh := getVehRegRecs.RegVehRecsWildCardRegSearch;
  // project out boolean flag unacceptableInput (signaling bad input for mvr wildcard Search)
  // not needed in final RETURN results
  finalRegVeh := PROJECT(RegVeh, TRANSFORM(iesp.MotorVehicle.t_MotorVehicleSearch2Record,
                          SELF := LEFT));

  // this is with MVR WildCard search recs added to regular MVR search results
  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(FinalRegVeh, iespOutput, iesp.motorvehicleRegistration.t_MotorVehicleRegistrationSearchResponse);

  Royalty.RoyaltyVehicles.MAC_SearchSet(iespOutput.Records, ds_iesp_royalties, datasource);
  royalties := ds_iesp_royalties;

  // taking out the check of 'unacceptable' input flag
  // in order to by pass error codes returned from the
  // wildcard search (which just has state as input)
  // and not DL in this example.
  // minor Driver's license # and a state
  // bug # 178650
  // that way 0 results are returned to emulate functionality of MVR search
  // and not indicate a 'search too broad' error which would come from wildcard search
  // ******************
  //
  // this is the regVeh combined results after projecting out the unacceptableInput Flag

  OUTPUT(iespOutput, NAMED('Results'));
  OUTPUT(royalties, NAMED('RoyaltySet'));

ENDMACRO;
