import doxie,doxie_build;

df := file_main;

df_exp := project(df, transform(Layout_fdid, 
                                self := left, 
						  self.lat := (real)left.geo_lat,
						  self.long := (real)left.geo_long));

export Key_SexOffender_fdid := index(df_exp,{did},
                                        {seisint_primary_key, lat, long},
								Constants.Cluster+'::key::sexoffender_fdid_'+ doxie_build.buildstate+'_'+doxie.Version_SuperKey);