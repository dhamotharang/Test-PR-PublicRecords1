IMPORT VehicleV2, VehLic;
EXPORT Files := MODULE
 
 EXPORT VEHICLE_MAIN_SF := '~thor_data400::base::vehicleV2::main';
 EXPORT VEHICLE_PARTY_SF := '~thor_data400::base::vehicleV2::party';
 EXPORT VINA_SF := '~thor_data400::in::vehreg_vina_info_all';
 //EXPORT DL_SF := '~thor_200::base::dl2::drvlic';
 
 EXPORT DS_BASE_VEHICLE_MAIN	:= PROJECT(Build_Vehicle.Main_Base(VEHICLE_MAIN_SF), 
   																																								TRANSFORM(VehicleV2.Layout_Base.Main,SELF:=LEFT));
 
 EXPORT PARTY_BIP	:=  PROJECT(Build_Vehicle.Party_Base_bip(VEHICLE_PARTY_SF), 
      																														TRANSFORM(VehicleV2.Layout_Base.Party_bip,SELF:=LEFT));
      
 EXPORT DS_BASE_VEHICLE_PARTY := PROJECT(PARTY_BIP,TRANSFORM(VehicleV2.Layout_Base.Party,SELF:=LEFT));

	EXPORT DS_BASE_VINA  := DATASET(VINA_SF, VehLic.Layout_VINA, THOR, OPT);	
	
	//EXPORT DS_BASE_DL := DATASET(DL_SF, Layouts.VEHICLE_DL, THOR, OPT);
	
END;