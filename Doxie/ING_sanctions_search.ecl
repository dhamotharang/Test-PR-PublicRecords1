/*--SOAP--
<message name="IngenixSanctionsRequest"> 
  <part name="Gateways" type="tns:XmlDataSet" cols="80" rows="4"/>
	<part name="UnParsedFullName" type="xsd:string"/> 
  <part name="LastName" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="DOB" type="xsd:unsignedInt"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="TAXID" type="xsd:string"/>
  <part name="DID" type="xsd:string" required="1"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="include_OIG" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- This service pulls from the Ingenix sanctions file.*/

IMPORT ingenix_natlprof, doxie, OIG;

EXPORT ING_sanctions_search := MACRO

	STRING11 taxid_value := ''    : STORED('taxid');
   BOOLEAN  include_OIG := FALSE : STORED('include_OIG');

	doxie.MAC_Header_Field_Declare();

	sanctions_rslt := doxie.ING_Sanctions_Search_Records ( taxid_value, include_OIG );

	with_blank_rec := RECORD
		sanctions_rslt;
		STRING20 blank_fld := '';
	END;

	fetched := TABLE(sanctions_rslt, with_blank_rec);

	doxie.MAC_Header_Result_Rank(Prov_Clean_fname,Prov_Clean_mname,Prov_Clean_lname,
										  blank_fld,SANC_DOB,did,
										  ProvCo_Address_Clean_predir,ProvCo_Address_Clean_prim_range,
							           ProvCo_Address_Clean_prim_name,ProvCo_Address_Clean_addr_suffix,
							           ProvCo_Address_Clean_postdir,ProvCo_Address_Clean_sec_range,
										  ProvCo_Address_Clean_v_city_name,blank_fld,ProvCo_Address_Clean_st,
							           ProvCo_Address_Clean_zip,PhoneNumber,TRUE)
							 
	out_f_srt := SORT(fetched, rec_type);

	sanctions_rslt slim_out(out_f_srt l) := TRANSFORM
		SELF := l;
	END;
	
	out_f_slim := PROJECT(out_f_srt, slim_out(LEFT));

	doxie.MAC_Marshall_Results(out_f_slim, out_rslt, 200000);

	OUTPUT(out_rslt, NAMED( 'Results' ) ); 

ENDMACRO;