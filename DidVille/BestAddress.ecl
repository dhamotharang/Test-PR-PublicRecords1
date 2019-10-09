import doxie, ut, header, address, mdr, std;

export BestAddress := MODULE

shared best_from_best_logic(dataset(doxie.layout_presentation) pres_recs) :=FUNCTION
// start best logic

header.Layout_Header TUdates(doxie.Layout_presentation l) := transform
 self.dt_last_seen := if(Mdr.sourceTools.SourceIsTransUnion(l.src),0,l.dt_last_seen);
 self.dt_first_seen := if(Mdr.sourceTools.SourceIsTransUnion(l.src),0,l.dt_first_seen);
 self.dt_vendor_first_reported := if(Mdr.sourceTools.SourceIsTransUnion(l.src),0,l.dt_vendor_first_reported);
 self.dt_vendor_last_reported := if(Mdr.sourceTools.SourceIsTransUnion(l.src),0,l.dt_vendor_last_reported);

 // I don't want tnt to affect sorting in mac_best_address since we are
 // defining valid tnts as B, V, or P and at this stage no records being processed
 //will have valid tnts, but I do want to retain the tnt field.
 self.tnt := if(l.tnt='Y','y',l.tnt);
 self := l;
end;

f := project(pres_recs,TUDates(left));


header.MAC_Best_Address(f, did, 2, en)

flag_rec := record
 en;
 string1 address_flag := '';
 unsigned3 addr_dt_last_seen := 0;
end;

flag_rec assignedDates(en Le) := transform
self.dt_last_seen := ((integer)(((STRING8)Std.Date.Today())[1..6])-if(le.dt_last_seen=0,le.dt_vendor_last_reported,le.dt_last_seen))/3;
self.dt_first_seen := if(le.dt_first_seen=0,le.dt_vendor_first_reported,le.dt_first_seen);
self.unit_desig := if(le.sec_range='','',le.unit_desig);
self.addr_dt_last_seen := (unsigned3)le.dt_last_seen;
Self.tnt := if(le.tnt ='y','Y',le.tnt);
self := le;
end;

flag_add := project(en,assignedDates(left));

// No sorting on TNT because at this point its not important since no B,V,or Ps were found
srt_h := sort(flag_add,did,dt_last_seen,-dt_first_seen,-dt_vendor_first_reported,-dt_vendor_last_reported,
record);
dup_h := dedup(srt_h,did);
BestAddress := project(ungroup(dup_h),transform(Didville.Layout_Did_Numeric_Out.Addr_Best,self:=left,self:=[]));
	Return BestAddress;
END;


Export Best_Recs(dataset(doxie.layout_presentation) header_recs0,
  dataset(doxie.layout_references) did,
  doxie.IDataAccess mod_access,
  string5 input_zip,
  string10 prange_value,
  unsigned1 fi_value,
  unsigned1 li_value)  := FUNCTION


// Keep addresses in the last three months or daily utility records since they appear to often have the correct
// address, even if the record date is an unreliable indicator
mac_date (ds,ds_out) := Macro
ds_out :=ds(ut.DaysApart(dt_last_seen+'30', (STRING8)Std.Date.Today()) < 31*3 or src='DU');
EndMacro;

header_recs := header_recs0(prim_name<>'');

doxie.Layout_presentation get_earliest_dt_first_seen(doxie.Layout_presentation l,doxie.Layout_presentation r):=transform
 self.dt_first_seen := if(l.dt_first_seen < r.dt_first_seen and l.dt_first_seen<>0,l.dt_first_seen,r.dt_first_seen);
 self := r;
END;

// this should not be necessary once rollup within header.MAC_Best_Address takes place but date filtering will need to be
//done after macro otherwise some records won't have the chance to rollup
recs_w_earliest_dt_first_seen := ungroup(iterate(group(sort(header_recs,prim_range, prim_name,zip,sec_range, rid),
prim_range,prim_name,zip,sec_range),get_earliest_dt_first_seen(left,right)));

mac_date(recs_w_earliest_dt_first_seen,RecentHeaderCleaned);

all_recs_match_zip := RecentheaderCleaned(zip=input_zip);

all_recs_match1 := if(exists(all_recs_match_zip),all_recs_match_zip,RecentHeaderCleaned);

all_recs_match_prange := all_recs_match1(prim_range=prange_value or prange_value='');

all_recs_match2 := if(exists(all_recs_match_prange),all_recs_match_prange,all_recs_match1);

rels :=doxie.Relative_Dids(did);

pres_recs := project(all_recs_match2,doxie.Layout_presentation);

w_gong_append := doxie.append_gong(pres_recs, rels, mod_access);

// B = Best, V = Verified, P = Probable
gong_verified := w_gong_append(tnt in ['B','V','P']);


srt_gong_verified0 := project(choosen(sort(gong_verified,map(tnt='B'=>0,tnt='V'=>1,2),
	-if(dt_last_seen=0,dt_first_seen,dt_last_seen),phone<>listed_phone,
	ut.Chr2PhoneDigit(fname[1]) <> fi_value,
	ut.Chr2PhoneDigit(lname[1]) <> li_value, rid),1),transform(Didville.Layout_Did_Numeric_Out.Addr_Best,self.dod:=(qstring8)left.dod, self.addr_dt_last_seen :=
	left.dt_last_seen,self:=left,self:=[]));

// Get nonglb latest date
latest_non_glb := sort(header_recs,prim_range,prim_name,city_name,zip,st,sec_range,-dt_nonglb_last_seen,rid);

srt_gong_verified1 := join(srt_gong_verified0,latest_non_glb,left.prim_range=right.prim_range and left.prim_name=right.prim_name
and left.city_name=right.city_name and left.zip=right.zip and left.st=right.st and left.sec_range=right.sec_range,
transform(Didville.Layout_Did_Numeric_Out.Addr_Best,self.addr_dt_last_seen := right.dt_nonglb_last_seen,self:=left),
keep(1), left outer);

// apply nonglb latest date if glb not valid
srt_gong_verified := if(mod_access.isValidGLB(), srt_gong_verified0, srt_gong_verified1);

bestAddress := best_from_best_logic(pres_recs);

// end best logic
Addr_recs := if(exists(srt_gong_verified),srt_gong_verified,BestAddress);



return Addr_recs;


END;

END;