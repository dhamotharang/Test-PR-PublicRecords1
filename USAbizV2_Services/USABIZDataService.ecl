/*--SOAP--
<message name="USABIZDataService">
  <part name="ABI"  type="xsd:string"/>
  <part name="BDID"  type="xsd:string"/>
  <part name="MaxResults"         type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This service returns USABIZ data (InfoUSA) in a format close to original data. */

EXPORT USABIZDataService := MACRO
  doxie.MAC_Header_Field_Declare ();


  string bdid_val := '' : stored('BDID');
  unsigned6 bdid := (unsigned6) bdid_val;
  bdids := dataset([{bdid}], doxie_cbrs.layout_references);

  ids_by_bdid := USAbizV2_Services.raw.get_ids_from_bdids (bdids);

  string9 abi_val := '' : stored('ABI');

  all_ids := IF (abi_val != '', DATASET ([{abi_val}], USAbizV2_Services.layouts.id)) +
             IF (bdid != 0, ids_by_bdid);

  fetched := USAbizV2_Services.raw.DATA_VIEW.by_id (all_ids);
  
  // additional processing here.
  doxie.MAC_Marshall_Results (fetched, res); 

  // TODO: sorting?
  output (SORT (res, abi_number, -process_date, COMPANY_NAME, name.lname), NAMED ('Results'));

ENDMACRO;
