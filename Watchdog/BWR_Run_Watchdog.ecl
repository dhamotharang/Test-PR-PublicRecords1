#workunit('name','Watchdog');

/*Change the second parameter in the stored function to run 
'' -- Complete file
'nonglb' -- Nonglb with Utility
'nonutility' -- complete file without utility
'nonglb_nonutility' -- Nonglb without utility
*/

#stored ('watchtype', ''); 

set_inputs := output('Setting input files...') : success(watchdog.Input_set);

send_bad_email := fileservices.SendEmail('afterhours@seisint.com','Watchdog Build Failed','');

sequential(set_inputs,watchdog.BWR_Best,watchdog.BWR_Delta,watchdog.BWR_Moxie_Key) : FAILURE(send_bad_email);