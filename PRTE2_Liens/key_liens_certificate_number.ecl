Import Data_Services, PRTE2_Liens, liensv2, Doxie, ut;

export key_liens_certificate_number(boolean isFCRA = false) := FUNCTION

get_recs := PRTE2_Liens.files.Main_out;

slim_rec := record
get_recs.tmsid;
get_recs.rmsid;
string25 certificate_number;
end;

slim_rec tslim(get_recs L) := transform
self.certificate_number := L.certificate_number;                  
self := L;

end;

slim_main := project(get_recs, tslim(left));

slim_main_dist := distribute(slim_main(certificate_number <> ''), hash(tmsid,rmsid,certificate_number)); 
slim_main_sort := sort(slim_main_dist, tmsid,rmsid,certificate_number,local);
slim_main_dedup  := dedup(slim_main_sort, tmsid, rmsid, certificate_number, local);

file_prefix := if(IsFCRA, 
                  Constants.KEY_PREFIX + 'fcra::',
                  Constants.KEY_PREFIX);

RETURN index(slim_main_dedup,{certificate_number},{tmsid,rmsid},file_prefix + doxie.Version_SuperKey + '::main::certificate_number');

END;