import doxie, business_header, doxie_build, doxie_raw;

//everything is defined in doxie.MAC_Header_Field_Declare, except "company_name_value"
Business_Header.doxie_MAC_Field_Declare()
mod_access := doxie.compliance.GetGlobalDataAccessModule();

doxie.MAC_Selection_Declare()
qstring25 vid_value := '' : STORED('VID');
string2 st_code_value := '' : STORED('StateCode');
string20 veh_num_value := '' : STORED('VehicleNumber');


doxie.layout_references just_did(dl_search_local le) :=
TRANSFORM
  SELF.did := le.did;
END;

dids := MAP(dl_value != '' => DEDUP(PROJECT(dl_search_local, just_did(LEFT)), did, all),
            did_value != '' => dataset([{did_value}], layout_references),
            PROJECT (get_dids(), doxie.layout_references))(Include_MotorVehicles_val);

FT := Doxie_Raw.Veh_Raw(dids, mod_access,
                        vin_value, tag_value, vid_value, st_code_value, veh_num_value,
                        company_name_value, , , IncludeNonRegulatedVehicleSources);

export Vehicle_Search_Local :=
#if(doxie_build.buildstate NOT IN ['PA','PUBLIC'])
dataset([],Layout_VehicleSearch);
#else
FT;
#end
