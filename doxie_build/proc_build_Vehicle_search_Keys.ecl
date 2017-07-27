import codes, did_add, didville, VehLic, ut, VehicleCodes, vehicle_wildcard, doxie_files;

pre1 := ut.SF_MaintBuilding('~thor_data400::base::perout'+doxie_build.buildstate);
pre2 := ut.SF_MaintBuilding('~thor_data400::base::vehout'+doxie_build.buildstate);


ut.MAC_SK_BuildProcess(doxie_build.Key_prep_Vehicles,'~thor_data400::key::'+doxie_build.buildstate+'vehiclefull', '~thor_data400::key::'+doxie_build.buildstate+'vehiclefull',a)
ut.MAC_SK_BuildProcess(doxie_build.Key_prep_Vehicle_id,'~thor_data400::key::'+doxie_build.buildstate+'vehicle_id','~thor_data400::key::'+doxie_build.buildstate+'vehicle_id',b)
ut.MAC_SK_BuildProcess(doxie_build.key_prep_vehicle_did,'~thor_data400::key::'+doxie_build.buildstate+'vehicle_did','~thor_data400::key::'+doxie_build.buildstate+'vehicle_did',c)
ut.MAC_SK_BuildProcess(doxie_build.key_prep_vehicle_tag,'~thor_data400::key::'+doxie_build.buildstate+'vehicle_tag','~thor_data400::key::'+doxie_build.buildstate+'vehicle_tag',d)
ut.MAC_SK_BuildProcess(doxie_build.key_prep_vehicle_vin,'~thor_data400::key::'+doxie_build.buildstate+'vehicle_vin','~thor_data400::key::'+doxie_build.buildstate+'vehicle_vin',e )
// ut.MAC_SK_BuildProcess(doxie_build.key_prep_vehicle_bdid,'~thor_data400::key::'+doxie_build.buildstate+'vehicle_bdid','~thor_data400::key::'+doxie_build.buildstate+'vehicle_bdid',f )
ut.MAC_SK_BuildProcess(doxie_files.Key_Vehicle_coName,'~thor_data400::key::'+doxie_build.buildstate+'vehicle_coName','~thor_data400::key::'+doxie_build.buildstate+'vehicle_coName',f )
wc := Vehicle_Wildcard.proc_build_wildcard_search;

post1 := ut.SF_MaintBuilt('~thor_data400::base::perout'+doxie_build.buildstate);
post2 := ut.sf_maintbuilt('~thor_data400::base::vehout'+doxie_build.buildstate);


full1 := if (fileservices.getsuperfilesubname('~thor_data400::base::perout' + doxie_build.buildstate,1) = 
		    fileservices.getsuperfilesubname('~thor_data400::base::perout' + doxie_build.buildstate + '_BUILT',1) AND
		   fileservices.getsuperfilesubname('~thor_data400::base::vehout' + doxie_build.buildstate,1) = 
		    fileservices.getsuperfilesubname('~thor_data400::base::vehout' + doxie_build.buildstate + '_BUILT',1),
		output('BASE = BUILT, Nothing done.'),sequential(a,b,c,d,e,f,wc));
		
export proc_build_Vehicle_search_Keys := sequential(parallel(pre1,pre2),full1,parallel(post1,post2));