import ut,mdr,doxie_build;

export proc_address_hist (boolean isFCRA) := FUNCTION

h:=if(isFCRA, Header.File_FCRA_header_raw_syncd,
							header.File_header_raw_syncd);
							
lab:=header.File_LAB_pairs;

r := record
	h.did;
	h.rid;
	h.src;
	h.dt_first_seen;
	h.dt_last_seen;
	h.prim_range;
	h.predir;
	h.prim_name;
	h.suffix;
	h.postdir;
	h.unit_desig;
	h.sec_range;
	h.zip;
	{lab} - [did,rid];
	h.RawAID
end;


join_all := JOIN(h(prim_name<>''),lab
                ,LEFT.rid=RIGHT.alpha_rid
                ,TRANSFORM(r
										,SELF := LEFT
										,SELF := Right)
								,hash
								)
								:persist('~thor400_data::persist::join_all'+if(isFCRA,'_fcra',''))
								;

join_all_dis := distribute(join_all,hash(did));
join_all_p := project(join_all_dis
											,transform({join_all_dis}
												,self.src:=map(
																			mdr.sourceTools.SourceIsProperty(left.src) => 'FP'
																			,left.src in mdr.sourceTools.set_Utility_sources => 'UT'
																			,left.src)
												,self:=left));

r tr(r l,r r) := transform
	self.dt_first_seen  := ut.Min2(l.dt_first_seen,r.dt_first_seen);
	self.dt_last_seen   :=     max(l.dt_last_seen,r.dt_last_seen);
	self.RawAID         := ut.min2(l.RawAID,r.RawAID);
	self:=l;
end;

join_all_srt:=sort(join_all_p, did,src,addr_ind,-best_addr_ind,prim_range, prim_name, predir, postdir, suffix, sec_range, unit_desig, zip, addressstatus, addresstype, local);
dsRlld0     :=rollup(join_all_srt,tr(left,right),did,src,addr_ind,local);

rTemp := record
	dsRlld0;
	min_dt_first_seen:=dsRlld0.dt_first_seen;
	max_dt_last_seen:=dsRlld0.dt_last_seen;
	unsigned2 bureau_source_count:=0;
	unsigned2 property_source_count:=0;
	unsigned2 utility_source_count:=0;
	unsigned2 vehicle_source_count:=0;
	unsigned2 dl_source_count:=0;
	unsigned2 voter_source_count:=0;
end;
dsRlld1:=table(dsRlld0,rTemp);

dsRlld     :=sort(dsRlld1,    did    ,addr_ind,-best_addr_ind,prim_range, prim_name, predir, postdir, suffix, sec_range, unit_desig, zip, addressstatus, addresstype, local);

rTemp tr1(rTemp l,rTemp r):=transform
	self.Min_dt_first_seen:=map(l.Min_dt_first_seen>0 and r.Min_dt_first_seen>0 => min(l.Min_dt_first_seen,r.Min_dt_first_seen)
															,l.Min_dt_first_seen>0 => l.Min_dt_first_seen
															,r.Min_dt_first_seen>0 => r.Min_dt_first_seen
															,999999);
	self.Max_dt_last_seen:=max(l.Max_dt_last_seen,r.Max_dt_last_seen);
	//TN is external but in case it becomes internal and we forget to change here
	self.bureau_source_count:=if(r.src in ['EQ','EN','TN'],l.bureau_source_count + 1, l.bureau_source_count);
	self.property_source_count:=if(mdr.sourceTools.SourceIsProperty(r.src),l.property_source_count + 1, l.property_source_count);
	self.utility_source_count:=if(mdr.sourceTools.SourceIsUtilities(r.src),l.utility_source_count + 1, l.utility_source_count);
	self.vehicle_source_count:=if(mdr.sourceTools.SourceIsVehicle(r.src),l.vehicle_source_count + 1, l.vehicle_source_count);
	self.dl_source_count:=if(mdr.sourceTools.SourceIsDL(r.src),l.dl_source_count + 1, l.dl_source_count);
	self.voter_source_count:=if(mdr.sourceTools.SourceIsVoters_v2(r.src),l.voter_source_count + 1, l.voter_source_count);
	self:=l;
end;

join_all_rld:= rollup(dsRlld,tr1(left,right),did,addr_ind,local);

hierarchy_layout := record
	unsigned s_did;
	STRING10 prim_range;
	STRING2  predir;
	STRING28 prim_name;
	STRING4  suffix;
	STRING2  postdir;
	STRING10 unit_desig;
	STRING8  sec_range;
	STRING5  zip;
	Unsigned3 date_first_seen;
	Unsigned3 date_last_seen;
	Integer address_history_seq;
	unsigned2 source_count;
	unsigned2 insurance_source_count;
  string5 addressstatus;
  string3 addresstype;
	unsigned2 bureau_source_count;
	unsigned2 property_source_count;
	unsigned2 utility_source_count;
	unsigned2 vehicle_source_count;
	unsigned2 dl_source_count;
	unsigned2 voter_source_count;
	unsigned8 RawAid;
end;

p:=project(join_all_rld
						,transform(hierarchy_layout
							,self.s_did:=left.did
							,self.date_first_seen:=if(left.min_dt_first_seen=999999,left.max_dt_last_seen,left.min_dt_first_seen)
							,self.date_last_seen:=left.max_dt_last_seen
							,self.address_history_seq:=(integer)left.addr_ind
							,self.source_count:=(integer)left.source_cnt
							,self.insurance_source_count:=(integer)left.ins_source_cnt
							,self:=left
							)
						);

layout_address_only := record

	header.Layout_Header.prim_range;
	header.Layout_Header.predir;
	header.Layout_Header.prim_name;
	header.Layout_Header.suffix;
	header.Layout_Header.postdir;
	header.Layout_Header.unit_desig;
	header.Layout_Header.sec_range;
	header.Layout_Header.zip;
  header.layout_Header.rawAID;

END;

building  := distribute(if(isFCRA, doxie_build.File_FCRA_header_built, doxie_build.file_header_building),
							hash32(prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,zip));

b_thin    := dedup(sort(project(building(RawAID<>0),transform(layout_address_only,self:=LEFT)),
                       prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,zip, rawaid,local),
                  except rawaid,local);

p_with_RawAID := join(distribute(p,hash32(prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,zip)),
											b_thin,

                      LEFT.prim_range = RIGHT.prim_range AND
                       LEFT.predir = RIGHT.predir AND
                       LEFT.prim_name = RIGHT.prim_name AND
                       LEFT.suffix = RIGHT.suffix AND
                       LEFT.postdir = RIGHT.postdir AND
                       LEFT.unit_desig = RIGHT.unit_desig AND
                       LEFT.sec_range = RIGHT.sec_range AND
                       LEFT.zip = RIGHT.zip,
                      TRANSFORM({p},
                                SELF.RawAID := if(RIGHT.RawAID <>0,RIGHT.RawAID,LEFT.RawAID),
                                SELF := LEFT),
                      LEFT OUTER,
                      KEEP(1),
                      local);

RETURN p_with_RawAID;
END;