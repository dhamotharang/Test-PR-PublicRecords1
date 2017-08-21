import autokey,doxie,ut;
export Fetch_SSN2(
	string autokey_keyname,
	gl_autokey.autokey_interfaces.ssn2 in_parms) :=
		function

			i := autokey.Key_SSN2(autokey_keyname);

			doxie.layout_references xt(i r) := 
			TRANSFORM
				SELF.did := r.did;
			END;
			pfe(string20 l, string20 r) := l[1..length(trim(datalib.preferredfirst(r)))]=datalib.preferredfirst(r);

			boolean is_straight_match := ~in_parms.workHard OR ~in_parms.fuzzy_ssn OR in_parms.isCRS;
			boolean is_limitable := is_straight_match;

			f_raw :=
				map( is_straight_match => i(in_parms.ssn_value<>'',keyed(s1=in_parms.ssn_value[1]),keyed(s2=in_parms.ssn_value[2]),keyed(s3=in_parms.ssn_value[3]),keyed(s4=in_parms.ssn_value[4]),keyed(s5=in_parms.ssn_value[5]),keyed(s6=in_parms.ssn_value[6]),keyed(s7=in_parms.ssn_value[7]),keyed(s8=in_parms.ssn_value[8]),keyed(s9=in_parms.ssn_value[9])),
									i(in_parms.ssn_value<>'',wild(s1),keyed(s2=in_parms.ssn_value[2]),keyed(s3=in_parms.ssn_value[3]),keyed(s4=in_parms.ssn_value[4]),keyed(s5=in_parms.ssn_value[5]),keyed(s6=in_parms.ssn_value[6]),keyed(s7=in_parms.ssn_value[7]),keyed(s8=in_parms.ssn_value[8]),keyed(s9=in_parms.ssn_value[9])) +
									i(in_parms.ssn_value<>'',keyed(s1=in_parms.ssn_value[1]),wild(s2),keyed(s3=in_parms.ssn_value[3]),keyed(s4=in_parms.ssn_value[4]),keyed(s5=in_parms.ssn_value[5]),keyed(s6=in_parms.ssn_value[6]),keyed(s7=in_parms.ssn_value[7]),keyed(s8=in_parms.ssn_value[8]),keyed(s9=in_parms.ssn_value[9])) +
									i(in_parms.ssn_value<>'',keyed(s1=in_parms.ssn_value[1]),keyed(s2=in_parms.ssn_value[2]),wild(s3),keyed(s4=in_parms.ssn_value[4]),keyed(s5=in_parms.ssn_value[5]),keyed(s6=in_parms.ssn_value[6]),keyed(s7=in_parms.ssn_value[7]),keyed(s8=in_parms.ssn_value[8]),keyed(s9=in_parms.ssn_value[9])) +
									i(in_parms.ssn_value<>'',keyed(s1=in_parms.ssn_value[1]),keyed(s2=in_parms.ssn_value[2]),keyed(s3=in_parms.ssn_value[3]),wild(s4),keyed(s5=in_parms.ssn_value[5]),keyed(s6=in_parms.ssn_value[6]),keyed(s7=in_parms.ssn_value[7]),keyed(s8=in_parms.ssn_value[8]),keyed(s9=in_parms.ssn_value[9])) +
									i(in_parms.ssn_value<>'',keyed(s1=in_parms.ssn_value[1]),keyed(s2=in_parms.ssn_value[2]),keyed(s3=in_parms.ssn_value[3]),keyed(s4=in_parms.ssn_value[4]),wild(s5),keyed(s6=in_parms.ssn_value[6]),keyed(s7=in_parms.ssn_value[7]),keyed(s8=in_parms.ssn_value[8]),keyed(s9=in_parms.ssn_value[9])) +
									i(in_parms.ssn_value<>'',keyed(s1=in_parms.ssn_value[1]),keyed(s2=in_parms.ssn_value[2]),keyed(s3=in_parms.ssn_value[3]),keyed(s4=in_parms.ssn_value[4]),keyed(s5=in_parms.ssn_value[5]),wild(s6),keyed(s7=in_parms.ssn_value[7]),keyed(s8=in_parms.ssn_value[8]),keyed(s9=in_parms.ssn_value[9])) +
									i(in_parms.ssn_value<>'',keyed(s1=in_parms.ssn_value[1]),keyed(s2=in_parms.ssn_value[2]),keyed(s3=in_parms.ssn_value[3]),keyed(s4=in_parms.ssn_value[4]),keyed(s5=in_parms.ssn_value[5]),keyed(s6=in_parms.ssn_value[6]),wild(s7),keyed(s8=in_parms.ssn_value[8]),keyed(s9=in_parms.ssn_value[9])) +
									i(in_parms.ssn_value<>'',keyed(s1=in_parms.ssn_value[1]),keyed(s2=in_parms.ssn_value[2]),keyed(s3=in_parms.ssn_value[3]),keyed(s4=in_parms.ssn_value[4]),keyed(s5=in_parms.ssn_value[5]),keyed(s6=in_parms.ssn_value[6]),keyed(s7=in_parms.ssn_value[7]),wild(s8),keyed(s9=in_parms.ssn_value[9])) +
									i(in_parms.ssn_value<>'',keyed(s1=in_parms.ssn_value[1]),keyed(s2=in_parms.ssn_value[2]),keyed(s3=in_parms.ssn_value[3]),keyed(s4=in_parms.ssn_value[4]),keyed(s5=in_parms.ssn_value[5]),keyed(s6=in_parms.ssn_value[6]),keyed(s7=in_parms.ssn_value[7]),keyed(s8=in_parms.ssn_value[8])) );
								
			f_filt := f_raw( ut.bit_test(lookups, in_parms.lookup_value) );

			f := project(f_filt, xt(LEFT));
			
			nofail := in_parms.nofail;

			AutoKey.mac_Limits(f,f_ret)	

			RETURN f;//if(is_limitable,f_ret,f);

		END;