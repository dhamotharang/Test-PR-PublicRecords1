/*--SOAP--
<message name="FAP_StateWide_SearchService" wuTimeout="300000">
	<part name="GLBPurpose"      type="xsd:byte" />
	<part name="DPPAPurpose"     type="xsd:byte" />
	<part name="ApplicationType"     	type="xsd:string"/>

  <part name="LastName"        type="xsd:string" />
	<part name="FirstName"       type="xsd:string" />
	<part name="MiddleName"      type="xsd:string" />
	<part name="PhoneticMatch"   type="xsd:boolean" />
	<part name="AllowNickNames"   type="xsd:boolean" />
	
	<part name="Addr"            type="xsd:string" />
	<part name="City"            type="xsd:string" />
	<part name="State"           type="xsd:string" />
	<part name="County"          type="xsd:string" />
	<part name="Zip"             type="xsd:unsignedInt" />
	<part name="ZipRadius"       type="xsd:unsignedInt" />
	<part name="phone"           type="xsd:string" />
	
	<part name="SSN" type="xsd:string"/>	
	<part name="SSNMask" type="xsd:string"/>
	
	<part name="DOB" type="xsd:unsignedInt"/>	
	<part name="AgeLow" type="xsd:unsignedInt"/>
	<part name="AgeHigh" type="xsd:unsignedInt"/>

	<part name="ParcelID"						type="xsd:string"/>
	
	<part name="AdditionalTerms" type="xsd:string" />
	
	<part name="TwoPartySearch"          type="xsd:boolean"/>
	<part name="Entity2_DID" 								type="xsd:string"/>
	<part name="Entity2_BDID" 							type="xsd:string"/>
	<part name="Entity2_CompanyName" 				type="xsd:string"/>
	<part name="Entity2_SSN"								type="xsd:string"/>
	<part name="Entity2_UnParsedFullName" 	type="xsd:string"/>
	<part name="Entity2_FirstName"   				type="xsd:string"/>
	<part name="Entity2_MiddleName"  				type="xsd:string"/>
	<part name="Entity2_LastName"    				type="xsd:string"/>
	<part name="Entity2_Addr"	       				type="xsd:string"/>
	<part name="Entity2_City"        				type="xsd:string"/>
	<part name="Entity2_State"       				type="xsd:string"/>
	<part name="Entity2_Zip"         				type="xsd:string"/>
	<part name="Entity2_County"             type="xsd:string"/>
	<part name="Entity2_AllowNickNames" 		type="xsd:boolean"/>
	<part name="Entity2_PhoneticMatch"  		type="xsd:boolean"/>
	<part name="Entity2_ZipRadius"  				type="xsd:unsignedInt"/>
	<part name="Entity2_phone"           		type="xsd:string" />
		
	<part name="Jurisdiction"    type="xsd:string"/>
	
  <part name="PenaltThreshold"      type="xsd:unsignedInt"/>
	<part name="SelectIndividually" type="xsd:boolean"/>
	<part name="NewStyle" type="xsd:boolean"/>
	<part name="IncludeVoters" type="xsd:boolean"/>
	<part name="IncludeUCC" type="xsd:boolean"/>
	<part name="IncludeProperty" type="xsd:boolean"/>
	<part name="IncludeHunting" type="xsd:boolean"/>
	<part name="IncludeHuntingFishingLicenses" type="xsd:boolean"/>
	<part name="IncludeProfessionalLicenses" type="xsd:boolean"/>
	<part name="IncludeSanctions" type="xsd:boolean"/>
	<part name="IncludeProviders" type="xsd:boolean"/>
	<part name="IncludeBankruptcy" type="xsd:boolean"/>
	<part name="IncludeLiens" type="xsd:boolean"/>
	<part name="IncludeMarriageDivorce" type="xsd:boolean"/>
	<part name="IncludeDeath" type="xsd:boolean"/>
	<part name="IncludeDriverLicenses" type="xsd:boolean"/>
	<part name="IncludeWatercraft" type="xsd:boolean"/>
	<part name="IncludeVehicles" type="xsd:boolean"/>
	<part name="IncludeEquifax" type="xsd:boolean"/>
	<part name="IncludePersonLocator1" type="xsd:boolean"/>
	<part name="IncludePersonLocator5" type="xsd:boolean"/>
  <part name="IncludePersonLocator6" type="xsd:boolean"/>
	<part name="IncludeCriminalRecords" type="xsd:boolean"/>
	<part name="IncludeWhitePages"    type="xsd:boolean"/>
	<part name="IncludeTargus"        type="xsd:boolean"/>
	<part name="KeepOldSSNs"          type="xsd:boolean"/>
	<part name="NoDeepDive"           type="xsd:boolean"/>
	<part name="LnBranded"					  type="xsd:boolean"/>
	<part name="DataRestrictionMask"  type="xsd:string"/>
	<part name="DataPermissionMask"  type="xsd:string"/>
  <part name="MaxResults"           type="xsd:unsignedInt" />
  <part name="MaxResultsThisTime"   type="xsd:unsignedInt" />
  <part name="SkipRecords"          type="xsd:unsignedInt" />	
	<part name="StrictMatch"		      type="xsd:boolean"/>

	// Enhancement/Bug: 64514
	<part name="MatchByBuyerAddresses"    type="xsd:boolean"/> 
  <part name="MatchByMailingAddresses"  type="xsd:boolean"/> 
  <part name="MatchByOwnerAddresses"    type="xsd:boolean"/> 
  <part name="MatchByPropertyAddresses" type="xsd:boolean"/> 
  <part name="MatchBySellerAddresses"   type="xsd:boolean"/> 

	<part name="PartyTypeBK" type="xsd:string"/>
</message>
*/
/*--INFO-- FAP StateWide Service.
IF Jurisdiction not specified,
Returns Results from all the available Jurisdiction.
*/


import AutoStandardI, FAP_StateWide, Doxie;

EXPORT FAP_SearchService := MACRO
#CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
#onwarning(4207, ignore);

#OPTION ('optimizeProjects', FALSE);
#CONSTANT('UsingKeepSSNs',TRUE);
#STORED('PenaltThreshold', 10);

	unsigned8	MaxResults_val					:= 2000		: stored('MaxResults');
	unsigned8	MaxResultsThisTime_val	:= 2000		: stored('MaxResultsThisTime');
	unsigned8	SkipRecords_val					:= 0			: stored('SkipRecords');
	unsigned2  pt	:= AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));

out_set := MODULE(Statewide_Services.layout_FAB_FAP_out.output_set)END;

OP := FAP_StateWide.FAPSearchService_ids(out_set).search_result()(penalt<= pt or isDeepDive);
doxie.MAC_Marshall_Results(OP,result);
OUTPUT(result,NAMED('Results'));

ENDMACRO;
//FAP_SearchService()