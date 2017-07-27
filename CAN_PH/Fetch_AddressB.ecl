/*2007-08-10T15:37:25Z (Chad Morton)
bug 26021
*/
import ut,doxie,autokeyb2,autokey,CanadianPhones;

export Fetch_AddressB(STRING t, boolean workHard,boolean nofail=true,boolean useAllLookups = false) :=
FUNCTION


  doxie.MAC_Header_Field_Declare ();

  d := DATASET([], CanadianPhones.layouts.addressb);

  i := if (stringlib.stringfind (trim(t),'::qa::',1) > 0,
             INDEX(d, {d}, TRIM(t)+'AddressB2'), INDEX(d, {d}, TRIM(t)+'AddressB2' + '_' + doxie.Version_SuperKey));						
																			

//*****  INDEX READ

kb2read := i (keyed (prim_name = pname_value),
                keyed (prim_range = prange_value), 
								keyed(state_value=st),
                keyed(city_code in city_codes_set),
								keyed ((can_poscode_value='') or (zip = can_poscode_value)) ,
								keyed(sec_range=sec_range_value or sec_range_value=''),
								keyed(cname_indic=comp_name_indic_value),
								keyed(cname_sec=comp_name_sec_value),
								ut.bit_test(lookups, lookup_value));


p := project(kb2read,
							 AutoKeyb2.layout_fetch);



//***** LIMIT
Autokey.mac_Limits(p,p_ret)




//***** NOW DO THE SAME FOR THE FUZZY ROUTE *****

fkb2read :=
         i(
		 keyed(prim_name=pname_value), 
		 keyed((workHard and (prange_value = '' OR addr_loose)) OR prange_value=prim_range),
		 keyed(city_code in city_codes_set OR (city_value='' and workHard)), 
		 keyed(state_value=st OR (state_value='' and workHard)), 
		 sec_range_value='' or sec_range_value=sec_range,
		 comp_name_value = '' or ut.CS100S.current(cname_indic, cname_sec, comp_name_indic_value, comp_name_sec_value) < 50,
		 ut.bit_test(lookups, lookup_value));


fp := project(fkb2read,
							 AutoKeyb2.layout_fetch);


//***** LIMIT
Autokey.mac_Limits_NoFail (fp, fp_ret)	


result := fp_ret + p_ret;

addr_search :=	pname_value != '';
return if(addr_search, result);

END;