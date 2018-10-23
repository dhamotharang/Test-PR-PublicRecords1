/*--SOAP--
<message name="BankruptcySearchService">
	<!-- Indexed Directly -->
  <part name="TMSID" 							type="xsd:string"/>
  <part name="BDID" 							type="xsd:string"/>
  <part name="DID" 								type="xsd:string"/>

	<!-- Indexed by Autokey -->
	<part name="PartyType"          type="xsd:string"/>
  <part name="CompanyName" 				type="xsd:string"/>
	<part name="UnParsedFullName" 	type="xsd:string"/>
  <part name="FirstName"   				type="xsd:string"/>
  <part name="MiddleName"  				type="xsd:string"/>
  <part name="LastName"    				type="xsd:string"/>
  <part name="Addr"	       				type="xsd:string"/>
  <part name="City"        				type="xsd:string"/>
  <part name="State"       				type="xsd:string"/>
  <part name="Zip"         				type="xsd:string"/>
  <part name="County"           	type="xsd:string"/>
  <part name='SSN'								type='xsd:string'/>
  <part name="FEIN"		  					type="xsd:string"/>
	
	<!-- CaseNumber -->
	<part name="CaseNumber"         type="xsd:string"/>
	
  <part name="FilingJurisdiction"	type='xsd:string'/>	
	
  <part name="PenaltThreshold"		type="xsd:unsignedInt"/>
	
  <part name="DPPAPurpose" 				type="xsd:byte"/>
  <part name="GLBPurpose" 				type="xsd:byte"/>
  <part name="SSNMask"						type="xsd:string"/>
	<part name="ApplicationType"   	type="xsd:string"/>
	
  <part name="AllowNickNames" 		type="xsd:boolean"/>
  <part name="PhoneticMatch"  		type="xsd:boolean"/>
  <part name="NoDeepDive" 				type="xsd:boolean"/>
  <part name="ZipRadius"  				type="xsd:unsignedInt"/>
  <part name="MaxResults"  				type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" 				type="xsd:unsignedInt"/>
  <part name="ReturnHashes" type="xsd:boolean"/>
  <part name="srch_hashvals" type="tns:XmlDataSet" cols="70" rows="3"/>
	<part name="StrictMatch"		type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service searches the Bankruptcyv3 files.*/

import doxie, text_search, WSInput;

export BankruptcySearchService(
	) :=
		macro
  #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
    //The following macro defines the field sequence on WsECL page of query.
		WSInput.MAC_BankruptcyV3_Services_BankruptcySearchService();  		
		
		doxie.MAC_Header_Field_Declare();
		#constant('SearchIgnoresAddressOnly',true);
		#stored('ScoreThreshold',10);
		#stored('PenaltThreshold',10);
		#constant('DisplayMatchedParty',true);

		recs	 := bankruptcyv3_Services.bankruptcy_raw().search_view(in_ssn_mask := ssn_mask_value,
																														 in_party_type := Party_Type, 
																														 in_filing_jurisdiction := FilingJurisdiction_value);
		
		orec := record 
      RECORDOF(recs);
      Text_Search.Layout_ExternalKey;
    END;
    orec addExt ( recs l) := transform
      self := l;
    	self.ExternalKey := l.TMSID;
    end;
    recs2 := project(recs, addext(left));
		
		doxie.MAC_Marshall_Results(recs2, recs_marshalled);

		OUTPUT(recs_marshalled, NAMED('Results'));			
		endmacro;
