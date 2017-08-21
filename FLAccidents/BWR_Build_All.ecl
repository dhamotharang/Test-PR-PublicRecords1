#workunit('name', 'Florida Accidents Build Process ' + FLAccidents.Version_Development);
import	_control;

//Make sure these attributes are correct:
//FLAccidents.Version
//FLAccidents.Version_Development

DestinationIP		:=  _Control.IPAddress.edata12;
DestinationVolume	:= '/super_credit/flcrash/out/';
filedate			:= FLAccidents.Version_Development;

FLAccidents.Proc_Build_All(DestinationIP, DestinationVolume, filedate).All;
