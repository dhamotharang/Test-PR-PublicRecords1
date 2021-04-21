
/*--SOAP--
<message name="IngenixProviderRequest">  
  <part name="Gateways" type="tns:XmlDataSet" cols="80" rows="4"/>
  <part name="LastName"           type="xsd:string"/>
  <part name="FirstName"          type="xsd:string"/>
  <part name="MiddleName"         type="xsd:string"/>
  <part name="DOB"                type="xsd:unsignedInt"/>
  <part name="Addr"               type="xsd:string"/>
  <part name="City"               type="xsd:string"/>
  <part name="State"              type="xsd:string"/>
  <part name="Zip"                type="xsd:string"/>
  <part name="TAXID"              type="xsd:string"/>
  <part name="DID"                type="xsd:string" required="1"/>
  <part name="LicenseState"       type="xsd:string"/>
  <part name="LicenseNumber"      type="xsd:string"/>
  <part name="DPPAPurpose"        type="xsd:byte"/>
  <part name="GLBPurpose"         type="xsd:byte"/>
  <part name="MaxResults"         type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords"        type="xsd:unsignedInt"/>
  <part name="include_NPPES"      type="xsd:boolean"/>
  <part name="npi_number"         type="xsd:string"/>
 </message>
*/
/*--INFO-- This service pulls from the Ingenix provider key, NPPES keys and the AMS keys.
           AMS is combined with Ingenix as one source and NPPES is output as a separate source.
*/

IMPORT ingenix_natlprof;

EXPORT ING_provider_search  := 
  MACRO
  // commented out the maxLength line. When the Ingenix ID key was added to the service
  // The maxLength code for the intermediate layouts caused the service to fail. There are
  // now maxLengths on all of the parent record layouts for this service.
  // #option('maxLength', 200000);

  doxie.MAC_Header_Field_Declare();

  STRING15 taxid_value   := ''    : STORED( 'TAXID' );
  STRING2  lic_st        := ''    : STORED( 'LicenseState' );
  STRING12 lic_num       := ''    : STORED( 'LicenseNumber' );
  BOOLEAN  include_NPPES := FALSE : STORED( 'include_NPPES' );
	STRING10 npi_number    := ''    : STORED( 'npi_number' );

  /*    NPI determine if NPI only search
        When the user only enters an NPI number, the service needs to search the NPPES file
        first, use that data to populate the call to find provider search data.  This code 
        is not in a function because no other service will use this and it keeps the soap 
        variables in the service level attribute.
  */
  
  only_NPI_number_Entered := ( include_NPPES        AND 
                               npi_number     != '' AND
												       // From doxie.MAC_Header_Field_Declare...:
							                 lname_val       = '' AND  
							                 fname_val       = '' AND  
							                 mname_val       = '' AND  
							                 dob_val         =  0 AND  
							                 addr_line_first = '' AND  
							                 city_val        = '' AND  
							                 state_val       = '' AND  
							                 zip_val0        = '' AND  
							                 taxid_value     = '' AND  
								               lic_st          = '' AND
								               lic_num         = '' AND
								               did_value       = '' 
									         );

	providers_rslt := doxie.ING_Provider_Search_Records( taxid_value, lic_st, lic_num, include_NPPES, 
	                                                     only_NPI_number_Entered, npi_number );

	doxie.MAC_Marshall_Results( providers_rslt, out_rslt, 200000 );
	
  OUTPUT( out_rslt, NAMED( 'Results' ) );
	
ENDMACRO;