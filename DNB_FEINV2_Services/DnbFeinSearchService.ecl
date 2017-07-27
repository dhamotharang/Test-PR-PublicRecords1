/*--SOAP--
<message name="DnbFeinSearchService">
	<!-- Indexed Directly -->
  <part name="TMSID" 							type="xsd:string"/>
  <part name="BDID" 							type="xsd:string"/>

	<!-- Indexed by Autokey -->
  <part name="CompanyName" 				type="xsd:string"/>
  <part name="Addr"	       				type="xsd:string"/>
  <part name="City"        				type="xsd:string"/>
  <part name="State"       				type="xsd:string"/>
  <part name="Zip"         				type="xsd:string"/>
  <part name="County"             type="xsd:string"/>
  <part name="FEIN"		  					type="xsd:string"/>
	
  <part name="PenaltThreshold"		type="xsd:unsignedInt"/>
	
  <part name="DPPAPurpose" 				type="xsd:byte"/>
  <part name="GLBPurpose" 				type="xsd:byte"/>
	
  <part name="NoDeepDive" 				type="xsd:boolean"/>
  <part name="ZipRadius"  				type="xsd:unsignedInt"/>
  <part name="MaxResults"  				type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" 				type="xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This service searches the DNB FEINv2 files.*/

export DnbFeinSearchService(
	) :=
		macro
		#constant('SearchIgnoresAddressOnly',true)
		#stored('ScoreThreshold',10)
		#stored('PenaltThreshold',10)

		rpen := DNB_FEINv2_Services.raw.search_view();
		Text_Search.MAC_Append_ExternalKey(rpen, rpen2, l.tmsid);
		output(
			rpen2,
			named('Results'));
		endmacro;
