import Bair,BairRx_Common,Bair_composite,Bair_Layers;

/*--INFO--
For package deployment testing only.
*/

// Please **DO NOT CHANGE** the number of datasets output by this query, or else it will break automated data deployment. 
// # of datasets currently expected: 18

eyeball := 5;

output(choosen(BairRx_Common.Keys.GeoHash(),eyeball), named('geohash'));
output(choosen(BairRx_Common.Keys.PayloadMOKey(),eyeball), named('event_mo'));
output(choosen(BairRx_Common.Keys.PayloadVehicleKey(),eyeball), named('event_vehicle'));
output(choosen(BairRx_Common.Keys.PayloadPersonKey(),eyeball), named('event_person'));

mo_udf_main := choosen(Bair.Key_Payload_MO_UDF_V2(),eyeball);
mo_udf_delta := choosen(Bair.Key_Payload_MO_UDF_V2(,TRUE),eyeball);
output(choosen(mo_udf_main+mo_udf_delta,eyeball), named('mo_udf'));

per_udf_main := choosen(Bair.Key_Payload_Person_UDF_V2(),eyeball);
per_udf_delta := choosen(Bair.Key_Payload_Person_UDF_V2(,TRUE),eyeball);
output(choosen(per_udf_main+per_udf_delta,eyeball), named('person_udf'));

// V1 keys deprecated
// cfs_v1_main := choosen(Bair.Key_Payload_CFS(),eyeball);
// cfs_v1_delta := choosen(Bair.Key_Payload_CFS(,TRUE),eyeball);
// output(choosen(cfs_v1_main+cfs_v1_delta,eyeball), named('cfs_v1'));

// CFS v2 split - temporarily out
cfs_v2_main := choosen(Bair.Key_Payload_CFS_V2(),eyeball);
cfs_v2_delta := choosen(Bair.Key_Payload_CFS_V2(,TRUE),eyeball);
output(choosen(cfs_v2_main+cfs_v2_delta,eyeball), named('cfs'));

cfs_officer_v2_main := choosen(Bair.Key_Payload_CFS_Officer(),eyeball);
cfs_officer_v2_delta := choosen(Bair.Key_Payload_CFS_Officer(,TRUE),eyeball);
output(choosen(cfs_officer_v2_main+cfs_officer_v2_delta,eyeball), named('cfs_officer'));
// CFS v2 split - temporarily out

// V1 keys deprecated
// crash_v1_main := choosen(Bair.Key_Payload_Crash(),eyeball);
// crash_v1_delta := choosen(Bair.Key_Payload_Crash(,TRUE),eyeball);
// output(choosen(crash_v1_main+crash_v1_delta,eyeball), named('crash_v1'));

crash_main := choosen(Bair.Key_Payload_Crash_V2(),eyeball);
crash_delta := choosen(Bair.Key_Payload_Crash_V2(,TRUE),eyeball);
output(choosen(crash_main+crash_delta,eyeball), named('crash'));

crash_person_main := choosen(Bair.Key_Payload_Crash_Person(),eyeball);
crash_person_delta := choosen(Bair.Key_Payload_Crash_Person(,TRUE),eyeball);
output(choosen(crash_person_main+crash_person_delta,eyeball), named('crash_person'));

crash_vehicle_main := choosen(Bair.Key_Payload_Crash_Vehicle(),eyeball);
crash_vehicle_delta := choosen(Bair.Key_Payload_Crash_Vehicle(,TRUE),eyeball);
output(choosen(crash_vehicle_main+crash_vehicle_delta,eyeball), named('crash_vehicle'));

output(choosen(BairRx_Common.Keys.PayloadLPRKey(),eyeball), named('licenseplate'));

mo_phone_main_V2 := choosen(BairRx_Common.Keys.PayloadKey_MO_PHONE(false),eyeball);
mo_phone_delta_V2 := choosen(BairRx_Common.Keys.PayloadKey_MO_PHONE(true),eyeball);
output(choosen(mo_phone_main_V2+mo_phone_delta_V2,eyeball), named('mo_phone'));

mo_eid_main_V2 := choosen(BairRx_Common.Keys.PayloadKey_MO_EID(false),eyeball);
mo_eid_delta_V2 := choosen(BairRx_Common.Keys.PayloadKey_MO_EID(true),eyeball);
output(choosen(mo_eid_main_V2+mo_eid_delta_V2,eyeball), named('mo_eid'));

output(choosen(BairRx_Common.Keys.GroupAccessKey,eyeball), named('group_access'));
output(choosen(BairRx_Common.Keys.DataProviderKey,eyeball), named('data_provider'));


// Intel_main := choosen(Bair.Key_Payload_Intel(),eyeball);
// Intel_delta := choosen(Bair.Key_Payload_Intel(,TRUE),eyeball);
// output(choosen(Intel_main+Intel_delta,eyeball), named('Intel'));


// Intel_main_V2 := choosen(Bair.Key_Payload_Intel_V2(),eyeball);
// Intel_delta_V2 := choosen(Bair.Key_Payload_Intel_V2(,TRUE),eyeball);
// output(choosen(Intel_main_V2+Intel_delta_V2,eyeball), named('Intel_V2'));

Layer_Search := choosen(Bair_Layers.Key_AgencyLayer_Search(),eyeball);
output(choosen(Layer_Search,eyeball), named('Layer_Search'));

Layer_Payload := choosen(Bair_Layers.Key_AgencyLayer_Payload().IDX,eyeball);
output(choosen(Layer_Payload,eyeball), named('Layer_Payload'));
// 
// --> temporarily disabling the ones below to promote new v2 keys.
//
// output(choosen(BairRx_Common.Keys.PayloadSSKey(),eyeball), named('shotspotter'));
// output(choosen(BairRx_Common.Keys.PayloadOffenderKey(),eyeball), named('offenders'));
// output(choosen(BairRx_Common.Keys.PayloadIntelKey(),eyeball), named('intel'));
// output(choosen(BairRx_Common.Keys.ImageKey().IDX,eyeball), named('images'));
// output(choosen(BairRx_Common.Keys.NotesKey().IDX,eyeball), named('notes'));
//output(choosen(BairRx_Common.Keys.ClassificationKey(),eyeball), named('classification'));