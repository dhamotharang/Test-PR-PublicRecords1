/*2008-02-06T21:01:21Z (Eitan Halper-Stromberg)
29114
*/
import ut,doxie,AutokeyB2,Autokey,CanadianPhones;

export Fetch_ZipB(STRING t, boolean workHard,boolean nofail,boolean useAllLookups = false,set of string1 get_skip_set = []) :=
FUNCTION

doxie.MAC_Header_Field_Declare ();


  d := DATASET([], CanadianPhones.layouts.zipb);

  i := if (stringlib.stringfind (trim(t),'::qa::',1) > 0,
             INDEX(d, {d}, TRIM(t)+'ZipB2'), INDEX(d, {d}, TRIM(t)+'ZipB2' + '_' + doxie.Version_SuperKey));


//***** INDEX READ

p0 := i (keyed (zip = can_poscode_value),
								keyed(cname_indic=comp_name_indic_value),
                keyed(cname_sec = comp_name_sec_value),
								ut.bit_test(lookups, lookup_value));


p := project (p0, AutoKeyb2.layout_fetch);

//***** LIMIT
Autokey.mac_Limits(p,p_ret)




//***** NOW DO THE SAME FOR THE FUZZY ROUTE *****

fp0 :=
         i(
			keyed(zip = can_poscode_value),
			comp_name_indic_value<>'',
			keyed(AutokeyB2.is_CNameIndicMatch(cname_indic, comp_name_indic_value)),
			comp_name_value = '' or ut.CS100S.current(cname_indic, cname_sec, comp_name_indic_value, comp_name_sec_value) < 50,
			ut.bit_test(lookups, lookup_value));

fp := project (fp0, AutoKeyb2.layout_fetch);

//***** LIMIT
Autokey.mac_Limits (fp, fp_ret)	


result := fp_ret + p_ret;

boolean cname_search := (comp_name_value <> '' or 'C' in get_skip_set)  AND can_poscode_value<>'' AND (pname_value='' OR addr_error_value);
return if(cname_search, result);



END;