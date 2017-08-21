import watchdog;
export BWR_Run_Best( boolean isnewheader = false, string build_type = '') := function

send_bad_email := fileservices.SendEmail('sudhir.kasavajjala@lexisnexis.com; wenhong.ma@lexisnexis.com; michael.gould@lexisnexis.com','FCRA list Build Failed',thorlib.wuid());

out_all :=  watchdog.BWR_Best(isnewheader,build_type) : FAILURE(send_bad_email);
return out_all;
end;
