	
EXPORT layout_JudgmentsAndLiens_Batch_out := 
	RECORD
	
		STRING30 acctno := '';
		STRING8 matchcodes := '';
		INTEGER error_code :=0;
		UNSIGNED2 penalt := 0;
		
		//	case information

		STRING50 tmsid                    := '';
		STRING50 filing_jurisdiction      := '';
		STRING21 filing_jurisdiction_name := '';
		STRING20 orig_filing_number       := '';
		STRING30 orig_filing_type         := '';
		STRING8  orig_filing_date         := '';
		STRING10 orig_filing_time         := '';
		STRING25 case_number              := '';
		STRING20 tax_code                 := '';
		STRING11 irs_serial_number        := '';
		STRING8  release_date             := '';
		STRING15 amount                   := '';
		STRING15 eviction                 := '';
		STRING8  judg_satisfied_date      := '';
		STRING8  judg_vacated_date        := '';
		STRING100 judge                   := '';
		STRING100 filing_status           := '';
		
		// debtors
		
		// ..debtor 1
		
		STRING5   debtor_1_party_1_title			:= '';
		STRING20  debtor_1_party_1_fname			:= '';
		STRING20  debtor_1_party_1_mname			:= '';
		STRING20  debtor_1_party_1_lname			:= '';
		STRING5   debtor_1_party_1_name_suffix:= '';
		STRING200 debtor_1_party_1_cname      := '';
	
		STRING120 debtor_1_party_1_orig_name  := '';

		STRING11 debtor_1_party_1_ssn         := '';
		STRING9 debtor_1_party_1_tax_id       := '';
	
		STRING50 debtor_1_party_1_address1    := '';
		STRING19 debtor_1_party_1_address2    := '';
		STRING25 debtor_1_party_1_p_city_name := '';
		STRING2  debtor_1_party_1_st          := '';
		STRING5  debtor_1_party_1_zip         := '';
		STRING4  debtor_1_party_1_zip4        := '';
		STRING4  debtor_1_party_1_msa         := '';
		STRING18 debtor_1_party_1_county_name := '';
		STRING15 debtor_1_party_1_phone       := '';				
		
		STRING5   debtor_1_party_2_title			:= '';
		STRING20  debtor_1_party_2_fname			:= '';
		STRING20  debtor_1_party_2_mname			:= '';
		STRING20  debtor_1_party_2_lname			:= '';
		STRING5   debtor_1_party_2_name_suffix:= '';
		STRING200 debtor_1_party_2_cname      := '';
			
		STRING11 debtor_1_party_2_ssn          := '';
		STRING9 debtor_1_party_2_tax_id       := '';
		
		STRING50 debtor_1_party_2_address1    := '';
		STRING19 debtor_1_party_2_address2    := '';
		STRING25 debtor_1_party_2_p_city_name := '';
		STRING2  debtor_1_party_2_st          := '';
		STRING5  debtor_1_party_2_zip         := '';
		STRING4  debtor_1_party_2_zip4        := '';
		STRING4  debtor_1_party_2_msa         := '';
		STRING18 debtor_1_party_2_county_name := '';
		STRING15 debtor_1_party_2_phone       := '';	
		
		// ..debtor 2
		
		STRING5   debtor_2_party_1_title			:= '';
		STRING20  debtor_2_party_1_fname			:= '';
		STRING20  debtor_2_party_1_mname			:= '';
		STRING20  debtor_2_party_1_lname			:= '';
		STRING5   debtor_2_party_1_name_suffix:= '';
		STRING200 debtor_2_party_1_cname      := '';
			
		STRING120 debtor_2_party_1_orig_name  := '';

		STRING11 debtor_2_party_1_ssn         := '';
		STRING9 debtor_2_party_1_tax_id       := '';
	
		STRING50 debtor_2_party_1_address1    := '';
		STRING19 debtor_2_party_1_address2    := '';
		STRING25 debtor_2_party_1_p_city_name := '';
		STRING2  debtor_2_party_1_st          := '';
		STRING5  debtor_2_party_1_zip         := '';
		STRING4  debtor_2_party_1_zip4        := '';
		STRING4  debtor_2_party_1_msa         := '';
		STRING18 debtor_2_party_1_county_name := '';
		STRING15 debtor_2_party_1_phone       := '';				
		
		STRING5   debtor_2_party_2_title			:= '';
		STRING20  debtor_2_party_2_fname			:= '';
		STRING20  debtor_2_party_2_mname			:= '';
		STRING20  debtor_2_party_2_lname			:= '';
		STRING5   debtor_2_party_2_name_suffix:= '';
		STRING200 debtor_2_party_2_cname      := '';
			
		STRING11 debtor_2_party_2_ssn          := '';
		STRING9 debtor_2_party_2_tax_id       := '';
	
		STRING50 debtor_2_party_2_address1    := '';
		STRING19 debtor_2_party_2_address2    := '';
		STRING25 debtor_2_party_2_p_city_name := '';
		STRING2  debtor_2_party_2_st          := '';
		STRING5  debtor_2_party_2_zip         := '';
		STRING4  debtor_2_party_2_zip4        := '';
		STRING4  debtor_2_party_2_msa         := '';
		STRING18 debtor_2_party_2_county_name := '';
		STRING15 debtor_2_party_2_phone       := '';	
		
		// ..debtor 3
		
		STRING5   debtor_3_party_1_title			:= '';
		STRING20  debtor_3_party_1_fname			:= '';
		STRING20  debtor_3_party_1_mname			:= '';
		STRING20  debtor_3_party_1_lname			:= '';
		STRING5   debtor_3_party_1_name_suffix:= '';
		STRING200 debtor_3_party_1_cname      := '';
	
		STRING120 debtor_3_party_1_orig_name  := '';
		
		STRING11 debtor_3_party_1_ssn         := '';
		STRING9 debtor_3_party_1_tax_id       := '';
	
		STRING50 debtor_3_party_1_address1    := '';
		STRING19 debtor_3_party_1_address2    := '';
		STRING25 debtor_3_party_1_p_city_name := '';
		STRING2  debtor_3_party_1_st          := '';
		STRING5  debtor_3_party_1_zip         := '';
		STRING4  debtor_3_party_1_zip4        := '';
		STRING4  debtor_3_party_1_msa         := '';
		STRING18 debtor_3_party_1_county_name := '';
		STRING15 debtor_3_party_1_phone       := '';				

		STRING5   debtor_3_party_2_title			:= '';
		STRING20  debtor_3_party_2_fname			:= '';
		STRING20  debtor_3_party_2_mname			:= '';
		STRING20  debtor_3_party_2_lname			:= '';
		STRING5   debtor_3_party_2_name_suffix:= '';
		STRING200 debtor_3_party_2_cname      := '';
	
		STRING11 debtor_3_party_2_ssn          := '';
		STRING9 debtor_3_party_2_tax_id       := '';
	
		STRING50 debtor_3_party_2_address1    := '';
		STRING19 debtor_3_party_2_address2    := '';
		STRING25 debtor_3_party_2_p_city_name := '';
		STRING2  debtor_3_party_2_st          := '';
		STRING5  debtor_3_party_2_zip         := '';
		STRING4  debtor_3_party_2_zip4        := '';
		STRING4  debtor_3_party_2_msa         := '';
		STRING18 debtor_3_party_2_county_name := '';
		STRING15 debtor_3_party_2_phone       := '';			
		
		// ..debtor 4
		
		STRING5   debtor_4_party_1_title			:= '';
		STRING20  debtor_4_party_1_fname			:= '';
		STRING20  debtor_4_party_1_mname			:= '';
		STRING20  debtor_4_party_1_lname			:= '';
		STRING5   debtor_4_party_1_name_suffix:= '';
		STRING200 debtor_4_party_1_cname      := '';
	
		STRING120 debtor_4_party_1_orig_name  := '';
		
		STRING11 debtor_4_party_1_ssn         := '';
		STRING9 debtor_4_party_1_tax_id       := '';
	
		STRING50 debtor_4_party_1_address1    := '';
		STRING19 debtor_4_party_1_address2    := '';
		STRING25 debtor_4_party_1_p_city_name := '';
		STRING2  debtor_4_party_1_st          := '';
		STRING5  debtor_4_party_1_zip         := '';
		STRING4  debtor_4_party_1_zip4        := '';
		STRING4  debtor_4_party_1_msa         := '';
		STRING18 debtor_4_party_1_county_name := '';
		STRING15 debtor_4_party_1_phone       := '';				
		
		STRING5   debtor_4_party_2_title			:= '';
		STRING20  debtor_4_party_2_fname			:= '';
		STRING20  debtor_4_party_2_mname			:= '';
		STRING20  debtor_4_party_2_lname			:= '';
		STRING5   debtor_4_party_2_name_suffix:= '';
		STRING200 debtor_4_party_2_cname      := '';
	
		STRING11 debtor_4_party_2_ssn          := '';
		STRING9 debtor_4_party_2_tax_id       := '';
	
		STRING50 debtor_4_party_2_address1    := '';
		STRING19 debtor_4_party_2_address2    := '';
		STRING25 debtor_4_party_2_p_city_name := '';
		STRING2  debtor_4_party_2_st          := '';
		STRING5  debtor_4_party_2_zip         := '';
		STRING4  debtor_4_party_2_zip4        := '';
		STRING4  debtor_4_party_2_msa         := '';
		STRING18 debtor_4_party_2_county_name := '';
		STRING15 debtor_4_party_2_phone       := '';	
		
		// ..debtor 5
		
		STRING5   debtor_5_party_1_title			:= '';
		STRING20  debtor_5_party_1_fname			:= '';
		STRING20  debtor_5_party_1_mname			:= '';
		STRING20  debtor_5_party_1_lname			:= '';
		STRING5   debtor_5_party_1_name_suffix:= '';
		STRING200 debtor_5_party_1_cname      := '';
	
		STRING120 debtor_5_party_1_orig_name  := '';
		
		STRING11 debtor_5_party_1_ssn         := '';
		STRING9 debtor_5_party_1_tax_id       := '';
	
		STRING50 debtor_5_party_1_address1    := '';
		STRING19 debtor_5_party_1_address2    := '';
		STRING25 debtor_5_party_1_p_city_name := '';
		STRING2  debtor_5_party_1_st          := '';
		STRING5  debtor_5_party_1_zip         := '';
		STRING4  debtor_5_party_1_zip4        := '';
		STRING4  debtor_5_party_1_msa         := '';
		STRING18 debtor_5_party_1_county_name := '';
		STRING15 debtor_5_party_1_phone       := '';				
		
		STRING5   debtor_5_party_2_title			:= '';
		STRING20  debtor_5_party_2_fname			:= '';
		STRING20  debtor_5_party_2_mname			:= '';
		STRING20  debtor_5_party_2_lname			:= '';
		STRING5   debtor_5_party_2_name_suffix:= '';
		STRING200 debtor_5_party_2_cname      := '';
	
		STRING11 debtor_5_party_2_ssn          := '';
		STRING9 debtor_5_party_2_tax_id       := '';
	
		STRING50 debtor_5_party_2_address1    := '';
		STRING19 debtor_5_party_2_address2    := '';
		STRING25 debtor_5_party_2_p_city_name := '';
		STRING2  debtor_5_party_2_st          := '';
		STRING5  debtor_5_party_2_zip         := '';
		STRING4  debtor_5_party_2_zip4        := '';
		STRING4  debtor_5_party_2_msa         := '';
		STRING18 debtor_5_party_2_county_name := '';
		STRING15 debtor_5_party_2_phone       := '';	
		
		// ..debtor 6
		
		STRING5   debtor_6_party_1_title			:= '';
		STRING20  debtor_6_party_1_fname			:= '';
		STRING20  debtor_6_party_1_mname			:= '';
		STRING20  debtor_6_party_1_lname			:= '';
		STRING5   debtor_6_party_1_name_suffix:= '';
		STRING200 debtor_6_party_1_cname      := '';
	
		STRING120 debtor_6_party_1_orig_name  := '';
		
		STRING11 debtor_6_party_1_ssn         := '';
		STRING9 debtor_6_party_1_tax_id       := '';
	
		STRING50 debtor_6_party_1_address1    := '';
		STRING19 debtor_6_party_1_address2    := '';
		STRING25 debtor_6_party_1_p_city_name := '';
		STRING2  debtor_6_party_1_st          := '';
		STRING5  debtor_6_party_1_zip         := '';
		STRING4  debtor_6_party_1_zip4        := '';
		STRING4  debtor_6_party_1_msa         := '';
		STRING18 debtor_6_party_1_county_name := '';
		STRING15 debtor_6_party_1_phone       := '';				
		
		STRING5   debtor_6_party_2_title			:= '';
		STRING20  debtor_6_party_2_fname			:= '';
		STRING20  debtor_6_party_2_mname			:= '';
		STRING20  debtor_6_party_2_lname			:= '';
		STRING5   debtor_6_party_2_name_suffix:= '';
		STRING200 debtor_6_party_2_cname      := '';
	
		STRING11 debtor_6_party_2_ssn          := '';
		STRING9 debtor_6_party_2_tax_id       := '';
	
		STRING50 debtor_6_party_2_address1    := '';
		STRING19 debtor_6_party_2_address2    := '';
		STRING25 debtor_6_party_2_p_city_name := '';
		STRING2  debtor_6_party_2_st          := '';
		STRING5  debtor_6_party_2_zip         := '';
		STRING4  debtor_6_party_2_zip4        := '';
		STRING4  debtor_6_party_2_msa         := '';
		STRING18 debtor_6_party_2_county_name := '';
		STRING15 debtor_6_party_2_phone       := '';		
		
		// ..debtor 7
		
		STRING5   debtor_7_party_1_title			:= '';
		STRING20  debtor_7_party_1_fname			:= '';
		STRING20  debtor_7_party_1_mname			:= '';
		STRING20  debtor_7_party_1_lname			:= '';
		STRING5   debtor_7_party_1_name_suffix:= '';
		STRING200 debtor_7_party_1_cname      := '';
	
		STRING120 debtor_7_party_1_orig_name  := '';
		
		STRING11 debtor_7_party_1_ssn         := '';
		STRING9 debtor_7_party_1_tax_id       := '';
	
		STRING50 debtor_7_party_1_address1    := '';
		STRING19 debtor_7_party_1_address2    := '';
		STRING25 debtor_7_party_1_p_city_name := '';
		STRING2  debtor_7_party_1_st          := '';
		STRING5  debtor_7_party_1_zip         := '';
		STRING4  debtor_7_party_1_zip4        := '';
		STRING4  debtor_7_party_1_msa         := '';
		STRING18 debtor_7_party_1_county_name := '';
		STRING15 debtor_7_party_1_phone       := '';				
		
		STRING5   debtor_7_party_2_title			:= '';
		STRING20  debtor_7_party_2_fname			:= '';
		STRING20  debtor_7_party_2_mname			:= '';
		STRING20  debtor_7_party_2_lname			:= '';
		STRING5   debtor_7_party_2_name_suffix:= '';
		STRING200 debtor_7_party_2_cname      := '';
	
		STRING11 debtor_7_party_2_ssn          := '';
		STRING9 debtor_7_party_2_tax_id       := '';
	
		STRING50 debtor_7_party_2_address1    := '';
		STRING19 debtor_7_party_2_address2    := '';
		STRING25 debtor_7_party_2_p_city_name := '';
		STRING2  debtor_7_party_2_st          := '';
		STRING5  debtor_7_party_2_zip         := '';
		STRING4  debtor_7_party_2_zip4        := '';
		STRING4  debtor_7_party_2_msa         := '';
		STRING18 debtor_7_party_2_county_name := '';
		STRING15 debtor_7_party_2_phone       := '';			
		
		
		// creditors (1)
		
		STRING5   creditor_title			:= '';
		STRING20  creditor_fname			:= '';
		STRING20  creditor_mname			:= '';
		STRING20  creditor_lname			:= '';
		STRING5   creditor_name_suffix:= '';
		STRING200 creditor_cname      := '';
		STRING120 creditor_orig_name  := '';
		
		STRING50 creditor_address1    := '';
		STRING19 creditor_address2    := '';
		STRING25 creditor_p_city_name := '';
		STRING2  creditor_st          := '';
		STRING5  creditor_zip         := '';
		STRING4  creditor_zip4        := '';
		STRING4  creditor_msa         := '';
		STRING18 creditor_county_name := '';
		STRING15 creditor_phone       := '';		
		
		// attorneys (1)

		STRING5   attorney_title			:= '';
		STRING20  attorney_fname			:= '';
		STRING20  attorney_mname			:= '';
		STRING20  attorney_lname			:= '';
		STRING5   attorney_name_suffix:= '';
		STRING200 attorney_cname      := '';
		STRING120 attorney_orig_name  := '';
		
		STRING50 attorney_address1    := '';
		STRING19 attorney_address2    := '';
		STRING25 attorney_p_city_name := '';
		STRING2  attorney_st          := '';
		STRING5  attorney_zip         := '';
		STRING4  attorney_zip4        := '';
		STRING4  attorney_msa         := '';
		STRING18 attorney_county_name := '';
		STRING15 attorney_phone       := '';		


		// ***************** Display no thds (third parties). *****************
		
		
		// filings (4)
		
		STRING20 filing_1_filing_number    := '';
		STRING50 filing_1_filing_type_desc := '';
		STRING8  filing_1_filing_date      := '';
		STRING10 filing_1_filing_time      := '';
		STRING10 filing_1_filing_book      := '';
		STRING10 filing_1_filing_page      := '';
		STRING60 filing_1_agency           := '';
		STRING2  filing_1_agency_state     := '';
		STRING35 filing_1_agency_city      := '';
		STRING35 filing_1_agency_county    := '';
		
		STRING20 filing_2_filing_number    := '';
		STRING50 filing_2_filing_type_desc := '';
		STRING8  filing_2_filing_date      := '';
		STRING10 filing_2_filing_time      := '';
		STRING10 filing_2_filing_book      := '';
		STRING10 filing_2_filing_page      := '';
		STRING60 filing_2_agency           := '';
		STRING2  filing_2_agency_state     := '';
		STRING35 filing_2_agency_city      := '';
		STRING35 filing_2_agency_county    := '';
		
		STRING20 filing_3_filing_number    := '';
		STRING50 filing_3_filing_type_desc := '';
		STRING8  filing_3_filing_date      := '';
		STRING10 filing_3_filing_time      := '';
		STRING10 filing_3_filing_book      := '';
		STRING10 filing_3_filing_page      := '';
		STRING60 filing_3_agency           := '';
		STRING2  filing_3_agency_state     := '';
		STRING35 filing_3_agency_city      := '';
		STRING35 filing_3_agency_county    := '';
		
		STRING20 filing_4_filing_number    := '';
		STRING50 filing_4_filing_type_desc := '';
		STRING8  filing_4_filing_date      := '';
		STRING10 filing_4_filing_time      := '';
		STRING10 filing_4_filing_book      := '';
		STRING10 filing_4_filing_page      := '';
		STRING60 filing_4_agency           := '';
		STRING2  filing_4_agency_state     := '';
		STRING35 filing_4_agency_city      := '';
		STRING35 filing_4_agency_county    := '';
		
	END;