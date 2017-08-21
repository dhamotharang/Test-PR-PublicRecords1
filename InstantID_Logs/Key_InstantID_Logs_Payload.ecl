import ut, doxie;

srtFile := sort(distribute(instantid_logs.File_InstantID_Logs_Base(did > 0), hash(fname,lname,phone)), fname, lname, phone, local);

export Key_InstantID_Logs_Payload := 
 INDEX(srtFile, {fname, lname, phone, did}, {srtFile}, '~thor_data400::key::instantid_logs_' + doxie.version_superkey, OPT);
