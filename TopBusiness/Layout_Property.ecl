import iesp;
export Layout_Property := module

  export main := module
	
		export Unlinked := record
			string2   source;
			string50  source_docid;						
			string1   vendor;		
			string12  event_id;
			string5   county_code;
			string45  apn; // or is it the next field.including both
			string200 legal_description;
			iesp.share.t_Address Property_address;
		end;
		
		export Linked := record
			unsigned6 bid;			
			string10  source_party;
			unlinked;
			string25  property_id;
			boolean   current_flag;
			unsigned4 owner_date;
    end;	

	end; // main module
	
	export party := module
	
		export Unlinked := record
			string2   source;
			string50  source_docid;						
			string10  source_party;						
			string12  event_id;		
			string1   vendor;		
			string1   party_type;						
			string1   party_type_address;		
			string120 company_name;
			unsigned4 owner_date;
			string20  name_last;
			string20  name_first;
			string20  name_middle;
			string5   name_suffix;
			string5   name_title;
			unsigned4 sales_date;		
			unsigned2 salesPrice;			// take back out later	
			string10 prim_range;
			string2 predir;
			string28 prim_name;
			string4 addr_suffix;
			string2 postdir;
			string10 unit_desig;
			string8 sec_range;
			string25 city_name;
			string2 state;
			string5 zip;		
			string4 zip4;
			string18 county_name;
		end;
		
		export Linked := record
			unsigned6 bid;
			Unlinked;
		end;
	
	end;
	
	export assessment := module
	
		export Unlinked := record
			string12 event_id;
			string1  vendor;		
			string1  current_record;
			string30 document_Type;		
			boolean  isForeclosedNOD;
			string11	assessed_land_value;
			string11	assessed_improvement_value;
			string11	assessed_total_value;
			string11	market_land_value;
			string11	market_improvement_value;
			string11	market_total_value;
			string4  tax_year;
			string30 county;
			string8 assessment_date;		
			string11 sales_Price;		
			string25 TransactionType;
		end;
		
		export Linked := record
			Unlinked;
			string25 property_id;
		end;
		
  end;		
	
	export deed := module
	
		export Unlinked := record
			string12  event_id;
			string1   vendor;	
			string1   current_record;
			string8   recording_date;
			string8   contract_date;	
			string20  document_number;
			string3   document_type_code;
			string10  book_number;
			string10  page_number;
			string11  sales_price;
			string11  first_td_loan_amount;        
			string11  second_td_loan_amount; 
			string5   loan_type_code;
			string8   LoanDate;
			string8   LoanAmount;
			string8   LoanAmountSecMort;
			string8   LoanDueDate;
			string5   LoanInterestRate;
			string60  title_company_name;           
			string40  lender_name;     
			string1   buyer_or_borrower_ind; //new - 'O' for buyer, 'B' for borrower
			string18  county_name;
		end;
		
		export Linked := record
			Unlinked;
			string25 property_id;
		end;
		
	end;
	
	export Foreclosure := module
		export Unlinked := record
			string1  vendor;		
			string12 foreclosure_event_id;
			string40 documentType;	
			string8  RecordingDate;
			string10 auction_date;
			string60 AttorneyName;
			string10 AttorneyPhoneNumber;
			string30 LenderFirstName;
			string30 LenderLastName;
			string30 LenderCompanyName;
		end;
		
		export Linked := record
			Unlinked;
			string25 property_id;
			string12 deed_event_id;
		end;
	end;
	
end;