import doxie_build,mdr,watchdog,doxie,address,ut,AutoStandardI,Suppress;

EXPORT Mod_FCRA_Header_EN_retro_test := module

src_dict:=mdr.sourcetools;
srcs:=[
			src_dict.set_scoring_FCRA_non_gov
			,src_dict.set_scoring_FCRA_gov
			,src_dict.set_scoring_FCRA_retro_test
			];

h0:=distribute(doxie_build.File_FCRA_header_building
(src in srcs
)
,hash(did))
;

SetNotAllowedSegments:=[
'DEAD'
,'NOISE'
,'H_MERGE'
,'AMBIG'
];
w:=dedup(distribute(watchdog.Key_Prep_Watchdog_GLB(adl_ind not in SetNotAllowedSegments)
,hash(did)),did,all,local)
;

r1:={h0.did
		,h0.rid
		,h0.ssn
		,unsigned8 current_addressid:=0
		,string46 current_address_line1:=''
		,string18 current_address_line2:=''
		,qstring25 current_address_city:=''
		,string2 current_address_state:=''
		,qstring5 current_address_zip:=''
		,unsigned8 previous_addressid:=0
		,string46 previous_address_line1:=''
		,string18 previous_address_line2:=''
		,qstring25 previous_address_city:=''
		,string2 previous_address_state:=''
		,qstring5 previous_address_zip:=''
		};

//////////////////////////////////////////////////
f := h0(zip4!='');

header.MAC_Best_Address(f, did, 2, en)

flag_rec := record
 en;
 string1 address_flag := '';
 unsigned3 addr_dt_last_seen := 0;
end;

flag_rec assignedDates(en Le) := transform
self.dt_last_seen := ((integer)(ut.GetDate[1..6])-if(le.dt_last_seen=0,le.dt_vendor_last_reported,le.dt_last_seen))/3;
self.dt_first_seen := if(le.dt_first_seen=0,le.dt_vendor_first_reported,le.dt_first_seen);
self.unit_desig := if(le.sec_range='','',le.unit_desig);
self.addr_dt_last_seen := (unsigned3)le.dt_last_seen;
self := le;
end;

flag_add := project(en,assignedDates(left));
flag_add10 := sort(flag_add, did);//added to remove warning.
grp := group(flag_add10,did,local);
//grp := group(flag_add,did,local); //orig

//Determine if the first address is better than the second.
flag_rec aflag(flag_rec le, flag_rec rt) := transform	
self.address_flag := if(le.dt_last_seen != rt.dt_last_seen or
							map(le.tnt='P'=>'2',le.tnt='Y'=>'1','0')!=
								map(rt.tnt='P'=>'2',rt.tnt='Y'=>'1','0') or
							le.dt_first_seen != rt.dt_first_seen,'N','Y');
self := rt;
end;

//take best address if available
compare_add := iterate(grp,aflag(left,right));

tnt_gd := map(compare_add.tnt='Y' => 1,
				compare_add.tnt='P' => 2,0);

srt_h := sort(compare_add,did,dt_last_seen,-tnt_gd,-dt_first_seen,-dt_vendor_first_reported,-address_flag);

srt_h1:=iterate(srt_h
			,transform({srt_h}
				,self.rec_type:=if(left.rec_type='','1','2')
				,self:=right
			));
baddr:=srt_h1(address_flag != 'Y');
/////////////////////////////////////////
d2:=table(h0,r1);
d3:=denormalize(d2,baddr
		,left.did=right.did
		,transform({d2}
				,self.current_addressid:=if(right.rec_type='1',right.rawaid,left.current_addressid)
				,self.current_address_line1:=if(right.rec_type='1'
												,stringlib.stringcleanspaces(trim(right.prim_range)
																		+' '+trim(right.predir)
																		+' '+trim(right.prim_name)
																		+' '+trim(right.suffix)
																		+' '+trim(right.postdir))
												,left.current_address_line1)
				,self.current_address_line2:=if(right.rec_type='1'
												,stringlib.stringcleanspaces(trim(right.unit_desig)+' '+trim(right.sec_range))
												,left.current_address_line2)
				,self.current_address_city:=if(right.rec_type='1',right.city_name,left.current_address_city)
				,self.current_address_state:=if(right.rec_type='1',right.st,left.current_address_state)
				,self.current_address_zip:=if(right.rec_type='1',right.zip,left.current_address_zip)

				,self.previous_addressid:=if(right.rec_type='2',right.rawaid,left.previous_addressid)
				,self.previous_address_line1:=if(right.rec_type='2'
												,stringlib.stringcleanspaces(trim(right.prim_range)
																		+' '+trim(right.predir)
																		+' '+trim(right.prim_name)
																		+' '+trim(right.suffix)
																		+' '+trim(right.postdir))
												,left.previous_address_line1)
				,self.previous_address_line2:=if(right.rec_type='2'
												,stringlib.stringcleanspaces(trim(right.unit_desig)+' '+trim(right.sec_range))
												,left.previous_address_line2)
				,self.previous_address_city:=if(right.rec_type='2',right.city_name,left.previous_address_city)
				,self.previous_address_state:=if(right.rec_type='2',right.st,left.previous_address_state)
				,self.previous_address_zip:=if(right.rec_type='2',right.zip,left.previous_address_zip)
				,self:=left
				));

appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
Suppress.MAC_Suppress(d3,pulled_ssn,appType,Suppress.Constants.LinkTypes.SSN,ssn);
Suppress.MAC_Suppress(pulled_ssn,d4,appType,Suppress.Constants.LinkTypes.DID,did);

h1:=table(h0,{
			srcIsEN:=src in src_dict.set_scoring_FCRA_retro_test
			,srcIsGov:=src in src_dict.set_scoring_FCRA_gov
			,did
			,rid
			,src
			,dt_last_seen
			,DateRank:=0
			,fname
			,fcnt:=0
			,sfcnt:=0
			,bfcnt:=0
			,lname
			,lcnt:=0
			,slcnt:=0
			,blcnt:=0
			,ssn
			,scnt:=0
			,sscnt:=0
			,bscnt:=0
			,dob
			,dcnt:=0
			,sdcnt:=0
			,bdcnt:=0
			,string46 addr1:=stringlib.stringcleanspaces(if(length(stringlib.stringfilterout(prim_range,'%0-. '))=0,'',trim(prim_range))
												+' '+if(length(stringlib.stringfilterout(predir,'%0-. '))=0,'',trim(predir))
												+' '+if(length(stringlib.stringfilterout(prim_name,'%0-. '))=0,'',trim(prim_name))
												+' '+if(length(stringlib.stringfilterout(suffix,'%0-. '))=0,'',trim(suffix))
												+' '+if(length(stringlib.stringfilterout(postdir,'%0-. '))=0,'',trim(postdir)))
			,string18 addr2:=stringlib.stringcleanspaces(if(length(stringlib.stringfilterout(unit_desig,'%0-. '))=0,'',trim(unit_desig))
												+' '+if(length(stringlib.stringfilterout(sec_range,'%0-. '))=0,'',trim(sec_range)))
			,city_name
			,st
			,zip
			,rawaid
			,qstring20 name_first:=''
			,qstring20 name_last:=''
			});

h2:=join(h1,w
		,left.did=right.did
		,transform({h1}
			,self.name_first:=left.fname
			,self.bfcnt:=if(left.fname=right.fname and right.fname<>'',1,0)
			,self.name_last:=left.lname
			,self.blcnt:=if(left.lname=right.lname and right.lname<>'',1,0)
			,self.bscnt:=if(left.ssn=right.ssn and right.ssn<>'',1,0)
			,self.bdcnt:=if(left.dob=right.dob and right.dob>0,1,0)
			,self:=left
			)
		// ,left outer
		,local);

h3:=join(h2,d4,left.rid=right.rid,local);

gd:=group(sort(h3,did,local),did);
///////////////////////////////////////////////////////////////////////////////////////
i1:=iterate(sort(gd,dt_last_seen)
			,transform({gd}
				,self.DateRank:=if(left.dt_last_seen=right.dt_last_seen,left.DateRank,left.DateRank+1)
				,self:=right
			));
///////////////////////////////////////////////////////////////////////////////////////
i2:=iterate(sort(i1,fname,src)
			,transform({gd}
				,self.fcnt:=if(left.fname=right.fname,left.fcnt+1,1)
				,self.sfcnt:=map(left.fname=right.fname and left.src=right.src => left.sfcnt
												,left.fname=right.fname and left.src<>right.src => left.sfcnt+1
												,1
												)
				,self:=right
			));
i3:=iterate(sort(i2,fname,-fcnt)
			,transform({gd}
				,self.fcnt:=if(left.fname=right.fname,left.fcnt,right.fcnt)
				,self:=right
			));
i4:=iterate(sort(i3,fname,-sfcnt)
			,transform({gd}
				,self.sfcnt:=if(left.fname=right.fname,left.sfcnt,right.sfcnt)
				,self:=right
			));
///////////////////////////////////////////////////////////////////////////////////////
i5:=iterate(sort(i4,lname,src)
			,transform({gd}
				,self.lcnt:=if(left.lname=right.lname,left.lcnt+1,1)
				,self.slcnt:=map(left.lname=right.lname and left.src=right.src => left.slcnt
												,left.lname=right.lname and left.src<>right.src => left.slcnt+1
												,1
												)
				,self:=right
			));
i6:=iterate(sort(i5,lname,-slcnt)
			,transform({gd}
				,self.slcnt:=if(left.lname=right.lname,left.slcnt,right.slcnt)
				,self:=right
			));
i7:=iterate(sort(i6,lname,-lcnt)
			,transform({gd}
				,self.lcnt:=if(left.lname=right.lname,left.lcnt,right.lcnt)
				,self:=right
			));
///////////////////////////////////////////////////////////////////////////////////////
i8:=iterate(sort(i7,ssn,src)
			,transform({gd}
				,self.scnt:=if(left.ssn=right.ssn,left.scnt+1,1)
				,self.sscnt:=map(left.ssn=right.ssn and left.src=right.src => left.sscnt
												,left.ssn=right.ssn and left.src<>right.src => left.sscnt+1
												,1
												)
				,self:=right
			));
i9:=iterate(sort(i8,ssn,-sscnt)
			,transform({gd}
				,self.sscnt:=if(left.ssn=right.ssn,left.sscnt,right.sscnt)
				,self:=right
			));
i10:=iterate(sort(i9,ssn,-scnt)
			,transform({gd}
				,self.scnt:=if(left.ssn=right.ssn,left.scnt,right.scnt)
				,self:=right
			));
///////////////////////////////////////////////////////////////////////////////////////
i11:=iterate(sort(i10,dob,src)
			,transform({gd}
				,self.dcnt:=if(left.dob=right.dob,left.dcnt+1,1)
				,self.sdcnt:=map(left.dob=right.dob and left.src=right.src => left.sdcnt
												,left.dob=right.dob and left.src<>right.src => left.sdcnt+1
												,1
												)
				,self:=right
			));
i12:=iterate(sort(i11,dob,-sdcnt)
			,transform({gd}
				,self.sdcnt:=if(left.dob=right.dob,left.sdcnt,right.sdcnt)
				,self:=right
			));
i13:=iterate(sort(i12,dob,-dcnt)
			,transform({gd}
				,self.dcnt:=if(left.dob=right.dob,left.dcnt,right.dcnt)
				,self:=right
			));
///////////////////////////////////////////////////////////////////////////////////////
t:=table(i13,{i13
							,fname_score:=(bfcnt*50) + fcnt + sfcnt + DateRank
							,lname_score:=(blcnt*50) + lcnt + slcnt + DateRank
							,ssn_score:=if((unsigned)ssn>0, (bscnt*50) + scnt + sscnt + DateRank, 0)
							,dob_score:=if(dob>0, (ut.mod_date_quality(dob,true).quality*5) + (bdcnt*50) + dcnt + sdcnt + DateRank, 0)
							});

export scored := t;

recordof(scored) ttroll(scored l, scored r) :=
transform
	self.name_first:=if(l.fname_score<r.fname_score,r.fname,l.name_first);
	self.fname_score:=if(l.fname_score<r.fname_score,r.fname_score,l.fname_score);

	self.name_last:=if(l.lname_score<r.lname_score,r.lname,l.name_last);
	self.lname_score:=if(l.lname_score<r.lname_score,r.lname_score,l.lname_score);

	self.ssn:=if(l.ssn_score<r.ssn_score,r.ssn,l.ssn);
	self.ssn_score:=if(l.ssn_score<r.ssn_score,r.ssn_score,l.ssn_score);

	self.dob:=if(l.dob_score<r.dob_score,r.dob,l.dob);
	self.dob_score:=if(l.dob_score<r.dob_score,r.dob_score,l.dob_score);

	self:=l;
end;

troll:=rollup(sort(scored,dt_last_seen,record),true,ttroll(left,right));

b:=group(table(troll
						,{DID
						,name_first
						,name_last
						,SSN
						,DOB
						,Current_AddressID
						,Current_Address_line1
						,Current_Address_line2
						,Current_Address_City
						,Current_Address_State
						,Current_Address_Zip
						,Previous_AddressID
						,Previous_Address_line1
						,Previous_Address_line2
						,Previous_Address_City
						,Previous_Address_State
						,Previous_Address_Zip
						}));

export best_file := b(Current_Address_line1<>'');

shared r:={
street_address:=stringlib.stringcleanspaces(trim(scored.addr1) +' '+ trim(scored.addr2))
,city:=scored.city_name
,state:=scored.st
,zip:=scored.Zip
,address_ID:=scored.rawaid
};

shared id:=group(table(scored
						,{DID
						,atLeastOneEN:=max(group,srcIsEN)
						,atLeastOneGov:=max(group,srcIsGov)
						,atLeastOneNonGov:=~(max(group,srcIsGov) or max(group,srcIsEN))
						}));
shared ssn_:=group(table(scored
						,{DID
						,ssn
						,atLeastOneEN:=max(group,srcIsEN)
						,atLeastOneGov:=max(group,srcIsGov)
						,atLeastOneNonGov:=~(max(group,srcIsGov) or max(group,srcIsEN))
						},did,ssn));
shared addr:=group(table(scored
						,{DID
						,addr1
						,atLeastOneEN:=max(group,srcIsEN)
						,atLeastOneGov:=max(group,srcIsGov)
						,atLeastOneNonGov:=~(max(group,srcIsGov) or max(group,srcIsEN))
						},did,addr1));

export EN_only_entities := table(id(atLeastOneEN,~atLeastOneGov,~atLeastOneNonGov),{did});
export EN_only_ssn := table(ssn_(atLeastOneEN,~atLeastOneGov,~atLeastOneNonGov),{ssn});
export EN_only_addr := table(addr(atLeastOneEN,~atLeastOneGov,~atLeastOneNonGov),{addr1});

export Gov_only_entities := table(id(~atLeastOneEN,atLeastOneGov,~atLeastOneNonGov),{did});
export Gov_only_ssn := table(ssn_(~atLeastOneEN,atLeastOneGov,~atLeastOneNonGov),{ssn});
export Gov_only_addr := table(addr(~atLeastOneEN,atLeastOneGov,~atLeastOneNonGov),{addr1});

export NonGov_only_entities := table(id(~atLeastOneEN,~atLeastOneGov,atLeastOneNonGov),{did});
export NonGov_only_ssn := table(ssn_(~atLeastOneEN,~atLeastOneGov,atLeastOneNonGov),{ssn});
export NonGov_only_addr := table(addr(~atLeastOneEN,~atLeastOneGov,atLeastOneNonGov),{addr1});

export address_file := distribute(dedup(distribute( table(scored(addr1<>''),r) ,hash(street_address)),street_address,city,state,zip,all,local),hash(street_address));
export ssn_file := distribute(dedup(distribute( table(scored(ssn<>''),{ssn}) ,hash(ssn)),record,all,local),hash(ssn));

export files := module
	export identity := dataset('~thor400_data::Experian_Extract::identity',{best_file},csv(quote('"'),heading(single)));
	export address := dataset('~thor400_data::Experian_Extract::address',{address_file},csv(quote('"'),heading(single)));
	export ssn := dataset('~thor400_data::Experian_Extract::ssn',{ssn_file},csv(quote('"'),heading(single)));
end;

End;