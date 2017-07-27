import ut;

export property_records_prs(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

pr := doxie_cbrs.property_records(bdids);

rec := record

	unsigned6 bdid := 0;
	boolean byBDID;					//because some recs may be by both
	boolean byAddress;

	string12 ln_fares_id;
	integer3 address_seq_no := -1;
	boolean current := false;
	string1 source_code;
	string8 compare_date := '';
     string1 refi_flag := '';
	string8 record_type := '';
	/*
	string45 uapn;
	string45 fapn;
	string12 book_page;*/
	
	//string10 Lot_Number := '';
	string60 Name_Owner_1 := '';
	string60 Name_Owner_2 := '';
	
	string70   property_full_street_address;
	string6    property_address_unit_number;
	string51   property_address_citystatezip;
	string18 	 property_county;
	/*
	string70   buyer_mailing_full_street_address;
	string6    buyer_mailing_address_unit_number;
	string51   buyer_mailing_address_citystatezip;
	string18 	 buyer_mailing_county;
	*/
	string40 land_usage := '';
	//string40 Subdivision_Name := '';
	string11 Total_Value := '';
	string11 Land_Value := '';
	string11 Improvement_Value := '';
	string9 Land_Size := '';
	string7 building_size := '';
	string4 Year_Built := '';
	string11 Sale_Price := '';
	string250 Legal_Description := '';
	
	string8 sale_date := '';
	string60 Name_of_Seller := '';/*
	string11 Loan_Amount := '';
	string4 Loan_Term_Code := '';
	string5 Loan_Term := '';
	string8 Loan_Due_Date := '';
	string35 Loan_Type := '';
	string6  Loan_Deed_Type := '';
	string6 Loan_Deed_Sub_Type := '';
	
	string60 Lender_Name := '';
	
	//more fields both
	string9  building_square_feet := '';
	string8  recording_date := '';
	string60 title_company_name := '';
	string12 document_number := '';
	
	//dees only
	string40  document_type := '';
	string40  transaction_type := '';
	
	
     //asses only
	string4  tax_year := '';
	string11 tax_amount := '';	
	string11 mkt_total_val := '';
	string11 mkt_land_val := '';
	string11 mkt_improvement_val := '';
	string7  living_square_feet := '';
	string3  stories_number := '';
	string3  foundation := '';
	string5  bedrooms := '';
	string5  full_baths := '';
	string5  half_baths := '';
	string11 assd_total_val := '';
		
	dataset(doxie_ln.layout_addl_buyer) other_buyers;
	dataset(doxie_ln.layout_addl_seller) other_sellers;*/
end;

ut.MAC_Slim_Back(pr, rec, prslim)

return prslim;
END;