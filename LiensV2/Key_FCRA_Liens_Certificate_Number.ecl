Import Data_Services, liensv2, Doxie, ut;
get_recs := LiensV2.file_liens_fcra_main;

slim_rec := record

get_recs.tmsid;
get_recs.rmsid;
string25 certificate_number;

end;

slim_rec tslim(get_recs L) := transform
self.certificate_number := if(L.certificate_number != '',L.certificate_number,L.irs_serial_number);                         
self := L;

end;

slim_main := project(get_recs, tslim(left));

slim_main_dist := distribute(slim_main(certificate_number <> ''), hash(tmsid,rmsid,certificate_number)); 
slim_main_sort := sort(slim_main_dist, tmsid,rmsid,certificate_number,local);
slim_main_dedup  := dedup(slim_main_sort, tmsid, rmsid, certificate_number, local);

export key_fcra_liens_certificate_number := index(slim_main_dedup ,{certificate_number},{tmsid,rmsid},
                                   Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::qa::main::certificate_number') ;