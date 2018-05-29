/*--SOAP--
<message name="VehicleSearchService" 		wuTimeout="300000">
	<part name = 'BDID'						type = 'xsd:string'/>
	<part name = 'DID'						type = 'xsd:string'/>
	<part name="DriversLicense" 	type = 'xsd:string' />
	<part name="ExcludeLessors"		type='xsd:boolean'/>
	<part name="Tag" 							type = 'xsd:string' />
	<part name="UseTagBlur" 			type = 'xsd:boolean' />
	<part name="TitleNumber" 			type = 'xsd:string' />
	<part name="VIN" 							type = 'xsd:string' />
	<part name="VehicleKey" 			type="xsd:string"/>
	<part name="IterationKey" 		type="xsd:string"/>
	<part name="SequenceKey" 			type="xsd:string"/>
	<part name="SSN" 							type = 'xsd:string' />
	<part name="SSNMask" 					type = 'xsd:string' />
	<part name="UnParsedFullName" type="xsd:string"/>	
	<part name="FirstName" 				type='xsd:string' />
	<part name="AllowNickNames" 	type="xsd:boolean"/>
	<part name="MiddleName" 			type='xsd:string' />
	<part name="LastName" 				type = 'xsd:string' />
	<part name="PhoneticMatch" 		type="xsd:boolean"/>
	<part name="NameSuffix" 			type = 'xsd:string' />
	<part name="ProfessionSuffix" type = 'xsd:string' />
	<part name="CompanyName" 			type='xsd:string' />
	<part name="Addr" 						type='xsd:string' />
	<part name="City" 						type="xsd:string" />
	<part name="State" 						type='xsd:string' />
	<part name="Zip" 							type = 'xsd:string' />
	<part name="County" 					type="xsd:string"/>
	<part name="TitleIssueDate" 	type = 'xsd:string' />
	<part name="PreviousTitleIssueDate" 	type = 'xsd:string' />
	<part name="Year" 						type = 'xsd:string' />
	<part name="Make" 						type = 'xsd:string' />
	<part name="Model" 						type = 'xsd:string' />	
	<part name="DataSource" 			type = 'xsd:string' />
	<part name="RealTimePermissibleUse" 	type = 'xsd:string' />	
	<part name ="GLBPurpose"			type = 'xsd:byte'/>
	<part name ="DPPAPurpose"			type = 'xsd:byte'/>
	<part name ="DataRestrictionMask" type="xsd:string"/>
	<part name ="DataPermissionMask" type="xsd:string"/>

	<part name="PenaltThreshold" 	type="xsd:unsignedInt"/>
	<part name="MaxResults"  			type = 'xsd:unsignedInt' />
	<part name="MaxResultsThisTime" type = 'xsd:unsignedInt' />
	<part name="SkipRecords" 			type = 'xsd:unsignedInt' />
	<part name="NoDeepDive"				type = 'xsd:boolean'/>
	<part name="DoCombined" 			type='xsd:boolean'/>
	<part name="insuranceUsage"	  type='xsd:boolean'/>
	<part name="authenticationUsage" type='xsd:boolean'/>
	<part name="includeDevelopedVehicles" type='xsd:boolean'/>
	<part name="IncludeCriminalIndicators" type='xsd:boolean'/>
	<part name="IncludeNonRegulatedVehicleSources" type='xsd:boolean'/>
	<part name="multiFamilyDwelling" type='xsd:boolean'/>
	<part name="RegistrationType" type="xsd:unsignedInt"/>

	<part name="gateways" 				type="tns:XmlDataSet" cols="100" rows="6"/>
	
	<part name="MotorVehicleSearch2Request" type="tns:XmlDataSet" cols="80" rows="20" />
	
</message>
*/
/*--INFO-- This service searches all Vehicle datafiles.*/

IMPORT iesp, Royalty;

EXPORT VehicleSearchService() := MACRO

 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
	#constant('SearchIgnoresAddressOnly',true);
	#constant('getBdidsbyExecutive',FALSE);
	#constant('DisplayMatchedParty',true);
	
	ds_in := DATASET ([], iesp.motorvehicle.t_MotorVehicleSearch2Request) : STORED ('MotorVehicleSearch2Request', FEW);
	first_row := ds_in[1] : INDEPENDENT;
	iesp.ECL2ESP.SetInputBaseRequest(first_row);	
	VehicleV2_Services.IParam.SetInputSearchBy(first_row.SearchBy);
	VehicleV2_Services.IParam.SetInputSearchOptions(first_row.Options);
	
	tempmod := VehicleV2_Services.IParam.getSearchModule();

	boolean returnIesp := COUNT(ds_in) > 0;
	
	getVehRecs := VehicleV2_Services.Get_Vehicle_Records(tempmod,returnIesp);

	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(getVehRecs.iespResults, iespOutput, iesp.motorvehicle.t_MotorVehicleSearch2Response);

	Rec_cnt := IF(returnIesp, 0, IF(getVehRecs.truncated,getVehRecs.trunc_cnt,COUNT(CHOOSEN(getVehRecs.sorted_vehs,tempmod.maxresultsVal))));
	
	IF(~returnIesp, OUTPUT(rec_cnt,NAMED('RecordsAvailable')));
	
	Royalty.RoyaltyVehicles.MAC_SearchSet(getVehRecs.marshalledRecs, ds_royalties, datasource);
	Royalty.RoyaltyVehicles.MAC_SearchSet(iespOutput.Records, ds_iesp_royalties, datasource);	
	royalties := IF(returnIesp, ds_iesp_royalties, ds_royalties);

	/* THIS OUTPUT SEQUENCE SHOULD NEVER BE CHANGED.  THE INTENT IS TO SUPPORT BOTH OUTPUT 
	    // FORMATS - ESDL and non-ESDL */	
	OUTPUT(iespOutput, NAMED('MotorVehicleSearch2Response'));	
	OUTPUT(getVehRecs.marshalledRecs, NAMED('Results'));
	OUTPUT(royalties, NAMED('RoyaltySet'));

ENDMACRO;
//VehicleV2_Services.VehicleSearchService();
/*
<MotorVehicleSearch2Request>  
<row> 
<User>
  <GLBPurpose>1</GLBPurpose>
  <DLPurpose>1</DLPurpose>
  <DataRestrictionMask>000000000000000000</DataRestrictionMask>
  <EndUser/>
</User>

<Options>
  <ReturnCount>10</ReturnCount>
  <StartingRecord>1</StartingRecord>
  <DataSource>ALL</DataSource>
  <RealTimePermissibleUse>GOVERNMENT</RealTimePermissibleUse>
  <doCombined>true</doCombined>
  <IncludeNonRegulatedVehicleSources>false</IncludeNonRegulatedVehicleSources>
</Options>

<SearchBy>
  <Name>
    <Last>THE LAST NAME</Last>
  </Name>
  <Address>
    <StreetAddress1>THE STREET ADDRESS</StreetAddress1>
    <City>CITY NAME</City>
    <State>STATE</State>
    <Zip5>11111</Zip5>
  </Address>
	<vin></vin>
	<ssn></ssn>
	<YearMake></YearMake>
	<Make></Make>
	<Model></Model>
	<TagNumber></TagNumber>
	<SSN></SSN>
	<DriverLicenseNumber></DriverLicenseNumber>
	<CompanyName></CompanyName>
	<TitleNumber></TitleNumber>
	<TitleIssueDate></TitleIssueDate>
	<PreTitleIssueDate></PreTitleIssueDate>
	<ExcludeLessors></ExcludeLessors>
	<UniqueId></UniqueId>
	<VehicleKey></VehicleKey>
	<IterationKey></IterationKey>
	<SequenceKey></SequenceKey>
</SearchBy>
</row>
</MotorVehicleSearch2Request>
*/