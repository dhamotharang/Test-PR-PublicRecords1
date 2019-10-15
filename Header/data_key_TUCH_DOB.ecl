import ut,header, dx_Header;

k  :=table(header.file_tn_did(did>0,dob>0),{did,rid,src,dob,dt_first_seen,dt_last_seen});

EXPORT data_key_TUCH_dob := PROJECT (k, TRANSFORM(dx_Header.layouts.i_tuch_dob,SELF:=LEFT,SELF.global_sid:=0,SELF.record_sid:=0)); 
//export Key_TUCH_dob := INDEX(k,{k.rid}, {k},ut.Data_Location.Person_header + 'thor_data400::key::header.TUCH_dob_' + doxie.version_superkey,opt);