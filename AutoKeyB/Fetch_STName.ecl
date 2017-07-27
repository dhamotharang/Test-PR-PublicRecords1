import ut,doxie,AutokeyB2,AutoKey;

export Fetch_StName(STRING t, boolean workHard,boolean nofail=true,boolean useAllLookups = false) :=
FUNCTION

doxie.MAC_Header_Field_Declare()


//***** MACRO FOR INDEX READ
indexread(i,f) :=
MACRO
f := i (keyed (st=state_value),
								keyed(cname_indic=comp_name_indic_value),
                keyed (cname_sec = comp_name_sec_value));						
ENDMACRO;

//***** DECLARE KEYS
kb 	:= autokeyb.Key_StName(t);
kb2 := autokeyb2.Key_StName(t);

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
f := i(
			keyed(st=state_value),
		  comp_name_indic_value<>'',
			keyed(AutokeyB2.is_CNameIndicMatch(cname_indic, comp_name_indic_value)),
			ut.CS100S.current(cname_indic, cname_sec, comp_name_indic_value, comp_name_sec_value) < 50);
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


result := if(exists(fp_ret(error_code > 0)), p_ret, fp_ret); //only go the strict route when the fuzzy one returns so many that it errors

boolean cname_search := comp_name_value != '' AND state_value <> '' AND city_value='' AND zip_value=[];
return if(cname_search, result);

END;