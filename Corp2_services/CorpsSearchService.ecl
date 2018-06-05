/*--SOAP--
<message name="CorpSearch" wuTimeout="300000">
	<part name="BDID"                    type="xsd:string"/>
	<part name="DID"                     type="xsd:string"/>
	<part name="CorpKey"                 type="xsd:string"/>
  <part name="UnParsedFullName"        type="xsd:string"/>	
	<part name="FirstName"               type="xsd:string"/>
	<part name="MiddleName"              type="xsd:string"/>
	<part name="LastName"                type="xsd:string"/>
	<part name="AllowNicknames"          type="xsd:boolean"/>
	<part name="PhoneticMatch"           type="xsd:boolean"/>
	<part name="CompanyName"             type="xsd:string"/>
	<part name="CharterNumber"           type="xsd:string"/>
  <part name="FilingJurisdiction"	     type="xsd:string"/>	
	<part name="FEIN"                    type="xsd:string"/>
	<part name="Addr"                    type="xsd:string"/>
	<part name="City"                    type="xsd:string"/>
	<part name="State"                   type="xsd:string"/>
  <part name="County"                  type="xsd:string"/>
	<part name="Zip"                     type="xsd:string"/>
  <part name="ZipRadius"               type="xsd:unsignedInt"/>
	<part name="Phone"                   type="xsd:string"/>

	<part name="TwoPartySearch"             type="xsd:boolean"/>
  <part name="Entity2_DID" 								type="xsd:string"/>
  <part name="Entity2_BDID" 							type="xsd:string"/>
  <part name="Entity2_CompanyName" 				type="xsd:string"/>
  <part name='Entity2_SSN'								type='xsd:string'/>
	<part name="Entity2_UnParsedFullName" 	type="xsd:string"/>
  <part name="Entity2_FirstName"   				type="xsd:string"/>
  <part name="Entity2_MiddleName"  				type="xsd:string"/>
  <part name="Entity2_LastName"    				type="xsd:string"/>
  <part name="Entity2_Addr"	       				type="xsd:string"/>
  <part name="Entity2_City"        				type="xsd:string"/>
  <part name="Entity2_State"       				type="xsd:string"/>
  <part name="Entity2_Zip"         				type="xsd:string"/>
  <part name="Entity2_County"             type="xsd:string"/>
  <part name="Entity2_FEIN"		  					type="xsd:string"/>
  <part name="Entity2_AllowNickNames" 		type="xsd:boolean"/>
  <part name="Entity2_PhoneticMatch"  		type="xsd:boolean"/>
  <part name="Entity2_ZipRadius"  				type="xsd:unsignedInt"/>

  <part name="NoDeepDive"              type="xsd:boolean"/>
  <part name="SimplifiedContactReturn" type="xsd:boolean"/> <!-- Defunct? -->
	<part name="LatestForMAs"            type="xsd:boolean"/>
	<part name="GLBPurpose"	             type="xsd:byte"/>
	<part name="DPPAPurpose"             type="xsd:byte"/>
	<part name="ApplicationType"     	type="xsd:string"/>
  <part name="PenaltThreshold"         type="xsd:unsignedInt"/>
	<part name="MaxResults"              type="xsd:unsignedInt"/>
	<part name="MaxResultsThisTime"      type="xsd:unsignedInt"/>
	<part name="SkipRecords"             type="xsd:unsignedInt"/>
  <part name="ReturnHashes"            type="xsd:boolean"/>
  <part name="srch_hashvals"           type="tns:XmlDataSet" cols="70" rows="3"/>
	<part name="StrictMatch"             type="xsd:boolean"/>
	<part name="OnlyCurrentLegal"        type="xsd:boolean"/>
	<part name="SearchRegisteredAgents"  type="xsd:boolean"/> <!-- PRMA? May be True. Accurint? Always False. -->
</message>
*/
/*--INFO-- This service searches all Corp datafiles.*/

export CorpsSearchService := macro

 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	#constant('SearchGoodSSNOnly',true);
	#constant('SearchIgnoresAddressOnly',true);
	#constant('getBdidsbyExecutive',FALSE);
	#Constant('SetRepAddr',TRUE);
	#stored('SetRepAddrBit',4);


	// output(corp2_services.CorpSearch, named('Results'));

	recs := corp2_services.CorpSearch(isCorpSearchService := TRUE);


orec := record 
   RECORDOF(recs);
   Text_Search.Layout_ExternalKey;
END;
orec addExt ( recs l) := transform
  self := l;
	self.ExternalKey := l.corp_key;
end;
recs2 := project(recs, addext(left));



	doxie.MAC_Header_Field_Declare()
	doxie.MAC_Marshall_Results(recs2, recs_marshalled);

	OUTPUT(recs_marshalled, NAMED('Results'));

endmacro;
