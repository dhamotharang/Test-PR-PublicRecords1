import ut, std, bipv2;

EXPORT fn_AppendFakeID := module
		 
			export did(string in_fname, string in_lname, string in_ssn, string in_dob, string in_customer_name)	 := function
			in_dob2:= if(STD.Date.IsValidDate((unsigned)in_dob)=true,in_dob,'0');
   	  did_out := 	if(in_fname<>'' and in_lname<>'' and ut.full_ssn(in_ssn) and ut.age((integer)in_dob2) between 1 and 300, (UNSIGNED6) hash(ut.CleanSpacesAndUpper(in_ssn + in_dob2 + in_customer_name)), 0); 
			
			return did_out;
			end;

			export bdid(string in_cname,	string in_prim_range,	string in_prim_name, string in_v_city_name, string in_st, string in_zip5, string in_customer_name) := function
			bdid_out := if(in_cname <> '' and in_prim_name <> '' and (unsigned)in_zip5 > 0, (UNSIGNED6) hash(ut.CleanSpacesAndUpper(ut.CleanCompany(in_cname) + in_prim_range + in_prim_name + in_v_city_name + in_st + in_zip5 + in_customer_name)), 0);
			return bdid_out;
			end;
			
			export LinkIds(string in_cname,	
										 string in_fein,
										 string in_incorp_date,
										 string in_prim_range,	
										 string in_prim_name, 
										 string in_sec_range, 
										 string in_v_city_name, 
										 string in_st, 
										 string in_zip5, 
										 string in_customer_name
										 ) := module
										 
            in_incorp_date2:= if(STD.Date.IsValidDate((unsigned)in_incorp_date)=true,in_incorp_date,'0');
				 	 
					  shared vCmpnyId := if(in_cname <> '' and (unsigned)in_incorp_date2 > 0 and (unsigned)in_fein > 0, (UNSIGNED6) hash(ut.CleanSpacesAndUpper(in_incorp_date2 + in_fein + in_customer_name)), 0);
						export powid		:= if(in_cname <> '' and in_prim_name <> '' and (unsigned)in_zip5 > 0, (UNSIGNED6) hash(ut.CleanSpacesAndUpper(ut.CleanCompany(in_cname) + in_prim_range + in_prim_name + in_v_city_name + in_st + in_zip5 + in_customer_name)), 0);
						export proxid	:= if(in_cname <> '' and in_prim_name <> '' and (unsigned)in_zip5 > 0, (UNSIGNED6) hash(ut.CleanSpacesAndUpper(ut.CleanCompany(in_cname) + in_prim_range + in_prim_name + in_sec_range + in_v_city_name + in_st + in_zip5 + in_customer_name)), 0); 
 			
// HERE are the Parent Child Exceptions	
	Shared Exception :=prte2.files.Linkids(relation='Child' and seleid=vCmpnyId);
 		
	shared orgid_exception_1:=if(count(Exception)= 0,vCmpnyId,exception[1].orgid);
	shared ultid_exception_1:=if(count(Exception)= 0,vCmpnyId,exception[1].ultid);
  shared seleid_exception_1	:= vCmpnyId;
	
	//HERE are the DBA exceptions
	Shared Exception_2 :=prte2.files.Linkids_DBA(relation='DBA' and Link_fein = in_fein and Company_name = in_cname);
			
	shared orgid_exception_2:=if(count(Exception_2)= 0,orgid_exception_1,exception_2[1].orgid);
	shared ultid_exception_2:=if(count(Exception_2)= 0,ultid_exception_1,exception_2[1].ultid);
	shared seleid_exception_2:=if(count(Exception_2)= 0, seleid_exception_1,exception_2[1].seleid);
	
	Export orgid:=orgid_exception_2;
	Export ultid:=ultid_exception_2;
	Export seleid:=seleid_exception_2;
end;
		          	
END;
