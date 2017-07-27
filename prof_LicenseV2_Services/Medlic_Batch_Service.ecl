/*--SOAP--
<message name="Medlic_Batch_Service">
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask"   type="xsd:string"/>
	<part name="DataPermissionMask"    type="xsd:string"/>
  <part name="MaxResults" type="xsd:unsignedInt"/> 
  <part name="PenaltThreshold" type="xsd:unsignedInt"/>
</message>
*/

export Medlic_Batch_Service(useCannedRecs = 'false') := MACRO

	unsigned2 penTh := 10 : STORED('PenaltThreshold');
	verifyPenalty := if(penTh=0,10,penTh);

  // 05/20/2010 - Moved almost all of the coding out this macro to a separate new
	// Medlic_Batch_Service_Records function attribute so the function can be called
	// from more than one batch service.
	// The first parm below is passing the input PenaltThreshold on to the new function.
	// The second parm below is passing on the input useCannedRecs boolean for testing.
	// The third parm below is set to false, which tells the new function you are NOT 
	// running the Medlic_PL_Combined_Batch_Service.
	
		Pre_result := prof_LicenseV2_Services.Medlic_Batch_Service_Records(verifyPenalty,useCannedRecs,false);

		ut.mac_TrimFields(Pre_result, 'Pre_result', result);
		
		OUTPUT(result, NAMED('RESULTS'));	
	
	
ENDMACRO;		

// <batch_request>
// <row>
// <seq></seq>  
// <acctno></acctno>  
 // <name_first></name_first> 
 // <name_middle></name_middle>  
 // <name_last></name_last>  
 // <name_suffix></name_suffix>  
 // <prim_range></prim_range>  
 // <predir></predir>  
 // <prim_name></prim_name> 
 // <addr_suffix></addr_suffix>  
 // <postdir></postdir>  
 // <unit_desig></unit_desig> 
 // <sec_range></sec_range>  
 // <p_city_name></p_city_name>  
 // <st></st>  
 // <z5></z5> 
 // <zip4></zip4>  
 // <ssn></ssn>  
 // <dob></dob>  
 // <homephone></homephone> 
 // <workphone></workphone>  
 // <dl></dl>  
 // <dlstate></dlstate>  
 // <vin></vin>  
 // <plate></plate>  
 // <platestate></platestate> 
 // <searchtype></searchtype>  
 // <max_results></max_results>  
 // <did></did>  
 // <score></score>  
 // <matchcode></matchcode>  
 // <date></date>  
 // <fein></fein>  
 // <comp_name></comp_name> 
 // <sic_code></sic_code>  
 // <filing_number></filing_number>  
 // <apn></apn>  
 // <fips_code></>  
 // <bdid></bdid>  
 // <score_bdid></score_bdid>  
 // <license_number></license_number> 
 // <taxid></taxid>  
 // <upin></upin>  
 // <npi></npi> 
// </row>
// </batch_request>