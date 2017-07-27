import doxie_cbrs,doxie, business_header;

export TxbusSearch_ids(TxbusV2_services.Interfaces.Search_params in_params,
	boolean includeDeepDive = true) := 
FUNCTION

business_header.doxie_MAC_Field_Declare()

							 
outrec := TXBUSV2_Services.Layout_Search_Ids;

//***** AUTOKEY PEICE
byak := if(in_params.is_search, TxbusV2_services.Autokey_Header_ids(false,false,includeDeepDive));


//*****BDID 
bybdid := if(bdid_value <>0,TXBUSV2_Services.Txbus_raw.get_TaxNumber_from_bdids(project(bdid_dataset,doxie_cbrs.layout_references)));		

//*****DID
dsdid := dataset([{did_value}], doxie.layout_references);
bydid := if(did_value <>'',TXBUSV2_Services.Txbus_raw.get_TaxNumber_from_dids(dsdid));


//***** GATHER Taxpayer Numbers
byTaxNo := if(in_params.taxpayer_number <>  '', 
			  dataset([{in_params.taxpayer_number}],TXBUSV2_Services.Layout_Taxpayer_Number));


//***** ADD THE FLAG SO WE CAN SHOW IT ON SEARCH RESULTS

TaxNos := byak +
	   project(bydid + bybdid + byTaxNo, 
		transform(outrec, self.isDeepDive := FALSE, self := left));

return dedup(sort(TaxNos, TaxPayer_Number, if(isDeepDive, 1, 0)), TaxPayer_Number);

END;