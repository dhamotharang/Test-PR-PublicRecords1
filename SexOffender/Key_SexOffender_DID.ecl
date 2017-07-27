import doxie,doxie_build, ut, hygenics_search;

export Key_SexOffender_DID (boolean IsFCRA = false) := function

//TODO: apply fcra-filtering by source, state, etc.
df := doxie_build.file_SO_Main_keybuilding;

df_exp_rec := record
	df.did;
	df.seisint_primary_key;
	real lat;
	real long;
end;

df_exp := project(df(did != 0), transform({df_exp_rec}, 
              self := left, 
						  self.lat := (real)left.geo_lat,
						  self.long := (real)left.geo_long));

df_final := dedup(sort(df_exp, record), record);// (~IsFCRA); // disable fcra for now;


df_filter := df_final(seisint_primary_key[1..4] not in Hygenics_search.Sex_Offenders_Not_Updating.SO_By_Key);
df_all 		:= df_final;

//TODO: change names according to a standard
string file_name := if (IsFCRA, 
					 Constants.Cluster+'::key::sexoffender::fcra::did'+doxie_build.buildstate+'_'+doxie.Version_SuperKey,
					 Constants.Cluster+'::key::sexoffender_did'+doxie_build.buildstate+'_'+doxie.Version_SuperKey);

return if (IsFCRA,
           index(df_filter, {did}, {seisint_primary_key, lat, long}, file_name, OPT),
           index(df_all, {did}, {seisint_primary_key, lat, long}, file_name, OPT));

end;