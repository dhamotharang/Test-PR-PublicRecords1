import watchdog;
export proc_watchdog_moxie_prep(string var1) := function

leMailTarget := 'dsunderman@seisint.com;ASiddique@seisint.com; dJustin@seisint.com';

fSendMail(string pSubject, string pBody)
 := fileservices.sendemail(leMailTarget,pSubject,pBody);

//******Convert best file into Moxie format
a := output(watchdog.Moxie_despray,,map(var1='nonglb'=>'~thor_data400::BASE::Watchdog_Moxie_nonglb',
								   var1='nonutility'=>'~thor_data400::BASE::Watchdog_Moxie_nonutility',
								   var1='nonglb_nonutility'=>'~thor_data400::BASE::Watchdog_Moxie_nonglb_nonutility',
								   var1='marketing' => '~thor_data400::BASE::Watchdog_Moxie_marketing',
						           '~thor_data400::BASE::Watchdog_Moxie'),overwrite);


//******Build Keys
string_rec := record
    watchdog.Layout_Moxie;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

t1 := dataset('~thor_data400::BASE::Watchdog_Moxie_nonglb',string_rec,flat);
t2 := dataset('~thor_data400::BASE::Watchdog_Moxie_nonutility',string_rec,flat);
t3 := dataset('~thor_data400::BASE::Watchdog_Moxie_nonglb_nonutility',string_rec,flat);
t4 := dataset('~thor_data400::BASE::Watchdog_Moxie_marketing',string_rec,flat);
t5 := dataset('~thor_data400::BASE::Watchdog_Moxie',string_rec,flat);


b1 := BUILDINDEX(t1,,'~thor_data400::key::Watchdog_Moxie_nonglb.did',overwrite,moxie);
b2 := BUILDINDEX(t2,,'~thor_data400::key::Watchdog_Moxie_nonutility.did',overwrite,moxie);
b3 := BUILDINDEX(t3,,'~thor_data400::key::Watchdog_Moxie_nonglb_nonutility.did',overwrite,moxie);
b4 := BUILDINDEX(t4,,'~thor_data400::key::Watchdog_Moxie_marketing.did',overwrite,moxie);
b5 := BUILDINDEX(t5,,'~thor_data400::key::Watchdog_Moxie.did',overwrite,moxie);

result := sequential(a,case(var1,'nonglb'=>b1,'nonutility'=>b2,'nonglb_nonutility'=>b3,'marketing' => b4,b5));

return result;
end;