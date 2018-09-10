import doxie,doxie_build, ut, hygenics_search;

export Key_SexOffender_SPK (boolean IsFCRA = false) := function

//TODO: apply fcra-filtering by source, state, etc.
df := doxie_build.file_SO_Main_keybuilding;

df_exp_rec := record
	df;
	real lat;
	real long;
end;

df_exp := project(df, transform({df_exp_rec}, 
                      self := left, 
											self.lat := (real)(left.geo_lat),
											self.long := (real)(left.geo_long)));// (~IsFCRA); // disable fcra for now;

df_filter := df_exp(seisint_primary_key[1..4] not in Hygenics_search.Sex_Offenders_Not_Updating.SO_By_Key);
df_all		:= df_exp;

//TODO: change names according to a standard
string file_name := if (IsFCRA, 
					 Constants.Cluster+'::key::sexoffender::fcra::spk'+doxie_build.buildstate+'_'+doxie.Version_SuperKey,
					 Constants.Cluster+'::key::sexoffender_spk'+doxie_build.buildstate+'_'+doxie.Version_SuperKey);

return if (IsFCRA,
           index (df_filter,{string60 sspk := df_filter.seisint_primary_key}, {df_filter}, file_name, OPT),
           index (df_all,{string60 sspk := df_all.seisint_primary_key}, {df_all}, file_name));
end;