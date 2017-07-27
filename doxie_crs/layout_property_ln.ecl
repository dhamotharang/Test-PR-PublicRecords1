import doxie_ln, ffd;
export layout_property_ln := record, maxlength(300000)
	string12 ln_fares_id;
	integer3 address_seq_no := -1;
	boolean current := false;
	string1 source_code;
	string8 compare_date := '';
  string1 refi_flag := '';
	string8 record_type := '';
	
	string45 uapn;
	string45 fapn;
	string12 book_page;
	
	string10 Lot_Number := '';
	string60 Name_Owner_1 := '';
	string60 Name_Owner_2 := '';
	
	string70   property_full_street_address;
	string6    property_address_unit_number;
	string51   property_address_citystatezip;
	string18 	 property_county;
	
	string10        address_prim_range := '';
	string2         address_predir := '';
	string28        address_prim_name := '';
	string4         address_suffix := '';
	string2         address_postdir := '';
	string10        address_unit_desig := '';
	string8         address_sec_range := '';
	string25        address_v_city_name := '';
	string2         address_ace_state := '';
	string5         address_ace_zip := '';
	string4         address_ace_zip4 := '';
	string18 		 		address_county := '';

	string70   buyer_mailing_full_street_address;
	string6    buyer_mailing_address_unit_number;
	string51   buyer_mailing_address_citystatezip;
	string18 	 buyer_mailing_county;
	
	string10        owners_address_prim_range := '';
	string2         owners_address_predir := '';
	string28        owners_address_prim_name := '';
	string4         owners_address_suffix := '';
	string2         owners_address_postdir := '';
	string10        owners_address_unit_desig := '';
	string8         owners_address_sec_range := '';
	string25        owners_address_v_city_name := '';
	string2         owners_address_ace_state := '';
	string5         owners_address_ace_zip := '';
	string4         owners_address_ace_zip4 := '';
	string18 		 		owners_address_county := '';
	
	string40 land_usage := '';
	string40 Subdivision_Name := '';
	string11 Total_Value := '';
	string11 Land_Value := '';
	string11 Improvement_Value := '';
	string9 Land_Size := '';
	string7 building_size := '';
	string4 Year_Built := '';
	string11 Sale_Price := '';
	string250 Legal_Description := '';
	
	string8 sale_date := '';
	string60 Name_of_Seller := '';
	string11 Loan_Amount := '';
	string4 Loan_Term_Code := '';
	string5 Loan_Term := '';
	string8 Loan_Due_Date := '';
	string35 Loan_Type := '';
	string6  Loan_Deed_Type := '';
	string10 Loan_Deed_Sub_Type := '';
	
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
	string50 foundation := '';
	string5  bedrooms := '';
	string5  full_baths := '';
	string5  half_baths := '';
	string11 assd_total_val := '';

	string120 basement :='';
	string120 roof_type :='';
	string120 roof_cover :='';
	string120 exteriorwalls :='';
	string120 heating :='';

	string120 Pool := '';
	string120 AirConditioning := '';
	string120 Garage := '';
	string3   firePlace :='';
	string4   InterestRate :='';
	string120 InterestRateType :='';
	
	string3   HomesteadExemption :='';
	
	string120 OtherBuildings1 :='';
	string120 OtherBuildings2 :='';
	string120 OtherBuildings3 :='';
	string120 OtherBuildings4 :='';
	string120 OtherBuildings5 :='';

	string120 OtherCharacteristics1 :='';
	string120 OtherCharacteristics2 :='';
	string120 OtherCharacteristics3 :='';
	string120 OtherCharacteristics4 :='';
	string120 OtherCharacteristics5 :='';

	dataset(doxie_ln.layout_addl_buyer) other_buyers;
	dataset(doxie_ln.layout_addl_seller) other_sellers;
	
	FFD.Layouts.CommonRawRecordElements;

end;