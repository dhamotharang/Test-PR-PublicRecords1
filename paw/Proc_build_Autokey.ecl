import AutoKeyB2,PAW, header_services, Autokey, ut; 

export Proc_Build_Autokey(

	 string													pversion 
	,dataset(LAYOUT.Employment_Out) pBase			= PAW.File_base_CleanAddr_Keybuild

) :=
FUNCTION
 


//===================================================================

	Suppression_Layout := header_services.Supplemental_Data.layout_in; 

	
  header_services.Supplemental_Data.mac_verify(	'employment_sup.txt',
  																							Suppression_Layout, 
																								emp_ONLY_supp_ds_func	);
	 
	Emp_ONLY_Suppression_In := emp_ONLY_supp_ds_func();

	dEmpONLYSuppressedIn := PROJECT(	Emp_ONLY_Suppression_In, 
																		header_services.Supplemental_Data.in_to_out(left));

	EmpHashBDIDFormat := header_services.Supplemental_Data.layout_out;

	EmpFullOut_HashBDID := RECORD
		Layout.Employment_Out;
		EmpHashBDIDFormat;
	end;

	EmpFullOut_HashBDID EmpHashBDID(Layout.Employment_Out l) := transform                            
	 self.hval := hashmd5(intformat((unsigned6)l.bdid,12,1), intformat((unsigned6)l.did,15,1));
	 self := l;
	end;

	EmpONLYHeader_withMD5 := project(pBase, EmpHashBDID(left));

	Layout.Employment_Out EmpONLYSuppress(EmpONLYHeader_withMD5 l) := transform
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
		Layout.Employment_Out;
		rHashVal;
	end;

	rEmp_withHash addHash(Layout.Employment_Out l) := transform                            
	 self.hval := hashmd5(intformat((unsigned6)l.bdid,12,1), l.company_title, l.lname, l.fname);
	 self := l;
	end;

	ds_withHash := project(emp_ONLY_full_out_suppress, addHash(left));

	Layout.Employment_Out removeHash(ds_withHash l) := transform
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
		Layout.Employment_Out;
		rHashBDID;
	end;

	rFullOut_HashBDID tHashBDID(Layout.Employment_Out l) := transform                            
	 self.hval := hashmd5(intformat((unsigned6)l.bdid,12,1));
	 self := l;
	end;


	dEmpAllHeader_withMD5 := project(emp_by_title_suppress, tHashBDID(left));

	Layout.Employment_Out tEmpAllSuppress(dEmpAllHeader_withMD5 l) := transform
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
	
	// UNSIGNED6 endMax := MAX(paw.File_Base, contact_id);

	paw.Layout.Employment_Out reformated_header(Base_File_In L, INTEGER c) := 
		transform
			self.contact_id 		:=  hash64 (l.did,
																			l.bdid,
																			l.ssn,
																			l.company_name,
																			l.company_prim_range,
																			l.company_predir,
																			l.company_prim_name,
																			l.company_addr_suffix,
																			l.company_unit_desig,
																			l.company_sec_range,
																			l.company_city,
																			l.company_state,
																			l.company_zip,
																			l.company_title,
																			l.company_phone,
																			l.company_fein,
																			l.fname,
																			l.mname,
																			l.lname,
																			l.name_suffix,
																			l.prim_range,
																			l.predir,
																			l.prim_name,
																			l.addr_suffix,
																			l.unit_desig,
																			l.sec_range,
																			l.city,
																			l.state,
																			l.zip,
																			l.phone,
																			l.email_address,
																			l.source);
			self.bdid 					:= (unsigned6)l.bdid;
			self.did  					:= (unsigned6)l.did;
			self.old_score			:= L.score;
			self.source_count		:= 1;
			self.dead_flag 			:= (unsigned6)l.dead_flag;
			self.company_status := '';
			self	 							:= L;
			self                := [];
	end;

	File_To_Append				 := project(Base_File_In, reformated_header(left, COUNTER)); 
	
	File_To_Process_To_Key := emp_all_full_out_suppress + File_To_Append;
	
//=================================================================== 


	b := file_SearchAutokey(File_To_Process_To_Key);
 
						//	b := file_SearchAutokey(pbase);

	AutoKeyB2.MAC_Build (b,
						person_name.fname,person_name.mname,person_name.lname,
						ssn,
						zero,
						phone,
						person_addr.prim_name,person_addr.prim_range,person_addr.st,person_addr.v_city_name,person_addr.zip5,person_addr.sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,
						DID,
						COMPANY_name,
						companY_fein,
						company_phone,
						Bus_addr.prim_name,Bus_addr.prim_range,Bus_addr.st,Bus_addr.p_city_name,Bus_addr.zip5,Bus_addr.sec_range,
						bdid,
						keynames(pversion).root.template,
						keynames(pversion).root.Logical,
						outaction,false,
						[],true,'PAW',
						true,,,contact_id,true) 
						

	retval :=
	sequential(
		 outaction
	);
	 
	return retval;

end;