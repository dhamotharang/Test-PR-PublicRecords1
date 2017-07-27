import ut;
export File_ssn_snapshot := dataset(ut.Data_Location.Person_header+'~thor_data400::base::header_ssn_snapshot',{ unsigned6 did, unsigned6 rid, string2 src, qstring9 ssn},flat);