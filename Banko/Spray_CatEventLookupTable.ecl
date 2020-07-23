/*import _control;

sourceIP					:=	_Control.IPAddress.edata12;
sourcepath1					:=	'/export/home/gwitz/Banko.txt';
maxrecordsize				:=	8192;
srcCSVseparator				:=	'|~|';
srcCSVterminator			:=	'\\n,\\r\\n';
srcCSVquote					:=	'"';
destinationgroup			:=	'thor400_44';
destinationlogicalname1		:=	'~thor400_44::temp::banko';


/*
FileServices.SprayVariable( sourceIP , sourcepath , [ maxrecordsize ] ,
							[ srcCSVseparator ] , [ srcCSVterminator ] , [ srcCSVquote ] ,
							destinationgroup, destinationlogicalname [,timeout]
							[,espserverIPport] [,maxConnections]
							[,allowoverwrite] [,replicate] [, compress ])

EXPORT Spray_Input:=	fileservices.SprayVariable	(
										sourceIP
										,sourcepath1
										,maxrecordsize
										,srcCSVseparator
										,srcCSVterminator
										,srcCSVquote
										,destinationgroup
										,destinationlogicalname1
										);
*/
import _control;
export Spray_CatEventLookupTable(string sourceIP,string sourcefile,string filedate,string group_name='',string email_target='') := 
function
STRING srcCSVseparator				:=	'|~|';
STRING srcCSVterminator			:=	'\\n,\\r\\n';
STRING srcCSVquote					:=	'"';
// #uniquename(sprayIP)
// #uniquename(spray_banko)
// #uniquename(super_banko)
// #uniquename(recordsize)
// #uniquename(fullfile)
// #uniquename(daily)
// #uniquename(dedup_daily)
// #uniquename(basefile)
// #uniquename(baseout)

// sprayIP := map(sourceIP = 'edata12' => _control.IPAddress.edata12,
								 // sourceIP);

recordsize :=8192;

spray_banko := fileservices.SprayVariable(_control.IPAddress.bctlpedata10,sourcefile, recordsize 
										,srcCSVseparator
										,srcCSVterminator
										,srcCSVquote,group_name
										,'~thor_data400::in::banko::categoryevent_'+filedate,,,,true,true);

super_banko := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_data400::in::banko::categoryevent_delete','~thor_data400::in::banko::categoryevent_father',, true),
				FileServices.ClearSuperFile('~thor_data400::in::banko::categoryevent_father'),
				FileServices.AddSuperFile('~thor_data400::in::banko::categoryevent_father', '~thor_data400::in::banko::categoryevent',, true),
				FileServices.ClearSuperFile('~thor_data400::in::banko::categoryevent'),
				FileServices.AddSuperFile('~thor_data400::in::banko::categoryevent','~thor_data400::in::banko::categoryevent_'+filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::in::banko::categoryevent_delete',true));

 ret := sequential(spray_banko,super_banko,notify('BK EVENT SPRAY COMPLETE','*'))
 : success(FileServices.sendemail(if(email_target<>' ',email_target,'Christopher.Brodeur@lexisnexisrisk.com,Manuel.Tarectecan@lexisnexisrisk.com'),'banko Spray Succeeded','banko Spray Succeeded')),
   failure(FileServices.sendemail(if(email_target<>' ',email_target,'Christopher.Brodeur@lexisnexisrisk.com,Manuel.Tarectecan@lexisnexisrisk.com'),'banko Spray Failure','banko Spray Failure'))
 ;

return ret;
END;
