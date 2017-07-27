/*--SOAP--
<message name="LiensReportService">

  <part name="DID" 					       type="xsd:string"/>
  <part name="BDID" 				       type="xsd:string"/>
  <part name="TMSID" 				       type="xsd:string"/>
  <part name="SSNMask"			       type="xsd:string"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="ReturnMultiplePages" type="xsd:boolean"/>
  <part name="IncludeCriminalIndicators" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service returns one lien.*/


export LiensReportService() := macro
#constant('getBdidsbyExecutive',FALSE);
#constant('usehigherlimit',TRUE);

BOOLEAN return_multiple_pgs := FALSE : STORED('ReturnMultiplePages');
BOOLEAN include_criminalIndicators := FALSE : STORED('IncludeCriminalIndicators');
doxie.MAC_Header_Field_Declare();

did := (unsigned6)did_value;
dids := dataset([{did}], doxie.layout_references);
bydid := liensv2_services.liens_raw.get_tmsids_from_dids(dids);

bdid := business_header.stored_bdid_value;
bdids := dataset([{bdid}], doxie_cbrs.layout_references);
bybdid := liensv2_services.liens_raw.get_tmsids_from_bdids(bdids);

tmsids_input_all := 
	if(tmsid_value <> '', dataset([{tmsid_value}],liensv2_services.layout_tmsid)) +
	if(did > 0, bydid) +
	if(bdid > 0, bybdid);

isCSMR := ut.IndustryClass.is_Knowx;	
tmsids := tmsids_input_all(~LiensV2_Services.Functions.isRestricted(isCSMR, tmsid));

res := liensv2_services.liens_raw.report_view.by_tmsid( in_tmsids := tmsids, 
                                                      in_ssn_mask_type := ssn_mask_value,
																											return_multiple_pages := return_multiple_pgs,
																											appType:=application_type_value,
                                                      includeCriminalIndicators := include_criminalIndicators);

output(res, named('Results'));

endmacro;




