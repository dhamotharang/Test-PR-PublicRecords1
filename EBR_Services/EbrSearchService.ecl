/*--SOAP--
<message name="EbrSearchService">
  <part name="BDID" 							type="xsd:string"/>
  <part name="CompanyName" 				type="xsd:string"/>
  <part name="ExactOnly"   				type="xsd:boolean"/>
  <part name="Addr"	       				type="xsd:string"/>
  <part name="City"        				type="xsd:string"/>
  <part name="State"       				type="xsd:string"/>
  <part name="Zip"         				type="xsd:string"/>
  <part name="County"             type="xsd:string"/>
  <part name="FileNumber" 				type="xsd:string"/>
  <part name="Phone"	  					type="xsd:string"/>
  <part name="MileRadius"  				type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" 				type="xsd:byte"/>
  <part name="GLBPurpose" 				type="xsd:byte"/>
  <part name="ScoreThreshold" 		type="xsd:unsignedInt"/>
  <part name="PenaltThreshold" 		type="xsd:unsignedInt"/>
  <part name="MaxResults" 				type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" 				type="xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This service searches the Experian Business Reports files.*/


export EbrSearchService() := macro

#constant('getBdidsbyExecutive',FALSE);
#stored('ScoreThreshold',10);
#stored('PenaltThreshold',10);

output(EBR_Services.search, named('Results'));

endmacro;




