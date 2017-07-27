import doxie_cbrs,txbus,doxie;

export Txbus_raw := Module

	// Gets RMSIDs from BDIDs
	export get_TaxNumber_from_bdids(dataset(doxie_cbrs.layout_references) in_bdids,
	                             unsigned in_limit = 0) := function
	  key := TXBUS.Key_Txbus_BDID;
		res := join(dedup(sort(in_bdids,bdid),bdid),key,
		            keyed(left.bdid = right.bdid),
								transform(TxBusV2_services.layout_TaxPayer_Number,self := right),
								keep(10000));							
		ded := dedup(sort(res,Taxpayer_Number),Taxpayer_Number);
		
		return if(in_limit = 0,ded,choosen(ded,in_limit));
	end;
	
	export get_TaxNumber_from_dids(dataset(doxie.layout_references) in_dids,
	                             unsigned in_limit = 0) := function
	  key := TXBUS.Key_Txbus_DID;
		res := join(dedup(sort(in_dids,did),did),key,
		            keyed(left.did = right.did),
								transform(TxBusV2_services.layout_TaxPayer_Number,self := right),
								keep(10000));							
		ded := dedup(sort(res,Taxpayer_Number),Taxpayer_Number);
		
		return if(in_limit = 0,ded,choosen(ded,in_limit));
	end;
	
	
	export Search_view := module
	
		export by_TaxPayerNumber(dataset(TxbusV2_services.layout_search_IDs) in_TaxPayer_Nums,
			string in_ssn_mask_type = '',boolean is_search):= function
			return TxbusV2_services.get_Txbus(in_TaxPayer_Nums, in_ssn_mask_type,is_Search).searchorReport;
		end;
		
	END;
	
	export Report_view := module
	
		export by_TaxPayerNumber(dataset(TxbusV2_services.layout_search_IDs) in_TaxPayer_Nums,
			string in_ssn_mask_type = '',boolean is_search):= function
			return TxbusV2_services.get_Txbus(in_TaxPayer_Nums, in_ssn_mask_type,is_Search).searchorReport;
		end;
		
	END;	
	
	end;