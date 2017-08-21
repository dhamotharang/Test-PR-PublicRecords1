Import Data_Services, PRTE2_Liens, liensv2, Doxie, ut;

export key_liens_irs_serial_number(boolean isFCRA = false) := FUNCTION

get_recs := PRTE2_Liens.files.Main_out;

slim_rec := record
get_recs.tmsid;
get_recs.rmsid;
string2  agency_state ;
string25 irs_serial_number;
end;

slim_main := project(get_recs, transform(slim_rec, self := left;));

slim_main_dist := distribute(slim_main(irs_serial_number <> ''), hash(tmsid,rmsid,irs_serial_number,agency_state)); 
slim_main_sort := sort(slim_main_dist, tmsid,rmsid,irs_serial_number,agency_state,local);
slim_main_dedup  := dedup(slim_main_sort, tmsid, rmsid, irs_serial_number,agency_state, local);

file_prefix := if(IsFCRA, 
                  Constants.KEY_PREFIX + 'fcra::',
                  Constants.KEY_PREFIX);

RETURN index(slim_main_dedup ,{irs_serial_number,agency_state},{tmsid,rmsid}, file_prefix + doxie.Version_SuperKey + '::main::IRS_serial_number');

END;
			   