import sexoffender, doxie, doxie_build;

df := dataset([], sexoffender.layout_zip_type_key);

export key_sexoffender_zip_type := index(df,{alt_zip, alt_type, yob, dob}, {did},
								                         Constants.Cluster+'::key::sexoffender_zip_type_'+ doxie_build.buildstate+'_'+doxie.Version_SuperKey);
