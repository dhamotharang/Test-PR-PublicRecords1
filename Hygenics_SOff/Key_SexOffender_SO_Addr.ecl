import autokey, doxie, ut, doxie_files, RoxieKeyBuild, doxie_build, hygenics_search, sexoffender;

EXPORT Key_SexOffender_SO_Addr (boolean IsFCRA = false, string filedate):= function

AltLayout := record
	unsigned6 alt_did;
	sexoffender.layout_out_main;
	sexoffender.layout_in_alt;
end;

f := dataset('persist::SexOffender_Temp', altlayout, flat);
//f := doxie_build.file_SO_Enh_keybuilding;

xl := RECORD
	f;
  integer8 zero;
  unsigned4 lookups;
  real8 lat;
  real8 long;	
END;

DS 			:= dataset('persist::sex_offender_enh_fdids', xl, flat);
			
ds_orig_fcra := project(ds(alt_type='S' and seisint_primary_key[1..4] not in Hygenics_search.Sex_Offenders_Not_Updating.SO_By_Key and source_file not in Hygenics_search.Sex_Offenders_Not_Updating.SO_By_Source),
                   transform({ds},
												self.alt_st := if(left.alt_st='',left.orig_state_code, left.alt_st);
												self := left)) : PERSIST('persist::sex_offender_fdids_fcra');

ds_orig := project(ds(alt_type='S'),
                   transform({ds},
												self.alt_st := if(left.alt_st='',left.orig_state_code, left.alt_st);
												self := left)) : PERSIST('persist::sex_offender_fdids');									

AutoKey.MAC_Build_version(ds_orig_fcra,fname,mname,lname,
						ssn,
						dob,
						police_agency_phone,
						alt_prim_name, alt_prim_range, alt_st, alt_city_name, alt_zip, alt_sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						lookups,
						did,
						'~thor_data400::key::sexoffender::fcra::so_'+doxie_build.buildstate,
						'~thor_data400::key::sexoffender::fcra::'+filedate+'::'+doxie_build.buildstate,outaction2_fcra,false) // Diffing originally true

AutoKey.MAC_Build_version(ds_orig,fname,mname,lname,
						ssn,
						dob,
						police_agency_phone,
						alt_prim_name, alt_prim_range, alt_st, alt_city_name, alt_zip, alt_sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						lookups,
						did,
						'~thor_data400::key::so_'+doxie_build.buildstate,
						'~thor_data400::key::sexoffender::'+filedate+'::'+doxie_build.buildstate,outaction2,false) // Diffing originally true

return if (IsFCRA,
						outaction2_fcra,
						outaction2);

end;