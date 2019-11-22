import ut,header, dx_Header;

k  :=table(header.file_tn_did(did>0,dob>0),{
    
    did,
    rid,
    src,
    dob,
    dt_first_seen,
    dt_last_seen,
    TYPEOF(dx_header.layout_header.global_sid) global_sid:=0,
    TYPEOF(dx_header.layout_header.record_sid) record_sid:=0,
    
    });

k_ccpa_compliant:=header.fn_suppress_ccpa(k,true);

EXPORT data_key_TUCH_dob := k_ccpa_compliant;
//export Key_TUCH_dob := INDEX(k,{k.rid}, {k},ut.Data_Location.Person_header + 'thor_data400::key::header.TUCH_dob_' + doxie.version_superkey,opt);