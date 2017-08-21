import ut, watchdog,certegy,driversV2, header,Business_Header,Risk_indicators,vehicleV2,gong,phonesplus;
export Files_Used := module

	export watchdog_File_Best	   		  := Watchdog.File_Best(did <>0);
	export certegy_base_File	   		  := certegy.Files.certegy_base(did <>0);
	export Drivers2_File_Dl      		  := dataset(ut.foreign_prod+DriversV2.Constants.Cluster + 'BASE::DL2::Drvlic',DriversV2.Layout_DL_Extended,thor); 
	export Header_file           		  := Header.File_Headers(did <> 0);
	export Header_relative_file           := Header.File_Relatives(same_lname); 	
	export Bus_Hdr_Business_contacts_File := Business_Header.File_Business_Contacts(did <> 0); 
	export Risk_indicators_HRA_file       := Risk_indicators.File_HRI_Address_Sic2;
	export vehicle_main_file              := vehicleV2.file_VehicleV2_Main; 
	export vehicle_party_file             := vehicleV2.file_vehicleV2_party(append_did <> 0 ); 
	export gong_file_history              := gong.file_history(did <>0 and phone10 <> '');
	//export phones_plus_file             := Phonesplus.file_phonesplus_base;
	export phones_plus_file               := dataset(ut.foreign_prod+'~thor_data400::base::phonesplus', phonesplus.layoutCommonOut, thor);
	
	export watchdog_Layout_best    		:= watchdog.Layout_best; 
	export driversV2_Layout_DL     		:= driversV2.Layout_DL_Extended; 
	export certegy_layout_base		 	:= certegy.layouts.base;
	export layout_Header_file  		 	:= header.Layout_Header;
	export Layout_Header_relative  		:= Header.Layout_Relatives; 
	export Layout_Business_Contact 	    := Business_Header.Layout_Business_Contact_Full_new;
	export Layout_HRA			        := Risk_indicators.Layout_HRI_Address_Sic2;
	export Layout_vehicle_main			:= vehicleV2.Layout_Base_Main;
	export Layout_vehicle_party         := vehicleV2.Layout_Base_Party;	
    export Layout_gong_history          := gong.layout_history;
	export Layout_phones_plus           := phonesplus.layoutCommonOut;
end;

