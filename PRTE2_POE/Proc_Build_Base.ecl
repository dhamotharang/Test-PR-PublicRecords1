IMPORT  PRTE2,PromoteSupers, ut;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION

// PRTE2.CleanFields(files.POE_IN, CleanPOE);

df_POE := project(files.POE_IN,
   Transform(Layouts.Base,
	 Self.Subject_name.title:=left.title;
	 Self.Subject_name.fname:=left.fname;
	 Self.Subject_name.mname:=left.mname;
	 Self.Subject_name.lname:=left.lname;
	 Self.Subject_name.name_suffix:=left.name_suffix;
	 Self.Subject_address.prim_range:=left.subject_prim_range;
	 Self.Subject_address.predir:=left.subject_predir;
	 Self.Subject_address.prim_name:=left.subject_prim_name;
	 Self.Subject_address.addr_suffix:=left.subject_addr_suffix;
	 Self.Subject_address.postdir:=left.subject_postdir;
	 Self.Subject_address.unit_desig:=left.subject_unit_desig;
	 Self.Subject_address.sec_range:=left.subject_sec_range;
	 Self.Subject_address.city_name:=left.subject_city_name;
	 Self.Subject_address.st:=left.subject_st;
	 Self.Subject_address.zip:=left.subject_zip;
	 Self.Subject_address.zip4:=left.subject_zip4;
	 Self.Company_address.prim_range:=left.company_prim_range;
	 Self.Company_address.predir:=left.company_predir;
	 Self.Company_address.prim_name:=left.company_prim_name;
	 Self.Company_address.addr_suffix:=left.company_addr_suffix;
	 Self.Company_address.postdir:=left.company_postdir;
	 Self.Company_address.unit_desig:=left.company_unit_desig;
	 Self.Company_address.city_name:=left.company_city_name;
	 Self.Company_address.st:=left.company_st;
	 Self.Company_address.zip:=left.company_zip;
	 Self.Company_address.zip4:=left.company_zip4;
	 // self.Did:=Prte2.fn_AppendFakeID.did(left.fname, left.lname, (string)left.subject_ssn, (string)left.subject_dob, left.cust_name);	
   self.Did		:= Prte2.fn_AppendFakeID.did(left.fname, left.lname, left.link_ssn, left.link_dob, left.cust_name);	
	 self.bdid  := prte2.fn_AppendFakeID.bdid(left.company_name,	left.company_PRIM_RANGE,	left.Company_PRIM_NAME, left.Company_CITY_NAME, left.Company_ST, left.Company_ZIP, left.Cust_name);
	 Self:=Left;
   self := []; 
   ));

PromoteSupers.MAC_SF_BuildProcess(df_POE,constants.Base_POE, writefile_POE);

sequential(writefile_POE);

Return 'success';
END;