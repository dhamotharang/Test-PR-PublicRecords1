import autokey, doxie, ut, doxie_files, RoxieKeyBuild, doxie_build, hygenics_search, sexoffender;

EXPORT Key_SexOffender_Enh_Addr (boolean IsFCRA = false, string filedate):= function

AltLayout := record
	unsigned6 alt_did;
	sexoffender.layout_out_main;
	sexoffender.layout_in_alt;
end;

f := dataset('persist::SexOffender_Temp', altlayout, flat);

//f := hygenics_soff.file_SO_Enh_keybuilding;

xl := RECORD
	f;
  integer8 zero;
  unsigned4 lookups;
  real8 lat;
  real8 long;	
END;

DS 			:= dataset('persist::sex_offender_enh_fdids', xl, flat);
ds_fcra := ds(seisint_primary_key[1..4] not in Hygenics_search.Sex_Offenders_Not_Updating.SO_By_Key and source_file not in Hygenics_search.Sex_Offenders_Not_Updating.SO_By_Source);
			
AutoKey.MAC_Build_version(DS,fname,mname,lname,
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
						Constants.Cluster+'::key::so_enh'+doxie_build.buildstate,
						Constants.Cluster+'::key::sexoffender::'+filedate+'::enh'+doxie_build.buildstate,outaction1,false) // Diffing originally true

AutoKey.MAC_Build_version(DS_fcra,fname,mname,lname,
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
						Constants.Cluster+'::key::sexoffender::fcra::so_enh'+doxie_build.buildstate,
						Constants.Cluster+'::key::sexoffender::fcra::'+filedate+'::enh'+doxie_build.buildstate,outaction1_fcra,false) // Diffing originally true

return if (IsFCRA,
						outaction1_fcra,
						outaction1);
						
end;