import doxie,doxie_build,did_add,ut, hygenics_search;

export Key_SexOffender_SPK_Enh (boolean IsFCRA = false) := function

df := doxie_build.Keybuild_Sexoffender_SPK;

r := RECORD
	df.seisint_primary_key;
	sexoffender.Layout_in_Alt;
END;

r make_norm(df le, sexoffender.Layout_Out_Alt ri) := TRANSFORM
	SELF.seisint_primary_key := IF(
						ri.alt_type<>'S' AND
						DID_Add.Address_Match_Score(le.prim_range, le.prim_name, le.sec_range, le.zip5, 
						ri.alt_prim_range, ri.alt_prim_name, ri.alt_sec_range, ri.alt_zip) BETWEEN 80 AND 100,
																 skip, le.seisint_primary_key);	
  self.isMisMatched := ri.alt_type in ['B','V','C'] and 
	                      DID_Add.Address_Match_Score(
												le.prim_range,     le.prim_name,     le.sec_range,     le.zip5, 
	                      ri.alt_prim_range, ri.alt_prim_name, ri.alt_sec_range, ri.alt_zip) < 80;
	SELF := ri;
END;

normed := NORMALIZE(df,LEFT.addresses,make_norm(LEFT,RIGHT));// (~IsFCRA); // disable fcra for now;

norm_filter := normed(seisint_primary_key[1..4] not in Hygenics_search.Sex_Offenders_Not_Updating.SO_By_Key);
norm_all		:= normed;

//TODO: change names according to a standard
string file_name := if (IsFCRA, 
					 Constants.Cluster+'::key::sexoffender::fcra::enh'+doxie_build.buildstate+'_'+doxie.Version_SuperKey,
					 Constants.Cluster+'::key::sexoffender_enh'+ doxie_build.buildstate+'_'+doxie.Version_SuperKey);

return if (IsFCRA, 
           index (norm_filter, {string60 sspk := norm_filter.seisint_primary_key}, {norm_filter}, file_name, OPT),
           index (norm_all, {string60 sspk := norm_all.seisint_primary_key}, {norm_all}, file_name));
end;
      