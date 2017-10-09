import	vehicleV2,lib_fileservices;

DeletePersistfiles(string	filename)	:=	if(fileservices.FileExists(filename),fileservices.DeleteLogicalFile(filename),output('No persist file need delete. (' +filename + ')' ));

delete01	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::experian_main_temp');
delete02	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::experian_main');
delete03	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::experian_party_temp');
delete04	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::experian_party');

delete05	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::nc_temp_main');
delete06	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::nc_main');
delete07	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::NC_temp_party');
delete08	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::NC_party');

delete09	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::OH_temp_main');
delete10	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::OH_main');
delete11	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::OH_temp_party');
delete12	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::OH_party');

delete13	:=	DeletePersistfiles('~thor_data400::persist::vehiclesv2_slim');
delete14	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::vehicle1_temp');
delete15	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::vehicle1_temp_main');
delete16	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::vehicle1_main');
delete17	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::vehiclev1_temp_party');
delete18	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::vehiclev1_party');

delete19	:=	DeletePersistfiles('~thor_data400::persist::vehreg_postbdid');
delete20	:=	DeletePersistfiles('~thor_data400::persist::vehreg_postdid');

delete21	:=	DeletePersistfiles('~thor_data400::persist::vehreg_vina_deduped');

delete22	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::inf_nondppa_vin_temp_main');
delete23	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::inf_nondppa_vin_main');
delete24	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::inf_nondppa_vin_temp_party');
delete25	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::inf_nondppa_vin_party');

delete26	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::inf_nondppa_motorcycle_temp_main');
delete27	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::inf_nondppa_motorcycle_main');
delete28	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::inf_nondppa_motorcycle_temp_party');
delete29	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::inf_nondppa_motorcycle_party');

delete30	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::ma_temp_main');
delete31	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::ma_main');
delete32	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::ma_temp_party');
delete33	:=	DeletePersistfiles('~thor_data400::persist::vehiclev2::ma_party');
delete34  :=	DeletePersistfiles('~thor_data400::persist::vehiclev2::interm_party');

export	Delete_persist_files	:=	parallel( delete01,delete02,delete03,delete04,
																						delete05,delete06,delete07,delete08,
																						delete09,delete10,delete11,delete12,
																						delete13,delete14,delete15,delete16,
																						delete17,delete18,delete19,delete20,
																						delete21,delete22,delete23,delete24,
																						delete25,delete26,delete27,delete28,
																						delete29,delete30,delete31,delete32,
																						delete33,delete34
																						);