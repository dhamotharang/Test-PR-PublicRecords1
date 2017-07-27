import liensv2, Doxie, ut;
get_recs := LiensV2.file_liens_main;

slim_rec := record

get_recs.tmsid;
get_recs.rmsid;
string2  agency_state ;
string25 irs_serial_number;

end;

slim_rec tslim(get_recs L) := transform
                   
self := L;

end;

slim_main := project(get_recs, tslim(left));

slim_main_dist := distribute(slim_main(irs_serial_number <> ''), hash(tmsid,rmsid,irs_serial_number,agency_state)); 
slim_main_sort := sort(slim_main_dist, tmsid,rmsid,irs_serial_number,agency_state,local);
slim_main_dedup  := dedup(slim_main_sort, tmsid, rmsid, irs_serial_number,agency_state, local);

export key_fcra_liens_irs_serial_number := index(slim_main_dedup ,{irs_serial_number,agency_state},{tmsid,rmsid},
                                   '~thor_data400::key::liensv2::fcra::qa::main::IRS_serial_number') ;


			   