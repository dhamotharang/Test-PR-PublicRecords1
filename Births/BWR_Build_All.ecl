import	_control;

SourceIP		:= _Control.IPAddress.edata12;
SourceVolume	:= '/super_credit/births/ca/';
filedate		:= 'DUMMY'; // <<<-- change to version date before executing - eg. 'YYYYMMDD'
InFile			:= 'DUMMY'; // <<<-- change to new vendor file - eg. 'BRTH1905_2006.CSV'

if(filedate != 'DUMMY' and InFile != 'DUMMY'
	,Births.Proc_Build_All(SourceIP, SourceVolume, filedate, InFile).All);
