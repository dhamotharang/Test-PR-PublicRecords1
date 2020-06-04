import doxie_build,mdr,watchdog,doxie,address,ut,PRTE2_Header,PromoteSupers,header;

r1 := RECORD
  unsigned6 did;
  unsigned6 rid;
  string1 pflag1;
  string1 pflag2;
  string1 pflag3;
  string2 src;
  unsigned3 dt_first_seen;
  unsigned3 dt_last_seen;
  unsigned3 dt_vendor_last_reported;
  unsigned3 dt_vendor_first_reported;
  unsigned3 dt_nonglb_last_seen;
  string1 rec_type;
  qstring18 vendor_id;
  qstring10 phone;
  qstring9 ssn;
  integer4 dob;
  qstring5 title;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 city_name;
  string2 st;
  qstring5 zip;
  qstring4 zip4;
  string3 county;
  qstring7 geo_blk;
  qstring5 cbsa;
  string1 tnt;
  string1 valid_ssn;
  string1 jflag1;
  string1 jflag2;
  string1 jflag3;
  unsigned8 rawaid;
  unsigned8 persistent_record_id;
  string1 valid_dob;
  unsigned6 hhid;
  string18 county_name;
  string120 listed_name;
  string10 listed_phone;
  unsigned4 dod;
  string1 death_code;
  unsigned4 lookup_did;
 END;

export Infutor_best(boolean excludeForeclosure = false
                    ,dataset({infutor.infutor_header}) head_in = infutor.infutor_header) := function

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
infutor_into_header := distribute(head_in, hash(did));
key_watchdog_best :=dedup(distribute(index(watchdog.Key_Prep_Watchdog_GLB(),'~prte::key::watchdog::qa::best.did'),hash(did)),did,all,local);
#ELSE
infutor_into_header := if(excludeForeclosure, 
	//distribute(infutor.infutor_header_filtered(true), hash(did)),
	distribute(PROJECT(DATASET('~thor::spokeo::infutor_header',r1,thor),RECORDOF(infutor.infutor_header)), hash(did)),
	distribute(infutor.infutor_header, hash(did)));
key_watchdog_best :=dedup(distribute(watchdog.Key_Prep_Watchdog_GLB(),hash(did)),did,all,local);
#END;

// apply CCPA suppression
infutor_into_header_ccpa_applied:=header.fn_suppress_ccpa(infutor_into_header,true);

//mapping to scored layout

infutor.layout_best.lscored tscored(infutor_into_header_ccpa_applied le) := transform

self.addr1:=stringlib.stringcleanspaces(if(length(stringlib.stringfilterout(le.prim_range,'%0-. '))=0,'',trim(le.prim_range))
															+' '+if(length(stringlib.stringfilterout(le.predir,'%0-. '))=0,'',trim(le.predir))
															+' '+if(length(stringlib.stringfilterout(le.prim_name,'%0-. '))=0,'',trim(le.prim_name))
															+' '+if(length(stringlib.stringfilterout(le.suffix,'%0-. '))=0,'',trim(le.suffix))
															+' '+if(length(stringlib.stringfilterout(le.postdir,'%0-. '))=0,'',trim(le.postdir)));
self.addr2:=stringlib.stringcleanspaces(if(length(stringlib.stringfilterout(le.unit_desig,'%0-. '))=0,'',trim(le.unit_desig))
															+' '+if(length(stringlib.stringfilterout(le.sec_range,'%0-. '))=0,'',trim(le.sec_range)));
		
self.poor_addr:=address.AddressQuality(le.prim_range,le.prim_name,le.suffix,le.sec_range,le.city_name,le.zip, le.zip4)>0
												or (unsigned)le.zip4=0;
												
self := le;
self := [];

end;

pre_scored := project(infutor_into_header_ccpa_applied, tscored(left));

//join with watchdog best

pre_scored tjoin(pre_scored le, key_watchdog_best ri) := transform

self.bfcnt      := if(trim(le.fname) = trim(ri.fname) and ri.fname <>'',1,0);
self.bmcnt      := if(trim(le.mname) = trim(ri.mname) and ri.mname <>'',1,0);
self.blcnt      :=if(trim(le.lname) = trim(ri.lname) and ri.lname<>'',1,0);
self.bsfxcnt    :=if(trim(le.name_suffix) = trim(ri.name_suffix) and ri.name_suffix<>'',1,0);
self.bscnt      :=if(trim(le.ssn)=trim(ri.ssn) and ri.ssn<>'',1,0);
self.bdcnt      :=if(le.dob=ri.dob and ri.dob>0,1,0);
self.bpcnt      :=if(trim(le.phone)=trim(ri.phone) and ri.phone<>'',1,0);
self.bacnt      :=map(le.addr1=stringlib.stringcleanspaces(trim(ri.prim_range)
																										+' '+trim(ri.predir)
																										+' '+trim(ri.prim_name)
																										+' '+trim(ri.suffix)
																										+' '+trim(ri.postdir))
											and
											le.addr2=stringlib.stringcleanspaces(trim(ri.unit_desig)
																										+' '+trim(ri.sec_range))
											and
											ri.prim_name<>'' => 2
											,le.addr1=stringlib.stringcleanspaces(trim(ri.prim_range)
																										+' '+trim(ri.predir)
																										+' '+trim(ri.prim_name)
																										+' '+trim(ri.suffix)
																										+' '+trim(ri.postdir))
																										and
																										ri.prim_name<>'' => 1
											,0);

self:=le;

end;

pre_best :=join(pre_scored,key_watchdog_best, left.did = right.did, tjoin(left, right), left outer, local);

gd:=group(sort(pre_best,did,local),did);

///////////////////////////////////////////////////////////////////////////////////////
//count date last seen
i1:=iterate(sort(gd,dt_last_seen)
			,transform({gd}
				,self.DateRank:=if(left.dt_last_seen=right.dt_last_seen and left.dt_last_seen > 0,left.DateRank,left.DateRank+1)
				,self:=right
			));
///////////////////////////////////////////////////////////////////////////////////////
//count fname
i2:=iterate(sort(i1,fname)
			,transform({gd}
				,self.fcnt:=if(left.fname=right.fname and left.fname <> '',left.fcnt+1,1)
				,self:=right
			));
i3:=iterate(sort(i2,fname,-fcnt)
			,transform({gd}
				,self.fcnt:=if(left.fname=right.fname and left.fname <> '',left.fcnt,right.fcnt)
				,self:=right
			));
///////////////////////////////////////////////////////////////////////////////////////
//count mname
i4:=iterate(sort(i3,mname)
			,transform({gd}
				,self.mcnt:=if(left.mname=right.mname and left.mname <> '',left.mcnt+1,1)
				,self:=right
			));
i5:=iterate(sort(i4,mname,-mcnt)
			,transform({gd}
				,self.mcnt:=if(left.mname=right.mname and left.mname <> '',left.mcnt,right.mcnt)
				,self:=right
			));
///////////////////////////////////////////////////////////////////////////////////////
//count lname
i6:=iterate(sort(i5,lname)
			,transform({gd}
				,self.lcnt:=if(left.lname=right.lname and left.lname <> '',left.lcnt+1,1)
				,self:=right
			));
i7:=iterate(sort(i6,lname,-lcnt)
			,transform({gd}
				,self.lcnt:=if(left.lname=right.lname and left.lname <> '',left.lcnt,right.lcnt)
				,self:=right
			));
///////////////////////////////////////////////////////////////////////////////////////
//count name_suffix
i6s :=iterate(sort(i7,name_suffix)
			,transform({gd}
				,self.sfxcnt:=if(left.name_suffix=right.name_suffix and left.name_suffix <> '',left.sfxcnt+1,1)
				,self:=right
			));
i7s :=iterate(sort(i6s,name_suffix,-sfxcnt)
			,transform({gd}
				,self.sfxcnt:=if(left.name_suffix=right.name_suffix and left.name_suffix <> '',left.sfxcnt,right.sfxcnt)
				,self:=right
			));///////////////////////////////////////////////////////////////////////////////////////
//count ssn
i8:=iterate(sort(i7s,ssn)
			,transform({gd}
				,self.scnt:=if(left.ssn=right.ssn and left.ssn <> '',left.scnt+1,1)
				,self:=right
			));
i9:=iterate(sort(i8,ssn,-scnt)
			,transform({gd}
				,self.scnt:=if(left.ssn=right.ssn and left.ssn <> '',left.scnt,right.scnt)
				,self:=right
			));
///////////////////////////////////////////////////////////////////////////////////////
//count DOB
i10:=iterate(sort(i9,dob)
			,transform({gd}
				,self.dcnt:=if(left.dob=right.dob and left.dob > 0,left.dcnt+1,1)
				,self:=right
			));
i11:=iterate(sort(i10,dob,-dcnt)
			,transform({gd}
				,self.dcnt:=if(left.dob=right.dob and left.dob > 0, left.dcnt,right.dcnt)
				,self:=right
			));
///////////////////////////////////////////////////////////////////////////////////////
//count phone
i12:=iterate(sort(i11,phone)
			,transform({gd}
				,self.pcnt:=if(left.phone=right.phone and left.phone <> '',left.pcnt+1,1)
				,self:=right
			));
i13:=iterate(sort(i12,phone,-pcnt)
			,transform({gd}
				,self.pcnt:=if(left.phone=right.phone and left.phone <> '',left.pcnt,right.pcnt)
				,self:=right
			));						
///////////////////////////////////////////////////////////////////////////////////////
//count addr
i14:=iterate(sort(i13,addr1)
			,transform({gd}
				,self.acnt:=if(left.addr1=right.addr1 and left.addr1 <> '',left.acnt+1,1)
				,self:=right
			));
i15:=iterate(sort(i14,addr1,-acnt)
			,transform({gd}
				,self.acnt:=if(left.addr1=right.addr1 and left.addr1 <> '',left.acnt,right.acnt)
				,self:=right
			));
i16:=iterate(sort(i15,addr1,dt_first_seen)
			,transform({gd}
				,self.dt_first_seen:=if(left.addr1=right.addr1 and left.dt_first_seen > 0, left.dt_first_seen,right.dt_first_seen)
				,self:=right
			));	
i17:=iterate(sort(i16,addr1,-dt_last_seen)
			,transform({gd}
				,self.dt_last_seen:=if(left.addr1=right.addr1 and left.dt_last_seen > 0,left.dt_last_seen, right.dt_last_seen)
				,self:=right
			));		
			
///////////////////////////////////////////////////////////////////////////////////////
//count score for all fields
scored_out := project(i17,transform(infutor.layout_best.lscored,
							self.fname_score:=if(length(trim(left.fname)) >1, (left.bfcnt*50) + left.fcnt + left.DateRank + 1,(left.bfcnt*50) + left.fcnt + left.DateRank); 
							,self.mname_score:=if(length(trim(left.mname)) >1, (left.bmcnt*50) + left.mcnt + left.DateRank + 1,
							                       if(left.mname <> '', (left.bmcnt*50) + left.mcnt + left.DateRank, 0));
							,self.lname_score:=if(left.lname <> '',(left.blcnt*50) + left.lcnt + left.DateRank,0)
							,self.sfxname_score:=if(left.name_suffix <> '',(left.bsfxcnt*50) + left.sfxcnt + left.DateRank,0)
							,self.ssn_score:=if((unsigned)left.ssn>0, (left.bscnt*50) + left.scnt  + left.DateRank, 0)
							,self.dob_score:=if(left.dob>0, (ut.mod_date_quality(left.dob,true).quality*5) + (left.bdcnt*50) + left.dcnt + left.DateRank, 0)
							,self.phone_score:=if(length(trim(left.phone)) = 10, (left.bpcnt*50) + left.pcnt + left.DateRank, 0)
							,self.addr_score:=if(left.poor_addr, 0, (left.bacnt*25) + left.acnt  + (left.DateRank*2) + if(left.addr2='APT',-1,0))
							,self := left
							));

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
scored := scored_out ;
#ELSE
scored := scored_out : persist('~thor400_data::persist::infutor_scored');
#END;
recordof(scored) trollup(scored le, scored ri) :=
transform
	self.fname :=if(le.fname_score<ri.fname_score,ri.fname,le.fname);
	self.fname_score:=if(le.fname_score<ri.fname_score,ri.fname_score,le.fname_score);

  self.mname :=if(le.mname_score<ri.mname_score,ri.mname,le.mname);
	self.mname_score:=if(le.mname_score<ri.mname_score,ri.mname_score,le.mname_score);
	
	self.lname:=if(le.lname_score<ri.lname_score,ri.lname,le.lname);
	self.lname_score:=if(le.lname_score<ri.lname_score,ri.lname_score,le.lname_score);
	
	self.name_suffix:=if(le.sfxname_score<ri.sfxname_score,ri.name_suffix,le.name_suffix);
	self.sfxname_score:=if(le.sfxname_score<ri.sfxname_score,ri.sfxname_score,le.sfxname_score);

	self.ssn:=if(le.ssn_score<ri.ssn_score,ri.ssn,le.ssn);
	self.ssn_score:=if(le.ssn_score<ri.ssn_score,ri.ssn_score,le.ssn_score);

	self.dob:=if(le.dob_score<ri.dob_score,ri.dob,le.dob);
	self.dob_score:=if(le.dob_score<ri.dob_score,ri.dob_score,le.dob_score);
  self.phone:=if(le.phone_score<ri.phone_score,ri.phone,le.phone);
	self.phone_score:=if(le.phone_score<ri.phone_score,ri.phone_score,le.phone_score);
  self.prim_range := if(le.addr_score<ri.addr_score,ri.prim_range,le.prim_range);
	self.prim_name  := if(le.addr_score<ri.addr_score,ri.prim_name,le.prim_name);
  self.predir := if(le.addr_score<ri.addr_score,ri.predir,le.predir);
  self.suffix := if(le.addr_score<ri.addr_score,ri.suffix,le.suffix);
  self.postdir := if(le.addr_score<ri.addr_score,ri.postdir,le.postdir);
  self.unit_desig := if(le.addr_score<ri.addr_score,ri.unit_desig,le.unit_desig);
  self.sec_range := if(le.addr_score<ri.addr_score,ri.sec_range,le.sec_range);
  self.city_name := if(le.addr_score<ri.addr_score,ri.city_name,le.city_name);
  self.st := if(le.addr_score<ri.addr_score,ri.st,le.st);
  self.zip := if(le.addr_score<ri.addr_score,ri.zip,le.zip);
  self.zip4 := if(le.addr_score<ri.addr_score,ri.zip4,le.zip4);
	self.addr_score:=if(le.addr_score<ri.addr_score,ri.addr_score,le.addr_score);
	self.dt_first_seen := if(le.addr_score<ri.addr_score, ri.dt_first_seen, le.dt_first_seen);
	self.dt_last_seen := if(le.addr_score<ri.addr_score, ri.dt_last_seen, le.dt_last_seen);
	self:=le;
end;

rollup_out :=rollup(sort(scored,-fname_score,-mname_score,-lname_score,-sfxname_score,-ssn_score,-dob_score,-phone_score,-addr_score,-dt_last_seen),true,trollup(left,right));

best_out :=group(project(rollup_out, transform(infutor.layout_best.lbest, 
                  self.addr_dt_first_seen := left.dt_first_seen, self.addr_dt_last_seen := left.dt_last_seen, self := left)));

PromoteSupers.mac_sf_buildprocess(best_out, '~thor_data400::base::infutor_best', build_infutor_best, 2,,true);
PromoteSupers.mac_sf_buildprocess(best_out, '~thor_data400::base::infutor_best_no_FR', build_infutor_best_no_FR, 3,,true);

build_out := if(excludeForeclosure, build_infutor_best_no_FR,build_infutor_best);

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
return best_out;
#ELSE
return build_out;
#END
end;