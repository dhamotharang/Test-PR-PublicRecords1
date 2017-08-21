import address;
export layouts_idv := module

	export eFund:=record
		string8 seqnum
		,string1 perf
		,string16 PROJCTID
		,string4 CPCORD30
		,string3 CPCORD60
		,string3 CPCORD90
		,string3 CPCOR180
		,string3 CPCOR365
		,string3 CPCOR730
		,string3 CPCOR999
		,string3 CPUNMICR
		,string4 CPMNSINC
		,string4 CPMXSINC
		,string4 CPQTY30
		,string4 CPQTY60
		,string4 CPQTY90
		,string4 CPQTY180
		,string4 CPQTY365
		,string5 CPQTY730
		,string5 CPQTY999
		,string4 CPMNQNTY
		,string4 CPMXQNTY
		,string9 CPAVQNTY
		,string9 CVCDAYME
		,string3 CVFRAUDS
		,string4 CVTMCLMN
		,string4 CVTMCLMX
		,string3 CVT0030S
		,string3 CVT0060S
		,string3 CVT0090S
		,string3 CVT0180S
		,string3 CVT0365S
		,string3 CVT0730S
		,string3 CVT1095S
		,string3 CVT1825S
		,string3 IV30
		,string3 IV60
		,string3 IV90
		,string3 IV180
		,string3 IV365
		,string3 IV730
		,string3 IV1095
		,string4 IVDSLI
		,string4 IVDSFI
		,string3 SCON30
		,string3 SCON60
		,string3 SCON90
		,string3 SCON180
		,string3 SCON365
		,string3 SCON730
		,string3 SCON999
		,string9 SCOD30
		,string9 SCOD60
		,string9 SCOD90
		,string9 SCOD180
		,string9 SCOD365
		,string9 SCOD730
		,string9 SCOD999
		,string3 SCPN30
		,string3 SCPN60
		,string3 SCPN90
		,string3 SCPN180
		,string3 SCPN365
		,string3 SCPN730
		,string3 SCPN999
		,string9 SCPD30
		,string9 SCPD60
		,string9 SCPD90
		,string9 SCPD180
		,string9 SCPD365
		,string9 SCPD730
		,string9 SCPD999
		,string4 SCOLAST
		,string4 SCPLAST
		,string9 SCOMAXD
		,string9 SCPMAXD
		,string9 SCOMINC
		,string9 SCPMINC
		,string4 SCMINDAY
		,string4 SCMAXDAY
		,string4 SCAEPSPN
		,string4 md_qfd
		,string2 qfact1
		,string2 qfact2
		,string2 qfact3
		,string2 qfact4
		,string2 lfcr
	end;

	export impulse_marketing:=record
		string record_id
		,string firstname
		,string lastname
		,string ssn
		,string address
		,string city
		,string state
		,string zip
		,string phone
		,string dob
		,string application_date
		,string performance
		,string IMG_source
		,string IMG_Sales_Status
	end;


	export infoDirect:=record
		string seqno
		,string firstname
		,string lastname
		,string ssn
		,string streetaddress
		,string city
		,string state
		,string zip
		,string homephone
		,string dateOfBirth
		,string archive_date
		,string perf
		,string firstname_lastname
		,string Birthday
		,string CreditLimit
		,string IndustryCode
	end;


	export rent_bureau:=record
		string LexNex_ID
		,string tl_1_lease_id
		,string tl_1_current_lease
		,string tl_1_num_lessees
		,string tl_1_city
		,string tl_1_state
		,string tl_1_zip
		,string tl_1_begin_date
		,string tl_1_end_date
		,string tl_1_movein_date
		,string tl_1_moveout_date
		,string tl_1_last_activity_date
		,string tl_1_last_payment_date
		,string tl_1_late_count
		,string tl_1_nsf_count
		,string tl_1_lemo
		,string tl_1_rb_pay_vector
		,string tl_1_rent
		,string tl_1_total_rent
		,string tl_1_total_write_offs
		,string tl_1_total_rent_write_offs
		,string tl_1_total_non_rent_write_offs
		,string tl_1_total_outstanding_rent
		,string tl_1_total_outstanding
		,string tl_2_lease_id
		,string tl_2_current_lease
		,string tl_2_num_lessees
		,string tl_2_city
		,string tl_2_state
		,string tl_2_zip
		,string tl_2_begin_date
		,string tl_2_end_date
		,string tl_2_movein_date
		,string tl_2_moveout_date
		,string tl_2_last_activity_date
		,string tl_2_last_payment_date
		,string tl_2_late_count
		,string tl_2_nsf_count
		,string tl_2_lemo
		,string tl_2_rb_pay_vector
		,string tl_2_rent
		,string tl_2_total_rent
		,string tl_2_total_write_offs
		,string tl_2_total_rent_write_offs
		,string tl_2_total_non_rent_write_offs
		,string tl_2_total_outstanding_rent
		,string tl_2_total_outstanding
		,string tl_3_lease_id
		,string tl_3_current_lease
		,string tl_3_num_lessees
		,string tl_3_city
		,string tl_3_state
		,string tl_3_zip
		,string tl_3_begin_date
		,string tl_3_end_date
		,string tl_3_movein_date
		,string tl_3_moveout_date
		,string tl_3_last_activity_date
		,string tl_3_last_payment_date
		,string tl_3_late_count
		,string tl_3_nsf_count
		,string tl_3_lemo
		,string tl_3_rb_pay_vector
		,string tl_3_rent
		,string tl_3_total_rent
		,string tl_3_total_write_offs
		,string tl_3_total_rent_write_offs
		,string tl_3_total_non_rent_write_offs
		,string tl_3_total_outstanding_rent
		,string tl_3_total_outstanding
		,string tl_4_lease_id
		,string tl_4_current_lease
		,string tl_4_num_lessees
		,string tl_4_city
		,string tl_4_state
		,string tl_4_zip
		,string tl_4_begin_date
		,string tl_4_end_date
		,string tl_4_movein_date
		,string tl_4_moveout_date
		,string tl_4_last_activity_date
		,string tl_4_last_payment_date
		,string tl_4_late_count
		,string tl_4_nsf_count
		,string tl_4_lemo
		,string tl_4_rb_pay_vector
		,string tl_4_rent
		,string tl_4_total_rent
		,string tl_4_total_write_offs
		,string tl_4_total_rent_write_offs
		,string tl_4_total_non_rent_write_offs
		,string tl_4_total_outstanding_rent
		,string tl_4_total_outstanding
		,string col_1_collection_id
		,string col_1_moveout_date
		,string col_1_placed_amt
		,string col_1_balance_amt
		,string col_1_collected_amt
		,string col_1_collection_status
		,string col_2_collection_id
		,string col_2_moveout_date
		,string col_2_placed_amt
		,string col_2_balance_amt
		,string col_2_collected_amt
		,string col_2_collection_status
		,string col_3_collection_id
		,string col_3_moveout_date
		,string col_3_placed_amt
		,string col_3_balance_amt
		,string col_3_collected_amt
		,string col_3_collection_status
		,string col_4_collection_id
		,string col_4_moveout_date
		,string col_4_placed_amt
		,string col_4_balance_amt
		,string col_4_collected_amt
		,string col_4_collection_status
	end;


	export teletrack:=record
		string Social_Security_Number
		,string Name
		,string Account_number
		,string Inquiry_Date
		,string Invalid_SSN
		,string Deceased_SSN
		,string Recent_Issued_SSN
		,string Total_Open_Chargeoffs
		,string Open_Chargeoffs_Rent_to_Own_Industry
		,string Open_Chargeoffs_Check_Advance_Industry
		,string Open_Chargeoffs_Cable_TV_Industry
		,string Open_Chargeoffs_Auto_Finance_Industry
		,string Open_Chargeoffs_Other_Industries
		,string Open_Chargeoffs_Past_3_months
		,string Open_Chargeoffs_Rent_to_Own_Industry_Past_3_months
		,string Open_Chargeoffs_Check_Advance_Industry_Past_3_months
		,string Open_Chargeoffs_Cable_TV_Industry_Past_3_months
		,string Open_Chargeoffs_Auto_Finance_Industry_Past_3_months
		,string Open_Chargeoffs_Other_Industries_Past_3_months
		,string Open_Chargeoffs_Past_6_months
		,string Open_Chargeoffs_Rent_to_Own_Industry_Past_6_months
		,string Open_Chargeoffs_Check_Advance_Industry_Past_6_months
		,string Open_Chargeoffs_Cable_TV_Industry_Past_6_months
		,string Open_Chargeoffs_Auto_Finance_Industry_Past_6_months
		,string Open_Chargeoffs_Other_Industries_Past_6_months
		,string Open_Chargeoffs_Past_9_months
		,string Open_Chargeoffs_Rent_to_Own_Industry_Past_9_months
		,string Open_Chargeoffs_Check_Advance_Industry_Past_9_months
		,string Open_Chargeoffs_Cable_TV_Industry_Past_9_months
		,string Open_Chargeoffs_Auto_Finance_Industry_Past_9_months
		,string Open_Chargeoffs_Other_Industries_Past_9_months
		,string Open_Chargeoffs_Past_12_months
		,string Open_Chargeoffs_Rent_to_Own_Industry_Past_12_months
		,string Open_Chargeoffs_Check_Advance_Industry_Past_12_months
		,string Open_Chargeoffs_Cable_TV_Industry_Past_12_months
		,string Open_Chargeoffs_Auto_Finance_Industry_Past_12_months
		,string Open_Chargeoffs_Other_Industries_Past_12_months
		,string Open_Chargeoffs_Past_24_months
		,string Open_Chargeoffs_Rent_to_Own_Industry_Past_24_months
		,string Open_Chargeoffs_Check_Advance_Industry_Past_24_months
		,string Open_Chargeoffs_Cable_TV_Industry_Past_24_months
		,string Open_Chargeoffs_Auto_Finance_Industry_Past_24_months
		,string Open_Chargeoffs_Other_Industries_Past_24_months
		,string Total_Inquiries
		,string Inquiries_Rent_to_Own_Industry
		,string Inquiries_Check_Advance_Industry
		,string Inquiries_Cable_TV_Industry
		,string Inquiries_Auto_Finance_Industry
		,string Inquiries_Other_Industries
		,string Inquiries_Past_3_months
		,string Inquiries_Rent_to_Own_Industry_Past_3_months
		,string Inquiries_Check_Advance_Industry_Past_3_months
		,string Inquiries_Cable_TV_Industry_Past_3_months
		,string Inquiries_Auto_Finance_Industry_Past_3_months
		,string Inquiries_Other_Industries_Past_3_months
		,string Inquiries_Past_6_months
		,string Inquiries_Rent_to_Own_Industry_Past_6_months
		,string Inquiries_Check_Advance_Industry_Past_6_months
		,string Inquiries_Cable_TV_Industry_Past_6_months
		,string Inquiries_Auto_Finance_Industry_Past_6_months
		,string Inquiries_Other_Industries_Past_6_months
		,string Inquiries_Past_9_months
		,string Inquiries_Rent_to_Own_Industry_Past_9_months
		,string Inquiries_Check_Advance_Industry_Past_9_months
		,string Inquiries_Cable_TV_Industry_Past_9_months
		,string Inquiries_Auto_Finance_Industry_Past_9_months
		,string Inquiries_Other_Industries_Past_9_months
		,string Inquiries_Past_12_months
		,string Inquiries_Rent_to_Own_Industry_Past_12_months
		,string Inquiries_Check_Advance_Industry_Past_12_months
		,string Inquiries_Cable_TV_Industry_Past_12_months
		,string Inquiries_Auto_Finance_Industry_Past_12_months
		,string Inquiries_Other_Industries_Past_12_months
		,string Inquiries_Past_24_months
		,string Inquiries_Rent_to_Own_Industry_Past_24_months
		,string Inquiries_Check_Advance_Industry_Past_24_months
		,string Inquiries_Cable_TV_Industry_Past_24_months
		,string Inquiries_Auto_Finance_Industry_Past_24_months
		,string Inquiries_Other_Industries_Past_24_months
		,string Total_Paid_Chargeoffs
		,string Paid_Chargeoffs_Rent_to_Own_Industry
		,string Paid_Chargeoffs_Check_Advance_Industry
		,string Paid_Chargeoffs_Cable_TV_Industry
		,string Paid_Chargeoffs_Auto_Finance_Industry
		,string Paid_Chargeoffs_Other_Industries
		,string Paid_Chargeoffs_Past_3_months
		,string Paid_Chargeoffs_Rent_to_Own_Industry_Past_3_months
		,string Paid_Chargeoffs_Check_Advance_Industry_Past_3_months
		,string Paid_Chargeoffs_Cable_TV_Industry_Past_3_months
		,string Paid_Chargeoffs_Auto_Finance_Industry_Past_3_months
		,string Paid_Chargeoffs_Other_Industries_Past_3_months
		,string Paid_Chargeoffs_Past_6_months
		,string Paid_Chargeoffs_Rent_to_Own_Industry_Past_6_months
		,string Paid_Chargeoffs_Check_Advance_Industry_Past_6_months
		,string Paid_Chargeoffs_Cable_TV_Industry_Past_6_months
		,string Paid_Chargeoffs_Auto_Finance_Industry_Past_6_months
		,string Paid_Chargeoffs_Other_Industries_Past_6_months
		,string Paid_Chargeoffs_Past_9_months
		,string Paid_Chargeoffs_Rent_to_Own_Industry_Past_9_months
		,string Paid_Chargeoffs_Check_Advance_Industry_Past_9_months
		,string Paid_Chargeoffs_Cable_TV_Industry_Past_9_months
		,string Paid_Chargeoffs_Auto_Finance_Industry_Past_9_months
		,string Paid_Chargeoffs_Other_Industries_Past_9_months
		,string Paid_Chargeoffs_Past_12_months
		,string Paid_Chargeoffs_Rent_to_Own_Industry_Past_12_months
		,string Paid_Chargeoffs_Check_Advance_Industry_Past_12_months
		,string Paid_Chargeoffs_Cable_TV_Industry_Past_12_months
		,string Paid_Chargeoffs_Auto_Finance_Industry_Past_12_months
		,string Paid_Chargeoffs_Other_Industries_Past_12_months
		,string Paid_Chargeoffs_Past_24_months
		,string Paid_Chargeoffs_Rent_to_Own_Industry_Past_24_months
		,string Paid_Chargeoffs_Check_Advance_Industry_Past_24_months
		,string Paid_Chargeoffs_Cable_TV_Industry_Past_24_months
		,string Paid_Chargeoffs_Auto_Finance_Industry_Past_24_months
		,string Paid_Chargeoffs_Other_Industries_Past_24_months
		,string Total_Negative_Landlord_Tenant_Court_Records
		,string Total_Bankruptcies
		,string Bankruptcies_Chapter_7
		,string Bankruptcies_Chapter_13
		,string Total_Occurrences_of_Multiple_Outstanding_Loans
	end;


	export Segment_52_SocialGuard_Data:=record
		string Segment_Type
		,string Social_Security_Number
		,string Customer_Reference_Number
		,string Customer_Name
		,string Data_Type
		,string Year_Issued
		,string Name_of_Deceased
		,string Date_Deceased
	end;


	export Segment_53_Charge_Offs:=record
		string Segment_Type
		,string Social_Security_Number
		,string Customer_Reference_Number
		,string Customer_Name
		,string Reporting_Merchant_ID
		,string Date_Reported
		,string Item_Charged_Off
		,string Amount_Charged_Off
		,string Date_Charged_Off
		,string Down_Payment
		,string Weekly_Payment
		,string Total_Payments_Scheduled
		,string Total_Payments_Made
		,string Agreement_Date
		,string Payment_Schedule
		,string Last_Known_Address
		,string Last_Known_City
		,string Last_Known_State
		,string Last_Known_Zip
		,string Reporting_Co_Industry
	end;


	export Segment_54_Previous_Inquiries:=record
		string Segment_Type
		,string Social_Security_Number
		,string Customer_Reference_Number
		,string Customer_Name
		,string Inquiring_Merchant_ID
		,string Date_of_Inquiry
		,string Inquiring_Co_Industry
	end;


	export Segment_56_SkipGuard_Alerts:=record
		string Segment_Type
		,string Social_Security_Number
		,string Customer_Reference_Number
		,string Customer_Name
		,string Involved_Merchant_ID
		,string SkipGuard_Alert_Date
		,string Inquiring_Co_Industry
		,string Loan_Amount
	end;


	export Segment_61_Tenant_Evictions_and_Court_Dispositions:=record
		string Segment_Type
		,string Social_Security_Number
		,string Customer_Reference_Number
		,string Tenant_Name
		,string Address
		,string City
		,string State
		,string Zip_Code
		,string Date_Case_Filed
		,string Plaintiff
		,string Case_Number
		,string Court
		,string Case_Type
		,string Rent_Amount
		,string Claim_Amount
		,string Disposition_Date
		,string Disposition
		,string Judgement_Amount
	end;


	export Segment_62_Paid_Charge_Offs:=record
		string Segment_Type
		,string Social_Security_Number
		,string Customer_Reference_Number
		,string Customer_Name
		,string Reporting_Merchant_ID
		,string Date_Reported_as_Paid
		,string Item_Charged_Off
		,string Amount_Charged_Off
		,string Date_Charged_Off
		,string Agreement_Date
		,string Last_Known_Address
		,string Last_Known_City
		,string Last_Known_State
		,string Last_Known_Zip
		,string Reporting_Co_Industry
	end;


	export Segment_68_Bankruptcies:=record
		string Segment_Type
		,string Social_Security_Number
		,string Customer_Reference_Number
		,string Customer_Name
		,string Address_City_State_Zip
		,string Court_Code
		,string Case_Number
		,string Chapter
		,string Judge_and_Trustee
		,string Case_Date
		,string Office
		,string Closed_Date
		,string Status
	end;



	export orig_slim := record
		String1 src
		,String50 orig_key
		,String9 orig_SSN
		,String10 orig_DOB
		,String10 orig_phone
		,String4 orig_Title
		,String20 orig_First_Name
		,String20 orig_Mid_Name
		,String35 orig_Last_Name
		,String4 orig_sffx
		,String100 orig_address
		,String25 orig_City
		,String2 orig_state
		,String5 orig_Zip
	end;

	export base := record
		unsigned6	did       :=0
		,unsigned	did_score :=0

		,orig_slim

		,String9 clean_ssn:=''
		,String8 clean_DOB:=''
		,String10 clean_hphone:=''
		,String10 clean_wphone:=''
		// ,string8  date_first_seen := ''
		// ,string8  date_last_seen := ''
		// ,string8  date_vendor_first_reported := ''
		// ,string8  date_vendor_last_reported := ''
		,address.Layout_Clean_Name.title
		,address.Layout_Clean_Name.fname
		,address.Layout_Clean_Name.mname
		,address.Layout_Clean_Name.lname
		,address.Layout_Clean_Name.name_suffix
		,address.Layout_Clean_Name.name_score

		,address.Layout_Clean182.prim_range
		,address.Layout_Clean182.predir
		,address.Layout_Clean182.prim_name
		,address.Layout_Clean182.addr_suffix
		,address.Layout_Clean182.postdir
		,address.Layout_Clean182.unit_desig
		,address.Layout_Clean182.sec_range
		,address.Layout_Clean182.p_city_name
		,address.Layout_Clean182.v_city_name
		,address.Layout_Clean182.st
		,address.Layout_Clean182.zip
		,address.Layout_Clean182.zip4
		,address.Layout_Clean182.cart
		,address.Layout_Clean182.cr_sort_sz
		,address.Layout_Clean182.lot
		,address.Layout_Clean182.lot_order
		,address.Layout_Clean182.dbpc
		,address.Layout_Clean182.chk_digit
		,address.Layout_Clean182.rec_type
		,string2		fips_county:=''
		,string3		county:=''
		,address.Layout_Clean182.geo_lat
		,address.Layout_Clean182.geo_long
		,address.Layout_Clean182.msa
		,address.Layout_Clean182.geo_blk
		,address.Layout_Clean182.geo_match
		,address.Layout_Clean182.err_stat
	end;

	export translateSource(string2 src) := case(src,
		'1' => 'eFund',
		'2' => 'impulse_marketing',
		'3' => 'infoDirect',
		'4' => 'rent_bureau',
		'5' => 'teletrack',
		'6' => 'Segment_52_SocialGuard_Data',
		'7' => 'Segment_53_Charge_Offs',
		'8' => 'Segment_54_Previous_Inquiries',
		'9' => 'Segment_56_SkipGuard_Alerts',
		'0' => 'Segment_61_Tenant_Evictions_and_Court_Dispositions',
		'A' => 'Segment_62_Paid_Charge_Offs',
		'B' => 'Segment_68_Bankruptcies',
		'?'+src);

end;