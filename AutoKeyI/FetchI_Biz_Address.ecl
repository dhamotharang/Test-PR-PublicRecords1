import ut,doxie,autokey,autokeyb,autokeyb2,AutoStandardI;
export FetchI_Biz_Address := module
	export old := module
		export params := module
			export base := interface
				export string comp_name_value;
				export string comp_name_indic_value;
				export string comp_name_sec_value;
				export string prange_value;
				export string pname_value;
				export string sec_range_value;
				export boolean addr_loose;
				export string city_value;
				export set of unsigned city_codes_set;
				export string state_value;
				export string5 zip_val;
				export set of integer4 zip_value;
				export unsigned4 lookup_value;
			end;
			export full := interface(base)
				export string autokey_keyname_root;
				export boolean workHard;
				export boolean noFail := true;
				export boolean useAllLookups := false;
			end;
		end;
		export dataset(autokeyb2.layout_fetch) do(params.full in_mod) := function
		
			zips :=set(project(dataset(in_mod.zip_value,{Integer4 zip}),transform({string5 zip},self.zip:=intformat(left.zip,5,1))),zip);								

			extended_zips := zips + 
					 IF(in_mod.state_value<>'' AND in_mod.city_value<>'',set(project(dataset(ut.ZipsWithinCity(in_mod.state_value,in_mod.city_value),{Integer4 zip}),transform({string5 zip},self.zip:=(string5)left.zip)),zip),[]); 
														

			//***** MACRO FOR INDEX READ
			indexread(i,f) :=
			MACRO
			f := i (keyed (prim_name = in_mod.pname_value),
											keyed (prim_range = in_mod.prange_value), 
											keyed(in_mod.state_value=st),
											keyed(city_code in in_mod.city_codes_set),
											keyed(zip in extended_zips or in_mod.zip_val='') ,
											keyed(sec_range=in_mod.sec_range_value or in_mod.sec_range_value=''),
											keyed(cname_indic=in_mod.comp_name_indic_value),
											keyed(cname_sec=in_mod.comp_name_sec_value));						
			ENDMACRO;

			//***** DECLARE KEYS
			kb 	:= autokeyb.key_address(in_mod.autokey_keyname_root);
			kb2 := autokeyb2.key_address(in_mod.autokey_keyname_root);

			//***** INDEX READ
			indexread(kb, kbread);
			indexread(kb2,kb2read);

			//***** INTO OUTREC AND CHECK LOOKUP IN B2
			outrec := autokeyb2.layout_fetch;
			pb 	:= project(kbread,
										 outrec);
			pb2 := project(kb2read(ut.bit_test(lookups, in_mod.lookup_value)),
										 outrec);

			//***** PICK YOUR PATH
			p := if(in_mod.useAllLookups, pb2, pb);
			
			nofail := in_mod.nofail;
			
			//***** LIMIT
			Autokey.mac_Limits(p,p_ret)




			//***** NOW DO THE SAME FOR THE FUZZY ROUTE *****

			//***** MACRO FOR INDEX READ
			findexread(i,f) :=
			MACRO
			f :=
							 i(
					 keyed(prim_name=in_mod.pname_value), 
					 keyed((in_mod.workHard and (in_mod.prange_value = '' OR in_mod.addr_loose)) OR in_mod.prange_value=prim_range),
					 keyed(city_code in in_mod.city_codes_set OR (in_mod.city_value='' and in_mod.workHard)), 
					 keyed(in_mod.state_value=st OR (in_mod.state_value='' and in_mod.workHard)), 
					 in_mod.sec_range_value='' or in_mod.sec_range_value=sec_range,
					 in_mod.comp_name_value = '' or ut.CS100S.current(cname_indic, cname_sec, in_mod.comp_name_indic_value, in_mod.comp_name_sec_value) < 50
						);
			ENDMACRO;


			//***** INDEX READ
			findexread(kb, fkbread);
			findexread(kb2,fkb2read);

			//***** INTO OUTREC AND CHECK LOOKUP IN B2
			fpb 	:= project(fkbread,
										 outrec);
			fpb2 := project(fkb2read(ut.bit_test(lookups, in_mod.lookup_value)),
										 outrec);

			//***** PICK YOUR PATH
			fp := if(in_mod.useAllLookups, fpb2, fpb);

			//***** LIMIT
			Autokey.mac_Limits_NoFail (fp, fp_ret)	


			result := fp_ret + p_ret;

			addr_search :=	in_mod.pname_value != '';
			return if(addr_search, result);
		end;
	end;
	export new := module
		export params := module
			export base := interface(
				AutoStandardI.InterfaceTranslator.comp_name_value.params,
				AutoStandardI.InterfaceTranslator.comp_name_indic_value.params,
				AutoStandardI.InterfaceTranslator.comp_name_sec_value.params,
				AutoStandardI.InterfaceTranslator.prange_value.params,
				AutoStandardI.InterfaceTranslator.pname_value.params,
				AutoStandardI.InterfaceTranslator.sec_range_value.params,
				AutoStandardI.InterfaceTranslator.addr_loose.params,
				AutoStandardI.InterfaceTranslator.city_value.params,
				AutoStandardI.InterfaceTranslator.city_codes_set.params,
				AutoStandardI.InterfaceTranslator.state_value.params,
				AutoStandardI.InterfaceTranslator.zip_val.params,
				AutoStandardI.InterfaceTranslator.zip_value.params,
				AutoStandardI.InterfaceTranslator.lookup_value.params)
			end;
			export full := interface(base)
				export string autokey_keyname_root;
				export boolean workHard;
				export boolean noFail := true;
				export boolean useAllLookups := false;
			end;
		end;
		export do(params.full in_mod) := function
			tempmod := module(old.params.full)
				export string autokey_keyname_root := in_mod.autokey_keyname_root;
				export boolean workHard := in_mod.workHard;
				export boolean noFail := in_mod.noFail;
				export boolean useAllLookups := in_mod.useAllLookups;
				export string comp_name_value := AutoStandardI.InterfaceTranslator.comp_name_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.comp_name_value.params));
				export string comp_name_indic_value := AutoStandardI.InterfaceTranslator.comp_name_indic_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.comp_name_indic_value.params));
				export string comp_name_sec_value := AutoStandardI.InterfaceTranslator.comp_name_sec_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.comp_name_sec_value.params));
				export string prange_value := AutoStandardI.InterfaceTranslator.prange_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.prange_value.params));
				export string pname_value := AutoStandardI.InterfaceTranslator.pname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.pname_value.params));
				export string sec_range_value := AutoStandardI.InterfaceTranslator.sec_range_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.sec_range_value.params));
				export boolean addr_loose := AutoStandardI.InterfaceTranslator.addr_loose.val(project(in_mod,AutoStandardI.InterfaceTranslator.addr_loose.params));
				export string city_value := AutoStandardI.InterfaceTranslator.city_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.city_value.params));
				export set of unsigned city_codes_set := AutoStandardI.InterfaceTranslator.city_codes_set.val(project(in_mod,AutoStandardI.InterfaceTranslator.city_codes_set.params));
				export string state_value := AutoStandardI.InterfaceTranslator.state_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.state_value.params));
				export string5 zip_val := AutoStandardI.InterfaceTranslator.zip_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.zip_val.params));
				export set of integer4 zip_value := AutoStandardI.InterfaceTranslator.zip_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.zip_value.params));
				export unsigned4 lookup_value := AutoStandardI.InterfaceTranslator.lookup_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lookup_value.params));
			end;
			return old.do(tempmod);
		end;
	end;
end;
