import doxie, autokeyb2, AutoKey, ut;

export FetchBizAddress (String keyNameRoot, boolean workHard, boolean aNoFail = true) := function

	companyIdSet := Functions.getCompanyIdSet();

	doxie.MAC_Header_Field_Declare ();
	
	zips :=set(project(dataset(zip_value,{Integer4 zip}),transform({string5 zip},self.zip:=intformat(left.zip,5,1))),zip);								

	extended_zips := zips + 
			 IF(state_value<>'' AND city_value<>'',set(project(dataset(ut.ZipsWithinCity(state_value,city_value),{Integer4 zip}),transform({string5 zip},self.zip:=(string5)left.zip)),zip),[]); 
														
	//***** DECLARE KEYS
	kb2 := autokeyb2.key_address(keyNameRoot);

	//***** INDEX READ
	kb2read := kb2(keyed (prim_name = pname_value),
	 							keyed (prim_range = prange_value), 
								keyed(state_value=st),
								keyed(city_code in city_codes_set),
								keyed(zip in extended_zips or zip_val='') ,
								keyed(sec_range=sec_range_value or sec_range_value=''),
								keyed(cname_indic=comp_name_indic_value),
								keyed(cname_sec=comp_name_sec_value), 
									lookups in CompanyIdSet);	

		//***** INTO OUTREC AND CHECK LOOKUP IN B2
		outrec := autokeyb2.layout_fetch;
		pb2 := project(kb2read,
									 outrec);

		nofail := aNoFail;
			
		//***** LIMIT
		Autokey.mac_Limits(pb2,p_ret)

		//***** NOW DO THE SAME FOR THE FUZZY ROUTE *****
		fkb2read := kb2(
				 keyed(prim_name=pname_value), 
				 keyed((workHard and (prange_value = '' OR addr_loose)) OR prange_value=prim_range),
				 keyed(city_code in city_codes_set OR (city_value='' and workHard)), 
				 keyed(state_value=st OR (state_value='' and workHard)), 
				 sec_range_value='' or sec_range_value=sec_range,
				 comp_name_value = '' or ut.CS100S.current(cname_indic, cname_sec, comp_name_indic_value, comp_name_sec_value) < 50,
				 lookups in companyIdSet);

		//***** INTO OUTREC AND CHECK LOOKUP IN B2
		fpb2 := project(fkb2read,
									 outrec);
					
		//***** LIMIT
		Autokey.mac_Limits_NoFail (fpb2, fp_ret)	

		result := fp_ret + p_ret;

		addr_search :=	pname_value != '';
		return if(addr_search, result);
end;