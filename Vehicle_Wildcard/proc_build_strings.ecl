import ut, doxie, vehlic, doxie_build,VehicleV2, doxie_files,RoxieKeyBuild,NID,PromoteSupers;

export proc_build_strings(string filedate) := function

/* *************** Combine all strings into one big dataset ****************** */
StringRecord :=
RECORD
	STRING36 str;
END;

StringRecord justString(STRING s, BOOLEAN doPF, INTEGER len) :=
TRANSFORM
	SELF.str := IF(doPF, NID.PreferredFirstVersionedStr(StringLib.StringToUpperCase(TRIM(TRIM(s, LEFT), RIGHT)),NID.version),
										StringLib.StringToUpperCase(TRIM(TRIM(s, LEFT), RIGHT)))[1..len];
END;

//model_descriptionTable := PROJECT(VehicleV2.file_VehicleV2_main, justString(if(LEFT.VINA_Model_Desc<>'', trim(LEFT.VINA_Model_Desc,left, right) + ' ' + trim(LEFT.VINA_Series_Desc,left, right), LEFT.Orig_Model_Desc),false, 36));
//Exclude Infutor data from wildcard search base file
model_descriptionTable := PROJECT(VehicleV2.file_VehicleV2_main/*(source_code not in ['1V','2V'])*/, justString(if(LEFT.VINA_Model_Desc<>'', trim(LEFT.VINA_Model_Desc,left, right) + ' ' + trim(LEFT.VINA_Series_Desc,left, right), LEFT.Orig_Model_Desc),false, 36));

/*
fNameTable := PROJECT(VehicleV2.file_VehicleV2_Party, justString(LEFT.Append_Clean_Name.fname, true, 20));
mNameTable := PROJECT(VehicleV2.file_VehicleV2_Party, justString(LEFT.Append_Clean_Name.mname, true, 20));
lNameTable := PROJECT(VehicleV2.file_VehicleV2_Party, justString(LEFT.Append_Clean_Name.lname, false, 20));
CompanyTable := PROJECT(VehicleV2.file_VehicleV2_Party, justString(LEFT.Append_Clean_CName, false, 20));

NameStrings := fNameTable + mNameTable + lNameTable + CompanyTable;

*/
blank_entry := dataset([{''}],StringRecord);

//dedupNames := DEDUP(NameStrings(str != '')+blank_entry, str, ALL);

dedupModels := DEDUP(model_descriptionTable(str != '')+blank_entry, str, ALL);

Layout_makeIndex := {string10 makecode , UNSIGNED2 i}; 
Layout_bodystyleIndex := {string2 body_style, string50 body_style_description, string20 category, UNSIGNED2 i};

Make_code  := dedup(project(VehicleV2.Files.base.picker , transform({string makecode}, self := left))+ VehicleV2.Files.base.MakeConst , makecode,all) ; 
Body_style := dedup(project(VehicleV2.Files.base.Picker_BodyStyle , transform(Layout_bodystyleIndex , self.body_style := left.body_style , self.body_style_description := left.body_style_description,self.i := 0,self.category :=left.category)),all) ; 

/* *************** Assigned indices ****************** */
//ut.MAC_Sequence_Records_NewRec(dedupNames, Layout_NameIndex, i, baseNameIndex)
ut.MAC_Sequence_Records_NewRec(dedupModels, Layout_ModelIndex, i, baseModelIndex)
ut.MAC_Sequence_Records_NewRec(Make_code,   Layout_makeIndex, i, baseMakeIndex)
ut.MAC_Sequence_Records_NewRec(Body_style,   Layout_bodystyleIndex, i, basebodyIndex);

/* *************** Output Base Files and Indices ****************** */
//ut.MAC_SF_BuildProcess(baseNameIndex,  '~thor_data400::WC_Vehicle::NameBase_' + doxie_build.buildstate,  do1)
PromoteSupers.MAC_SF_BuildProcess(baseModelIndex, '~thor_data400::WC_Vehicle::ModelBase_' + doxie_build.buildstate, do2)
PromoteSupers.MAC_SF_BuildProcess(baseMakeIndex,  '~thor_data400::base::WC_Vehicle::Make', do7)
PromoteSupers.MAC_SF_BuildProcess(basebodyIndex,  '~thor_data400::base::WC_Vehicle::BodyStyle', do10);


// todo: make sure File_NameIndex and File_ModelIndex are full

/*name_index_index := index(File_NameIndex, {str, i}, 
							'~thor_data400::WC_Vehicle::KeyNameIndex_' + doxie_build.buildstate + '_' + doxie.Version_SuperKey);*/
model_index_index := index(File_ModelIndex, {str, i}, 
							'~thor_data400::WC_Vehicle::KeyModelIndex_' + doxie_build.buildstate + '_' + doxie.Version_SuperKey);

/*RoxieKeyBuild.MAC_SK_BuildProcess_Local(name_index_index,'~thor_data400::key::vehicle::'+filedate+'::keynameindex_' + doxie_build.buildstate, 
								'~thor_data400::WC_Vehicle::KeyNameIndex_' + doxie_build.buildstate, do3);
*/
RoxieKeyBuild.MAC_SK_BuildProcess_Local(model_index_index,'~thor_data400::key::vehicle::'+filedate+'::keymodelindex_' + doxie_build.buildstate, 
								 '~thor_data400::WC_Vehicle::KeyModelIndex_' + doxie_build.buildstate, do4);

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Vehicle_Wildcard.Key_Make,'~thor_data400::key::WC_Vehicle::'+filedate+'::make' , 
								 '~thor_data400::Key::WC_Vehicle::Make' , do8);

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Vehicle_Wildcard.Key_BodyStyle,'~thor_data400::key::WC_Vehicle::'+filedate+'::BodyStyle' , 
								 '~thor_data400::Key::WC_Vehicle::BodyStyle' , do11);
								 
/*RoxieKeyBuild.MAC_SK_Move_To_Built('~thor_data400::key::vehicle::'+filedate+'::keynameindex_' + doxie_build.buildstate, 
								'~thor_data400::WC_Vehicle::KeyNameIndex_' + doxie_build.buildstate, do5);*/

RoxieKeyBuild.MAC_SK_Move_To_Built('~thor_data400::key::vehicle::'+filedate+'::keymodelindex_' + doxie_build.buildstate, 
								 '~thor_data400::WC_Vehicle::KeyModelIndex_' + doxie_build.buildstate, do6);

RoxieKeyBuild.MAC_SK_Move_To_Built('~thor_data400::key::WC_Vehicle::'+filedate+'::make' , 
								 '~thor_data400::Key::WC_Vehicle::Make' , do9);
								 
RoxieKeyBuild.MAC_SK_Move_To_Built('~thor_data400::key::WC_Vehicle::'+filedate+'::bodystyle' , 
								 '~thor_data400::Key::WC_Vehicle::bodystyle' , do12);
								 
build_key := sequential(do2,do7,do10, parallel(do4,do8,do11),parallel(do6,do9,do12));

return build_key ;

end ; 
