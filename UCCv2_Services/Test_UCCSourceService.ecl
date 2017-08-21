/*--SOAP--
<message name="Test_UCCSourceService">

  <part name="DID" 					type="xsd:string"/>
  <part name="BDID" 				type="xsd:string"/>
	
  <part name="TMSID" 				type="xsd:string"/>
  <part name="RMSID" 				type="xsd:string"/>
    
</message>
*/
/*--INFO-- This service returns UCC Records in the Source format. */
/*--RESULT-- xslt.html */

export Test_UCCSourceService() := macro

#STORED('IncludeMulitpleSecured', true)
#STORED('ReturnRolledDebtors', true)

#constant('getBdidsbyExecutive',FALSE)
#constant('usehigherlimit',TRUE)
doxie.MAC_Header_Field_Declare()

did := (unsigned6)did_value;
dids := dataset([{did}], doxie.layout_references);
bydid := UCCv2_Services.UCCRaw.get_rmsids_from_dids(dids);

bdid := business_header.stored_bdid_value;
bdids := dataset([{bdid}], doxie_cbrs.layout_references);
bybdid := UCCv2_Services.UCCRaw.get_rmsids_from_bdids(bdids);

rmsids := 
	if(tmsid_value <> '' and rmsid_value <> '', dataset([{tmsid_value, rmsid_value}],UCCv2_Services.layout_rmsid)) +
	if(did > 0, bydid) +
	if(bdid > 0, bybdid);

r := UCCv2_Services.UCCRaw.source_view.by_rmsid(rmsids,ssn_mask_value);

output(r, named('Results'));

endmacro;
