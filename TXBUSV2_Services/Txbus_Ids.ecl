import autokeyb,doxie_cbrs,doxie,doxie_raw, business_header,txbus;

export Txbus_ids(TXBUSV2_Services.Interfaces.Search_Params in_params,
	boolean includeDeepDive = true,boolean is_search) := 
FUNCTION

business_header.doxie_MAC_Field_Declare()

							 
outrec := txbusV2_Services.layout_search_IDs;

//***** AUTOKEY PEICE
byak := if(is_search, TxbusV2_services.Autokey_Header_ids(false,false,includeDeepDive));


		 		 
//***** TaxPayer Number
TaxPayerNum:= dataset([{in_params.taxpayer_number}], Txbusv2_services.layout_Taxpayer_Number);
byTaxNum := if(in_params.taxpayer_number <> '', TaxPayerNum);

//*****BDID 
bybdid := if(bdid_value <>0 and is_search=FALSE,TxbusV2_services.Txbus_raw.get_Taxnumber_from_bdids(project(bdid_dataset,doxie_cbrs.layout_references)));		

//*****DID
dsdid := dataset([{did_value}], doxie.layout_references);
bydid := if(did_value <>'' and is_search=FALSE,TxbusV2_services.Txbus_raw.get_Taxnumber_from_dids(dsdid));


//***** ADD THE FLAG SO WE CAN SHOW IT ON SEARCH RESULTS

TaxNumbers := byak +
	   project(byTaxNum + bydid + bybdid, 
		transform(outrec, self.isDeepDive := FALSE, self := left));

return dedup(sort(Taxnumbers, Taxpayer_number, if(isDeepDive, 1, 0)), taxpayer_number);

END;