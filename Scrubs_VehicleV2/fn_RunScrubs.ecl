import scrubs,Scrubs_VehicleV2,vehicleV2,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion, string emailList) := function

OHDirectCount:=fileservices.getsuperfilesubcount('~thor_data400::in::vehiclev2::di::oh_building');
ExperianCount:=fileservices.getsuperfilesubcount('~thor_data400::in::vehiclev2::experian_building');
VINCount:=fileservices.getsuperfilesubcount('~thor_data400::in::vehiclev2::inf_nondppa::vin_building');
MotoCount:=fileservices.getsuperfilesubcount('~thor_data400::in::vehiclev2::inf_nondppa::motorcycle_building');

EmailOHDirect:=if(emailList <>'' , fileservices.sendEmail(emailList,'Scrubs Plus Reporting Scrubs_VehicleV2_OH_Direct','Scrubs_VehicleV2_OH_Direct has no content, Scrubs not performed\n\n'));
EmailExperian:=if(emailList <>'' , fileservices.sendEmail(emailList,'Scrubs Plus Reporting Scrubs_VehicleV2_Experian','Scrubs_VehicleV2_Experian has no content, Scrubs not performed\n\n'));
EmailVIN:=if(emailList <>'' , fileservices.sendEmail(emailList,'Scrubs Plus Reporting Scrubs_VehicleV2_Infutor_VIN','Scrubs_VehicleV2_Infutor_VIN has no content, Scrubs not performed\n\n'));
EmailMoto:=if(emailList <>'' , fileservices.sendEmail(emailList,'Scrubs Plus Reporting Scrubs_VehicleV2_Infutor_Motorcycle','Scrubs_VehicleV2_Infutor_Motorcycle has no content, Scrubs not performed\n\n'));

return sequential(
				if(OHDirectCount>0,scrubs.ScrubsPlus('vehicleV2','Scrubs_VehicleV2','Scrubs_VehicleV2_OH_Direct','OH_Direct',pVersion,emailList,false),EmailOHDirect),
				if(ExperianCount>0,scrubs.ScrubsPlus('vehicleV2','Scrubs_VehicleV2','Scrubs_VehicleV2_Experian','Experian',pVersion,emailList,false),EmailExperian),
				if(VINCount>0,scrubs.ScrubsPlus('vehicleV2','Scrubs_VehicleV2','Scrubs_VehicleV2_Infutor_VIN','Infutor_VIN',pVersion,emailList,false),EmailVIN),
				if(MotoCount>0,scrubs.ScrubsPlus('vehicleV2','Scrubs_VehicleV2','Scrubs_VehicleV2_Infutor_Motorcycle','Infutor_Motorcycle',pVersion,emailList,false),EmailMoto)
				);
end;