/*--SOAP--
<message name="RealTime_Batch_Service_V2">
<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="DPPAPurpose" type="xsd:byte" default="1"/>
  <part name="GLBPurpose" type="xsd:byte" default="1"/>
	<part name="ApplicationType" type="xsd:string"/>
	<part name="RealTimePermissibleUse" type="xsd:string" default="LAWENFORCEMENT"/> 
	<part name="Operation" type="xsd:unsignedInt"/> 
  <part name="gateways" type="tns:XmlDataSet" cols="90" rows="6"/>
  
  // for Vin and Licplate Batch Services
	<part name="ReturnCurrent" type="xsd:boolean"/>
	<part name="Run_Deep_Dive" type="xsd:boolean"/>
	<part name="PenaltThreshold" type="xsd:unsignedInt"/>
	<part name="IncludeNonRegulatedVehicleSources" type="xsd:boolean"/>
  
  // for best info function
	<part name="Appends" type="xsd:string"/>
  <part name="Verify" type="xsd:string"/>
  <part name="Fuzzies" type="xsd:string"/>
  <part name="Deduped" type="xsd:boolean"/>
  <part name="AppendThreshold" type="xsd:string"/>
  <part name="PatriotProcess" type="xsd:boolean"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="IncludeMinors" type="xsd:boolean"/>
  <part name="IndustryClass" type="xsd:string"/>
  
  // for this service
	<part name="UseDate" type="xsd:boolean"/>
	<part name="SelectYears" type="xsd:boolean"/>
	<part name="NumberOfYears" type="xsd:unsignedInt"/>
	<part name="IncludeSSN" type="xsd:boolean"/>
	<part name="IncludeDOB" type="xsd:boolean"/>
	<part name="IncludeAddress" type="xsd:boolean"/>
	<part name="IncludePhone" type="xsd:boolean"/>
	<part name="GatewayNameMatch" type="xsd:boolean"/>
  <part name="ReturnDetailedRoyalties" type="xsd:boolean"/>	
  <part name="IncludeRanking" type="xsd:boolean"/>
  <part name="GetSSNBest" type="xsd:boolean"/>
	<part name="BIPFetchLevel" type="xsd:string"/>
</message>
*/

/*--INFO-- Real-Time Motor Vehicle Batch via Polk or Experian gateways including In-House data<br>

<table border="1">
<tr><th>Operation:</th><td>Default/0=Search by Name and Address</td><td>1=Search by VIN</td><td>2=Search by Plate and State</td></tr>
<tr><th>Return Current:</th><td>Default/False=Historical and current registrations will be returned.</td><td>True=Most current registration based on Expiration Date will be returned</td></tr>
<tr><th>GatewayNameMatch:</th><td>Default/False=All vehicles returned from the gateway will be returned</td><td>True=Only vehicles from the gateway with a Name and Address match will be returned</td></tr>
<tr><th>Use Date:</th><td>Default/False=No Filtering</td><td>True=Determines who the vehicle was registered to during that time using Date</td></tr>
<tr><th>Select Years :</th><td>Default/False=No Filtering</td><td>True=Search records from # of years specified to current date</td></tr>
</table>
*/

IMPORT address, doxie, AutoStandardI, Royalty, VehicleV2_Services;

EXPORT RealTime_Batch_Service_V2 := MACRO
  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  inputData := DATASET([], VehicleV2_Services.Batch_Layout.RealTime_InLayout_V2) : STORED('batch_in',FEW);
  
  STRING1 sBIPFetchLevel := BIPV2.IDconstants.Fetch_Level_SELEID : STORED('BIPFetchLevel');
  
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());

  //Note, some fields have default values dIFferent from mod_access.
  mod := MODULE(VehicleV2_Services.IParam.RTBatch_V2_params)
    EXPORT UNSIGNED1 Operation := 0 : STORED('Operation');
    EXPORT BOOLEAN use_date := FALSE : STORED('usedate');
    EXPORT BOOLEAN select_years := FALSE : STORED('selectyears');
    EXPORT UNSIGNED years := 0 : STORED('numberofyears');
    EXPORT BOOLEAN include_ssn := FALSE : STORED('includeSSN');
    EXPORT BOOLEAN include_dob := FALSE : STORED('includeDOB');
    EXPORT BOOLEAN include_addr := FALSE : STORED('includeAddress');
    EXPORT BOOLEAN include_phone := FALSE : STORED('includePhone');
    EXPORT STRING120 append_l := '' : STORED('Appends');
    EXPORT STRING120 verify_l := '' : STORED('Verify');
    EXPORT STRING120 fuzzy_l := '' : STORED('Fuzzies');
    EXPORT BOOLEAN DEDUP_results_l := TRUE : STORED('Deduped');
    EXPORT STRING3 thresh_val := '' : STORED('AppendThreshold');
    EXPORT UNSIGNED1 glb := 8 : STORED('glbpurpose');
    EXPORT UNSIGNED1 dppa := mod_access.dppa;
    EXPORT BOOLEAN patriotproc := FALSE : STORED('PatriotProcess');
    EXPORT BOOLEAN show_minors := FALSE : STORED('IncludeMinors');
    // 127542 - GatewayNameMatch option works only for gateways - It filters
    //by person's name who owns the vehicle at input address.
    EXPORT BOOLEAN GatewayNameMatch := FALSE : STORED('GatewayNameMatch');
    EXPORT BOOLEAN AlwaysHitGateway := ~doxie.compliance.use_Polk(mod_access.DataPermissionMask);
    EXPORT BOOLEAN ReturnCurrent := FALSE : STORED('ReturnCurrent');
    EXPORT BOOLEAN FullNameMatch := FALSE : STORED('FullNameMatch');
    EXPORT STRING32 application_type := mod_access.application_type;
    EXPORT STRING5 industry_class := mod_access.industry_class;
    EXPORT STRING DataRestrictionMask := mod_access.DataRestrictionMask;
    EXPORT BOOLEAN Is_UseDate := use_date;
    EXPORT BOOLEAN IncludeRanking := FALSE : STORED('IncludeRanking');
    //unlike other services, we purposely set GetSSNBest to false by default
    //since batch will send in TRUE only for their government verticals
    EXPORT BOOLEAN GetSSNBest := FALSE : STORED('GetSSNBest');
    EXPORT STRING1 BIPFetchLevel := STD.Str.touppercase(sBIPFetchLevel);
  END;
  
  recs := VehicleV2_Services.RealTime_Batch_Service_V2_records(inputdata, mod, TRUE);
  
  returnDetailedRoyalties := FALSE : STORED('ReturnDetailedRoyalties');
  Royalty.RoyaltyVehicles.MAC_Append(recs, results, vin, hit_flag, TRUE);
  Royalty.RoyaltyVehicles.MAC_BatchSet(results, royalties,,returnDetailedRoyalties);
  
  OUTPUT(results, NAMED('Results'));
  OUTPUT(royalties,NAMED('RoyaltySet'));

ENDMACRO;
// RealTime_Batch_Service_V2()
