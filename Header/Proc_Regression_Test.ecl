import ut,mdr;

Base := dataset('~thor_data400::base::header_prod',header.Layout_Header,flat)(header.Blocked_data());

New := dataset('~thor_data400::base::header',header.Layout_Header,flat);

Header.MAC_Header_Sample(base,base_smpl)


header.mac_header_sample(new,new_smpl)

rrec := record
  integer8 rid;
  string10 what_happened;
  end;

rrec what_happened(base_smpl le, new_smpl ri) := transform
  self.what_happened := MAP ( le.rid=0 => 'APPEAR',
                              ri.rid=0 => 'DISAPPEAR',
                              le.did<>ri.did => 'DID SHIFT',
                              le.fname<>ri.fname or
                              le.mname<>ri.mname or
                              le.lname<>ri.lname or
                              (le.name_suffix<>ri.name_suffix and ~ut.is_unk(ri.name_suffix)) or
                              le.title<>ri.title => 'NAME',
                              le.ssn<>ri.ssn => 'SSN',
                              le.dob<>ri.dob => 'DOB',
                              le.phone<>ri.phone => 'PHONE',
                              le.prim_range<>ri.prim_range or
                              le.predir<>ri.predir or
                              le.prim_name<>ri.prim_name or
                              le.suffix<>ri.suffix or
                              le.postdir<>ri.postdir or
                              le.unit_desig<>ri.unit_desig or
                              le.sec_range<>ri.sec_range or
                              le.city_name<>ri.city_name or
                              le.zip<>ri.zip or
                              le.zip4<>ri.zip4 or
                              le.county<>ri.county => 'ADDRESS',
                              le.rec_type<>ri.rec_type => 'REC_TYPE',
                              le.tnt<>ri.tnt => 'TNT',
                              le.dt_first_seen <> ri.dt_first_seen or
                              le.dt_vendor_first_reported<>ri.dt_vendor_first_reported or
                              le.dt_nonglb_last_seen<>ri.dt_nonglb_last_seen => 'SIG DATE',
                              le.dt_last_seen<>ri.dt_last_seen or
                              le.dt_vendor_last_reported<>ri.dt_vendor_last_reported => 'DATE',
                              'NONE');
  self.rid := if ( le.rid<>0, le.rid, ri.rid );
  end;

base_dist := distribute(base_smpl, hash((integer8)rid));
new_dist := distribute(new_smpl, hash((integer8)rid));

rec_match := join(base_dist,new_dist,
			      left.rid=right.rid,
				  what_happened(left,right),
				  full outer, local) : persist('headerbuild_regression_rec_match');

// ut.MAC_Field_Count(rec_match,rec_match.what_happened,'what_happened',true, true,field_count)

base_smpl_per := base_smpl  : persist('headerbuild_regression_base_smpl');
new_smpl_per := new_smpl : persist('headerbuild_regression_new_smpl');

out_match := output(rec_match,,'CEMTEMP::Match_Results', overwrite);
out_base := output(base_smpl_per,,'CEMTEMP::Match_Base', overwrite);
out_new := output(new_smpl_per,,'CEMTEMP::Match_New', overwrite);

diff := dataset('CEMTEMP::Match_Results',rrec,flat);
dold := dataset('CEMTEMP::Match_Base',header.Layout_Header,flat);
dnew := dataset('CEMTEMP::Match_New',header.Layout_Header,flat);

header.MAC_Regression_Samples(dold, dnew, diff, rid, 'APPEAR', 3000, old1, new1)
header.MAC_Regression_Samples(dold, dnew, diff, rid, 'DISAPPEAR', 3000, old2, new2)
header.MAC_Regression_Samples(dold, dnew, diff, rid, 'DID SHIFT', 3000, old3, new3)
header.MAC_Regression_Samples(dold, dnew, diff, rid, 'preGLB_DID', 3000, old4, new4)
header.MAC_Regression_Samples(dold, dnew, diff, rid, 'NAME', 3000, old5, new5)
header.MAC_Regression_Samples(dold, dnew, diff, rid, 'SSN', 3000, old6, new6)
header.MAC_Regression_Samples(dold, dnew, diff, rid, 'DOB', 3000, old7, new7)
header.MAC_Regression_Samples(dold, dnew, diff, rid, 'PHONE', 3000, old8, new8)
header.MAC_Regression_Samples(dold, dnew, diff, rid, 'ADDRESS', 3000, old9, new9)
header.MAC_Regression_Samples(dold, dnew, diff, rid, 'REC_TYPE', 3000, old10, new10)
header.MAC_Regression_Samples(dold, dnew, diff, rid, 'TNT', 3000, old11, new11)
header.MAC_Regression_Samples(dold, dnew, diff, rid, 'SIG DATE', 3000, old12, new12)
header.MAC_Regression_Samples(dold, dnew, diff, rid, 'DATE', 3000, old13, new13)


export Proc_Regression_Test := sequential(
parallel(
// field_count, 
out_match, 
out_base, 
out_new),
old1,new1,old2,new2,old3,new3,old4,new4,old5,new5,old6,new6,old7,new7,
old8,new8,old9,new9,old10,new10,old11,new11,old12,new12,old13,new13);