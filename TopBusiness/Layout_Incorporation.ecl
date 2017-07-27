export Layout_Incorporation := module

	export Unlinked := record
		string2   source;
		string50  source_docid;
		string10  source_party;
	  //v--- fields needed in Biz report Operations/Sites Section
    string2   corp_state_origin;
    string100 corp_legal_name; // length=350 on base corp2 corp, but that seems excessive???
    string32  corp_orig_sos_charter_nbr;
    string100 corp_orig_bus_type_desc; //length=350 on base corp2 corp, but that seems excessive??? is this what Tim intended here ???
    string8   latest_filing_date;
		string60  corp_status_desc;
    string8   corp_status_date;
		string1   corp_foreign_domestic_ind;
		string1   corp_for_profit_ind;
		//string??  filing_type; // corp_filing_desc? as of 07/07/11, Tim B to think about this ???
    string9	  corp_term_exist_exp; // expiration date or convert "P" to "Perpetual"
 		//       v--- Get these 2 fields from the base corp2 events file
		string8  event_filing_date;
		string60 event_filing_desc;
		
    // v--- fields needed in other sections
		string8   start_date; // for use in calculating years in business ???
		//dt_vendor_first_reported OR dt_first_at_location; //may be needed to calcualte years at location???
		string8   dt_vendor_last_reported; // for use in calculating years in business ???
		//string3 YearsInBusiness; // 3 related fields on EBR 5600 rec; store here or convert to start_date ???
    //string3 YearsAtLocation; // calculate from ???
		
 		// v--- fields needed for linking corp main to event recs ???
		string30 corp_key; // ???
    string1  record_type; //???
		string60 corp_structure;
		string2  corp_foreign_state;
	end;
	
	export Linked := record
		unsigned6 bid;
		Unlinked;
		string60  ln_corp_status_desc;
	end;
end;