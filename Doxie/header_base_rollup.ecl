import ut, doxie, address;

doxie.MAC_Header_Field_Declare();

l_out := record(Layout_HeaderFileSearch)
	DATASET(doxie.Layout_Rollup.RidRec) rids {maxcount(ut.limits.HEADER_PER_DID)};
end;

export dataset(l_out) header_base_rollup(DATASET(doxie.Layout_HeaderFileSearch) infile) :=
FUNCTION

// add Listing rids
l_out addListings(infile L) := transform
	self.rids := if(
		L.did<>'' and L.phone<>'',
		dataset([doxie.makeRidRec(L.did+'PH'+L.phone, 'PH', 1)]),
		dataset([], doxie.Layout_Rollup.RidRec));
	self := L;
end;
with_listings := project(infile, addListings(left));

// compute rids with doccnt values
doxie.Layout_Rollup.RidRecDid getRids(infile L) := transform
	self.listed_phone	:= L.phone;
	self.r.rid				:= L.rid;
	self.r.src				:= L.src;
	self							:= L;
END;
inRids := dedup(sort(project(infile,getRids(left)),record),record);
srcRids := doxie.lookup_rid_src(inRids, true);

// and merge them into the dataset
l_out addRids(with_listings le, srcRids ri) := transform
	self.rids := le.rids + if(
		(integer)ri.did=0,
		dataset([doxie.makeRidRec(le.rid, le.src, if(le.rid <> '',1,0))]),
		dataset([doxie.makeRidRec(ri.r.rid, ri.r.src, ri.r.doccnt)])
	);
	self := le;
end;
with_rids := join(
	with_listings, srcRids,
	left.did=right.did and left.rid=right.r.rid,
	addRids(left,right),
	left outer, keep(1)
);

infile_plus := if(Include_SourceDocCounts, with_rids, project(infile,transform(l_out,self:=left;self:=[])));

l_out rol_it(l_out le,l_out ri) := transform
  self.glb := le.glb and ri.glb;
  self.dppa := le.dppa and ri.dppa;
  self.first_seen := IF( le.first_seen >0 and le.first_seen < ri.first_seen, le.first_seen, ri.first_seen );
  self.last_seen := IF( le.last_seen > ri.last_seen, le.last_seen, ri.last_seen );
	self.dt_vendor_first_reported := IF( le.dt_vendor_first_reported > 0 and le.dt_vendor_first_reported < ri.dt_vendor_first_reported, le.dt_vendor_first_reported, ri.dt_vendor_first_reported );
	self.dt_vendor_last_reported := IF( le.dt_vendor_last_reported > ri.dt_vendor_last_reported, le.dt_vendor_last_reported, ri.dt_vendor_last_reported );
  self.tnt := IF( tnt_score(le.tnt)<tnt_score(ri.tnt), le.tnt,ri.tnt );
  self.penalt := IF( le.penalt<ri.penalt, le.penalt,ri.penalt );
  self.mname := IF( length(trim(le.mname)) > length(trim(ri.mname)), le.mname, ri.mname );
  self.dob := 			IF( le.dob>ri.dob,le.dob, ri.dob ); // Slight hack for 'best' date
  self.age := 			IF( le.dob>ri.dob,le.age, ri.age ); // Not a typo, taking age from 'best' dsob
	self.IsLimitedAccessDMF := 	ri.IsLimitedAccessDMF; 
	self.dead_age := 	IF( le.dob>ri.dob,le.dead_age, ri.dead_age ); // Not a typo, taking age from 'best' dob
	self.deceased := map(le.deceased = 'Y' or ri.deceased = 'Y' => 'Y',
										   le.deceased = 'N' or ri.deceased = 'N' => 'N',
											 'U');
  left_ssn := length(trim(le.ssn))>length(trim(ri.ssn));
  self.ssn := IF(left_ssn, le.ssn, ri.ssn);
  self.valid_ssn := IF( length(trim(le.ssn))>length(trim(ri.ssn)) or length(trim(le.ssn))=length(trim(ri.ssn)) and ri.valid_ssn='M', le.valid_ssn, ri.valid_ssn);
  self.zip4 := IF( le.zip4='',ri.zip4,le.zip4 );
  self.phone := IF( length(trim(le.phone)) > length(trim(ri.phone)),le.phone, ri.phone );
  self.timezone := IF( length(trim(le.phone)) > length(trim(ri.phone)),le.timezone, ri.timezone );
  self.listed_phone := IF( length(trim(le.listed_phone)) > length(trim(ri.listed_phone)),le.listed_phone, ri.listed_phone);
  self.listed_timezone := IF( length(trim(le.listed_phone)) > length(trim(ri.listed_phone)),le.listed_timezone, ri.listed_timezone);
	self.listed_name := IF( length(trim(le.listed_phone)) > length(trim(ri.listed_phone)),le.listed_name, ri.listed_name);
  self.sec_range := IF(length(trim(le.sec_range))>length(trim(ri.sec_range)),le.sec_range,ri.sec_range);
  SELF.hri_address := le.hri_address;
  SELF.hri_ssn := IF(left_ssn,le.hri_ssn,ri.hri_ssn);
  SELF.ssn_issue_early := IF(le.ssn_issue_early <> 0, le.ssn_issue_early, ri.ssn_issue_early);
  SELF.ssn_issue_last := IF(le.ssn_issue_last <> 0, le.ssn_issue_last, ri.ssn_issue_last);
  SELF.ssn_issue_place := IF(le.ssn_issue_place <> '', le.ssn_issue_place, ri.ssn_issue_place);	
	self.PHONES := CHOOSEN(DEDUP(SORT(LE.PHONES+RI.PHONES,record),record),doxie.rollup_limits.phones);
	self.rids := choosen(dedup(sort(le.rids + ri.rids,record),record), ut.limits.HEADER_PER_DID);
	self := le;
  end;

srtd1 := sort(infile_plus,did,lname,fname,prim_range,prim_name,mname,name_suffix,
			  phone,sec_range,listed_phone,dob,ssn,listed_name,rid);

ta1 := rollup( srtd1,  
left.did=right.did and
  left.fname=right.fname and
  (left.mname=right.mname or ut.lead_contains(left.mname,right.mname)) and
  left.lname=right.lname and
  left.name_suffix=right.name_suffix and 
  left.dod=right.dod and
  left.prim_range=right.prim_range and
  left.predir=right.predir and
  left.prim_name=right.prim_name and
  left.suffix=right.suffix and
  left.postdir=right.postdir and
  address.sec_range_eq(left.sec_range,right.sec_range)<10 and
  left.city_name=right.city_name and
  left.st=right.st and
  left.zip=right.zip and
  left.county_name=right.county_name and
  ut.NNEQ_Phone(left.phone,right.phone) and
  ut.NNEQ_Phone(left.listed_phone,right.listed_phone) and
  ut.NNEQ_Date(left.dob,right.dob) and
  ut.NNEQ_SSN(left.ssn,right.ssn) and
  ut.NNEQ(left.listed_name,right.listed_name)
  , rol_it(left,right) );
	
// output(infile, 		named('infile'),extend);			// DEBUG
// output(inRids, 		named('inRids'));			// DEBUG
// output(srcRids,		named('srcRids'));		// DEBUG
// output(with_rids,	named('with_rids'));	// DEBUG
 // output(ta1,				named('ta1'),extend);				// DEBUG

RETURN ta1;
END;