// comment move keys in autokey.mac_build_version before running this code.
import standard,AutoKeyB2,roxiekeybuild, vehiclev2, Vehicle_Wildcard,doxie_build,doxie,address_attributes,_control;
 
export Proc_Test_keys(string filedate) := function

dParty := Vehiclev2.File_VehicleV2_Party;

string_rec := record
	dParty.Vehicle_Key;
	dParty.Iteration_Key;
	dParty.Sequence_Key;
	unsigned1 zero := 0;
	unsigned4 lookup_bit := 0;
	dParty.source_code;
	dParty.Append_DID;
	dParty.Append_BDID;
	dParty.Append_Clean_CName;
	dParty.Append_SSN;
	dParty.Append_FEIN;
	standard.Addr company_addr;
	standard.Addr person_addr;
	standard.Name person_name;
	dParty.Orig_Name_Type;
	dParty.history;
	
	unsigned4 Reg_Latest_Effective_Date;
	unsigned4 Reg_Latest_Expiration_Date;
	unsigned4 Ttl_Latest_Issue_Date;	
end;

d2 := dataset([],string_rec);

skip_set := ['P','Q','N'];

vdidds := pull(vehiclev2.key_vehicle_DID)(Append_DID = 0);
vdid := index(vdidds, {Append_DID, is_minor}, {Vehicle_Key,Iteration_Key,Sequence_Key},
	   '~thor_data400::key::VehicleV2::DID_'+ doxie.Version_SuperKey);
	   
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vdid,'~thor_data400::key::vehiclev2::custtest::did','~thor_data400::key::vehiclev2::custtest::'+filedate+'::DID',vehicle_DID_key);


vbdidds := pull(vehiclev2.key_vehicle_BDID)(Append_BDID = 0);
vbdid := index(vbdidds, {Append_BDID}, {Vehicle_Key,Iteration_Key,Sequence_Key},
       '~thor_data400::key::VehicleV2::BDID_'+ doxie.Version_SuperKey);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vbdid,'~thor_data400::key::vehiclev2::custtest::bdid','~thor_data400::key::vehiclev2::custtest::'+filedate+'::BDID',vehicle_BDID_key);

vdlds := pull(vehiclev2.key_vehicle_DL_Number)(dl_number = '');
vdl := index(vdlds, {DL_number, state_origin,is_minor}, {Vehicle_Key,Iteration_Key,Sequence_Key},
'~thor_data400::key::VehicleV2::dl_number_'+ doxie.Version_SuperKey);
	   
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vdl,'~thor_data400::key::vehiclev2::custtest::dl_number','~thor_data400::key::vehiclev2::custtest::'+filedate+'::DL_Number',vehicle_DL_Number_key);

vlplateds := pull(vehiclev2.key_vehicle_Lic_Plate)(license_plate = '');

vlplate := index(vlplateds, {license_plate, state_origin,dph_lname,pfname,is_minor}, {vlplateds},
'~thor_data400::key::VehicleV2::lic_plate_'+ doxie.Version_SuperKey);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vlplate,'~thor_data400::key::vehiclev2::custtest::Lic_Plate','~thor_data400::key::vehiclev2::custtest::'+filedate+'::Lic_Plate',vehicle_Lic_Plate_key);

vrlplateds := pull(vehiclev2.key_vehicle_reverse_Lic_Plate)(reverse_license_plate = '');

vrlplate := index(vrlplateds, {reverse_license_plate, state_origin,dph_lname,pfname,is_minor}, {vrlplateds},
'~thor_data400::key::VehicleV2::reverse_lic_plate_'+ doxie.Version_SuperKey);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vrlplate,'~thor_data400::key::vehiclev2::custtest::reverse_Lic_Plate','~thor_data400::key::vehiclev2::custtest::'+filedate+'::reverse_Lic_Plate',vehicle_reverse_Lic_Plate_key);

vmkeyds := pull(vehiclev2.key_vehicle_MAIN_Key)(vehicle_key = '' and iteration_key = '');

vmkey := index(vmkeyds, {Vehicle_Key, iteration_key}, {vmkeyds},
'~thor_data400::key::vehicleV2::main_Key_'+ doxie.Version_SuperKey);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vmkey,'~thor_data400::key::vehiclev2::custtest::MAIN_Key','~thor_data400::key::vehiclev2::custtest::'+filedate+'::MAIN_Key',vehicle_MAIN_Key);

vinkeyds := pull(vehiclev2.key_vehicle_VIN)(vin = '');

vinkey := index(vinkeyds, {VIN, state_origin}, {Vehicle_Key,Iteration_Key},
'~thor_data400::key::VehicleV2::VIN_'+ doxie.Version_SuperKey);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vinkey,'~thor_data400::key::vehiclev2::custtest::VIN','~thor_data400::key::vehiclev2::custtest::'+filedate+'::VIN',vehicle_VIN_key);

vpkeyds := pull(vehiclev2.key_vehicle_Party_Key)(vehicle_key = '' and iteration_key = '');

vpkey := index(	vpkeyds,
																					{Vehicle_Key, iteration_key, sequence_key}, {vpkeyds},
																					'~thor_data400::key::vehicleV2::party_Key_'+ doxie.Version_SuperKey
																				);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vpkey,'~thor_data400::key::vehiclev2::custtest::Party_Key','~thor_data400::key::vehiclev2::custtest::'+filedate+'::Party_Key',vehicle_Party_Key);


//RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vehiclev2.key_vehicle_SSN,'~thor_data400::key::vehiclev2::custtest::SSN','~thor_data400::key::vehiclev2::custtest::'+filedate+'::SSN',vehicle_SSN_key);
//Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vehiclev2::custtest::SSN', '~thor_data400::key::vehiclev2::custtest::'+filedate+'::SSN', mv_SSN_key);

vtnumberds :=  pull(vehiclev2.key_vehicle_Title_Number)(ttl_number = '');

vtnumber := index(vtnumberds, {ttl_number, state_origin}, {Vehicle_Key,Iteration_Key,Sequence_Key},
'~thor_data400::key::VehicleV2::title_number_'+ doxie.Version_SuperKey);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vtnumber,'~thor_data400::key::vehiclev2::custtest::Title_Number','~thor_data400::key::vehiclev2::custtest::'+filedate+'::Title_Number',vehicle_Title_Number_key);


vbvds := pull(vehiclev2.Key_BocaShell_Vehicles)(did = 0);

vbv := index (vbvds, {did}, {vbvds},
                                             '~thor_data400::key::vehicleV2::bocashell_did_' + doxie.Version_SuperKey);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vbv,'~thor_data400::key::vehiclev2::custtest::bocashell_did','~thor_data400::key::vehiclev2::custtest::'+filedate+'::bocashell_did',bocashell_did_key);

licplateblurds := pull(vehiclev2.Key_Vehicle_Lic_Plate_Blur)(license_plate_blur = '');

key_ct_lpb := index(licplateblurds,{license_plate_blur}, {licplateblurds},
	'~thor_data400::key::VehicleV2::lic_plate_blur_'+ doxie.Version_SuperKey);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key_ct_lpb
,'~thor_data400::key::vehiclev2::lic_plate_blur','~thor_data400::key::vehiclev2::custtest::'+filedate+'::lic_plate_blur',lic_plate_blur);

addrkeyds := pull(Address_Attributes.key_vehicles_addr)(zip5 = '');

addrkey := index(	addrkeyds,
																			{zip5,prim_range,prim_name,suffix,predir},
																			{addrkeyds},
																			'~thor_data400::key::vehiclev2::vehicles_address_'	+	doxie.Version_SuperKey
																		);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(addrkey,'~thor_data400::key::vehiclev2::vehicles_address','~thor_data400::key::vehiclev2::custtest::'+filedate+'::vehicles_address',vehicle_addr_key);

keymids := pull(vehicle_wildcard.Key_ModelIndex)(str = '');
keymi := index(keymids,{str}, {i},
		'~thor_data400::WC_Vehicle::KeyModelIndex_' + doxie_build.buildstate +'_'+ doxie.Version_SuperKey);

RoxieKeyBuild.MAC_SK_BuildProcess_Local(keymi,'~thor_data400::key::vehicle::custtest::'+filedate+'::keymodelindex_' + doxie_build.buildstate, 
								 '~thor_data400::WC_Vehicle::KeyModelIndex_' + doxie_build.buildstate, do4);

keynmds := pull(vehicle_wildcard.Key_NameIndex)(str = '');
keynm := index(keynmds, {str},{i}, 
		'~thor_data400::WC_Vehicle::KeyNameIndex_' + doxie_build.buildstate +'_' + doxie.Version_SuperKey);

RoxieKeyBuild.MAC_SK_BuildProcess_Local(keynm,'~thor_data400::key::vehicle::custtest::'+filedate+'::keynameindex_' + doxie_build.buildstate, 
								'~thor_data400::WC_Vehicle::KeyNameIndex_' + doxie_build.buildstate, do3);


c1 := output(dataset([],Vehicle_Wildcard.Layout_Hole_Veh),,'~thor_data400::data::vehicle::custtest::'+filedate+'::wildcard_' + doxie_build.buildstate, overwrite);



VehicleV2.Mac_Test_Build (d2,person_name.fname,person_name.mname,person_name.lname,
						Append_ssn,
						zero,
						zero,
						person_addr.prim_name,person_addr.prim_range,person_addr.st,person_addr.v_city_name,person_addr.zip5,person_addr.sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						lookup_bit,
						Append_DID,
						Append_Clean_CName,
						Append_FEIN,
						zero,
						company_addr.prim_name,company_addr.prim_range,company_addr.st,company_addr.v_city_name,company_addr.zip5,company_addr.sec_range,
						Append_BDID,
						Vehiclev2.Cluster.cluster_out + 'key::vehiclev2::custtest::autokey::',
						Vehiclev2.cluster.cluster_out + 'key::vehiclev2::custtest::' +filedate+ '::autokey::',
						outaction,false,
						skip_set,true,'BC',
						true,,,zero); 



Email_Recipients := 'Anantha.Venkatachalam@lexisnexis.com,Ayeesha.Kayttala@lexisnexis.com';

build_keys := sequential(parallel(
              vehicle_DID_key,
							vehicle_BDID_key,
							vehicle_DL_Number_key,
							//vehicle_FEIN_key,mv_FEIN_key,
							vehicle_Lic_Plate_key,
							vehicle_reverse_lic_plate_key, 
							vehicle_MAIN_Key,
							vehicle_VIN_Key,
							vehicle_Party_Key,
							//vehicle_SSN_Key,mv_SSN_Key,
							vehicle_Title_Number_Key,
							bocashell_did_key,
							lic_plate_blur,
							vehicle_addr_key,
							do3,
							do4,
							c1,
							outaction
							
							),
							// Create orbitI build instance
						VehicleV2.Proc_OrbitI_CreateBuild(filedate,'test'),
	
						// Update DOPS in Alpharetta
						RoxieKeyBuild.updateversion('VehicleV2Keys',filedate,Email_Recipients,,'T',,,'A')
	
							);
						
return build_keys;

end;