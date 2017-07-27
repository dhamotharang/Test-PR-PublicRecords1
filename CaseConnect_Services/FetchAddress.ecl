IMPORT ut, doxie, autokey, AutoKeyI;
export FetchAddress (String keyNameRoot, boolean workHard,boolean aNoFail = true) := FUNCTION

	companyIdSet := Functions.getCompanyIdSet();
	
	doxie.MAC_Header_Field_Declare ();
	
	key := autokey.key_address(keyNameRoot);

	limit_inner := 10000;
	limit_outer := ut.limits.FETCH_LEV2_UNKEYED;

	zips :=set(project(dataset(zip_value,{Integer4 zip}),transform({string5 zip},self.zip:=intformat(left.zip,5,1))),zip);
			extended_zips := zips + 
					 IF(state_value<>'' AND city_value<>'',set(project(dataset(ut.ZipsWithinCity(state_value,city_value),{Integer4 zip}),transform({string5 zip},self.zip:=intformat(left.zip,5,1))),zip),[]); 

			// Second Lookup bit checks for representative address
			pname_value_word:=trim(pname_value)+' ';
			f_exact := Project(
									 key (keyed(if(do_primname_word_match,(prim_name[1..length(pname_value_word)]=pname_value_word),prim_name=pname_value)),
											keyed (prim_range = prange_value), 
											keyed(state_value=st),
											keyed(city_code in city_codes_set or city_value=''),
											keyed(zip in extended_zips or zip_val='') ,
											keyed(sec_range=sec_range_value or sec_range_value='' or (lname_value <> '' and (FuzzySecRange_value != AutoStandardI.Constants.SECRANGE.EXACT))),
											keyed(dph_lname=metaphonelib.DMetaPhone1(lname_value)[1..6] or lname_value=''),
											keyed(lname in lname_set_value  or lname_value=''),
											keyed(AutoKeyI.Functions.PrefFirstMatch(pfname,fname_value) or fname_value =''),
											keyed(fname = fname_value or fname_value =''),											
											lookups in companyIdSet),											
											AutoKey.layout_fetch);

			f_fuzzy :=
				 project(
							 key(
					 keyed(if(do_primname_word_match,(prim_name[1..length(pname_value_word)]=(pname_value_word)),prim_name=pname_value)),
					 keyed((workHard and (prange_value = '' OR addr_loose)) OR prange_value=prim_range),
					 keyed(state_value=st OR (state_value='' and workHard)), 
					 keyed(city_code in city_codes_set OR (city_codes_set = [] and workHard)), 
					 keyed(zip in extended_zips or zip_val=''),
					 keyed(sec_range_value='' or sec_range_value=sec_range or (lname_value <> '' and (FuzzySecRange_value != AutoStandardI.Constants.SECRANGE.EXACT) )),
					 keyed(lname_value='' or dph_lname=metaphonelib.DMetaPhone1(lname_value)[1..6]),
					 keyed(lname in lname_set_value  or lname_value='' or phonetics),
					 keyed(AutoKeyI.Functions.PrefFirstMatch(pfname,fname_value) or fname_value =''),
					 keyed(fname = fname_value or fname_value ='' or nicknames),						
						lookups in companyIdSet)
							, AutoKey.layout_fetch);
					 

			boolean addr_search :=	pname_value != ''; 
			
			nofail := aNofail;

			Autokey.mac_Limits(f_exact,f_ret_exact)	

			doxie.mac_FetchLimitLimitSkipFail (f_fuzzy, limit_inner, limit_outer, EXISTS (f_ret_exact) or nofail, 203, false, true, f_ret_fuzzy)

			ret := IF (addr_search, IF (exists (f_ret_fuzzy), f_ret_fuzzy, f_ret_exact));
			
			RETURN ret;
		end;