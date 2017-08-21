IMPORT Address, BIPV2, AID, hxmx;

EXPORT Layouts := MODULE

	EXPORT Input	:= MODULE
	
		EXPORT hx_record := RECORD
			STRING		claim_type; // I for hospital/institution
			STRING		claim_num;
			STRING		attend_prov_id;
			STRING		attend_prov_name;
			STRING		billing_addr;
			STRING		billing_city;
			STRING		billing_npi;
			STRING		billing_org_name;
			STRING		billing_state;
			STRING		billing_tax_id;
			STRING		billing_zip;
			STRING		ext_injury_diag_code;
			STRING		inpatient_proc1;
			STRING		inpatient_proc2;
			STRING		inpatient_proc3;
			STRING		operating_prov_id;
			STRING		operating_prov_name;
			STRING		other_diag1;
			STRING		other_diag2;
			STRING		other_diag3;
			STRING		other_diag4;
			STRING		other_diag5;
			STRING		other_diag6;
			STRING		other_diag7;
			STRING		other_diag8;
			STRING		other_proc1;
			STRING  	other_proc2;
			STRING		other_proc3;
			STRING		other_proc4;
			STRING		other_proc5;
			STRING		other_proc_method_code;
			STRING		other_prov_id1;
			STRING		other_prov_id2;
			STRING		other_prov_name1;
			STRING		other_prov_name2;
			STRING		outpatient_proc1;
			STRING		outpatient_proc2;
			STRING		outpatient_proc3;
			STRING		principle_diag;
			STRING		principle_proc;
			STRING		service_from;
			STRING		service_line;
			STRING		service_to;
			STRING		submitted_date;
		END;
			
		EXPORT mx_record := RECORD
			STRING		claim_type; // P for Medical/Professional
			STRING		claim_num;
			STRING		billing_pay_to_taxonomy;
			STRING		billing_addr;
			STRING		billing_anesth_lic;
			STRING		billing_city;
			STRING		billing_dentist_lic;
			STRING		billing_first_name;
			STRING		billing_last_name;
			STRING		billing_middle_name;
			STRING		billing_npi;
			STRING		billing_org_name;
			STRING		billing_service_phone;
			STRING		billing_specialty_code;
			STRING		billing_specialty_lic;
			STRING		billing_state;
			STRING		billing_state_lic;
			STRING		billing_tax_id;
			STRING		billing_upin;
			STRING		billing_zip;
			STRING		diag_code1;
			STRING		diag_code2;
			STRING		diag_code3;
			STRING		diag_code4;
			STRING		diag_code5;
			STRING		diag_code6;
			STRING		diag_code7;
			STRING		diag_code8;
			STRING		dme_hcpcs_proc_code;
			STRING		emt_paramedic_first_name;
			STRING		emt_paramedic_last_name;
			STRING		emt_paramedic_middle_name;
			STRING		ext_injury_diag_code;
			STRING		facility_lab_addr;
			STRING		facility_lab_city;
			STRING		facility_lab_name;
			STRING		facility_lab_npi;
			STRING		facility_lab_state;
			STRING		facility_lab_tax_id;
			STRING		facility_lab_type_code;
			STRING		facility_lab_zip;
			STRING		ordering_prov_addr;
			STRING 		ordering_prov_city;
			STRING 		ordering_prov_first_name;
			STRING 		ordering_prov_last_name;
			STRING 		ordering_prov_middle_name;
			STRING 		ordering_prov_npi;
			STRING 		ordering_prov_state;
			STRING		ordering_prov_upin;
			STRING		ordering_prov_zip;
			STRING		pay_to_addr;
			STRING		pay_to_city;
			STRING		pay_to_first_name;
			STRING		pay_to_last_name;
			STRING		pay_to_middle_name;
			STRING		pay_to_npi;
			STRING		pay_to_service_phone;
			STRING		pay_to_state;
			STRING		pay_to_tax_id;
			STRING		pay_to_zip;
			STRING		performing_prov_phone;
			STRING		performing_prov_specialty;
			STRING		performing_prov_tax_id;
			STRING		place_of_service_code;
			STRING		place_of_service_name;
			STRING		prov_a_addr;
			STRING		prov_a_city;
			STRING		prov_a_service_role_code;
			STRING		prov_a_state;
			STRING		prov_a_zip;
			STRING		prov_b_addr;
			STRING		prov_b_city;
			STRING		prov_b_service_role_code;
			STRING		prov_b_state;
			STRING		prov_b_zip;
			STRING		prov_c_addr;
			STRING		prov_c_city;
			STRING		prov_c_service_role_code;
			STRING		prov_c_state;
			STRING		prov_c_zip;
			STRING		purch_service_first_name;
			STRING		purch_service_last_name;
			STRING		purch_service_middle_name;
			STRING		purch_service_npi;
			STRING		purch_service_prov_addr;
			STRING		purch_service_prov_city;
			STRING		purch_service_prov_name;
			STRING		purch_service_prov_phone;
			STRING		purch_service_prov_state;
			STRING		purch_service_prov_zip;
			STRING		purch_service_prov_tax_id;
			STRING		ref_prov_first_name;
			STRING		ref_prov_last_name;
			STRING		ref_prov_middle_name;
			STRING		ref_prov_npi;
			STRING		ref_prov_state;
			STRING		ref_prov_tax_id;
			STRING		ref_prov_taxonomy;
			STRING		ref_prov_upin;
			STRING		render_prov_first_name;
			STRING		render_prov_last_name;
			STRING		render_prov_middle_name;
			STRING		render_prov_npi;
			STRING		render_prov_specialty_code;
			STRING		render_prov_tax_id;
			STRING		service_from_date;
			STRING		serv_line_diag_pointer1;
			STRING		serv_line_diag_pointer2;
			STRING		serv_line_diag_pointer3;
			STRING		serv_line_diag_pointer4;
			STRING		serv_line_diag_pointer5;
			STRING		serv_line_diag_pointer6;
			STRING		serv_line_diag_pointer7;
			STRING		serv_line_diag_pointer8;
			STRING		serv_line_fac_addr;
			STRING		serv_line_fac_city;
			STRING		serv_line_fac_name;
			STRING		serv_line_fac_npi;
			STRING		serv_line_fac_state;
			STRING		serv_line_fac_type_code;
			STRING		serv_line_fac_zip;
			STRING		serv_line_from_date;
			STRING		serv_line_number;
			STRING		serv_line_proc_code;
			STRING		serv_line_purch_service_npi;
			STRING		serv_line_ref_prov_first_name;
			STRING		serv_line_ref_prov_last_name;
			STRING		serv_line_ref_prov_middle_name;
			STRING		serv_line_ref_prov_npi;
			STRING		serv_line_ref_prov_state;
			STRING		serv_line_ref_prov_upin;
			STRING		serv_line_render_prov_npi;
			STRING		serv_line_render_prov_tax_id;
			STRING		serv_line_render_prov_first_name;
			STRING		serv_line_render_prov_last_name;
			STRING		serv_line_render_prov_middle_name;
			STRING		serv_line_render_prov_specialty_code;
			STRING		serv_line_render_prov_upin;
			STRING		serv_line_supervising_prov_first_name;
			STRING		serv_line_supervising_prov_last_name;
			STRING		serv_line_supervising_prov_middle_name;
			STRING		serv_line_supervising_prov_npi;
			STRING		serv_line_supervising_prov_state;
			STRING		serv_line_supervising_prov_upin;
			STRING		service_to_date;
			STRING		submit_date;
			STRING		supervising_prov_first_name;
			STRING		supervising_prov_last_name;
			STRING		supervising_prov_middle_name;
			STRING		supervising_prov_npi;
			STRING		supervising_prov_tax_id;
			STRING		type_of_service_code;
		END;
	END;
	
	EXPORT Consolidated	:= MODULE
	
		EXPORT hx_record	:= RECORD
			STRING	filename;
			Input.hx_record;
		END;
		
		EXPORT mx_record	:= RECORD
			STRING	filename;
			Input.mx_record;
		END;

	END;
	
	EXPORT Base	:= MODULE
	
		EXPORT src_and_date	:= RECORD
			UNSIGNED6 	pid;
			STRING2 		src;		
			UNSIGNED4 	dt_vendor_first_reported;
			UNSIGNED4 	dt_vendor_last_reported;
			UNSIGNED4		dt_first_seen	:= 0;
			UNSIGNED4		dt_last_seen	:= 0;
			STRING1   	ln_record_type;
			UNSIGNED8	 	source_rid;
			UNSIGNED8	 	lnpid;
		END;
	
		EXPORT clean_address := RECORD
			address.Layout_Clean182.prim_range;
		  address.Layout_Clean182.predir;
		  address.Layout_Clean182.prim_name;
		  address.Layout_Clean182.addr_suffix;
		  address.Layout_Clean182.postdir;
		  address.Layout_Clean182.unit_desig;
		  address.Layout_Clean182.sec_range;
		  address.Layout_Clean182.p_city_name;
		  address.Layout_Clean182.v_city_name;
		  address.Layout_Clean182.st;
		  address.Layout_Clean182.zip;
		  address.Layout_Clean182.zip4;
		  address.Layout_Clean182.cart;
		  address.Layout_Clean182.cr_sort_sz;
		  address.Layout_Clean182.lot;
		  address.Layout_Clean182.lot_order;
		  address.Layout_Clean182.dbpc;
		  address.Layout_Clean182.chk_digit;
		  address.Layout_Clean182.rec_type;
		  STRING2		fips_st:='';
		  STRING3		fips_county:='';
		  address.Layout_Clean182.geo_lat;
		  address.Layout_Clean182.geo_long;
		  address.Layout_Clean182.msa;
		  address.Layout_Clean182.geo_blk;
		  address.Layout_Clean182.geo_match;
		  address.Layout_Clean182.err_stat;
			AID.Common.xAID		RawAID;		
			AID.Common.xAID   ACEAID;
		END;
	
		EXPORT clean_name	:= RECORD
			address.Layout_Clean_Name.title;
		  address.Layout_Clean_Name.fname;
		  address.Layout_Clean_Name.mname;
		  address.Layout_Clean_Name.lname;
		  address.Layout_Clean_Name.name_suffix;
			STRING35	clean_company_name;
			STRING1 name_type:='';
			UNSIGNED8	nid;
		END;

		EXPORT hx_record	:= RECORD
			Input.hx_record;
			src_and_date - [lnpid];
			STRING35		clean_billing_company_name;
			UNSIGNED6		billing_bdid;
			UNSIGNED1		billing_bdid_score	:= 0;
			UNSIGNED8		billing_lnpid;
			STRING5			clean_attending_prov_title;
			STRING20		clean_attending_prov_fname;
			STRING20 		clean_attending_prov_mname;
			STRING20 		clean_attending_prov_lname;
			STRING5  		clean_attending_prov_name_suffix;
			STRING1			clean_attending_prov_name_type	:= '';
			UNSIGNED8		clean_attending_prov_nid;
			UNSIGNED4		attending_prov_best_dob;
			STRING9			attending_prov_best_ssn;
			UNSIGNED6 	attending_prov_did;
			UNSIGNED1		attending_prov_did_score :=0;
			UNSIGNED6 	attending_prov_bdid;
			UNSIGNED1 	attending_prov_bdid_score := 0;
			UNSIGNED8	 	attending_prov_lnpid;
			STRING5			clean_operating_prov_title;
			STRING20		clean_operating_prov_fname;
			STRING20 		clean_operating_prov_mname;
			STRING20 		clean_operating_prov_lname;
			STRING5  		clean_operating_prov_name_suffix;
			STRING1			clean_operating_prov_name_type	:= '';
			UNSIGNED8		clean_operating_prov_nid;
			UNSIGNED4		operating_prov_best_dob;
			STRING9			operating_prov_best_ssn;
			UNSIGNED6 	operating_prov_did;
			UNSIGNED1		operating_prov_did_score :=0;
			UNSIGNED6 	operating_prov_bdid;
			UNSIGNED1 	operating_prov_bdid_score := 0;
			UNSIGNED8	 	operating_prov_lnpid;
			STRING5			clean_other_prov1_title;
			STRING20		clean_other_prov1_fname;
			STRING20 		clean_other_prov1_mname;
			STRING20 		clean_other_prov1_lname;
			STRING5  		clean_other_prov1_name_suffix;
			STRING1			clean_other_prov1_name_type	:= '';
			UNSIGNED8		clean_other_prov1_nid;
			UNSIGNED4		other_prov1_best_dob;
			STRING9			other_prov1_best_ssn;
			UNSIGNED6 	other_prov1_did;
			UNSIGNED1		other_prov1_did_score :=0;
			UNSIGNED6 	other_prov1_bdid;
			UNSIGNED1 	other_prov1_bdid_score := 0;
			UNSIGNED8	 	other_prov1_lnpid;
			STRING5			clean_other_prov2_title;
			STRING20		clean_other_prov2_fname;
			STRING20 		clean_other_prov2_mname;
			STRING20 		clean_other_prov2_lname;
			STRING5  		clean_other_prov2_name_suffix;
			STRING1			clean_other_prov2_name_type	:= '';
			UNSIGNED8		clean_other_prov2_nid;
			UNSIGNED4		other_prov2_best_dob;
			STRING9			other_prov2_best_ssn;
			UNSIGNED6 	other_prov2_did;
			UNSIGNED1		other_prov2_did_score :=0;
			UNSIGNED6 	other_prov2_bdid;
			UNSIGNED1 	other_prov2_bdid_score := 0;
			UNSIGNED8	 	other_prov2_lnpid;
			STRING10		clean_billing_prim_range;
			STRING2 		clean_billing_predir;
			STRING28 		clean_billing_prim_name;
			STRING4 		clean_billing_addr_suffix;
			STRING2 		clean_billing_postdir;
			STRING10 		clean_billing_unit_desig;
			STRING8 		clean_billing_sec_range;
			STRING25 		clean_billing_p_city_name;
			STRING2 		clean_billing_st;
			STRING5 		clean_billing_zip;
			STRING4 		clean_billing_zip4;
			STRING4 		clean_billing_cart;
			STRING1 		clean_billing_cr_sort_sz;
			STRING4 		clean_billing_lot;
			STRING1 		clean_billing_lot_order;
			STRING2 		clean_billing_dbpc;
			STRING1 		clean_billing_chk_digit;
			STRING2 		clean_billing_rec_type;
			STRING2 		clean_billing_fips_st;
			STRING3 		clean_billing_fips_county;
			STRING10 		clean_billing_geo_lat;
			STRING11 		clean_billing_geo_long;
			STRING4 		clean_billing_msa;
			STRING7 		clean_billing_geo_blk;
			STRING1 		clean_billing_geo_match;
			STRING4 		clean_billing_err_stat;
			UNSIGNED8 	clean_billing_rawaid;
			UNSIGNED8 	clean_billing_aceaid;
			UNSIGNED4		clean_service_from;
			UNSIGNED4		clean_service_to;
			UNSIGNED4		clean_submitted_date;
			BIPV2.IDlayouts.l_xlink_ids;
		END;
				
		EXPORT mx_record	:= RECORD
			Input.mx_record;
			src_and_date - [lnpid];
			STRING35			clean_billing_company_name;
			UNSIGNED6			billing_company_bdid;
			UNSIGNED1			billing_company_bdid_score	:= 0;
			UNSIGNED8			billing_company_lnpid;
			STRING5				clean_billing_title;
			STRING20			clean_billing_fname;
			STRING20 			clean_billing_mname;
			STRING20 			clean_billing_lname;
			STRING5  			clean_billing_name_suffix;
			STRING1				clean_billing_name_type	:= '';
			UNSIGNED8			clean_billing_nid;
			UNSIGNED4			billing_best_dob;
			STRING9				billing_best_ssn;
			UNSIGNED6 		billing_did;
			UNSIGNED1			billing_did_score :=0;
			UNSIGNED6 		billing_bdid;
			UNSIGNED1 		billing_bdid_score := 0;
			UNSIGNED8	 		billing_lnpid;
			STRING5				clean_emt_paramedic_title;
			STRING20			clean_emt_paramedic_fname;
			STRING20 			clean_emt_paramedic_mname;
			STRING20 			clean_emt_paramedic_lname;
			STRING5  			clean_emt_paramedic_name_suffix;
			STRING1				clean_emt_paramedic_name_type	:= '';
			UNSIGNED8			clean_emt_paramedic_nid;
			UNSIGNED4			emt_paramedic_best_dob;
			STRING9				emt_paramedic_best_ssn;
			UNSIGNED6 		emt_paramedic_did;
			UNSIGNED1			emt_paramedic_did_score :=0;
			UNSIGNED6 		emt_paramedic_bdid;
			UNSIGNED1 		emt_paramedic_bdid_score := 0;
			UNSIGNED8	 		emt_paramedic_lnpid;
			STRING35			clean_facility_lab_name;
			UNSIGNED6			facility_lab_company_bdid;
			UNSIGNED1			facility_lab_company_bdid_score	:= 0;
			UNSIGNED8			facility_lab_company_lnpid;	
			STRING5				clean_ordering_prov_title;
			STRING20			clean_ordering_prov_fname;
			STRING20 			clean_ordering_prov_mname;
			STRING20 			clean_ordering_prov_lname;
			STRING5  			clean_ordering_prov_name_suffix;
			STRING1				clean_ordering_prov_name_type	:= '';
			UNSIGNED8			clean_ordering_prov_nid;
			UNSIGNED4			ordering_prov_best_dob;
			STRING9				ordering_prov_best_ssn;
			UNSIGNED6 		ordering_prov_did;
			UNSIGNED1			ordering_prov_did_score :=0;
			UNSIGNED6 		ordering_prov_bdid;
			UNSIGNED1 		ordering_prov_bdid_score := 0;
			UNSIGNED8	 		ordering_prov_lnpid;
			STRING5				clean_pay_to_title;
			STRING20			clean_pay_to_fname;
			STRING20 			clean_pay_to_mname;
			STRING20 			clean_pay_to_lname;
			STRING5  			clean_pay_to_name_suffix;
			STRING1				clean_pay_to_name_type	:= '';
			UNSIGNED8			clean_pay_to_nid;
			UNSIGNED4			pay_to_best_dob;
			STRING9				pay_to_best_ssn;
			UNSIGNED6 		pay_to_did;
			UNSIGNED1			pay_to_did_score :=0;
			UNSIGNED6 		pay_to_bdid;
			UNSIGNED1 		pay_to_bdid_score := 0;
			UNSIGNED8	 		pay_to_lnpid;		
			STRING5				clean_purch_service_title;
			STRING20			clean_purch_service_fname;
			STRING20 			clean_purch_service_mname;
			STRING20 			clean_purch_service_lname;
			STRING5  			clean_purch_service_name_suffix;
			STRING1				clean_purch_service_name_type	:= '';
			UNSIGNED8			clean_purch_service_nid;
			UNSIGNED4			purch_service_best_dob;
			STRING9				purch_service_best_ssn;
			UNSIGNED6 		purch_service_did;
			UNSIGNED1			purch_service_did_score :=0;
			UNSIGNED6 		purch_service_bdid;
			UNSIGNED1 		purch_service_bdid_score := 0;
			UNSIGNED8	 		purch_service_lnpid;			
			STRING5				clean_ref_prov_title;
			STRING20			clean_ref_prov_fname;
			STRING20 			clean_ref_prov_mname;
			STRING20 			clean_ref_prov_lname;
			STRING5  			clean_ref_prov_name_suffix;
			STRING1				clean_ref_prov_name_type	:= '';
			UNSIGNED8			clean_ref_prov_nid;
			UNSIGNED4			ref_prov_best_dob;
			STRING9				ref_prov_best_ssn;
			UNSIGNED6 		ref_prov_did;
			UNSIGNED1			ref_prov_did_score :=0;
			UNSIGNED6 		ref_prov_bdid;
			UNSIGNED1 		ref_prov_bdid_score := 0;
			UNSIGNED8	 		ref_prov_lnpid;			
			STRING5				clean_render_prov_title;
			STRING20			clean_render_prov_fname;
			STRING20 			clean_render_prov_mname;
			STRING20 			clean_render_prov_lname;
			STRING5  			clean_render_prov_name_suffix;
			STRING1				clean_render_prov_name_type	:= '';
			UNSIGNED8			clean_render_prov_nid;
			UNSIGNED4			render_prov_best_dob;
			STRING9				render_prov_best_ssn;
			UNSIGNED6 		render_prov_did;
			UNSIGNED1			render_prov_did_score :=0;
			UNSIGNED6 		render_prov_bdid;
			UNSIGNED1 		render_prov_bdid_score := 0;
			UNSIGNED8	 		render_prov_lnpid;
			STRING5				clean_serv_line_ref_prov_title;
			STRING20			clean_serv_line_ref_prov_fname;
			STRING20 			clean_serv_line_ref_prov_mname;
			STRING20 			clean_serv_line_ref_prov_lname;
			STRING5  			clean_serv_line_ref_prov_name_suffix;
			STRING1				clean_serv_line_ref_prov_name_type	:= '';
			UNSIGNED8			clean_serv_line_ref_prov_nid;
			UNSIGNED4			serv_line_ref_prov_best_dob;
			STRING9				serv_line_ref_prov_best_ssn;
			UNSIGNED6 		serv_line_ref_prov_did;
			UNSIGNED1			serv_line_ref_prov_did_score :=0;
			UNSIGNED6 		serv_line_ref_prov_bdid;
			UNSIGNED1 		serv_line_ref_prov_bdid_score := 0;
			UNSIGNED8	 		serv_line_ref_prov_lnpid;			
			STRING5				clean_serv_line_render_prov_title;
			STRING20			clean_serv_line_render_prov_fname;
			STRING20 			clean_serv_line_render_prov_mname;
			STRING20 			clean_serv_line_render_prov_lname;
			STRING5  			clean_serv_line_render_prov_name_suffix;
			STRING1				clean_serv_line_render_prov_name_type	:= '';
			UNSIGNED8			clean_serv_line_render_prov_nid;
			UNSIGNED4			serv_line_render_prov_best_dob;
			STRING9				serv_line_render_prov_best_ssn;
			UNSIGNED6 		serv_line_render_prov_did;
			UNSIGNED1			serv_line_render_prov_did_score :=0;
			UNSIGNED6 		serv_line_render_prov_bdid;
			UNSIGNED1 		serv_line_render_prov_bdid_score := 0;
			UNSIGNED8	 		serv_line_render_prov_lnpid;
			STRING5				clean_serv_line_supervising_prov_title;
			STRING20			clean_serv_line_supervising_prov_fname;
			STRING20 			clean_serv_line_supervising_prov_mname;
			STRING20 			clean_serv_line_supervising_prov_lname;
			STRING5  			clean_serv_line_supervising_prov_name_suffix;
			STRING1				clean_serv_line_supervising_prov_name_type	:= '';
			UNSIGNED8			clean_serv_line_supervising_prov_nid;
			UNSIGNED4			serv_line_supervising_prov_best_dob;
			STRING9				serv_line_supervising_prov_best_ssn;
			UNSIGNED6 		serv_line_supervising_prov_did;
			UNSIGNED1			serv_line_supervising_prov_did_score :=0;
			UNSIGNED6 		serv_line_supervising_prov_bdid;
			UNSIGNED1 		serv_line_supervising_prov_bdid_score := 0;
			UNSIGNED8	 		serv_line_supervising_prov_lnpid;		
			STRING5				clean_supervising_prov_title;
			STRING20			clean_supervising_prov_fname;
			STRING20 			clean_supervising_prov_mname;
			STRING20 			clean_supervising_prov_lname;
			STRING5  			clean_supervising_prov_name_suffix;
			STRING1				clean_supervising_prov_name_type	:= '';
			UNSIGNED8			clean_supervising_prov_nid;
			UNSIGNED4			supervising_prov_best_dob;
			STRING9				supervising_prov_best_ssn;
			UNSIGNED6 		supervising_prov_did;
			UNSIGNED1			supervising_prov_did_score :=0;
			UNSIGNED6 		supervising_prov_bdid;
			UNSIGNED1 		supervising_prov_bdid_score := 0;
			UNSIGNED8	 		supervising_prov_lnpid;
			STRING10			clean_billing_prim_range;
			STRING2 			clean_billing_predir;
			STRING28 			clean_billing_prim_name;
			STRING4 			clean_billing_addr_suffix;
			STRING2 			clean_billing_postdir;
			STRING10 			clean_billing_unit_desig;
			STRING8 			clean_billing_sec_range;
			STRING25 			clean_billing_p_city_name;
			STRING2 			clean_billing_st;
			STRING5 			clean_billing_zip;
			STRING4 			clean_billing_zip4;
			STRING4 			clean_billing_cart;
			STRING1 			clean_billing_cr_sort_sz;
			STRING4 			clean_billing_lot;
			STRING1 			clean_billing_lot_order;
			STRING2 			clean_billing_dbpc;
			STRING1 			clean_billing_chk_digit;
			STRING2 			clean_billing_rec_type;
			STRING2 			clean_billing_fips_st;
			STRING3 			clean_billing_fips_county;
			STRING10 			clean_billing_geo_lat;
			STRING11 			clean_billing_geo_long;
			STRING4 			clean_billing_msa;
			STRING7 			clean_billing_geo_blk;
			STRING1 			clean_billing_geo_match;
			STRING4 			clean_billing_err_stat;
			UNSIGNED8 		clean_billing_rawaid;
			UNSIGNED8 		clean_billing_aceaid;			
			STRING10			clean_facility_lab_prim_range;
			STRING2 			clean_facility_lab_predir;
			STRING28 			clean_facility_lab_prim_name;
			STRING4 			clean_facility_lab_addr_suffix;
			STRING2 			clean_facility_lab_postdir;
			STRING10 			clean_facility_lab_unit_desig;
			STRING8 			clean_facility_lab_sec_range;
			STRING25 			clean_facility_lab_p_city_name;
			STRING2 			clean_facility_lab_st;
			STRING5 			clean_facility_lab_zip;
			STRING4 			clean_facility_lab_zip4;
			STRING4 			clean_facility_lab_cart;
			STRING1 			clean_facility_lab_cr_sort_sz;
			STRING4 			clean_facility_lab_lot;
			STRING1 			clean_facility_lab_lot_order;
			STRING2 			clean_facility_lab_dbpc;
			STRING1 			clean_facility_lab_chk_digit;
			STRING2 			clean_facility_lab_rec_type;
			STRING2 			clean_facility_lab_fips_st;
			STRING3 			clean_facility_lab_fips_county;
			STRING10 			clean_facility_lab_geo_lat;
			STRING11 			clean_facility_lab_geo_long;
			STRING4 			clean_facility_lab_msa;
			STRING7 			clean_facility_lab_geo_blk;
			STRING1 			clean_facility_lab_geo_match;
			STRING4 			clean_facility_lab_err_stat;
			UNSIGNED8 		clean_facility_lab_rawaid;
			UNSIGNED8 		clean_facility_lab_aceaid;
			STRING10			clean_ordering_prov_prim_range;
			STRING2 			clean_ordering_prov_predir;
			STRING28 			clean_ordering_prov_prim_name;
			STRING4 			clean_ordering_prov_addr_suffix;
			STRING2 			clean_ordering_prov_postdir;
			STRING10 			clean_ordering_prov_unit_desig;
			STRING8 			clean_ordering_prov_sec_range;
			STRING25 			clean_ordering_prov_p_city_name;
			STRING2 			clean_ordering_prov_st;
			STRING5 			clean_ordering_prov_zip;
			STRING4 			clean_ordering_prov_zip4;
			STRING4 			clean_ordering_prov_cart;
			STRING1 			clean_ordering_prov_cr_sort_sz;
			STRING4 			clean_ordering_prov_lot;
			STRING1 			clean_ordering_prov_lot_order;
			STRING2 			clean_ordering_prov_dbpc;
			STRING1 			clean_ordering_prov_chk_digit;
			STRING2 			clean_ordering_prov_rec_type;
			STRING2 			clean_ordering_prov_fips_st;
			STRING3 			clean_ordering_prov_fips_county;
			STRING10 			clean_ordering_prov_geo_lat;
			STRING11 			clean_ordering_prov_geo_long;
			STRING4 			clean_ordering_prov_msa;
			STRING7 			clean_ordering_prov_geo_blk;
			STRING1 			clean_ordering_prov_geo_match;
			STRING4 			clean_ordering_prov_err_stat;
			UNSIGNED8 		clean_ordering_prov_rawaid;
			UNSIGNED8 		clean_ordering_prov_aceaid;		
			STRING10			clean_pay_to_prim_range;
			STRING2 			clean_pay_to_predir;
			STRING28 			clean_pay_to_prim_name;
			STRING4 			clean_pay_to_addr_suffix;
			STRING2 			clean_pay_to_postdir;
			STRING10 			clean_pay_to_unit_desig;
			STRING8 			clean_pay_to_sec_range;
			STRING25 			clean_pay_to_p_city_name;
			STRING2 			clean_pay_to_st;
			STRING5 			clean_pay_to_zip;
			STRING4 			clean_pay_to_zip4;
			STRING4 			clean_pay_to_cart;
			STRING1 			clean_pay_to_cr_sort_sz;
			STRING4 			clean_pay_to_lot;
			STRING1 			clean_pay_to_lot_order;
			STRING2 			clean_pay_to_dbpc;
			STRING1 			clean_pay_to_chk_digit;
			STRING2 			clean_pay_to_rec_type;
			STRING2 			clean_pay_to_fips_st;
			STRING3 			clean_pay_to_fips_county;
			STRING10 			clean_pay_to_geo_lat;
			STRING11 			clean_pay_to_geo_long;
			STRING4 			clean_pay_to_msa;
			STRING7 			clean_pay_to_geo_blk;
			STRING1 			clean_pay_to_geo_match;
			STRING4 			clean_pay_to_err_stat;
			UNSIGNED8 		clean_pay_to_rawaid;
			UNSIGNED8 		clean_pay_to_aceaid;
			STRING10			clean_prov_a_prim_range;
			STRING2 			clean_prov_a_predir;
			STRING28 			clean_prov_a_prim_name;
			STRING4 			clean_prov_a_addr_suffix;
			STRING2 			clean_prov_a_postdir;
			STRING10 			clean_prov_a_unit_desig;
			STRING8 			clean_prov_a_sec_range;
			STRING25 			clean_prov_a_p_city_name;
			STRING2 			clean_prov_a_st;
			STRING5 			clean_prov_a_zip;
			STRING4 			clean_prov_a_zip4;
			STRING4 			clean_prov_a_cart;
			STRING1 			clean_prov_a_cr_sort_sz;
			STRING4 			clean_prov_a_lot;
			STRING1 			clean_prov_a_lot_order;
			STRING2 			clean_prov_a_dbpc;
			STRING1 			clean_prov_a_chk_digit;
			STRING2 			clean_prov_a_rec_type;
			STRING2 			clean_prov_a_fips_st;
			STRING3 			clean_prov_a_fips_county;
			STRING10 			clean_prov_a_geo_lat;
			STRING11 			clean_prov_a_geo_long;
			STRING4 			clean_prov_a_msa;
			STRING7 			clean_prov_a_geo_blk;
			STRING1 			clean_prov_a_geo_match;
			STRING4 			clean_prov_a_err_stat;
			UNSIGNED8 		clean_prov_a_rawaid;
			UNSIGNED8 		clean_prov_a_aceaid;
			STRING10			clean_prov_b_prim_range;
			STRING2 			clean_prov_b_predir;
			STRING28 			clean_prov_b_prim_name;
			STRING4 			clean_prov_b_addr_suffix;
			STRING2 			clean_prov_b_postdir;
			STRING10 			clean_prov_b_unit_desig;
			STRING8 			clean_prov_b_sec_range;
			STRING25 			clean_prov_b_p_city_name;
			STRING2 			clean_prov_b_st;
			STRING5 			clean_prov_b_zip;
			STRING4 			clean_prov_b_zip4;
			STRING4 			clean_prov_b_cart;
			STRING1 			clean_prov_b_cr_sort_sz;
			STRING4 			clean_prov_b_lot;
			STRING1 			clean_prov_b_lot_order;
			STRING2 			clean_prov_b_dbpc;
			STRING1 			clean_prov_b_chk_digit;
			STRING2 			clean_prov_b_rec_type;
			STRING2 			clean_prov_b_fips_st;
			STRING3 			clean_prov_b_fips_county;
			STRING10 			clean_prov_b_geo_lat;
			STRING11 			clean_prov_b_geo_long;
			STRING4 			clean_prov_b_msa;
			STRING7 			clean_prov_b_geo_blk;
			STRING1 			clean_prov_b_geo_match;
			STRING4 			clean_prov_b_err_stat;
			UNSIGNED8 		clean_prov_b_rawaid;
			UNSIGNED8 		clean_prov_b_aceaid;
			STRING10			clean_prov_c_prim_range;
			STRING2 			clean_prov_c_predir;
			STRING28 			clean_prov_c_prim_name;
			STRING4 			clean_prov_c_addr_suffix;
			STRING2 			clean_prov_c_postdir;
			STRING10 			clean_prov_c_unit_desig;
			STRING8 			clean_prov_c_sec_range;
			STRING25 			clean_prov_c_p_city_name;
			STRING2 			clean_prov_c_st;
			STRING5 			clean_prov_c_zip;
			STRING4 			clean_prov_c_zip4;
			STRING4 			clean_prov_c_cart;
			STRING1 			clean_prov_c_cr_sort_sz;
			STRING4 			clean_prov_c_lot;
			STRING1 			clean_prov_c_lot_order;
			STRING2 			clean_prov_c_dbpc;
			STRING1 			clean_prov_c_chk_digit;
			STRING2 			clean_prov_c_rec_type;
			STRING2 			clean_prov_c_fips_st;
			STRING3 			clean_prov_c_fips_county;
			STRING10 			clean_prov_c_geo_lat;
			STRING11 			clean_prov_c_geo_long;
			STRING4 			clean_prov_c_msa;
			STRING7 			clean_prov_c_geo_blk;
			STRING1 			clean_prov_c_geo_match;
			STRING4 			clean_prov_c_err_stat;
			UNSIGNED8 		clean_prov_c_rawaid;
			UNSIGNED8 		clean_prov_c_aceaid;
			STRING10			clean_purch_service_prim_range;
			STRING2 			clean_purch_service_predir;
			STRING28 			clean_purch_service_prim_name;
			STRING4 			clean_purch_service_addr_suffix;
			STRING2 			clean_purch_service_postdir;
			STRING10 			clean_purch_service_unit_desig;
			STRING8 			clean_purch_service_sec_range;
			STRING25 			clean_purch_service_p_city_name;
			STRING2 			clean_purch_service_st;
			STRING5 			clean_purch_service_zip;
			STRING4 			clean_purch_service_zip4;
			STRING4 			clean_purch_service_cart;
			STRING1 			clean_purch_service_cr_sort_sz;
			STRING4 			clean_purch_service_lot;
			STRING1 			clean_purch_service_lot_order;
			STRING2 			clean_purch_service_dbpc;
			STRING1 			clean_purch_service_chk_digit;
			STRING2 			clean_purch_service_rec_type;
			STRING2 			clean_purch_service_fips_st;
			STRING3 			clean_purch_service_fips_county;
			STRING10 			clean_purch_service_geo_lat;
			STRING11 			clean_purch_service_geo_long;
			STRING4 			clean_purch_service_msa;
			STRING7 			clean_purch_service_geo_blk;
			STRING1 			clean_purch_service_geo_match;
			STRING4 			clean_purch_service_err_stat;
			UNSIGNED8 		clean_purch_service_rawaid;
			UNSIGNED8 		clean_purch_service_aceaid;
			STRING35			clean_serv_line_fac_company_name;
			UNSIGNED6			serv_line_fac_bdid;
			UNSIGNED1			serv_line_fac_bdid_score	:= 0;
			UNSIGNED8			serv_line_fac_lnpid;
			STRING10			clean_serv_line_fac_prim_range;
			STRING2 			clean_serv_line_fac_predir;
			STRING28 			clean_serv_line_fac_prim_name;
			STRING4 			clean_serv_line_fac_addr_suffix;
			STRING2 			clean_serv_line_fac_postdir;
			STRING10 			clean_serv_line_fac_unit_desig;
			STRING8 			clean_serv_line_fac_sec_range;
			STRING25 			clean_serv_line_fac_p_city_name;
			STRING2 			clean_serv_line_fac_st;
			STRING5 			clean_serv_line_fac_zip;
			STRING4 			clean_serv_line_fac_zip4;
			STRING4 			clean_serv_line_fac_cart;
			STRING1 			clean_serv_line_fac_cr_sort_sz;
			STRING4 			clean_serv_line_fac_lot;
			STRING1 			clean_serv_line_fac_lot_order;
			STRING2 			clean_serv_line_fac_dbpc;
			STRING1 			clean_serv_line_fac_chk_digit;
			STRING2 			clean_serv_line_fac_rec_type;
			STRING2 			clean_serv_line_fac_fips_st;
			STRING3 			clean_serv_line_fac_fips_county;
			STRING10 			clean_serv_line_fac_geo_lat;
			STRING11 			clean_serv_line_fac_geo_long;
			STRING4 			clean_serv_line_fac_msa;
			STRING7 			clean_serv_line_fac_geo_blk;
			STRING1 			clean_serv_line_fac_geo_match;
			STRING4 			clean_serv_line_fac_err_stat;
			UNSIGNED8 		clean_serv_line_fac_rawaid;
			UNSIGNED8 		clean_serv_line_fac_aceaid;
			UNSIGNED4			clean_service_from;
			UNSIGNED4			clean_serv_line_from;
			UNSIGNED4			clean_service_to;
			UNSIGNED4			clean_submitted_date;
			BIPV2.IDlayouts.l_xlink_ids;
		END;		
	END;
END;