import doxie,Data_Services,mdr,ut,doxie_build, dx_Header;

df := header.file_headers(mdr.sourcetools.sourceisonprobation(src)=false,prim_name<>'',zip<>'');

slimrec := record
	df.prim_name;
	df.prim_range;
	df.sec_range;
	df.zip;
	df.zip4;
	df.suffix;
	df.did;
	df.dt_first_seen;
	df.dt_last_seen;
	df.RawAID;
end;

df2 := table(df,slimrec);

df3 := group(sort(distribute(df2,hash(did,prim_name,zip,prim_range)),did,prim_name,zip,prim_range,sec_Range,suffix,dt_first_seen, -dt_last_seen,local),did,prim_name,zip,prim_range,sec_Range,suffix,local);

df3 roll_dates(df3 L, df3 R) := transform
	self.dt_first_seen := if (L.dt_first_seen < R.dt_first_seen and L.dt_first_seen != 0, L.dt_first_seen, R.dt_first_seen);
	self.dt_last_seen := if (L.dt_last_seen > R.dt_last_seen, L.dt_last_seen, R.dt_last_seen);
	self.RawAID := max(L.RawAID,R.RawAID);
	self := l;
end;

df4 := rollup(df3, true, roll_dates(LEFT,RIGHT));

df5 := group(df4);


building  := distribute(doxie_build.file_header_building,
							hash32(did,prim_name,zip,prim_range,sec_range,suffix));

layout_address_only := record

	building.did;
	building.prim_name;
	building.zip;
	building.prim_range;
	building.sec_Range;
	building.suffix;
	building.rawAID;

END;

b_thin    := dedup(sort(project(building(RawAID<>0),layout_address_only),
                      did,prim_name,zip,prim_range,sec_range,suffix, rawaid,local),
                  except rawaid,local);

df5_with_RawAID := join(distribute(df5,hash32(did,prim_name,zip,prim_range,sec_range,suffix))
											,b_thin,
								
								LEFT.did = RIGHT.did AND
								LEFT.prim_name = RIGHT.prim_name AND
                LEFT.zip = RIGHT.zip AND
								LEFT.prim_range = RIGHT.prim_range AND
								LEFT.sec_range = RIGHT.sec_range AND
                LEFT.suffix = RIGHT.suffix
                
                                          ,TRANSFORM({df5},
																										 SELF.RawAID := if(RIGHT.RawAID <>0,RIGHT.RawAID,LEFT.RawAID),
																										 SELF := LEFT)
																				  ,LEFT OUTER, KEEP(1)
																					,local);


export data_Key_Nbr_Address := PROJECT (df5_with_RawAID, 
                                 TRANSFORM (dx_Header.layouts.i_nbr_address,
                                            SELF.z2 := LEFT.zip4[1..2], SELF := LEFT));
//index(df5_with_RawAID,{prim_name,zip,z2 := zip4[1..2], suffix, prim_range},{did,sec_range,dt_first_seen,dt_last_seen,RawAID},
//Data_Services.Data_location.Prefix('PersonHeader') +'thor_Data400::key::nbr_address_' + doxie.Version_SuperKey);
