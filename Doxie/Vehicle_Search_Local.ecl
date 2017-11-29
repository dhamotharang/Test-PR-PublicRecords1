import doxie, doxie_files, business_header, doxie_build, doxie_raw;

Business_Header.doxie_MAC_Field_Declare()
doxie.MAC_Selection_Declare()
qstring25 vid_value := '' : stored('VID');
string2 st_code_value := '' : STORED('StateCode');
string20 veh_num_value := '' : STORED('VehicleNumber');

layout_references just_did(dl_search_local le) :=
TRANSFORM
	SELF.did := le.did;
END;

dids := MAP(dl_value != '' 	=> 	DEDUP(PROJECT(dl_search_local, just_did(LEFT)), did, all),
		  did_value != ''	=> 	dataset([{did_value}], layout_references),
							PROJECT (get_dids(), doxie.layout_references))(Include_MotorVehicles_val);

FT := Doxie_Raw.Veh_Raw(dids, vin_value, tag_value, vid_value, st_code_value, veh_num_value,
    company_name_value, dateVal, dppa_purpose, glb_purpose, ln_branded_value, ssn_mask_value, dl_mask_value,
    , IsCRS,,application_type_value,IncludeNonRegulatedVehicleSources);

export Vehicle_Search_Local := 
#if(doxie_build.buildstate NOT IN ['PA','PUBLIC'])
dataset([],Layout_VehicleSearch);
#else
FT;
#end