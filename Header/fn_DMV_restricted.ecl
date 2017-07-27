import doxie,mdr,ut;

EXPORT fn_DMV_restricted(string filedate) := function

d :=pull(index(doxie.Key_Header,'~thor_data400::key::header::'+filedate+'::data'));

dmvSRC    :=d( mdr.sourcetools.SourceIsDMVRestricted(src));
NotdmvSRC :=d(~mdr.sourcetools.SourceIsDMVRestricted(src));

rec_fname := record
	unsigned6 did;
	unsigned6 rid;
	string25 fname;
end;
rec_mname := record
	unsigned6 did;
	unsigned6 rid;
	string25 mname;
end;
rec_lname := record
	unsigned6 did;
	unsigned6 rid;
	string25 lname;
end;
rec_dob := record
	unsigned6 did;
	unsigned6 rid;
	unsigned4 dob;
end;
rec_ssn := record
	unsigned6 did;
	unsigned6 rid;
	string25 ssn;
end;
rec_adr := record
	unsigned6 did;
	unsigned6 rid;
	string25 prim_range;
	string25 prim_name;
	string25 city_name;
end;

ds_fname := project(dmvSRC(fname<>''),rec_fname);
ds_lname := project(dmvSRC(lname<>''),rec_lname);
ds_ssn   := project(dmvSRC(ssn<>''),rec_ssn);
ds_dob   := project(dmvSRC(dob>0),rec_dob);
ds_addr  := project(dmvSRC(prim_name<>''),rec_adr);

fname := dedup(project(NotdmvSRC, rec_fname), did, fname,all);
j_fname := join(fname, ds_fname
								,   left.did = right.did
								and (left.fname = right.fname
										or ut.WithinEditN(left.fname, right.fname, 2)
										or left.fname = right.fname[1..LENGTH(TRIM(left.fname))]
										or right.fname = left.fname[1..LENGTH(TRIM(right.fname))])
								,transform(right)
								,right only)
								:persist('~thor400_data::persist::dmv_fname')
								;

mname := dedup(project(NotdmvSRC(mname != ''), rec_mname), did, mname,all);
j_fname1 := join(mname, j_fname
								,   left.did = right.did
								and (left.mname = right.fname
										or ut.WithinEditN(left.mname, right.fname, 2)
										or left.mname = right.fname[1..LENGTH(TRIM(left.mname))]
										or right.fname = left.mname[1..LENGTH(TRIM(right.fname))])
								,transform(right)
								,right only)
								:persist('~thor400_data::persist::dmv_fname1')
								;

lname := dedup(project(NotdmvSRC, rec_lname), did, lname,all);
j_lname := join(lname, ds_lname
								,    left.did = right.did
								and (left.lname = right.lname
										or ut.WithinEditN(left.lname, right.lname, 2)
										or left.lname = right.lname[1..LENGTH(TRIM(left.lname))]
										or right.lname = left.lname[1..LENGTH(TRIM(right.lname))])
								,transform(right)
								,right only)
								:persist('~thor400_data::persist::dmv_lname')
								;

j_Lname1 := join(mname, j_Lname
								,   left.did = right.did
								and (left.mname = right.Lname
										or ut.WithinEditN(left.Mname, right.Lname, 2)
										or left.mname = right.Lname[1..LENGTH(TRIM(left.mname))]
										or right.Lname = left.mname[1..LENGTH(TRIM(right.Lname))])
								,transform(right)
								,right only)
								:persist('~thor400_data::persist::dmv_lname1')
								;

dob := dedup(project(NotdmvSRC((unsigned4)dob > 0), rec_dob), did, dob,all);
j_dob := join(dob, ds_dob
							,    left.did = right.did
							 and left.dob = right.dob
							,transform(right)
							,right only)
							:persist('~thor400_data::persist::dmv_dob')
							;

ssn := dedup(project(NotdmvSRC(ssn != ''),rec_ssn), did, ssn, all);
j_ssn := join(ssn, ds_ssn
							,   left.did = right.did
							and left.ssn = right.ssn
							,transform(right)
							,right only)
							:persist('~thor400_data::persist::dmv_ssn')
							;

adr := dedup(project(NotdmvSRC(prim_name<>''), rec_adr), did, prim_range, prim_name, city_name,all);
j_adr := join(adr, ds_addr
							,   left.did = right.did
							and left.prim_range = right.prim_range
							and left.prim_name = right.prim_name
							and left.city_name = right.city_name
							,transform(right)
							,right only)
							:persist('~thor400_data::persist::dmv_adr')
							;

restrictedDMVrids
	:=dedup(
						table(j_fname,{rid})
					+ table(j_fname1,{rid})
					+ table(j_lname,{rid})
					+ table(j_lname1,{rid})
					+ table(j_dob,{rid})
					+ table(j_ssn,{rid})
					+ table(j_adr,{rid})
				,rid,all)
			;

j_rids := join(d, restrictedDMVrids
							,left.rid = right.rid
							,transform(left)
							,lookup
							)
							:persist('~thor400_data::persist::dmv_res_rids')
							;

j1 := join(j_rids, j_fname
							,left.rid = right.rid
							,transform({j_rids}
								,self.fname:=if(left.rid=right.rid,'',left.fname)
								,self:=left
								)
							,left outer
							,lookup
							);

j2 := join(j1, j_fname1
							,left.rid = right.rid
							,transform({j_rids}
								,self.fname:=if(left.rid=right.rid,'',left.fname)
								,self.mname:=if(left.rid=right.rid,'',left.mname)
								,self:=left
								)
							,left outer
							,lookup
							);

j3 := join(j2, j_lname
							,left.rid = right.rid
							,transform({j_rids}
								,self.lname:=if(left.rid=right.rid,'',left.lname)
								,self:=left
								)
							,left outer
							,lookup
							);

j4 := join(j3, j_lname1
							,left.rid = right.rid
							,transform({j_rids}
								,self.lname:=if(left.rid=right.rid,'',left.lname)
								,self.mname:=if(left.rid=right.rid,'',left.mname)
								,self:=left
								)
							,left outer
							,lookup
							);

j5 := join(j4, j_dob
							,left.rid = right.rid
							,transform({j_rids}
								,self.dob:=if(left.rid=right.rid,0,left.dob)
								,self.valid_dob:=if(left.rid=right.rid,'',left.valid_dob)
								,self:=left
								)
							,left outer
							,lookup
							);

j7 := join(j5, j_ssn
							,left.rid = right.rid
							,transform({j_rids}
								,self.ssn:=if(left.rid=right.rid,'',left.ssn)
								,self.valid_ssn:=if(left.rid=right.rid,'',left.valid_ssn)
								,self:=left
								)
							,left outer
							,lookup
							);

j9 := join(j7, j_adr
							,left.rid = right.rid
							,transform({j_rids,boolean exclusivedmvsourced:=false}
								,self.prim_range:=if(left.rid=right.rid,'',left.prim_range)
								,self.predir:=if(left.rid=right.rid,'',left.predir)
								,self.prim_name:=if(left.rid=right.rid,'',left.prim_name)
								,self.suffix:=if(left.rid=right.rid,'',left.suffix)
								,self.postdir:=if(left.rid=right.rid,'',left.postdir)
								,self.unit_desig:=if(left.rid=right.rid,'',left.unit_desig)
								,self.sec_range:=if(left.rid=right.rid,'',left.sec_range)
								,self.city_name:=if(left.rid=right.rid,'',left.city_name)
								,self.st:=if(left.rid=right.rid,'',left.st)
								,self.zip:=if(left.rid=right.rid,'',left.zip)
								,self.zip4:=if(left.rid=right.rid,'',left.zip4)
								,self.county:=if(left.rid=right.rid,'',left.county)
								,self.geo_blk:=if(left.rid=right.rid,'',left.geo_blk)
								,self:=left
								)
							,left outer
							,lookup
							);

	p:=project(j9
					,transform({j9}
						,self.exclusivedmvsourced
								:=		left.fname=''
									and left.lname=''
									and left.ssn=''
									and left.dob=0
									and left.prim_name=''
						,self:=left
					));

 return p;
 
 end;