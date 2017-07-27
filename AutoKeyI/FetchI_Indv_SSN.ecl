import ut, AutoStandardI, autokey;

export FetchI_Indv_SSN := module
	export old := module
		export params := module
			export base := interface
				export boolean isCRS;
				export string9 ssn_value;
				export boolean fuzzy_ssn;
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

			boolean is_straight_match := ~in_mod.workHard OR ~in_mod.fuzzy_ssn OR in_mod.isCRS;
      integer READ_LIMIT := 10000;

			//***** MACRO FOR INDEX READ
			indexread(i,f) :=
			MACRO
			f := IF (is_straight_match,
                  LIMIT (i(in_mod.ssn_value<>'',keyed(s1=in_mod.ssn_value[1]),keyed(s2=in_mod.ssn_value[2]),keyed(s3=in_mod.ssn_value[3]),keyed(s4=in_mod.ssn_value[4]),keyed(s5=in_mod.ssn_value[5]),keyed(s6=in_mod.ssn_value[6]),keyed(s7=in_mod.ssn_value[7]),keyed(s8=in_mod.ssn_value[8]),keyed(s9=in_mod.ssn_value[9])), READ_LIMIT, fail(203,'Too many Subjects found')),

									LIMIT (i(in_mod.ssn_value<>'',wild(s1),keyed(s2=in_mod.ssn_value[2]),keyed(s3=in_mod.ssn_value[3]),keyed(s4=in_mod.ssn_value[4]),keyed(s5=in_mod.ssn_value[5]),keyed(s6=in_mod.ssn_value[6]),keyed(s7=in_mod.ssn_value[7]),keyed(s8=in_mod.ssn_value[8]),keyed(s9=in_mod.ssn_value[9])), READ_LIMIT, fail(203,'Too many Subjects found')) +
									LIMIT (i(in_mod.ssn_value<>'',keyed(s1=in_mod.ssn_value[1]),wild(s2),keyed(s3=in_mod.ssn_value[3]),keyed(s4=in_mod.ssn_value[4]),keyed(s5=in_mod.ssn_value[5]),keyed(s6=in_mod.ssn_value[6]),keyed(s7=in_mod.ssn_value[7]),keyed(s8=in_mod.ssn_value[8]),keyed(s9=in_mod.ssn_value[9])), READ_LIMIT, fail(203,'Too many Subjects found')) +
									LIMIT (i(in_mod.ssn_value<>'',keyed(s1=in_mod.ssn_value[1]),keyed(s2=in_mod.ssn_value[2]),wild(s3),keyed(s4=in_mod.ssn_value[4]),keyed(s5=in_mod.ssn_value[5]),keyed(s6=in_mod.ssn_value[6]),keyed(s7=in_mod.ssn_value[7]),keyed(s8=in_mod.ssn_value[8]),keyed(s9=in_mod.ssn_value[9])), READ_LIMIT, fail(203,'Too many Subjects found')) +
									LIMIT (i(in_mod.ssn_value<>'',keyed(s1=in_mod.ssn_value[1]),keyed(s2=in_mod.ssn_value[2]),keyed(s3=in_mod.ssn_value[3]),wild(s4),keyed(s5=in_mod.ssn_value[5]),keyed(s6=in_mod.ssn_value[6]),keyed(s7=in_mod.ssn_value[7]),keyed(s8=in_mod.ssn_value[8]),keyed(s9=in_mod.ssn_value[9])), READ_LIMIT, fail(203,'Too many Subjects found')) +
									LIMIT (i(in_mod.ssn_value<>'',keyed(s1=in_mod.ssn_value[1]),keyed(s2=in_mod.ssn_value[2]),keyed(s3=in_mod.ssn_value[3]),keyed(s4=in_mod.ssn_value[4]),wild(s5),keyed(s6=in_mod.ssn_value[6]),keyed(s7=in_mod.ssn_value[7]),keyed(s8=in_mod.ssn_value[8]),keyed(s9=in_mod.ssn_value[9])), READ_LIMIT, fail(203,'Too many Subjects found')) +
									LIMIT (i(in_mod.ssn_value<>'',keyed(s1=in_mod.ssn_value[1]),keyed(s2=in_mod.ssn_value[2]),keyed(s3=in_mod.ssn_value[3]),keyed(s4=in_mod.ssn_value[4]),keyed(s5=in_mod.ssn_value[5]),wild(s6),keyed(s7=in_mod.ssn_value[7]),keyed(s8=in_mod.ssn_value[8]),keyed(s9=in_mod.ssn_value[9])), READ_LIMIT, fail(203,'Too many Subjects found')) +
									LIMIT (i(in_mod.ssn_value<>'',keyed(s1=in_mod.ssn_value[1]),keyed(s2=in_mod.ssn_value[2]),keyed(s3=in_mod.ssn_value[3]),keyed(s4=in_mod.ssn_value[4]),keyed(s5=in_mod.ssn_value[5]),keyed(s6=in_mod.ssn_value[6]),wild(s7),keyed(s8=in_mod.ssn_value[8]),keyed(s9=in_mod.ssn_value[9])), READ_LIMIT, fail(203,'Too many Subjects found')) +
									LIMIT (i(in_mod.ssn_value<>'',keyed(s1=in_mod.ssn_value[1]),keyed(s2=in_mod.ssn_value[2]),keyed(s3=in_mod.ssn_value[3]),keyed(s4=in_mod.ssn_value[4]),keyed(s5=in_mod.ssn_value[5]),keyed(s6=in_mod.ssn_value[6]),keyed(s7=in_mod.ssn_value[7]),wild(s8),keyed(s9=in_mod.ssn_value[9])), READ_LIMIT, fail(203,'Too many Subjects found')) +
									LIMIT (i(in_mod.ssn_value<>'',keyed(s1=in_mod.ssn_value[1]),keyed(s2=in_mod.ssn_value[2]),keyed(s3=in_mod.ssn_value[3]),keyed(s4=in_mod.ssn_value[4]),keyed(s5=in_mod.ssn_value[5]),keyed(s6=in_mod.ssn_value[6]),keyed(s7=in_mod.ssn_value[7]),keyed(s8=in_mod.ssn_value[8])), READ_LIMIT, fail(203,'Too many Subjects found')));
			ENDMACRO;

			//***** DECLARE KEYS
			k 	:= autokey.Key_SSN(in_mod.autokey_keyname_root);
			k2 	:= autokey.Key_SSN2(in_mod.autokey_keyname_root);

			//***** INDEX READ
			indexread(k, kread);
			indexread(k2,k2read);

			//***** INTO OUTREC AND CHECK LOOKUP IN B2
			outrec := AutoKey.layout_fetch;
			pb 	:= project(kread,
										 outrec);
			pb2 := project(k2read(ut.bit_test(lookups, in_mod.lookup_value)),
										 outrec);

			//***** PICK YOUR PATH
			p := if(in_mod.useAllLookups, pb2, pb);

			//***** THIS DOES NOT LEND ITSELF TO LIMITS AND HAS NOT HAD THEM FOR A WHILE (IF EVER)
			return p;
		end;
	end;
	export new := module
		export params := module
			export base := interface(
				AutoStandardI.InterfaceTranslator.isCRS.params,
				AutoStandardI.InterfaceTranslator.ssn_value.params,
				AutoStandardI.InterfaceTranslator.fuzzy_ssn.params,
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
				export boolean isCRS := AutoStandardI.InterfaceTranslator.isCRS.val(project(in_mod,AutoStandardI.InterfaceTranslator.isCRS.params));
				export string9 ssn_value := AutoStandardI.InterfaceTranslator.ssn_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.ssn_value.params));
				export boolean fuzzy_ssn := AutoStandardI.InterfaceTranslator.fuzzy_ssn.val(project(in_mod,AutoStandardI.InterfaceTranslator.fuzzy_ssn.params));
				export unsigned4 lookup_value := AutoStandardI.InterfaceTranslator.lookup_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lookup_value.params));
			end;
			return old.do(tempmod);
		end;
	end;
end;
