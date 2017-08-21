import autokey,doxie,ut;
export Fetch_Phone(
	string autokey_keyname,
	gl_autokey.autokey_interfaces.phone in_parms) :=
		function

			i := autokey.key_phone(autokey_keyname);

			doxie.layout_references xt(i r) := 
			TRANSFORM
				SELF := r;
			END;

			pfe(string20 l, string20 r) := l[1..length(trim(datalib.preferredfirst(r)))]=(STRING20)datalib.preferredfirst(r);

			f := project(
							i(in_parms.phone_value<>'',
					keyed(p7=IF(length(trim(in_parms.phone_value))=10,in_parms.phone_value[4..10],(STRING7)in_parms.phone_value)),
					keyed(p3=in_parms.phone_value[1..3] OR length(trim(in_parms.phone_value)) <> 10),
					keyed(in_parms.lname_value='' or dph_lname=(string6)metaphonelib.DMetaPhone1(in_parms.lname_value)[1..6]))  , xt(LEFT));

			nofail := in_parms.nofail;
			
			AutoKey.mac_Limits(f,f_ret)	
												
			RETURN f_ret;
					
		END;