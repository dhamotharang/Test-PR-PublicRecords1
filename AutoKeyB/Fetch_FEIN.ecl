import ut,doxie,business_header,autokeyb2,Autokey;

export Fetch_FEIN(STRING t, boolean workHard,boolean nofail=true,boolean useAllLookups = false) :=
FUNCTION


business_header.doxie_MAC_Field_Declare()

fv := if(fein_value = 0, '', trim(Stringlib.StringFilterOut(fein_val,'-')));

//***** MACRO FOR INDEX READ
indexread(i,f) :=
MACRO
f := i(fv<>'',keyed(f1=fv[1]),keyed(f2=fv[2]),keyed(f3=fv[3]),keyed(f4=fv[4]),keyed(f5=fv[5]),keyed(f6=fv[6]),keyed(f7=fv[7]),keyed(f8=fv[8]),keyed(f9=fv[9]));						
ENDMACRO;

//***** DECLARE KEYS
kb 	:= autokeyb.Key_FEIN(t);
kb2 := autokeyb2.Key_FEIN(t);

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