import ut,doxie,autokey,autokeyb,autokeyb2,AutoStandardI,lib_stringlib;
export FetchI_Biz_FEIN := module
	export old := module
		export params := module
			export base := interface
				export string10 fein_val;
				export unsigned4 fein_value;
				export unsigned4 lookup_value;
			end;
			export full := interface(base)
				export string autokey_keyname_root;
				export boolean workHard;
				export boolean noFail := true;
				export boolean useAllLookups := false;
			end;
		end;
		export do(params.full in_mod) := function

			fv := if(in_mod.fein_value = 0, '', trim(Stringlib.StringFilterOut(in_mod.fein_val,'-')));

			//***** DECLARE KEYS
			kb 	:= autokeyb.Key_FEIN(in_mod.autokey_keyname_root);
			kb2 := autokeyb2.Key_FEIN(in_mod.autokey_keyname_root);

			//***** INDEX READ, INTO OUTREC AND CHECK LOOKUP IN B2
			outrec := autokeyb2.layout_fetch;
      kbread := kb (fv<>'',
                    keyed(f1=fv[1]),keyed(f2=fv[2]),keyed(f3=fv[3]),keyed(f4=fv[4]),keyed(f5=fv[5]),
                    keyed(f6=fv[6]),keyed(f7=fv[7]),keyed(f8=fv[8]),keyed(f9=fv[9]));
			pb 	:= project(kbread, outrec);
      
			kb2read := kb2 (fv<>'',
                      keyed (f1=fv[1]),keyed(f2=fv[2]),keyed(f3=fv[3]),keyed(f4=fv[4]),keyed(f5=fv[5]),
                      keyed(f6=fv[6]),keyed(f7=fv[7]),keyed(f8=fv[8]),keyed(f9=fv[9]),
                      ut.bit_test(lookups, in_mod.lookup_value)
                      );
			pb2 := project(kb2read, outrec);

			//***** PICK YOUR PATH
			p := if(in_mod.useAllLookups, pb2, pb);
			
			nofail := in_mod.nofail;
			
			//***** LIMIT
			Autokey.mac_Limits(p,p_ret)

			return p_ret;
		end;
	end;
	export new := module
		export params := module
			export base := interface(
				AutoStandardI.InterfaceTranslator.fein_val.params,
				AutoStandardI.InterfaceTranslator.fein_value.params,
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
				export string10 fein_val := AutoStandardI.InterfaceTranslator.fein_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.fein_val.params));
				export unsigned4 fein_value := AutoStandardI.InterfaceTranslator.fein_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.fein_value.params));
				export unsigned4 lookup_value := AutoStandardI.InterfaceTranslator.lookup_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lookup_value.params));
			end;
			return old.do(tempmod);
		end;
	end;
end;