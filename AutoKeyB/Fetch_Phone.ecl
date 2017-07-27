import ut,doxie,autokeyb2,Autokey;

export Fetch_Phone(STRING t,boolean nofail=true,boolean useAllLookups = false) :=
FUNCTION

doxie.mac_header_field_declare()

//***** MACRO FOR INDEX READ
indexread(i,f) :=
MACRO
f := i(phone_value<>'',
		keyed(p7=IF(length(trim(phone_value))=10,phone_value[4..10],(STRING7)phone_value)),
		keyed(p3=phone_value[1..3] OR length(trim(phone_value)) <> 10),
		comp_name_value = '' or ut.CS100S.current(cname_indic, cname_sec, comp_name_indic_value, comp_name_sec_value) < 50);
ENDMACRO;

//***** DECLARE KEYS
kb 	:= autokeyb.key_phone(t);
kb2 := autokeyb2.key_phone(t);

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

return p_ret;

									
		
END;