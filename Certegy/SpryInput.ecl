import _control;

versionnum					:=	Certegy.version;
sourceDIR					:=	'/load01/choicepoint_inbound/certegy/';
Target						:=	'~thor_data400::in::certegy::dl';
sourceIP					:=	_Control.IPAddress.edata14;
filename					:=	versionnum[3..]+'_certextr.dat';
sourcepath1					:=	sourceDIR + versionnum + '/' + filename;
maxrecordsize				:=	371;
destinationgroup			:=	_Control.ThisCluster.GroupName;
destinationlogicalname1		:=	Target + versionnum + thorlib.wuid();

clear_sf:=fileservices.clearsuperfile(Target);

spry_file:=	fileservices.sprayfixed	(
									sourceIP
									,sourcepath1
									,maxrecordsize
									,destinationgroup
									,destinationlogicalname1
									,-1,,,true,true,true
									);

add_to_sf:=	fileServices.AddSuperFile(Target,destinationlogicalname1);

export SpryInput := sequential(	clear_sf,  spry_file,  add_to_sf );