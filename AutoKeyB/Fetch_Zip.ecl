import ut,doxie,AutokeyB2,Autokey;

export Fetch_Zip(STRING t, boolean workHard,boolean nofail,boolean useAllLookups = false,set of string1 get_skip_set=[]) :=
FUNCTION

doxie.MAC_Header_Field_Declare()


//***** MACRO FOR INDEX READ
indexread(i,f) :=
MACRO
f := i (keyed (zip IN zip_value),
								keyed(cname_indic=comp_name_indic_value),
                keyed(cname_sec = comp_name_sec_value));						
ENDMACRO;

//***** DECLARE KEYS
kb 	:= autokeyb.key_zip(t);
kb2 := autokeyb2.key_zip(t);

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
			keyed(zip IN zip_value),
			comp_name_indic_value<>'',
			keyed(AutokeyB2.is_CNameIndicMatch(cname_indic, comp_name_indic_value)),
			comp_name_value = '' or ut.CS100S.current(cname_indic, cname_sec, comp_name_indic_value, comp_name_sec_value) < 50);
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


result := fp_ret + p_ret;

boolean cname_search := (comp_name_value <> '' or 'C' in get_skip_set)  AND zip_value<>[] AND (pname_value='' OR addr_error_value);
return if(cname_search, result);



END;