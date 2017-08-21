import	_control;

EXPORT SprayInput	(
					 string pVersion =  Births.Version_Development
					,string pInFile
					) := 
MODULE

// Fix the directory path and version number before running
versionnum					:=	pVersion;
sourceDIR					:=	'/super_credit/births/ca/';
Target						:=	'~thor_data400::in::births::ca';

sourceIP					:=	_Control.IPAddress.edata12;
sourcepath1					:=	sourceDIR + pInFile;
maxrecordsize				:=	8192;
srcCSVseparator				:=	'\\,';
srcCSVterminator			:=	'\\n,\\r\\n';
srcCSVquote					:=	'"';
// destinationgroup			:=	_Control.TargetGroup.All_400;
destinationgroup			:=	'thor_200';
destinationlogicalname1		:=	Target + pInFile;


Births.MAC_SprayInput('~thor_data400::in::Births',move_0);

/*
FileServices.SprayVariable( sourceIP , sourcepath , [ maxrecordsize ] ,
							[ srcCSVseparator ] , [ srcCSVterminator ] , [ srcCSVquote ] ,
							destinationgroup, destinationlogicalname [,timeout]
							[,espserverIPport] [,maxConnections]
							[,allowoverwrite] [,replicate] [, compress ])
*/
spry_raw:=	fileservices.SprayVariable	(
										sourceIP
										,sourcepath1
										,maxrecordsize
										,srcCSVseparator
										,srcCSVterminator
										,srcCSVquote
										,destinationgroup
										,destinationlogicalname1
										);

move_1:=	fileServices.AddSuperFile('~thor_data400::in::Births',destinationlogicalname1);


EXPORT all :=	sequential(
							move_0
							,spry_raw
							,move_1
							);
END;