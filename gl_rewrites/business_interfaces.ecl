import gl_autokey;
export business_interfaces :=
	module
		export i__get_bdids_plus :=
			interface(
				gl_rewrites.basic_interfaces.i__precs,
				gl_rewrites.basic_interfaces.i__company_name_val,
				gl_rewrites.basic_interfaces.i__company_name_val_filt,
				gl_rewrites.basic_interfaces.i__company_name_val_filt2,
				gl_rewrites.basic_interfaces.i__phone_value,
				gl_rewrites.basic_interfaces.i__fein_value,
				gl_rewrites.basic_interfaces.i__company_name_value,
				gl_rewrites.basic_interfaces.i__state_value,
				gl_rewrites.basic_interfaces.i__zip_val,
				gl_rewrites.basic_interfaces.i__fname_value,
				gl_rewrites.basic_interfaces.i__nicknames,
				gl_rewrites.basic_interfaces.i__phonetics,
				gl_rewrites.basic_interfaces.i__lname_value,
				gl_rewrites.basic_interfaces.i__exact_only,
				gl_rewrites.basic_interfaces.i__bdid_dataset,
				gl_rewrites.basic_interfaces.i__mile_radius_value,
				gl_rewrites.basic_interfaces.i__bh_zip_value,
				gl_rewrites.basic_interfaces.i__adl_service_ip)
				export boolean forceLocal := true;
			end;
		export i__get_bdids :=
			interface(
				i__get_bdids_plus)
				export boolean forceLocal := false;
			end;
	end;
	