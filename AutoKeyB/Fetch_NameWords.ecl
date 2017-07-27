import autokeyB,ut,business_header,business_header_ss,autokeyb2,Autokey;

export Fetch_NameWords(STRING t, boolean workHard,boolean nofail=true,boolean useAllLookups = false) := 
FUNCTION

business_header.doxie_MAC_Field_Declare()



company_name_val_filt_no_the := if(company_name_val_filt[1..4]='THE ',company_name_val_filt[5..length(company_name_val_filt)],
																company_name_val_filt);
																
comp_name_indic_value_no_the := if(comp_name_indic_value[1..4]='THE ',company_name_val_filt[5..length(company_name_val_filt)],
																comp_name_indic_value);
																
fuzzy_search_val := trim(comp_name_indic_value_no_the + comp_name_sec_value,all);

fuzzy_search_val2 := Business_Header_SS.Fn_SubstituteForAndString(comp_name_value,company_name_val_filt);
																


//***** MACRO FOR INDEX READ
indexread(i,f) :=
MACRO
f := i(
			
			 keyed(company_name_val_filt_no_the = word[1..LENGTH(TRIM(company_name_val_filt_no_the))] or
				   (company_name_val_filt2 <> '' and company_name_val_filt2 = word[1..LENGTH(TRIM(company_name_val_filt2))])
				), 
			 keyed(state_value = '' or state_value = state)
		   ) ;						
ENDMACRO;

//***** DECLARE KEYS
kb 	:= autokeyb.key_nameWords(t);
kb2 := autokeyb2.key_nameWords(t);

//***** INDEX READ
indexread(kb, kbread);
indexread(kb2,kb2read);

//***** INTO OUTREC AND CHECK LOOKUP IN B2
outrec := autokeyb2.layout_fetch;
pb 	:= project(kbread,
							 outrec);
pb2 := project(kb2read(ut.bit_test(lookups, lookup_value)),
							 outrec);

//***** PICK YOUR PATH
p := if(useAllLookups, pb2, pb);

//***** LIMIT
Autokey.mac_Limits(p,p_ret)




//***** NOW DO THE SAME FOR THE FUZZY ROUTE *****

//***** MACRO FOR INDEX READ
findexread(i,f) :=
MACRO
f :=
         i(keyed(fuzzy_search_val = word[1..LENGTH(TRIM(fuzzy_search_val))] or
				(fuzzy_search_val2 <> '' and fuzzy_search_val2 = word[1..Length(trim(fuzzy_search_val2))])),
			 keyed(state_value = '' or state_value = state)
		   );
ENDMACRO;


//***** INDEX READ
findexread(kb, fkbread);
findexread(kb2,fkb2read);

//***** INTO OUTREC AND CHECK LOOKUP IN B2
fpb 	:= project(fkbread,
							 outrec);
fpb2 := project(fkb2read(ut.bit_test(lookups, lookup_value)),
							 outrec);

//***** PICK YOUR PATH
fp := if(useAllLookups, fpb2, fpb);

//***** LIMIT
Autokey.mac_Limits (fp, fp_ret)	

result := if(exists(p_ret),p_ret,fp_ret); //prefer tight results and dont check error code becuase the fuzzy will doomed anyway if the tight fails

cname_search := bdid_value = 0 and length(trim(company_name_val_filt)) > 1 /*AND state_value = ''*/ /* AND city_value = ''*/ AND zip_value = [];
return if(cname_search, result);

			


END;