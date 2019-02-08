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
  <part name="GLBData" type="xsd:boolean"/>
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
<tr><th>Select Years :</th><td>Default/False=No Filterting</td><td>True=Search records from # of years specified to current date</td></tr>
</table>
*/

import address, autokey_batch, doxie, DidVille, ut, risk_indicators, AutoStandardI, Royalty, VehicleV2_Services;

export RealTime_Batch_Service_V2 := macro
 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	inputData := DATASET([], VehicleV2_Services.Batch_Layout.RealTime_InLayout_V2) : STORED('batch_in',FEW);
	
	STRING1 sBIPFetchLevel := BIPV2.IDconstants.Fetch_Level_SELEID	 : STORED('BIPFetchLevel');
	
	mod := module(VehicleV2_Services.IParam.RTBatch_V2_params)
		export unsigned1 Operation           := 0     : stored('Operation');
		export boolean   use_date            := false : stored('usedate');
		export boolean   select_years        := false : stored('selectyears');
		export unsigned  years               := 0     : stored('numberofyears');
		export boolean   include_ssn         := false : stored('includeSSN');
		export boolean   include_dob         := false : stored('includeDOB');
		export boolean   include_addr        := false : stored('includeAddress');
		export boolean   include_phone       := false : stored('includePhone');
		export string120 append_l            := '' 		: stored('Appends');
		export string120 verify_l            := '' 		: stored('Verify');
		export string120 fuzzy_l             := '' 		: stored('Fuzzies');
		export boolean   dedup_results_l     := true 	: stored('Deduped');
		export string3   thresh_val          := '' 		: stored('AppendThreshold');
		export boolean   GLB_data            := false : stored('GLBData');
		export unsigned1 glb_purpose_value   := 8     : stored('glbpurpose');
	  export unsigned1 dppa_purpose_value  := 0     : stored('dppapurpose');
		export boolean   patriotproc         := false : stored('PatriotProcess');
		export boolean   include_minors      := false : stored('IncludeMinors');
		// 127542 - GatewayNameMatch option works only for gateways - It filters
		//by person's name who owns the vehicle at input address.
		export boolean   GatewayNameMatch    := false : stored('GatewayNameMatch');
	  export boolean   AlwaysHitGateway    := ~doxie.DataPermission.use_Polk;
		export boolean   ReturnCurrent	     := false : stored('ReturnCurrent');
		export boolean   FullNameMatch       := false : stored('FullNameMatch');
		export string32  ApplicationType	   := AutoStandardI.InterfaceTranslator.application_type_val.val(
		                                        project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
		export string5   IndustryClass       := AutoStandardI.InterfaceTranslator.industry_class_val.val(
																						project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.industry_class_val.params));
		export string50  DataRestriction     := doxie.DataRestriction.fixed_DRM;
		export boolean   Is_UseDate          := use_date;
		export boolean   IncludeRanking  	   := false : stored('IncludeRanking');
		//unlike other services, we purposely set GetSSNBest to false by default
		//since batch will send in TRUE only for their government verticals
		export boolean   GetSSNBest          := false : stored('GetSSNBest');
		export string1 	 BIPFetchLevel  		 := STD.Str.touppercase(sBIPFetchLevel);
	end;
	
	recs := VehicleV2_Services.RealTime_Batch_Service_V2_records(inputdata, mod, true);		
	
	returnDetailedRoyalties	:= false : stored('ReturnDetailedRoyalties');	
	Royalty.RoyaltyVehicles.MAC_Append(recs, results, vin, hit_flag, true);	
	Royalty.RoyaltyVehicles.MAC_BatchSet(results, royalties,,returnDetailedRoyalties);	
	
	output(results, named('Results'));
	output(royalties,named('RoyaltySet'));

endmacro;
// RealTime_Batch_Service_V2()