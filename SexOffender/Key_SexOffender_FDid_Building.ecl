import doxie, doxie_build, hygenics_search;

EXPORT Key_SexOffender_FDid_Building (boolean IsFCRA = false) := function

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

DS 				:= dataset('persist::sex_offender_enh_fdids', xl, flat);

in_common := project(ds,transform(sexoffender.Layout_fdid,self := left));

in_filter := in_common(seisint_primary_key[1..4] not in Hygenics_search.Sex_Offenders_Not_Updating.SO_By_Key);
in_all		:= in_common;

string file_name := if (IsFCRA, 
						Constants.Cluster+'::key::sexoffender::fcra::fdid'+doxie_build.buildstate+'_'+doxie.Version_SuperKey,
						Constants.Cluster+'::key::sexoffender_fdid'+doxie_build.buildstate+'_'+doxie.Version_SuperKey);

return if (IsFCRA,
           index(in_filter,{did}, {seisint_primary_key, lat, long}, file_name, OPT),
           index(in_all,{did}, {seisint_primary_key, lat, long}, file_name));
end;