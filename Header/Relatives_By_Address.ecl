/*					Relatives_By_Address
==============================================================	
Generate did pairs based on the same address. 
Split from the original Header.Relatives.
*/
import ut,doxie;

export Relatives_By_Address(
	dataset(header.Layout_Header) h
	) :=
FUNCTION


dhdrs := distribute(relative_candidates(h), addr4);  

//sreq(string5 le, string5 ri) := MAP( le=ri=>3, le='' or ri=''=>2, 0 );
sreq(string5 le, string5 ri) := MAP( le=ri=>3, le='' or ri=''=>1, 0 );

rec := record
	doxie.layout_relative_dids;
    integer3 zip;
    integer2 prim_range;
	dhdrs.addr4;
	string105 recent_address;
end;

rec match_them(dhdrs lef, dhdrs rig) := transform
  self.person1 := lef.did;
  self.person2 := rig.did;
  self.same_lname := lef.lname=rig.lname;
  self.zip:=(integer)lef.zip;
  self.prim_range:=if(sreq(lef.sec_range,rig.sec_range)=0, //if they are both populated and differ
    -3,
    //Extract any number from prim_name before final roll up, since we dedup by prim_name.
    (integer)Header.getSpecialRelPrim(lef.prim_range, lef.prim_name));
  self.number_cohabits := Max(
    sreq(lef.sec_range,rig.sec_range)
    + IF (lef.first_seen > rig.last_seen+2  or rig.first_seen > lef.last_seen+2,
      0,
      1 + IF(lef.lname=rig.lname and sreq(lef.sec_range,rig.sec_range)<>0, 
              min( lef.lname_weight, rig.lname_weight), 0
          )
      )
    //Decrease 1 point when both prime range and second range are empty. Mostly for rural area. See bug12826.
    - if (lef.prim_range='' and rig.prim_range='' and lef.sec_range='' and rig.sec_range='', 1, 0),
	0) ; //number_cohabit does not decrease below zero.

  self.recent_cohabit := ut.date_overlap_last(lef.first_seen,lef.last_seen,
                                              rig.first_seen,rig.last_seen)
	                    +IF(self.number_cohabits=0,skip,0);								
											
   self.addr4 := lef.addr4;
   self.recent_address := trim(Stringlib.stringcleanspaces(
                           lef.prim_range+' '+
	                       lef.predir+' '+
	                       lef.prim_name+' '+
						   lef.suffix+' '+
						   lef.postdir+' '+ 
						   lef.unit_desig+' '+ 
						   lef.sec_range+' '+
						   lef.city_name+' '+
						   lef.st+' '+
						   lef.zip)); 
 
 end;


j := 
	join(  
		dhdrs,
		dhdrs(did != 0),
		left.addr4=right.addr4 and
    left.predir=right.predir and
    left.postdir=right.postdir and
    left.did > right.did,
    match_them(left,right),
		local
	)
	;

//***** If there is a loose and and a strong association in the same buildilng, drop the loose one
s0 := dedup(j, record, local):persist('~thor_data400::persist::relatives_by_address_s0');
// s0 := dataset('~thor_data400::persist::relatives_by_address_s0',{j},flat);

s1 := sort(sample(s0,4,1), addr4, person1, person2, prim_range, local);
ds1 := 
	rollup(
		s1,
		left.addr4 = right.addr4 and
		left.person1 = right.person1 and
		left.person2 = right.person2 and
		left.prim_range <= right.prim_range,	//a lower prim_Range at the same addr4 represents a looser association, see -3 above
		transform(
			rec,
			self.same_lname := left.same_lname or right.same_lname,
			self.prim_range := 			if(right.prim_range 			> left.prim_range, 			right.prim_range, 			left.prim_range),
			self.number_cohabits := if(right.number_cohabits 	> left.number_cohabits, right.number_cohabits, 	left.number_cohabits),
			self.recent_cohabit := 	if(right.number_cohabits 	> left.number_cohabits, right.recent_cohabit, 	left.recent_cohabit),  //intentionally checking number_cohabits because i want the date from the stronger association (just taking the higher date could work too)
			self := left
		),
		local
	)
		:persist('~thor_data400::persist::relatives_by_address_ds1')
;
// ds1 := dataset('~thor_data400::persist::relatives_by_address_ds1',{ds1_},flat);

s2 := sort(sample(s0,4,2), addr4, person1, person2, prim_range, local);
ds2 := 
	rollup(
		s2,
		left.addr4 = right.addr4 and
		left.person1 = right.person1 and
		left.person2 = right.person2 and
		left.prim_range <= right.prim_range,	//a lower prim_Range at the same addr4 represents a looser association, see -3 above
		transform(
			rec,
			self.same_lname := left.same_lname or right.same_lname,
			self.prim_range := 			if(right.prim_range 			> left.prim_range, 			right.prim_range, 			left.prim_range),
			self.number_cohabits := if(right.number_cohabits 	> left.number_cohabits, right.number_cohabits, 	left.number_cohabits),
			self.recent_cohabit := 	if(right.number_cohabits 	> left.number_cohabits, right.recent_cohabit, 	left.recent_cohabit),  //intentionally checking number_cohabits because i want the date from the stronger association (just taking the higher date could work too)
			self := left
		),
		local
	)
		:persist('~thor_data400::persist::relatives_by_address_ds2')
;
// ds2 := dataset('~thor_data400::persist::relatives_by_address_ds2',{ds2_},flat);

s3 := sort(sample(s0,4,3), addr4, person1, person2, prim_range, local);
ds3 := 
	rollup(
		s3,
		left.addr4 = right.addr4 and
		left.person1 = right.person1 and
		left.person2 = right.person2 and
		left.prim_range <= right.prim_range,	//a lower prim_Range at the same addr4 represents a looser association, see -3 above
		transform(
			rec,
			self.same_lname := left.same_lname or right.same_lname,
			self.prim_range := 			if(right.prim_range 			> left.prim_range, 			right.prim_range, 			left.prim_range),
			self.number_cohabits := if(right.number_cohabits 	> left.number_cohabits, right.number_cohabits, 	left.number_cohabits),
			self.recent_cohabit := 	if(right.number_cohabits 	> left.number_cohabits, right.recent_cohabit, 	left.recent_cohabit),  //intentionally checking number_cohabits because i want the date from the stronger association (just taking the higher date could work too)
			self := left
		),
		local
	)
		:persist('~thor_data400::persist::relatives_by_address_ds3')
;
// ds3 := dataset('~thor_data400::persist::relatives_by_address_ds3',{ds3_},flat);

s4 := sort(sample(s0,4,4), addr4, person1, person2, prim_range, local);
ds4 := 
	rollup(
		s4,
		left.addr4 = right.addr4 and
		left.person1 = right.person1 and
		left.person2 = right.person2 and
		left.prim_range <= right.prim_range,	//a lower prim_Range at the same addr4 represents a looser association, see -3 above
		transform(
			rec,
			self.same_lname := left.same_lname or right.same_lname,
			self.prim_range := 			if(right.prim_range 			> left.prim_range, 			right.prim_range, 			left.prim_range),
			self.number_cohabits := if(right.number_cohabits 	> left.number_cohabits, right.number_cohabits, 	left.number_cohabits),
			self.recent_cohabit := 	if(right.number_cohabits 	> left.number_cohabits, right.recent_cohabit, 	left.recent_cohabit),  //intentionally checking number_cohabits because i want the date from the stronger association (just taking the higher date could work too)
			self := left
		),
		local
	)
		:persist('~thor_data400::persist::relatives_by_address_ds4')
;
// ds4 := dataset('~thor_data400::persist::relatives_by_address_ds4',{ds4_},flat);


ss1 := sort(ds1+ds2, addr4, person1, person2, prim_range, local);
dss1 := 
	rollup(
		ss1,
		left.addr4 = right.addr4 and
		left.person1 = right.person1 and
		left.person2 = right.person2 and
		left.prim_range <= right.prim_range,	//a lower prim_Range at the same addr4 represents a looser association, see -3 above
		transform(
			rec,
			self.same_lname := left.same_lname or right.same_lname,
			self.prim_range := 			if(right.prim_range 			> left.prim_range, 			right.prim_range, 			left.prim_range),
			self.number_cohabits := if(right.number_cohabits 	> left.number_cohabits, right.number_cohabits, 	left.number_cohabits),
			self.recent_cohabit := 	if(right.number_cohabits 	> left.number_cohabits, right.recent_cohabit, 	left.recent_cohabit),  //intentionally checking number_cohabits because i want the date from the stronger association (just taking the higher date could work too)
			self := left
		),
		local
	)
		:persist('~thor_data400::persist::relatives_by_address_dss1')
;
// dss1 := dataset('~thor_data400::persist::relatives_by_address_dss1',{dss1_},flat);

ss2 := sort(ds3+ds4, addr4, person1, person2, prim_range, local);
dss2 := 
	rollup(
		ss2,
		left.addr4 = right.addr4 and
		left.person1 = right.person1 and
		left.person2 = right.person2 and
		left.prim_range <= right.prim_range,	//a lower prim_Range at the same addr4 represents a looser association, see -3 above
		transform(
			rec,
			self.same_lname := left.same_lname or right.same_lname,
			self.prim_range := 			if(right.prim_range 			> left.prim_range, 			right.prim_range, 			left.prim_range),
			self.number_cohabits := if(right.number_cohabits 	> left.number_cohabits, right.number_cohabits, 	left.number_cohabits),
			self.recent_cohabit := 	if(right.number_cohabits 	> left.number_cohabits, right.recent_cohabit, 	left.recent_cohabit),  //intentionally checking number_cohabits because i want the date from the stronger association (just taking the higher date could work too)
			self := left
		),
		local
	)
		:persist('~thor_data400::persist::relatives_by_address_dss2')
;
// dss2 := dataset('~thor_data400::persist::relatives_by_address_dss2',{dss2_},flat);

s := sort(dss1+dss2, addr4, person1, person2, prim_range, local) :success(parallel(
												fileservices.deletelogicalfile('~thor_data400::persist::relatives_by_address_s0'),
												fileservices.deletelogicalfile('~thor_data400::persist::relatives_by_address_ds1'),
												fileservices.deletelogicalfile('~thor_data400::persist::relatives_by_address_ds2'),
												fileservices.deletelogicalfile('~thor_data400::persist::relatives_by_address_ds3'),
												fileservices.deletelogicalfile('~thor_data400::persist::relatives_by_address_ds4')
		));

ds := 
	rollup(
		s,
		left.addr4 = right.addr4 and
		left.person1 = right.person1 and
		left.person2 = right.person2 and
		left.prim_range <= right.prim_range,	//a lower prim_Range at the same addr4 represents a looser association, see -3 above
		transform(
			rec,
			self.same_lname := left.same_lname or right.same_lname,
			self.prim_range := 			if(right.prim_range 			> left.prim_range, 			right.prim_range, 			left.prim_range),
			self.number_cohabits := if(right.number_cohabits 	> left.number_cohabits, right.number_cohabits, 	left.number_cohabits),
			self.recent_cohabit := 	if(right.number_cohabits 	> left.number_cohabits, right.recent_cohabit, 	left.recent_cohabit),  //intentionally checking number_cohabits because i want the date from the stronger association (just taking the higher date could work too)
			self := left
		),
		local
	)
	:persist('~thor_data400::persist::relatives_by_address_ds')
;
// ds := dataset('~thor_data400::persist::relatives_by_address_ds',{ds_},flat);

sg0 := dedup(sort(ds,person1,person2,prim_range,IF(same_lname,0,1),-number_cohabits,zip, record,local),person1,person2,prim_range,local)
				:success(parallel(
												fileservices.deletelogicalfile('~thor_data400::persist::relatives_by_address_dss1'),
												fileservices.deletelogicalfile('~thor_data400::persist::relatives_by_address_dss2')
							));
gj := group(sg0,person1,person2,all);
sg := dedup(sort(gj,prim_range,IF(same_lname,0,1),-number_cohabits,zip, record),prim_range);

return project(sg, HEADER.Layout_Relatives_v2.temp);
END;