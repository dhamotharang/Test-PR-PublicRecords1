// SCHEDULE TO RUN IN ALPHARETTA !!!
// SCHEDULE TO RUN IN ALPHARETTA !!!
// SCHEDULE TO RUN IN ALPHARETTA !!!
// SCHEDULE TO RUN IN ALPHARETTA !!!
// SCHEDULE TO RUN IN ALPHARETTA !!!
// SCHEDULE TO RUN IN ALPHARETTA !!!

IMPORT ut,std;
#workunit('name','Boca.PersonHeader - Monitor copy from Boca');

emailListS			:=  'gabriel.marcan@lexisnexisrisk.com'
									 +',Cody.Fouts@lexisnexisrisk.com'
									 ;
emailListF			:= 'gabriel.marcan@lexisnexis.com';
flagFileName		:= '~thor_data400::flag::personHeader::boca::hhid_copy_';

pVersion				:= trim(dataset(flagFileName,{string9 version},thor)[1].version);

updateSuper(string sp, string lg) := sequential(fileservices.RemoveOwnedSubFiles(sp,true),
																								fileservices.clearsuperfile     (sp     ),
																								fileservices.addsuperfile       (sp,lg  ));
updateSuperFile := 

sequential(
		  
			updateSuper('~thor_data400::BASE::HHID'					,'~thor_data400::base::hhid_'+pVersion											),
			updateSuper('~thor_data400::key::did_hhid_qa'		,'~thor_data400::key::header::hhid::'+pVersion+'::did.ver'	),
			updateSuper('~thor_data400::key::hhid_did_qa'		,'~thor_data400::key::header::hhid::'+pVersion+'::hhid.ver'	),
			updateSuper('~thor_data400::key::hhid_qa'				,'~thor_data400::key::header::'+pVersion+'::hhid'						),
			updateSuper('~thor_data400::base::hss_household','~thor400_66::base::hss_household_'+pVersion								),
			
			fileservices.SendEmail(emailListS,'SUCCESS! PersonHeader '+pVersion+' HHID files copied from Boca to Alpharetta','See Alpha prod:'+WORKUNIT),
			if(fileservices.FileExists(flagFileName)=true,fileservices.deleteLogicalFile  (flagFileName))
);		
dt:=Std.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%F%H%M%S%u');
last_checked:= dt[1..10]+' '+dt[11..12]+':'+dt[13..14]+':'+dt[15..16];

when(output(last_checked,named('last_checked')),
		if(fileservices.FileExists(flagFileName)=true
				,updateSuperFile
		 
		 )) : when(cron('9 * * * *')); // every hour at 9 minutes past the hour
		 
// SCHEDULE TO RUN IN ALPHARETTA !!!
// SCHEDULE TO RUN IN ALPHARETTA !!!
// SCHEDULE TO RUN IN ALPHARETTA !!!
// SCHEDULE TO RUN IN ALPHARETTA !!!
// SCHEDULE TO RUN IN ALPHARETTA !!!
// SCHEDULE TO RUN IN ALPHARETTA !!!