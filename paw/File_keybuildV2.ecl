IMPORT  RoxieKeyBuild,ut,autokey,doxie, header_services,business_header,mdr, aid;

export File_keybuild_BIPv2(

	dataset(paw.layout.Employment_Out_BIPv2	) pPawBase	= paw.File_base_cleanAddr_keybuild_BIPv2
	                                                

) :=
function

	dBase 	  	  := pPawBase;
	
	Suppression_Layout := header_services.Supplemental_Data.layout_in;

	
  header_services.Supplemental_Data.mac_verify(	'employment_sup.txt',
																								Suppression_Layout, 
																								emp_ONLY_supp_ds_func	);
	 
	Emp_ONLY_Suppression_In := emp_ONLY_supp_ds_func();

	dEmpONLYSuppressedIn := PROJECT(	Emp_ONLY_Suppression_In, 
																		header_services.Supplemental_Data.in_to_out(left));

	EmpHashBDIDFormat := header_services.Supplemental_Data.layout_out;

	EmpFullOut_HashBDID := RECORD
		Layout.Employment_Out_BIPv2;
		EmpHashBDIDFormat;
	end;

	EmpFullOut_HashBDID EmpHashBDID(Layout.Employment_Out_bipv2 l) := transform                            
	 self.hval := hashmd5(intformat((unsigned6)l.bdid,12,1), intformat((unsigned6)l.did,15,1)); 
	 self := l;
	end;

	EmpONLYHeader_withMD5 := project(pPawBase, EmpHashBDID(left));

	Layout.Employment_Out_bipv2 EmpONLYSuppress(EmpONLYHeader_withMD5 l) := transform
	 self := l;
	end;

	emp_ONLY_full_out_suppress := JOIN(	EmpONLYHeader_withMD5,
																			dEmpONLYSuppressedIn,
																			left.hval = right.hval,
																			EmpONLYSuppress(left),
																			left only,
																			lookup);
		

	header_services.Supplemental_Data.mac_verify(	'businesscontactsbytitle_sup.txt',
																									Suppression_Layout, 
																								BCbytitle_ds_func	);
	 
	BCbytitle_Suppression_In := BCbytitle_ds_func();

	dBCbytitle_SuppressedIn := PROJECT(	BCbytitle_Suppression_In, 
																	header_services.Supplemental_Data.in_to_out(left));

	rHashVal := header_services.Supplemental_Data.layout_out;
	
	rEmp_withHash := RECORD
		Layout.Employment_Out_bipv2;
		rHashVal;
	end;

	rEmp_withHash addHash(Layout.Employment_Out_bipv2 l) := transform                            
	 self.hval := hashmd5(intformat((unsigned6)l.bdid,12,1), l.company_title, l.lname, l.fname);
	 self := l;
	end;

	ds_withHash := project(emp_ONLY_full_out_suppress, addHash(left));

	Layout.Employment_Out_bipv2 removeHash(ds_withHash l) := transform
	 self := l;
	end;
	
	emp_by_title_suppress := JOIN(ds_withHash,
																dBCbytitle_SuppressedIn,
																left.hval = right.hval,
																removeHash(left),
																left only,
																lookup);
																			
	header_services.Supplemental_Data.mac_verify(	'employmentall_sup.txt',
																								Suppression_Layout, 
																								emp_all_supp_ds_func	);
	 
	Emp_All_Suppression_In := emp_all_supp_ds_func();

	dEmpAllSuppressedIn := PROJECT(	Emp_All_Suppression_In, 
																	header_services.Supplemental_Data.in_to_out(left));

	rHashBDID := header_services.Supplemental_Data.layout_out;

	rFullOut_HashBDID := RECORD
		Layout.Employment_Out_bipv2;
		rHashBDID;
	end;

	rFullOut_HashBDID tHashBDID(Layout.Employment_Out_bipv2 l) := transform                            
	 self.hval := hashmd5(intformat((unsigned6)l.bdid,12,1));
	 self := l;
	end;


	dEmpAllHeader_withMD5 := project(emp_by_title_suppress, tHashBDID(left));

	Layout.Employment_Out_bipv2 tEmpAllSuppress(dEmpAllHeader_withMD5 l) := transform
	 self := l;
	end;


	emp_all_full_out_suppress := JOIN(	dEmpAllHeader_withMD5,
																			dEmpAllSuppressedIn,
																			left.hval = right.hval,
																			tEmpAllSuppress(left),
																			left only,
																			lookup);
																			
	
	//=========================================================
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
	
	UNSIGNED6 endMax := MAX(paw.File_Base, contact_id);
	
	paw.Layout.Employment_Out_bipv2 reformated_header(Base_File_In L, INTEGER c) := 
	transform
			self.contact_id 		:= endMax + c;
			self.bdid 					:= (unsigned6)l.bdid;
			self.did  					:= (unsigned6)l.did;
			self.old_score			:= L.score;
			self.source_count		:= 1;
			self.dead_flag 			:= (unsigned6)l.dead_flag;
			self.company_status := '';
			self	 							:= L;
			self								:= [];
	end;

	File_To_Append				 := project(Base_File_In, reformated_header(left, COUNTER)); 

	File_To_Process_To_Key := emp_all_full_out_suppress + File_To_Append;
	
	return File_To_Process_To_Key;

end;