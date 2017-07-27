import ut,did_add, property,drivers,vehlic,Bankrupt, lib_datalib, ngadl;
// Rules 6&7 code elsewhere
// Rule 6 is TCOA match
// Rule 7 is relative match 

/*typeof(match_candidates) out_unk(match_candidates le) := transform
  self.name_suffix := if ( le.name_suffix='UNK','',le.name_suffix);
  self := le;
  end;
*/

export Did_Rules0(
	dataset(recordof(header.Layout_MatchCandidates)) me_use2,
	string persist_suffix = '',
	boolean includeOutsideMatches = true,
	dataset(header.Layout_Header) head = dataset([], header.Layout_Header)
	)  := 
MODULE

	
Header.Layout_PairMatch tra2(unsigned6 ldid, unsigned6 rdid, integer1 match) := transform
  self.old_rid := ldid;
  self.new_rid := rdid;
  self.pflag := match;
  end;

ssns_ok := (integer)me_use2.ssn<>0 and ~me_use2.ssn IN ut.Set_BadSSN;

ssn_comparable := me_use2(fname<>'',ssns_ok);
has_fs := distribute(ssn_comparable,hash(ssn));
mu1_dups := has_fs(lname<>'');
//ut.MAC_Remove_Withdups_local(mu1_dups,ssn,100,mu1)
mu1 := mu1_dups;
// maybe should consider a NNEQ on mname too? see ssn=581015822
e_dv(boolean gd_ssn,le,ri) := MAP( header.date_value(le,ri) >= 1 => header.date_value(le,ri),
                                   gd_ssn and header.date_value(le,ri) = 0 => 1,
                                   -10 );

ssn_nneq(string9 ssn1, string9 ssn2) := ut.NNEQ(ssn1,ssn2) or
			((unsigned)ssn1 % 10000 = (unsigned)ssn2 % 10000 AND 
		(((unsigned)ssn1 div 10000) = 0 OR ((unsigned)ssn2 div 10000) = 0));

// Slim down to just the fields used in join 1
j1fields := TABLE(mu1,{did,ssn,fname,mname,lname,name_suffix,dob,prim_range,prim_name,zip,good_nmaddr,good_ssn});
// Remove duplicates of this new table; improves the meaningfulness of the "atmost 100" below
j1ddpd := DEDUP(SORT(j1fields,RECORD,local),
								RECORD,local);

Header.Layout_PairMatch tra_ssn(j1ddpd ll, j1ddpd r, integer1 match) := transform
  self.old_rid := ll.did;
  self.new_rid := r.did;
  self.pflag := match;
  end;

j := join(j1ddpd,j1ddpd, 
   left.ssn=right.ssn and left.did > right.did and
   ( 
      left.fname=right.fname and
      length(trim(left.fname)) >= 3 and
      ( 
         header.sig_near_dob(left.dob,right.dob) 
       or
         left.good_nmaddr>=0 and left.good_ssn 
       )
	 or
       ( 
         header.gens_ok(left.name_suffix,left.dob,right.name_suffix,right.dob) 
       or
         left.good_ssn
       ) and
       e_dv(left.good_ssn,left.dob,right.dob) //-  this subtraction was a mistake
       + IF ( left.good_nmaddr>=0, 
         //rule 5
              IF ( left.prim_range=right.prim_range and left.prim_range<>'' and
				   left.prim_name=right.prim_name and left.prim_name<>'' and
                   left.zip=right.zip, 1+left.good_nmaddr, 0 ), 
              -1 ) -
       ut.NameMatch(left.fname,left.mname,left.lname,right.fname,right.mname,right.lname)
       >= 0 
     ),tra_ssn(left,right,1),atmost(left.ssn=right.ssn,100),local);


name_valid := me_use2.fname<>'' and me_use2.lname<>'';

has_fl := me_use2(name_valid);

address_valid := (me_use2.zip<>'' or me_use2.city_name<>'') and 
                 ( me_use2.prim_name<>'' or me_use2.sec_range<>'' );

mu2_dup := has_fl(address_valid);

nm_addrs_p := distribute(mu2_dup,hash(prim_range,prim_name,st));

//ut.MAC_Remove_Withdups_local(nm_addrs_p,hash(prim_range, prim_name, st),1000,nm_addrs)
nm_addrs := nm_addrs_p;

rnm_addrs_with_clean_sec_range
 :=
  record
	nm_addrs.did;
	nm_addrs.ssn;
	nm_addrs.dob;
	nm_addrs.fname;
	nm_addrs.lname;
	nm_addrs.mname;
	nm_addrs.name_suffix;
	nm_addrs.prim_range;
	nm_addrs.prim_name;
	nm_addrs.zip;
	nm_addrs.st;
	nm_addrs.city_name;
	nm_addrs.sec_range;
	nm_addrs.good_nmaddr;
	typeof(nm_addrs.sec_range)	temp_desig;
	typeof(nm_addrs.sec_range)	temp_hsr;
	typeof(nm_addrs.sec_range)	temp_num_only;
	typeof(nm_addrs.sec_range)	temp_let_only;
	
	//these are the fields i was able to drop from j2
		//nm_addrs.vendor_id;
		//nm_addrs.phone;
		//nm_addrs.dt_last_seen;
		//nm_addrs.good_ssn;
		//nm_addrs.rare_name;
  end
 ;
 
Header.Layout_PairMatch j2tra(rnm_addrs_with_clean_sec_range ll, rnm_addrs_with_clean_sec_range r, integer1 match) := transform
  self.old_rid := ll.did;
  self.new_rid := r.did;
  self.pflag := match;
  end;

rnm_addrs_with_clean_sec_range	tCleanUpSecRange(nm_addrs pInput)
 :=
  transform
	self.temp_desig		:=	map(stringlib.stringfind(trim(pInput.sec_range),' ',1)<>0	=> pInput.sec_range[stringlib.stringfind(trim(pInput.sec_range),' ',1)+1..],
								stringlib.stringfind(trim(pInput.sec_range),'-',1)<>0 => pInput.sec_range[stringlib.stringfind(trim(pInput.sec_range),'-',1)+1..],
								pInput.sec_range[1] >= 'A' and pInput.sec_range[1]<='Z' and (unsigned4)(pInput.sec_range[2..length(pInput.sec_range)])<>0	=> pInput.sec_range[2..],
								pInput.sec_range[length(trim(pInput.sec_range))] >= 'A' and pInput.sec_range[length(trim(pInput.sec_range))]<='Z' and (unsigned4)(pInput.sec_range[1..length(trim(pInput.sec_range))-1])<>0	=> pInput.sec_range[1..length(trim(pInput.sec_range))-1],
								pInput.sec_range
							   );
	self.temp_hsr		:=	stringlib.stringfilter(pInput.sec_range,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
	self.temp_num_only	:=	stringlib.stringfilter(pInput.sec_range,'0123456789');
	self.temp_let_only	:=	stringlib.stringfilter(pInput.sec_range,'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	self				:=	pInput;
  end
 ;

nm_addrs_cleanSR	:=	dedup(sort(project(nm_addrs,tCleanUpSecRange(left)), record, local), record, local);

boolean evalSRalternates(nm_addrs_cleanSR leftds, nm_addrs_cleanSR rightds) := 
(
	(leftds.sec_range = '' or rightds.sec_range = '' or leftds.temp_hsr = rightds.temp_hsr)
		or 
	(leftds.temp_desig = rightds.temp_desig)
		or 
	(leftds.temp_num_only = rightds.temp_num_only and (unsigned4)leftds.temp_num_only <> 0)
		or 
	(leftds.temp_let_only = rightds.temp_let_only and (unsigned4)leftds.temp_num_only = 0 and leftds.temp_let_only <> '')
);

genderDiff(string l, string r) := 
	(datalib.gender(trim(l))='M' and datalib.gender(trim(r))='F') or
	(datalib.gender(trim(r))='M' and datalib.gender(trim(l))='F');

boolean evalJ2(nm_addrs_cleanSR leftds, nm_addrs_cleanSR rightds, 
			   boolean withSR, boolean withZip, boolean WithCity, boolean WithGoodNames) := (
leftds.prim_range=rightds.prim_range and
leftds.prim_name=rightds.prim_name and
leftds.st = rightds.st and
leftds.did > rightds.did and
( 
    WithZip and				//these two lines may look redundant, but the WithZip allows atmost to evaluate
    leftds.zip<>'' and 
    leftds.zip=rightds.zip 
		or 
    WithCity and
    leftds.city_name<>'' and 
    leftds.city_name=rightds.city_name 
) and
(
	leftds.sec_range = rightds.sec_range 
		or 
	not withSR and
	evalSRalternates(leftds,rightds)
) and
(
	ssn_nneq(leftds.ssn,rightds.ssn)
		or 
	leftds.prim_range<>'' and 
	header.sig_near_dob(leftds.dob,rightds.dob)
) and
	header.gens_ok(leftds.name_suffix,leftds.dob,rightds.name_suffix,rightds.dob) and 
	(
		leftds.good_nmaddr>0 and
		leftds.fname=rightds.fname and
		leftds.lname=rightds.lname
			or
		not WithGoodNames and
		(leftds.good_nmaddr>=0 and rightds.good_nmaddr>=0 or header.sig_near_dob(leftds.dob,rightds.dob)) and
		header.date_value(leftds.dob,rightds.dob)
		+ map(leftds.good_nmaddr=2 and rightds.good_nmaddr=2 and
					metaphonelib.DMetaPhone1(leftds.fname)[1]=metaphonelib.DMetaPhone1(rightds.fname)[1] and
					leftds.lname = rightds.lname
																																							=> 2,
					leftds.good_nmaddr>=0 and rightds.good_nmaddr>=0										=> 1, 
																																							  -1 )
		+ header.suffix_value(leftds.name_suffix,rightds.name_suffix)
		+ header.ssn_value(leftds.ssn,rightds.ssn) 
		- if((genderDiff(leftds.fname, rightds.fname)), 2, 0)
		- ut.NameMatch(leftds.fname,leftds.mname,leftds.lname,rightds.fname,rightds.mname,rightds.lname) >= 0
	)
);




// output(	choosen(nm_addrs_cleanSR, 1000), named('nm_addrs_cleanSR'), extend);
j2c := join(nm_addrs_cleanSR(city_name<>''),nm_addrs_cleanSR(city_name<>''), 
           evalJ2(left,right,false,false,true,false),
					 j2tra(left,right,2),
					 atmost(left.prim_range=right.prim_range and
									left.prim_name=right.prim_name and
									left.city_name=right.city_name and
									left.st = right.st, 1000),
					 local);
// output(	choosen(j2c, 1000), named('j2c'), extend);
j2z := join(nm_addrs_cleanSR(zip<>''),nm_addrs_cleanSR(zip<>''), 
           evalJ2(left,right,false,true,false,false),
					 j2tra(left,right,2),
					 atmost(left.prim_range=right.prim_range and
									left.prim_name=right.prim_name and
									left.zip=right.zip and
									left.st = right.st, 1000),
					 local);
// output(	choosen(j2z, 1000), named('j2z'), extend);
j2n := join(nm_addrs_cleanSR(good_nmaddr>0),nm_addrs_cleanSR(good_nmaddr>0), 
           evalJ2(left,right,false,true,true,true),
					 j2tra(left,right,2),
					 atmost(left.prim_range=right.prim_range and
									left.prim_name=right.prim_name and
									left.fname=right.fname and
									left.lname=right.lname and
									left.st = right.st, 1000),
					 local);
// output(	choosen(j2n, 1000), named('j2n'), extend);
j2sr := join(nm_addrs_cleanSR(sec_range <> ''),nm_addrs_cleanSR(sec_range <> ''), 
           evalJ2(left,right,true,true,true,false),
					 j2tra(left,right,2),
					 atmost(left.prim_range=right.prim_range and
									left.prim_name=right.prim_name and
									left.st = right.st and
									left.sec_range = right.sec_range, 1000),
					 local);
// output(	choosen(j2sr, 1000), named('j2sr'), extend);				
j2 := dedup(j2c + j2z + j2n + j2sr, all);
//output(j2);
mu3_dups := distribute(me_use2(~Header.Vendor_Id_Null(vendor_id)),hash(vendor_id));
//ut.MAC_Remove_Withdups_local(mu3_dups,vendor_id,500,mu3)

//patch vendor ID of EQ records for platform bug from 06/2004-12/2005
new_vendor_rec := record
 mu3_dups.ssn;
 mu3_dups.did;
 mu3_dups.name_suffix;
 mu3_dups.dob;
 mu3_dups.fname;
 mu3_dups.mname;
 mu3_dups.lname;
 string18 new_vendor;
 end;

 
new_vendor_rec setvendor(mu3_dups L) := transform
 self.new_vendor := header.make_new_vendor(l.vendor_id);
 self := l;
end;

mu3 := dedup(project(mu3_dups,setvendor(left)), local, all);


j3 := join(mu3,mu3,left.new_vendor=right.new_vendor and 
                   header.ssn_value(left.ssn,right.ssn)>=0 and
                   ( left.did > right.did
                   //or left.preglb_did > right.preglb_did and
                   //   left.preglb=1 and right.preglb=1 
                   ) and
                   header.gens_ok(left.name_suffix,left.dob,right.name_suffix,right.dob) and
                   (
                   header.ssn_value(left.ssn,right.ssn) +
                   header.date_value(left.dob,right.dob) >= 5 or
                   header.ssn_value(left.ssn,right.ssn) +
                   header.date_value(left.dob,right.dob) -
                   ut.NameMatch(left.fname,left.mname,left.lname,right.fname,right.mname,right.lname)
                   >= 0 
                   ),
                   tra2(left.did,right.did,3),atmost(left.new_vendor=right.new_vendor,500),local);


has_fl_for4 := dedup(project(has_fl(rare_name<=100),
														 {has_fl.fname, has_fl.mname, has_fl.lname, has_fl.did, has_fl.dob, has_fl.st, has_fl.city_name, has_fl.rare_name, has_fl.zip}),
										 local, all);
mu4p := distribute(has_fl_for4,hash(fname,lname));
mu4 := mu4p(ut.date_quality(dob)>=4);

j4 := join(mu4,mu4,left.fname=right.fname and
                   left.lname=right.lname and
                   left.did>right.did and
                   ut.nneq(left.mname,right.mname) and
                   (
					  left.rare_name <= 10 and 
                         did_add.DOB_Match_Score(left.dob,right.dob)=100
                      or left.rare_name <= 20 and
                         did_add.DOB_Match_Score(left.dob,right.dob)=100 and
                         left.st=right.st
                      or left.rare_name <= 50 and
                         did_add.DOB_Match_Score(left.dob,right.dob)=100 and
                         left.st=right.st and
                         left.city_name=right.city_name
                      or left.rare_name <= 100 and
                         did_add.DOB_Match_Score(left.dob,right.dob)> 75 and
                         left.zip=right.zip
                   ),
                   tra2(left.did, right.did, 4),
									 local);
									 

has_fl_for5 := dedup(project(has_fl(rare_name<=100),
														 {has_fl.fname, has_fl.mname, has_fl.lname, has_fl.zip, has_fl.did, has_fl.prim_range, has_fl.prim_name, has_fl.sec_Range, has_fl.ssn, has_fl.name_suffix, has_fl.good_nmaddr, has_fl.dob, has_fl.good_ssn}),
										 local, all);
mu5p := distribute(has_fl_for5,hash(fname,lname));

j5 := join(mu5p,mu5p,left.fname=right.fname and
                   left.lname=right.lname and
				   left.zip = right.zip and
                   left.did>right.did and
                   ut.nneq(left.mname,right.mname) and
                   (
                     left.prim_range=right.prim_range and
                     ut.stringsimilar100(left.prim_name,right.prim_name) < 30 or
                     ut.stringsimilar(left.prim_range,right.prim_range) < 2 and
                     left.prim_name=right.prim_name
                   )
                   and
                   ut.Sec_Range_EQ(left.sec_range,right.sec_range) < 5 and
                   ssn_nneq(left.ssn,right.ssn) and 
                   header.gens_ok(left.name_suffix,left.dob,right.name_suffix,right.dob) and 
                   header.date_value(left.dob,right.dob)
                    + IF ( left.good_nmaddr>=0 and right.good_nmaddr>=0, 0, -1 )
                    + header.suffix_value(left.name_suffix,right.name_suffix)
                    + IF (left.good_ssn, header.ssn_value(left.ssn,right.ssn), 0 ) > 0
					,
                   tra2(left.did, right.did, 5),
									 local);


mu8_dups := distribute(has_fl(ssns_ok,good_ssn or dob<>0),hash(fname,mname,lname));
//ut.MAC_Remove_Withdups_local(mu8_dups,hash(fname, lname, mname),2000,mu8)
mu8 := dedup(project(mu8_dups,
										 {mu8_dups.fname, mu8_dups.lname, mu8_dups.mname, mu8_dups.did, mu8_dups.rare_name, mu8_dups.ssn, mu8_dups.dob, mu8_dups.good_ssn, mu8_dups.name_suffix}),
						 local, all);
// Full name & dob, one 'edit' for SSNs to match
j8 := join(mu8,mu8,left.fname=right.fname and
                      left.lname=right.lname and
                      left.mname=right.mname and
                      left.did > right.did and
                      ut.StringSimilar(left.ssn,right.ssn)<=1 and
                      (
                        ut.mob(left.dob)=ut.mob(right.dob) or
                        left.good_ssn and header.near_dob(left.dob,right.dob) and (left.rare_name < 255 or right.dob = 0 or left.dob = 0)
					  ) and 
                      ut.NNEQ_suffix(left.name_suffix,right.name_suffix),
                      tra2(left.did,right.did,8),
											atmost(left.fname=right.fname and
                      left.lname=right.lname and
                      left.mname=right.mname,2000),local);

j14 := header.j14_phone(me_use2);

//***** Gather matches found in other datasets
hrdm := header.relativedidmatches(me_use2);
hrdm_pst := hrdm : persist('relativematches' 	+ persist_suffix);
OutsideMatches := if(header.DoSkipPersist(persist_suffix),hrdm,hrdm_pst) + 
					property.prop_did_matches + 
					Drivers.DL_DID_matches + 
					vehlic.Vehicle_DID_matches +
					Bankrupt.Bankrupt_DID_matches + 
					project(
						NGADL.matches(head).Matches,  //ADL2
						transform(
							Header.Layout_PairMatch, 
							self.new_rid := left.DID2,
							self.old_rid := left.DID1,
							self.pflag := 16
						)
					); 

j_pst 	:= j 	 : persist('j1' 	+ persist_suffix);
j2_pst 	:= j2  : persist('j2' 	+ persist_suffix);
j3_pst 	:= j3  : persist('j3' 	+ persist_suffix);
j4_pst 	:= j4  : persist('j4' 	+ persist_suffix);
j5_pst 	:= j5  : persist('j5' 	+ persist_suffix);
j8_pst 	:= j8  : persist('j8' 	+ persist_suffix);
j14_pst := j14 : persist('j14' + persist_suffix);

allj := if(header.DoSkipPersist(persist_suffix), 
					 j		+	j2+			j3+			j4+			j5+			j8+			j14, 
					 j_pst+	j2_pst+	j3_pst+	j4_pst+	j5_pst+	j8_pst+	j14_pst);

export combined := allj+
			if(includeOutsideMatches, OutsideMatches);

out := dedup(combined,new_rid,old_rid,all);
out_pst := out : persist('did_rules0' + persist_suffix);

export result := if(header.DoSkipPersist(persist_suffix), 
					out,
					out_pst);

end;