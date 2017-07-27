/*Change var1 to run 
'' -- Complete file
'nonglb' -- Nonglb with Utility
'nonutility' -- complete file without utility
'nonglb_nonutility' -- Nonglb without utility
*/
string20 var1 := '' : stored('watchtype');

leMailTarget := 'ENeiberg@seisint.com;ASiddique@seisint.com; dJustin@seisint.com';

fSendMail(string pSubject, string pBody)
 := fileservices.sendemail(leMailTarget,pSubject,pBody);

//******Convert best file into Moxie format
a := output(watchdog.Moxie_despray,,map(var1='nonglb'=>'~thor_data400::BASE::Watchdog_Moxie_nonglb',
								   var1='nonutility'=>'~thor_data400::BASE::Watchdog_Moxie_nonutility',
								   var1='nonglb_nonutility'=>'~thor_data400::BASE::Watchdog_Moxie_nonglb_nonutility',
						           '~thor_data400::BASE::Watchdog_Moxie'),overwrite);


//******Build Keys
string_rec := record
    Layout_Moxie;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

t1 := dataset('~thor_data400::BASE::Watchdog_Moxie_nonglb',string_rec,flat);
t2 := dataset('~thor_data400::BASE::Watchdog_Moxie_nonutility',string_rec,flat);
t3 := dataset('~thor_data400::BASE::Watchdog_Moxie_nonglb_nonutility',string_rec,flat);
t4 := dataset('~thor_data400::BASE::Watchdog_Moxie',string_rec,flat);


b1 := BUILDINDEX(t1,,'~thor_data400::key::Watchdog_Moxie_nonglb.did',overwrite,moxie);
b2 := BUILDINDEX(t2,,'~thor_data400::key::Watchdog_Moxie_nonutility.did',overwrite,moxie);
b3 := BUILDINDEX(t3,,'~thor_data400::key::Watchdog_Moxie_nonglb_nonutility.did',overwrite,moxie);
b4 := BUILDINDEX(t4,,'~thor_data400::key::Watchdog_Moxie.did',overwrite,moxie);

c := fSendMail('Watchdog_Best_Stats','Finished Watchdog Build ' + watchdog.RunDate + ' ' + var1 +  '\r\n \r\n ' +
			  'Results and stats:  http://10.150.28.12:8010/WsWorkunits/WUInfo?Wuid=' + workunit + '\r\n');

d := fileservices.sendemail('Afterhours@seisint.com','Watchdog Complete', 'Finished Watchdog Build ' + var1 +  '\r\n \r\n ');

export BWR_Moxie_Key := sequential(a,case(var1,'nonglb'=>b1,'nonutility'=>b2,'nonglb_nonutility'=>b3,b4),c,d);