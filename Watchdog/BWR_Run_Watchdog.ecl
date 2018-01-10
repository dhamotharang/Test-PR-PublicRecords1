import ut;
export BWR_Run_Watchdog(string build_type) := function
/*Change the second parameter in the stored function to run 
'' -- Complete file
'nonglb' -- Nonglb with Utility
'nonutility' -- complete file without utility
'nonglb_nonutility' -- Nonglb without utility
'glb_noneq' -- complete file without eq 
'glb_nonen' -- complete file without Experian 
'nonglb_noneq' -- Nonglb without Equifax 
'supplemental' -- Supplemental SmartLinx file 
*/

boolean isnewheader := Watchdog.proc_Validate_NewHdr.out;

verify_hdr := output(isnewheader,named('NewHdrcheck'));
// set this to true/false after running Watchdog.is_new_header
string_rec := record
  string8 fdate;
end;

d := dataset([{ut.GetDate}],string_rec);

wchk := if(fileservices.fileexists('~thor_data400::in::watchdog_check'),
	output('Watchdog check file exists'),
	output(d,,'~thor_data400::in::watchdog_check'));

set_inputs := output('Setting input files...') : success(watchdog.Input_set);

send_bad_email := fileservices.SendEmail('michael.gould@lexisnexisrisk.com,sudhir.kasavajjala@lexisnexis.com','Watchdog Build Failed',thorlib.wuid());

out_all :=  sequential(verify_hdr,wchk,set_inputs,watchdog.BWR_Best(isnewheader,build_type)) : FAILURE(send_bad_email);
return out_all;
end;
