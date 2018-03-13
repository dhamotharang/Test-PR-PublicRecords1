import ut, std, bipv2;

EXPORT fn_AppendFakeID := module
		 
			export did(string in_fname, string in_lname, string in_ssn, string in_dob, string in_customer_name)	 := function
			did_out := 	if(in_fname<>'' and in_lname<>'' and ut.full_ssn(in_ssn) and ut.age((integer)in_dob) between 1 and 300, (UNSIGNED6) hash(ut.CleanSpacesAndUpper(in_ssn + in_dob + in_customer_name)), 0); 
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
				 	 
						shared vCmpnyId := if(in_cname <> '' and (unsigned)in_incorp_date > 0 and (unsigned)in_fein > 0, (UNSIGNED6) hash(ut.CleanSpacesAndUpper(in_incorp_date + in_fein + in_customer_name)), 0);
						export powid		:= if(in_cname <> '' and in_prim_name <> '' and (unsigned)in_zip5 > 0, (UNSIGNED6) hash(ut.CleanSpacesAndUpper(ut.CleanCompany(in_cname) + in_prim_range + in_prim_name + in_v_city_name + in_st + in_zip5 + in_customer_name)), 0);
						export proxid	:= if(in_cname <> '' and in_prim_name <> '' and (unsigned)in_zip5 > 0, (UNSIGNED6) hash(ut.CleanSpacesAndUpper(ut.CleanCompany(in_cname) + in_prim_range + in_prim_name + in_sec_range + in_v_city_name + in_st + in_zip5 + in_customer_name)), 0); 
 			
	Shared Exception :=prte2.files.Linkids(relation='Child' and seleid=vCmpnyId);
 		
	Export orgid:=if(count(Exception)= 0,vCmpnyId,exception[1].orgid);
	Export ultid:=if(count(Exception)= 0,vCmpnyId,exception[1].ultid);
  Export seleid	:= vCmpnyId;		
	
end;
		          	
END;
