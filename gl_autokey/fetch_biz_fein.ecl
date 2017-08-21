import autokeyb2,doxie,ut;
export Fetch_Biz_FEIN(
	string autokey_keyname,
	gl_autokey.autokey_interfaces.biz_fein in_parms) :=
		function

			i := autokeyb2.Key_FEIN(autokey_keyname);

			doxie.layout_ref_bdid xt(i r) := 
			TRANSFORM
				SELF.bdid := r.bdid;
			END;

			fv := if(in_parms.fein_value = 0, '', trim(Stringlib.StringFilterOut(in_parms.fein_val,'-')));

			f_raw :=
				map( ~in_parms.workHard OR in_parms.isCRS => i(fv<>'',keyed(f1=fv[1]),keyed(f2=fv[2]),keyed(f3=fv[3]),keyed(f4=fv[4]),keyed(f5=fv[5]),keyed(f6=fv[6]),keyed(f7=fv[7]),keyed(f8=fv[8]),keyed(f9=fv[9])),
									i(fv<>'',wild(f1),keyed(f2=fv[2]),keyed(f3=fv[3]),keyed(f4=fv[4]),keyed(f5=fv[5]),keyed(f6=fv[6]),keyed(f7=fv[7]),keyed(f8=fv[8]),keyed(f9=fv[9])) +
									i(fv<>'',keyed(f1=fv[1]),wild(f2),keyed(f3=fv[3]),keyed(f4=fv[4]),keyed(f5=fv[5]),keyed(f6=fv[6]),keyed(f7=fv[7]),keyed(f8=fv[8]),keyed(f9=fv[9])) +
									i(fv<>'',keyed(f1=fv[1]),keyed(f2=fv[2]),wild(f3),keyed(f4=fv[4]),keyed(f5=fv[5]),keyed(f6=fv[6]),keyed(f7=fv[7]),keyed(f8=fv[8]),keyed(f9=fv[9])) +
									i(fv<>'',keyed(f1=fv[1]),keyed(f2=fv[2]),keyed(f3=fv[3]),wild(f4),keyed(f5=fv[5]),keyed(f6=fv[6]),keyed(f7=fv[7]),keyed(f8=fv[8]),keyed(f9=fv[9])) +
									i(fv<>'',keyed(f1=fv[1]),keyed(f2=fv[2]),keyed(f3=fv[3]),keyed(f4=fv[4]),wild(f5),keyed(f6=fv[6]),keyed(f7=fv[7]),keyed(f8=fv[8]),keyed(f9=fv[9])) +
									i(fv<>'',keyed(f1=fv[1]),keyed(f2=fv[2]),keyed(f3=fv[3]),keyed(f4=fv[4]),keyed(f5=fv[5]),wild(f6),keyed(f7=fv[7]),keyed(f8=fv[8]),keyed(f9=fv[9])) +
									i(fv<>'',keyed(f1=fv[1]),keyed(f2=fv[2]),keyed(f3=fv[3]),keyed(f4=fv[4]),keyed(f5=fv[5]),keyed(f6=fv[6]),wild(f7),keyed(f8=fv[8]),keyed(f9=fv[9])) +
									i(fv<>'',keyed(f1=fv[1]),keyed(f2=fv[2]),keyed(f3=fv[3]),keyed(f4=fv[4]),keyed(f5=fv[5]),keyed(f6=fv[6]),keyed(f7=fv[7]),wild(f8),keyed(f9=fv[9])) +
									i(fv<>'',keyed(f1=fv[1]),keyed(f2=fv[2]),keyed(f3=fv[3]),keyed(f4=fv[4]),keyed(f5=fv[5]),keyed(f6=fv[6]),keyed(f7=fv[7]),keyed(f8=fv[8])) );

			f_filt := f_raw( ut.bit_test(lookups, in_parms.lookup_value) );

			f := project(f_filt, xt(LEFT));
			
			nofail := in_parms.nofail;

			AutokeyB2.mac_Limits(f,f_ret)

												
			RETURN f_ret;

		END;