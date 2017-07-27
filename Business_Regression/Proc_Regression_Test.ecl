import ut, header, business_header;
#workunit('name', 'Business Header Regression');

Base := business_header.File_Business_Header_father;

New := business_header.File_Business_Header;

business_regression.MAC_Sample(base,base_smpl)

business_regression.mac_sample(new,new_smpl)

rrec := record
  integer8 rcid;
  string10 what_happened;
  end;

rrec what_happened(base_smpl le, new_smpl ri) := transform
  self.what_happened := MAP ( le.rcid=0 => 'APPEAR',
                              ri.rcid=0 => 'DISAPPEAR',
                              le.bdid<>ri.bdid => 'BDID SHIFT',
															le.fein <> ri.fein => 'FEIN',
															le.source <> ri.source or le.source_group <> ri.source_group => 'SOURCE',          // Source file type
														  le.vendor_id <> ri.vendor_id => 'VID',
															le.company_name <> ri.company_name or le.match_company_name <> ri.match_company_name => 'NAME',
                              le.prim_range<>ri.prim_range or
                              le.predir<>ri.predir or
                              le.prim_name<>ri.prim_name or
                              le.addr_suffix<>ri.addr_suffix or
                              le.postdir<>ri.postdir or
                              le.unit_desig<>ri.unit_desig or
                              le.sec_range<>ri.sec_range or
                              le.city<>ri.city or
                              le.zip<>ri.zip or
                              le.zip4<>ri.zip4 or
                              le.county<>ri.county => 'ADDRESS',
                              le.phone<>ri.phone => 'PHONE',
															le.current <> ri.current => 'CURRENT',
															le.match_branch_unit <> ri.match_branch_unit => 'MBU',  
															le.match_geo_city <> ri.match_geo_city => 'MGC',
															le.dt_first_seen <> ri.dt_first_seen or
                              le.dt_vendor_first_reported<>ri.dt_vendor_first_reported  => 'SIG DATE',
                              le.dt_last_seen<>ri.dt_last_seen or
                              le.dt_vendor_last_reported<>ri.dt_vendor_last_reported => 'DATE',

															'NONE');
  self.rcid := if ( le.rcid<>0, le.rcid, ri.rcid );
  end;

base_dist := distribute(base_smpl, hash((integer8)rcid));
new_dist := distribute(new_smpl, hash((integer8)rcid));

rec_match := join(base_dist,new_dist,
			      left.rcid=right.rcid,
				  what_happened(left,right),
				  full outer, local) : persist('bh_regression_rec_match');
					
ut.MAC_Field_Count(rec_match,rec_match.what_happened,'what_happened',true, true,field_count)

base_smpl_per := base_smpl  : persist('bh_regression_base_smpl');
new_smpl_per := new_smpl : persist('bh_regression_new_smpl');

out_match := output(rec_match,,'CEMTEMP::BH_Match_Results', overwrite);
out_base := output(base_smpl_per,,'CEMTEMP::BH_Match_Base', overwrite);
out_new := output(new_smpl_per,,'CEMTEMP::BH_Match_New', overwrite);

diff := dataset('~thor_data400::CEMTEMP::BH_Match_Results',rrec,flat);
dold := dataset('~thor_data400::CEMTEMP::BH_Match_Base',Business_Header.Layout_Business_Header_Base,flat);
dnew := dataset('~thor_data400::CEMTEMP::BH_Match_New',Business_Header.Layout_Business_Header_Base,flat);


header.MAC_Regression_Samples(dold, dnew, diff, rcid, 'APPEAR', 6000, old1, new1)
header.MAC_Regression_Samples(dold, dnew, diff, rcid, 'DISAPPEAR', 6000, old2, new2)
header.MAC_Regression_Samples(dold, dnew, diff, rcid, 'BDID SHIFT', 6000, old3, new3)
header.MAC_Regression_Samples(dold, dnew, diff, rcid, 'FEIN', 6000, old4, new4)
header.MAC_Regression_Samples(dold, dnew, diff, rcid, 'SOURCE', 6000, old5, new5)
header.MAC_Regression_Samples(dold, dnew, diff, rcid, 'VID', 6000, old6, new6)
header.MAC_Regression_Samples(dold, dnew, diff, rcid, 'NAME', 6000, old7, new7)
header.MAC_Regression_Samples(dold, dnew, diff, rcid, 'ADDRESS', 6000, old8, new8)
header.MAC_Regression_Samples(dold, dnew, diff, rcid, 'PHONE', 6000, old9, new9)
header.MAC_Regression_Samples(dold, dnew, diff, rcid, 'CURRENT', 6000, old10, new10)
header.MAC_Regression_Samples(dold, dnew, diff, rcid, 'MBU', 6000, old11, new11)
header.MAC_Regression_Samples(dold, dnew, diff, rcid, 'MGC', 6000, old12, new12)
header.MAC_Regression_Samples(dold, dnew, diff, rcid, 'SIG DATE', 6000, old13, new13)
header.MAC_Regression_Samples(dold, dnew, diff, rcid, 'DATE', 6000, old14, new14)

export Proc_Regression_Test  := sequential(
parallel(
field_count, 
out_match, 
out_base, 
out_new),
old1,new1,old2,new2,old3,new3,old4,new4,old5,new5,old6,new6,old7,new7,
old8,new8,old9,new9,old10,new10,old11,new11,old12,new12,old13,new13,old14,new14);