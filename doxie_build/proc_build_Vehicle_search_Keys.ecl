import RoxieKeyBuild,codes, did_add, didville, VehLic, ut, VehicleCodes, vehicle_wildcard, doxie_files,doxie;
export proc_build_vehicle_search_keys(string filedate) := 
function

pre1 := ut.SF_MaintBuilding('~thor_data400::base::perout'+doxie_build.buildstate);
pre2 := ut.SF_MaintBuilding('~thor_data400::base::vehout'+doxie_build.buildstate);


//RoxieKeyBuild.MAC_SK_BuildProcess_Local(doxie_build.Key_prep_Vehicles,'~thor_data400::key::vehicle::'+filedate+'::'+doxie_build.buildstate+'vehiclefull', '~thor_data400::key::'+doxie_build.buildstate+'vehiclefull',a);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (doxie_Files.Key_Vehicles, '~thor_data400::key::'+doxie_build.buildstate+'vehiclefull', '~thor_data400::key::vehicle::'+filedate+'::'+doxie_build.buildstate+'vehiclefull',a);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (doxie_Files.Key_Vehicles_FCRA, '~thor_data400::key::vehicle::fcra::full', '~thor_data400::key::vehicle::fcra::' + filedate + '::full', a2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(doxie_build.Key_prep_Vehicle_id,'~thor_data400::key::vehicle::'+filedate+'::'+doxie_build.buildstate+'vehicle_id','~thor_data400::key::'+doxie_build.buildstate+'vehicle_id',b);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(doxie_build.key_prep_vehicle_did,'~thor_data400::key::vehicle::'+filedate+'::'+doxie_build.buildstate+'vehicle_did','~thor_data400::key::'+doxie_build.buildstate+'vehicle_did',c);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (doxie_files.key_vehicle_did_FCRA, '~thor_data400::key::vehicle::fcra::did','~thor_data400::key::vehicle::fcra::' + filedate + '::did', c2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(doxie_build.key_prep_vehicle_tag,'~thor_data400::key::vehicle::'+filedate+'::'+doxie_build.buildstate+'vehicle_tag','~thor_data400::key::'+doxie_build.buildstate+'vehicle_tag',d);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(doxie_build.key_prep_vehicle_vin,'~thor_data400::key::vehicle::'+filedate+'::'+doxie_build.buildstate+'vehicle_vin','~thor_data400::key::'+doxie_build.buildstate+'vehicle_vin',e );
RoxieKeyBuild.Mac_SK_BuildProcess_Local(doxie_build.key_prep_vehicle_bdid,'~thor_data400::key::vehicle::'+filedate+'::'+doxie_build.buildstate+'vehicle_bdid','~thor_data400::key::'+doxie_build.buildstate+'vehicle_bdid',h );
RoxieKeyBuild.Mac_SK_BuildProcess_Local(doxie_files.Key_Vehicle_coName,'~thor_data400::key::vehicle::'+filedate+'::'+doxie_build.buildstate+'vehicle_coName','~thor_data400::key::'+doxie_build.buildstate+'vehicle_coName',f );
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(doxie_files.Key_Vehicle_St_VNum,'~thor_data400::key::'+doxie_build.buildstate+'vehicle_st_vnum','~thor_data400::key::vehicle::'+filedate+'::'+doxie_build.buildstate+'vehicle_st_vnum',g);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(doxie_files.Key_BocaShell_Vehicles,'~thor_data400::key::bocashell_veh_did','~thor_data400::key::vehicle::'+filedate+'::bocashell_did',g2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(doxie_files.Key_BocaShell_Vehicles_FCRA,'~thor_data400::key::vehicle::fcra::bocashell.did','~thor_data400::key::vehicle::fcra::' + filedate + '::bocashell.did', g3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(doxie_files.Key_Vehicle_Vin_FCRA,'~thor_data400::key::fcra::'+doxie_build.buildstate+'vehicle_vin_'+doxie.Version_SuperKey,'~thor_data400::key::vehicle::fcra::'+filedate+'::vehicle_vin', g4);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(doxie_files.key_vehicle_addr,'~thor_data400::key::'+doxie_build.buildstate+'vehicle_addr_'+doxie.Version_SuperKey,'~thor_data400::key::vehicle::'+filedate+'::vehicle_addr', g5);


RoxieKeyBuild.Mac_SK_diff(doxie_files.Key_Vehicle_St_VNum,'~thor_data400::key::'+doxie_build.buildstate+'vehicle_st_vnum','~thor_data400::key::vehicle::'+filedate+'::'+doxie_build.buildstate+'vehicle_st_vnum',i);

RoxieKeyBuild.MAC_SK_Move_to_Built_v2('~thor_data400::key::'+doxie_build.buildstate+'vehiclefull','~thor_data400::key::vehicle::'+filedate+'::'+doxie_build.buildstate+'vehiclefull', j);
RoxieKeyBuild.Mac_SK_Move_to_Built('~thor_data400::key::vehicle::'+filedate+'::'+doxie_build.buildstate+'vehicle_id','~thor_data400::key::'+doxie_build.buildstate+'vehicle_id',k);
RoxieKeyBuild.Mac_SK_Move_to_Built('~thor_data400::key::vehicle::'+filedate+'::'+doxie_build.buildstate+'vehicle_did','~thor_data400::key::'+doxie_build.buildstate+'vehicle_did',l);
RoxieKeyBuild.Mac_SK_Move_to_Built('~thor_data400::key::vehicle::'+filedate+'::'+doxie_build.buildstate+'vehicle_tag','~thor_data400::key::'+doxie_build.buildstate+'vehicle_tag',m);
RoxieKeyBuild.Mac_SK_Move_to_Built('~thor_data400::key::vehicle::'+filedate+'::'+doxie_build.buildstate+'vehicle_vin','~thor_data400::key::'+doxie_build.buildstate+'vehicle_vin',n );
RoxieKeyBuild.Mac_SK_Move_to_Built('~thor_data400::key::vehicle::'+filedate+'::'+doxie_build.buildstate+'vehicle_bdid','~thor_data400::key::'+doxie_build.buildstate+'vehicle_bdid',o );
RoxieKeyBuild.Mac_SK_Move_to_Built('~thor_data400::key::vehicle::'+filedate+'::'+doxie_build.buildstate+'vehicle_coName','~thor_data400::key::'+doxie_build.buildstate+'vehicle_coName',p );
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::'+doxie_build.buildstate+'vehicle_st_vnum','~thor_data400::key::vehicle::'+filedate+'::'+doxie_build.buildstate+'vehicle_st_vnum',q);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bocashell_veh_did','~thor_data400::key::vehicle::'+filedate+'::bocashell_did',q2);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vehicle::fcra::bocashell.did','~thor_data400::key::vehicle::fcra::' + filedate + '::bocashell.did', q3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 ('~thor_data400::key::vehicle::fcra::did','~thor_data400::key::vehicle::fcra::' + filedate + '::did', q4);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 ('~thor_data400::key::vehicle::fcra::full', '~thor_data400::key::vehicle::fcra::' + filedate + '::full', q5);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 ('~thor_data400::key::fcra::publicvehicle_vin', '~thor_data400::key::vehicle::fcra::'+filedate+'::vehicle_vin', q6);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 ('~thor_data400::key::'+doxie_build.buildstate+'vehicle_addr', '~thor_data400::key::vehicle::'+filedate+'::vehicle_addr', q7);



wc := Vehicle_Wildcard.proc_build_wildcard_search;

post1 := ut.SF_MaintBuilt('~thor_data400::base::perout'+doxie_build.buildstate);
post2 := ut.sf_maintbuilt('~thor_data400::base::vehout'+doxie_build.buildstate);


full1 := if (fileservices.getsuperfilesubname('~thor_data400::base::perout' + doxie_build.buildstate,1) = 
		    fileservices.getsuperfilesubname('~thor_data400::base::perout' + doxie_build.buildstate + '_BUILT',1) AND
		   fileservices.getsuperfilesubname('~thor_data400::base::vehout' + doxie_build.buildstate,1) = 
		    fileservices.getsuperfilesubname('~thor_data400::base::vehout' + doxie_build.buildstate + '_BUILT',1),
		output('BASE = BUILT, Nothing done.'),sequential(parallel(a,a2,b,c,c2,d,e,f,g,g2,g3,g4,g5,h),i,parallel(j,k,l,m,n,o,p,q,q2,q3,q4,q5,q6,q7),wc));
		
return sequential(parallel(pre1,pre2),full1,parallel(post1,post2));

end;