/*import _control;

sourceIP					:=	_Control.IPAddress.edata12;
sourcepath1					:=	'/export/home/gwitz/Banko.txt';
maxrecordsize				:=	8192;
srcCSVseparator				:=	'|~|';
srcCSVterminator			:=	'\\n,\\r\\n';
srcCSVquote					:=	'"';
destinationgroup			:=	'thor400_92';
destinationlogicalname1		:=	'~thor400_92::temp::banko';


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
export Spray_CatEventLookupTable(sourceIP,sourcefile,filedate,group_name='\'thor400_92\'',email_target='\' \'') := 
macro
srcCSVseparator				:=	'|~|';
srcCSVterminator			:=	'\\n,\\r\\n';
srcCSVquote					:=	'"';
#uniquename(sprayIP)
#uniquename(spray_banko)
#uniquename(super_banko)
#uniquename(recordsize)
#uniquename(fullfile)
#uniquename(daily)
#uniquename(dedup_daily)
#uniquename(basefile)
#uniquename(baseout)

#workunit('name','banko Spray ' + filedate);

%sprayIP% := map(sourceIP = 'edata12' => _control.IPAddress.edata12,
								 sourceIP);

%recordsize% :=8192;

%spray_banko% := fileservices.SprayVariable(%sprayIP%,sourcefile, %recordsize% 
										,srcCSVseparator
										,srcCSVterminator
										,srcCSVquote,group_name
										,'~thor_data400::in::banko::categoryevent_'+filedate);

%super_banko% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_data400::in::banko::categoryevent_delete','~thor_data400::in::banko::categoryevent_father',, true),
				FileServices.ClearSuperFile('~thor_data400::in::banko::categoryevent_father'),
				FileServices.AddSuperFile('~thor_data400::in::banko::categoryevent_father', '~thor_data400::in::banko::categoryevent',, true),
				FileServices.ClearSuperFile('~thor_data400::in::banko::categoryevent'),
				FileServices.AddSuperFile('~thor_data400::in::banko::categoryevent','~thor_data400::in::banko::categoryevent_'+filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::in::banko::categoryevent_delete',true));

sequential(%spray_banko%,%super_banko%)
 : success(FileServices.sendemail(if(email_target<>' ',email_target,'Gavin.Witz@lexisNexis.com,Christopher.Brodeur@lexisNexis.com,John.Freibaum@lexisNexis.com'),'banko Spray Succeeded','banko Spray Succeeded')),
   failure(FileServices.sendemail(if(email_target<>' ',email_target,'Gavin.Witz@lexisNexis.com,Christopher.Brodeur@lexisNexis.com,John.Freibaum@lexisNexis.com'),'banko Spray Failure','banko Spray Failure'))
 ;

endmacro;
