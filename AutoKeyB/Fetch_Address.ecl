import ut,doxie,autokeyb2,autokey;

export Fetch_Address(STRING t, boolean workHard,boolean nofail=true,boolean useAllLookups = false) :=
FUNCTION


doxie.MAC_Header_Field_Declare()


zips :=set(project(dataset(zip_value,{Integer4 zip}),transform({string5 zip},self.zip:=intformat(left.zip,5,1))),zip);								
																			

//***** MACRO FOR INDEX READ
indexread(i,f) :=
MACRO
f := i (keyed (prim_name = pname_value),
                keyed (prim_range = prange_value), 
								keyed(state_value=st),
                keyed(city_code in city_codes_set),
								keyed(zip in zips or zip_val='') ,
								keyed(sec_range=sec_range_value or sec_range_value=''),
								keyed(cname_indic=comp_name_indic_value),
								keyed(cname_sec=comp_name_sec_value));						
ENDMACRO;

//***** DECLARE KEYS
kb 	:= autokeyb.key_address(t);
kb2 := autokeyb2.key_address(t);

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
         i(
		 keyed(prim_name=pname_value), 
		 keyed((workHard and (prange_value = '' OR addr_loose)) OR prange_value=prim_range),
		 keyed(city_code in city_codes_set OR (city_value='' and workHard)), 
		 keyed(state_value=st OR (state_value='' and workHard)), 
		 sec_range_value='' or sec_range_value=sec_range,
		 comp_name_value = '' or ut.CS100S.current(cname_indic, cname_sec, comp_name_indic_value, comp_name_sec_value) < 50
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
Autokey.mac_Limits_NoFail (fp, fp_ret)	


result := fp_ret + p_ret;

addr_search :=	pname_value != '';
return if(addr_search, result);

END;