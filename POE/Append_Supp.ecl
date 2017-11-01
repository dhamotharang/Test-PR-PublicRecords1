import header_services, business_header, POE, Address, ut, mdr ;

export Append_Supp(dataset(Layouts.Keybuild) pDataset) := FUNCTION


  // Hash base file 
	
	EmpHashBDIDFormat_v2 := header_services.Supplemental_Data.layout_out;
		
	EmpFullOut_HashBDID_v2 := RECORD
		Layouts.Keybuild;
		EmpHashBDIDFormat_v2;
		data16 EmpHashTitleFormat ;
	end;

	EmpFullOut_HashBDID_v2 EmpHashBDID_v2(Layouts.Keybuild l) := transform                            
	 self.hval := hashmd5(intformat((unsigned6)l.bdid,12,1), intformat((unsigned6)l.did,15,1));
	 self.EmpHashTitleFormat := hashmd5(intformat((unsigned6)l.bdid,12,1), l.subject_job_title, l.subject_name.lname, l.subject_name.fname);
	 self := l;
	end;

	EmpONLYHeader_withMD5_v2 := project(pDataset, EmpHashBDID_v2(left));
	
	// First supp file

  Suppression_Layout := header_services.Supplemental_Data.layout_in;

  header_services.Supplemental_Data.mac_verify(	'employment_sup.txt',
																								Suppression_Layout, 
																								emp_ONLY_supp_ds_func	);
	 
	Emp_ONLY_Suppression_In := emp_ONLY_supp_ds_func();
	
	
	dEmpONLYSuppressedIn := PROJECT(	Emp_ONLY_Suppression_In, 
																		header_services.Supplemental_Data.in_to_out(left));
////////////////////////////////////////////////////////////////////
	
	
  //	
	// Second supp file
	//
	
	
	header_services.Supplemental_Data.mac_verify(	'businesscontactsbytitle_sup.txt',
																									Suppression_Layout, 
																								BCbytitle_ds_func	);
	 
	BCbytitle_Suppression_In := BCbytitle_ds_func();
	
	dBCbytitle_SuppressedIn := PROJECT(	BCbytitle_Suppression_In, 
																	header_services.Supplemental_Data.in_to_out(left));

	// Third supp file


 header_services.Supplemental_Data.mac_verify(	'employmentall_sup.txt',
																								Suppression_Layout, 
																								emp_all_supp_ds_func	);
	 
	Emp_All_Suppression_In := emp_all_supp_ds_func();

	dEmpAllSuppressedIn := PROJECT(	Emp_All_Suppression_In, 
																	header_services.Supplemental_Data.in_to_out(left));


  // All in one suppression
	
			
	EmpSuppAll := dEmpONLYSuppressedIn + dBCbytitle_SuppressedIn + dEmpAllSuppressedIn ;
	
	Layout_SuppOnly := RECORD	
		EmpHashBDIDFormat_v2;
		data16 EmpHashTitleFormat ;	
	END ;
	
	Layout_SuppOnly xHashedAll(EmpSuppAll L) := TRANSFORM
	  self.hval := L.hval ; 
		self.EmpHashTitleFormat := L.hval ; 
	END ;
	
	EmpSuppAllOut := PROJECT (EmpSuppAll, xHashedAll(left) ) ;
	

	Layouts.Keybuild tEmpAllSuppress(EmpONLYHeader_withMD5_v2 l) := transform
	 self := l;
	end;


	emp_all_full_out_suppress := JOIN(	EmpONLYHeader_withMD5_v2,
																			EmpSuppAllOut,
																			(left.hval = right.hval) OR (left.EmpHashTitleFormat = right.EmpHashTitleFormat),
																			tEmpAllSuppress(left),
																			left only, all
																			);	
		
	// Injection file
		
	string_layout := RECORD
	
				string15	contact_id;
				string15	did; 
				string15	bdid;       
				string9   ssn;
				string3		score;
				string120 company_name;      
				string10 	company_prim_range;
				string2   company_predir;
				string28 	company_prim_name;
				string4  	company_addr_suffix;
				string2   company_postdir;
				string5  	company_unit_desig;
				string8  	company_sec_range;
				string25 	company_city;
				string2   company_state;
				string5 	company_zip;
				string4 	company_zip4;				
				string35 	company_title;
				string35 	company_department;
				string10 	company_phone;
				string9 	company_fein;
				string5  	title;
				string20 	fname;
				string20 	mname;
				string20 	lname;
				string5  	name_suffix;				
				string10 	prim_range;
				string2   predir;
				string28 	prim_name;
				string4  	addr_suffix;
				string2   postdir;
				string5  	unit_desig;
				string8		sec_range;
				string25	city;
				string2		state;
				string5		zip;
				string4 	zip4;
				string3   county;
				string4   msa;
				string10 	geo_lat;
				string11 	geo_long;
				string10	phone;
				string60	email_address;
				string8	  dt_first_seen;
				string8	  dt_last_seen;
				string1   record_type;	
				string1   active_phone_flag;		
				string1   GLB;
				string2   source;
				string2	  DPPA_State;
				string3   old_score;
				string15  source_count;
				string3   dead_flag:= '000';
				string10  company_status:=''; 
				string2		eor;	

		end;
  
	header_services.Supplemental_Data.mac_verify(	'file_business_employment_v2_inj.txt', 
																								string_layout	, 
																								attr );
	Base_File_In := attr();
	
	
	Layouts.Keybuild xToPOE (Base_File_In L) := TRANSFORM
	
	    SELF.bdid := (INTEGER) L.bdid;
			SELF.source := mdr.sourceTools.src_Teletrack	 ;
			SELF.did := (INTEGER) L.did;
			SELF.did_score := 100 ;
			SELF.bdid_score := 100 ;
      SELF.vendor_id := (string40)hash(L.ssn,
																						L.lname, 
																						L.fname, 
																						L.mname, 
																						StringLib.GetDateYYYYMMDD()) ;
																						
			// Layout_Clean_Name subject_name formatted data
			
			SELF.subject_name.title := L.title;
      SELF.subject_name.fname := L.fname;
      SELF.subject_name.mname := L.mname;
      SELF.subject_name.lname := L.lname;
      SELF.subject_name.name_suffix := L.name_suffix;
			SELF.subject_name.name_score   := '97' ;
			
      // Layout_Clean_Slim subject_address data
			
			 SELF.subject_address.prim_range := L.prim_range;
			 SELF.subject_address.predir := L.predir;
			 SELF.subject_address.prim_name := L.prim_name;
			 SELF.subject_address.addr_suffix := L.addr_suffix;
			 SELF.subject_address.postdir := L.postdir;
			 SELF.subject_address.unit_desig := L.unit_desig;
			 SELF.subject_address.sec_range := L.sec_range;
			 SELF.subject_address.city_name := L.city;
			 SELF.subject_address.st := L.state;
			 SELF.subject_address.zip := L.zip;
			 SELF.subject_address.zip4 := L.zip4;
			//
			
			SELF.subject_phone := (INTEGER) L.phone;
			SELF.subject_ssn := (INTEGER)L.ssn;
			// SELF.subject_dob := 0 ;
			SELF.subject_job_title := L.company_title ;
			SELF.subject_rawaid := 0 ;
			SELF.subject_aceaid := 0;
			SELF.company_name := L.company_name;
			
			//  Layout_Clean_Slim company_address formatted data			
			
			SELF.company_address.prim_range := L.company_prim_range;
			SELF.company_address.predir := L.company_predir;
			SELF.company_address.prim_name := L.company_prim_name;
			SELF.company_address.addr_suffix := L.company_addr_suffix;
			SELF.company_address.postdir := L.company_postdir;
			SELF.company_address.unit_desig := L.company_unit_desig;
			SELF.company_address.sec_range := L.company_sec_range;
			SELF.company_address.city_name := L.company_city;
			SELF.company_address.st := L.company_state;
			SELF.company_address.zip := L.company_zip;
			SELF.company_address.zip4 := L.company_zip4;
			//
			SELF.company_phone := (INTEGER) L.company_phone;
			SELF.company_fein := (INTEGER) L.company_fein;
			SELF.company_rawaid := hash(L.prim_range,
																			 L.predir,
																			 L.prim_name,
																			 L.addr_suffix,
																			 L.postdir,
																			 L.unit_desig,
																			 L.sec_range,
																			 L.city,
																			 L.state,
																			 L.zip,
																			 L.zip4) ;
			
			SELF.company_aceaid := 0;
			
			SELF := [] ;
	  
	END ;
	
	Base_To_POE := PROJECT(Base_File_In, xToPOE (left)) ;
	
	File_To_Process_To_Key := emp_all_full_out_suppress + Base_To_POE;
		
  RETURN File_To_Process_To_Key ;
	
end ;