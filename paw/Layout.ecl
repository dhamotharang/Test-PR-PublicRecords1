IMPORT standard, business_header, bipv2;
EXPORT Layout:=
  module

	export StatusDescLayout	:=	
	record
		string StatusDesc;
	end;

	EXPORT paw_stats:= business_header.Layout_Business_Contacts_Stats;
          
	 EXPORT Business_Contact := RECORD
			UNSIGNED6 		bdid 			:= 0;       // BDID from Business Headers
			UNSIGNED6 		did 			:= 0;        // DID from Headers
			UNSIGNED1 		contact_score 	:= 0;
			QSTRING34 		vendor_id 		:= ''; // Vendor key
			UNSIGNED4 		dt_first_seen		;   // From contact info if available
			UNSIGNED4 		dt_last_seen		;    // From contact infor if available
			STRING2   		source				;          // Source file type
			STRING1   		record_type			;     // 'C' = Current, 'H' = Historical
			STRING1   		from_hdr 	 := 'N'; // 'Y' if contact is from address 
									   // match with person headers.
			BOOLEAN   		glb 		:= false;    // GLB restricted record (only possible
									   // for contacts pulled from header)
			BOOLEAN	  		dppa 		:= false;   // DPPA restricted record
			QSTRING35 		company_title		;   // Title of Contact at Company if available
			QSTRING35 		company_department := '';
			QSTRING5  		title				;
			QSTRING20 		fname				;
			QSTRING20 		mname				;
			QSTRING20 		lname				;
			QSTRING5  		name_suffix			;
			STRING1   		name_score			;
			QSTRING10 		prim_range			;
			STRING2   		predir				;
			QSTRING28 		prim_name			;
			QSTRING4  		addr_suffix			;
			STRING2   		postdir				;
			QSTRING5  		unit_desig			;
			QSTRING8  		sec_range			;
			QSTRING25 		city				;
			STRING2   		state				;
			UNSIGNED3 		zip					;
			UNSIGNED2 		zip4				;
			STRING3   		county				;
			STRING4   		msa					;
			QSTRING10 		geo_lat				;
			QSTRING11 		geo_long			;
			UNSIGNED6 		phone				;
			STRING60 		email_address		;
			UNSIGNED4 		ssn 			:= 0;
			QSTRING34 		company_source_group := ''; // Source group
			QSTRING120 		company_name		;
			QSTRING10 		company_prim_range	;
			STRING2   		company_predir		;
			QSTRING28 		company_prim_name	;
			QSTRING4  		company_addr_suffix	;
			STRING2   		company_postdir		;
			QSTRING5  		company_unit_desig	;
			QSTRING8  		company_sec_range	;
			QSTRING25 		company_city		;
			STRING2   		company_state		;
			UNSIGNED3 		company_zip			;
			UNSIGNED2 		company_zip4		;
			UNSIGNED6 		company_phone		;
			UNSIGNED4 		company_fein 		:= 0;
			UNSIGNED8 		__filepos { virtual(fileposition)};
	
	END;
	
	EXPORT	Business_Contact_Seq	:= RECORD
			UNSIGNED6 		bdid 			:= 0;       // BDID from Business Headers
			UNSIGNED6 		did 			:= 0;        // DID from Headers
			UNSIGNED1 		contact_score 	:= 0;
			QSTRING34 		vendor_id 		:= ''; // Vendor key
			UNSIGNED4 		dt_first_seen		;   // From contact info if available
			UNSIGNED4 		dt_last_seen		;    // From contact infor if available
			STRING2   		source				;          // Source file type
			STRING1   		record_type			;     // 'C' = Current, 'H' = Historical
			STRING1   		from_hdr 	 := 'N'; // 'Y' if contact is from address 
									   // match with person headers.
			BOOLEAN   		glb 		:= false;    // GLB restricted record (only possible
									   // for contacts pulled from header)
			BOOLEAN	  		dppa 		:= false;   // DPPA restricted record
			QSTRING35 		company_title		;   // Title of Contact at Company if available
			QSTRING35 		company_department := '';
			QSTRING5  		title				;
			QSTRING20 		fname				;
			QSTRING20 		mname				;
			QSTRING20 		lname				;
			QSTRING5  		name_suffix			;
			STRING1   		name_score			;
			QSTRING10 		prim_range			;
			STRING2   		predir				;
			QSTRING28 		prim_name			;
			QSTRING4  		addr_suffix			;
			STRING2   		postdir				;
			QSTRING5  		unit_desig			;
			QSTRING8  		sec_range			;
			QSTRING25 		city				;
			STRING2   		state				;
			UNSIGNED3 		zip					;
			UNSIGNED2 		zip4				;
			STRING3   		county				;
			STRING4   		msa					;
			QSTRING10 		geo_lat				;
			QSTRING11 		geo_long			;
			UNSIGNED6 		phone				;
			STRING60 		email_address		;
			UNSIGNED4 		ssn 			:= 0;
			QSTRING34 		company_source_group := ''; // Source group
			QSTRING120 		company_name		;
			QSTRING10 		company_prim_range	;
			STRING2   		company_predir		;
			QSTRING28 		company_prim_name	;
			QSTRING4  		company_addr_suffix	;
			STRING2   		company_postdir		;
			QSTRING5  		company_unit_desig	;
			QSTRING8  		company_sec_range	;
			QSTRING25 		company_city		;
			STRING2   		company_state		;
			UNSIGNED3 		company_zip			;
			UNSIGNED2 		company_zip4		;
			UNSIGNED6 		company_phone		;
			UNSIGNED4 		company_fein 		:= 0;
			UNSIGNED6 		seqNum;
	END;
	
	EXPORT  Business_Contact_Stats :=RECORD
			Business_Contact								;
			UNSIGNED4 		bdid_per_addr		:= 0		;
			UNSIGNED4 		apts				:= 0		;
			UNSIGNED4 		ppl					:= 0		;
			UNSIGNED4 		r_phone_per_addr	:= 0		;
			UNSIGNED4 		b_phone_per_addr	:= 0		;
			UNSIGNED4 		dnb_emps			:= 0		;
			UNSIGNED4 		irs5500_emps		:= 0		;
			UNSIGNED4 		domainss			:= 0		;
			UNSIGNED1 		sources				:= 0		;
			UNSIGNED1 		company_name_score	:= 0		;
			UNSIGNED1 		combined_score		:= 0		;
			UNSIGNED1 		combined_new_score	:= 0		;
			BOOLEAN   		has_gong_yp			:= FALSE	;
			BOOLEAN   		eq_emp_match		:= FALSE	;
			BOOLEAN  		current_corp		:= FALSE	;
			UNSIGNED6 		best_phone			:= 0		;
			UNSIGNED6 		source_count		:= 0		;
			
	END;
		
	EXPORT	Business_Contact_Stats_Seq	:= RECORD
			Business_Contact_Stats;
			UNSIGNED6 seqNum;
	END;
	
	EXPORT Employment_Out_old := RECORD
			UNSIGNED6 contact_id;
			UNSIGNED6 did; 
			UNSIGNED6 bdid;
			STRING9   ssn;
			STRING3   score;
			STRING120 company_name;
			STRING10  company_prim_range;
			STRING2   company_predir;
			STRING28  company_prim_name;
			STRING4   company_addr_suffix;
			STRING2   company_postdir;
			STRING5   company_unit_desig;
			STRING8   company_sec_range;
			STRING25  company_city;
			STRING2   company_state;
			STRING5   company_zip;
			STRING4   company_zip4;
			STRING35  company_title;
			STRING35  company_department;
			STRING10  company_phone;
			STRING9   company_fein;
			STRING5   title;
			STRING20  fname;
			STRING20  mname;
			STRING20  lname;
			STRING5   name_suffix;
			STRING10  prim_range;
			STRING2   predir;
			STRING28  prim_name;
			STRING4   addr_suffix;
			STRING2   postdir;
			STRING5   unit_desig;
			STRING8   sec_range;
			STRING25  city;
			STRING2   state;
			STRING5   zip;
			STRING4   zip4;
			STRING3   county;
			STRING4   msa;
			STRING10  geo_lat;
			STRING11  geo_long;
			STRING10  phone;
			STRING60  email_address;
			STRING8   dt_first_seen;
			STRING8   dt_last_seen;
			STRING1   record_type;
			STRING1   active_phone_flag;
			STRING1   GLB;
			STRING2   source;
			STRING2   DPPA_State;
			STRING3   old_score;
			UNSIGNED6 source_count;
			UNSIGNED1 dead_flag:= 0;
			STRING10   company_status:=''; 
	 END;
	
	EXPORT Employment_Out := RECORD		
		Employment_Out_old;
		string from_hdr;
		string vendor_id;
		unsigned8 RawAID := 0;    // Added for Address_id
		unsigned8	Company_RawAID	:= 0;    // Added for Address_id
		// The below 2 fields are added for CCPA (California Consumer Protection Act) project enhancements - JIRA# CCPA-111
		unsigned4 global_sid := 0;
		unsigned8 record_sid := 0;
	end;
	
	EXPORT Employment_Out_BIPv2 := RECORD		
		Employment_Out;
		BIPV2.IDlayouts.l_xlink_ids;	
	end;	

END ;