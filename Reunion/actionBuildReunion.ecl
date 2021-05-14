IMPORT PromoteSupers, STD, Orbit3;

EXPORT actionBuildReunion(UNSIGNED1 mode, STRING sVersion, STRING feedversion) := MODULE

sprayFiles   := Reunion.mSpray(mode).actionSprayFiles(feedversion, sVersion);
desprayFiles := Reunion.mSpray(mode).actionDesprayAll;

actionBuildSEOFile := reunion.actionBuildSEO(mode, sVersion).all;
dCustomerDB:=reunion.mapping_reunion_customer_database(mode, sVersion);
dThirdPartyDB:=reunion.mapping_reunion_third_party_database(mode, sVersion);
actionBuildMainWAttributes := reunion.mapping_reunion_attributes(mode, sVersion).all;
dMain:=DISTRIBUTE(reunion.mapping_reunion_main(mode, sVersion).all,HASH(adl));
dOldAddresses:=reunion.mapping_reunion_old_addresses(mode, sVersion).all;
dRelatives:=DISTRIBUTE(reunion.mapping_reunion_relatives(mode, sVersion).all,HASH(main_adl));
dMainDist:= DEDUP(dMain(TRIM(date_of_death)='' AND get_other_elements=TRUE),adl,LOCAL);
dAliases:=reunion.mapping_reunion_alias(mode, sVersion).all;
dAdlScore:=reunion.mapping_reunion_adl_score(mode, sVersion).all;
dEmail:=reunion.mapping_reunion_email(mode, sVersion).all;
dCollege:=reunion.mapping_reunion_college(mode, sVersion).all;
dDeeds:=reunion.mapping_reunion_deed(mode, sVersion).all;
dTax:=reunion.mapping_reunion_tax(mode, sVersion).all;
dFlags:=reunion.mapping_indicator_flags(mode, sVersion).all;

dMainFiltered := PROJECT(dMain(get_other_elements=TRUE),reunion.layouts.lMain);
dAttributes   := reunion.fn_attributes(mode, dMain(get_other_elements=TRUE));

j1:=JOIN(dRelatives,dMainDist,LEFT.main_adl=RIGHT.adl,TRANSFORM(reunion.layouts.lRelatives,SELF:=LEFT;),LOCAL);

sPrefix := '~thor::base::mylife::' + reunion.Constants.sMode(mode) + '::';
sFile(record_type) := sPrefix + reunion.Constants.sFile(record_type);

PromoteSupers.MAC_SF_BuildProcess(DEDUP(dCustomerDB,RECORD,ALL),sFile(1),actionBuildCustomerDB,2,,true);
PromoteSupers.MAC_SF_BuildProcess(DEDUP(dThirdPartyDB,RECORD,ALL),sFile(2),actionBuildThirdPartyDB,2,,true);
PromoteSupers.MAC_SF_BuildProcess(DEDUP(dMainFiltered, RECORD, ALL),sFile(3),actionBuildMain,2,,true);
PromoteSupers.MAC_SF_BuildProcess(DEDUP(dOldAddresses,RECORD,ALL),sFile(4),actionBuildOldAddresses,2,,true);
PromoteSupers.MAC_SF_BuildProcess(DEDUP(j1,RECORD,ALL),sFile(5),actionBuildRelatives,2,,true);
PromoteSupers.MAC_SF_BuildProcess(DEDUP(dAliases,RECORD,ALL),sFile(6),actionBuildAliases,2,,true);
PromoteSupers.MAC_SF_BuildProcess(dAdlScore,sFile(7),actionBuildAdlScore,2,,true);
PromoteSupers.MAC_SF_BuildProcess(dEmail,sFile(8),actionBuildEmail,2,,true);
PromoteSupers.MAC_SF_BuildProcess(dCollege,sFile(9),actionBuildCollege,2,,true);
PromoteSupers.MAC_SF_BuildProcess(dDeeds,sFile(10),actionBuildDeeds,2,,true);
PromoteSupers.MAC_SF_BuildProcess(dTax,sFile(11),actionBuildTax,2,,true);
PromoteSupers.Mac_SF_BuildProcess(dFlags,sFile(12),actionBuildFlags,2,,true);
PromoteSupers.MAC_SF_BuildProcess(dAttributes,sFile(13),actionBuildAttributes,2,,true);

seq_core := SEQUENTIAL(
	Reunion.mac_runIfNotCompleted ('Reunion',sVersion, actionBuildMainWAttributes, 210),
	Reunion.mac_runIfNotCompleted ('Reunion',sVersion, actionBuildMain,220),
	Reunion.mac_runIfNotCompleted ('Reunion',sVersion, actionBuildAttributes,225),
	// Reunion.mac_runIfNotCompleted ('Reunion',sVersion, actionBuildRelatives,230),
	// Reunion.mac_runIfNotCompleted ('Reunion',sVersion, actionBuildOldAddresses,240),
	// Reunion.mac_runIfNotCompleted ('Reunion',sVersion, actionBuildAliases,250),
	// Reunion.mac_runIfNotCompleted ('Reunion',sVersion, actionBuildAdlScore,260),
	// Reunion.mac_runIfNotCompleted ('Reunion',sVersion, actionBuildEmail,270),
	// Reunion.mac_runIfNotCompleted ('Reunion',sVersion, actionBuildCollege,280),
	// Reunion.mac_runIfNotCompleted ('Reunion',sVersion, actionBuildDeeds,290),
	// Reunion.mac_runIfNotCompleted ('Reunion',sVersion, actionBuildTax,300),
	// Reunion.mac_runIfNotCompleted ('Reunion',sVersion, actionBuildFlags,310)
);

seq_full := SEQUENTIAL(
	//- Reunion.mac_runIfNotCompleted ('Reunion',sVersion, sprayFiles,100),
	//- Reunion.mac_runIfNotCompleted ('Reunion',sVersion, actionBuildSEOFile, 105),
	// Reunion.mac_runIfNotCompleted ('Reunion',sVersion, actionBuildCustomerDB,110),
    // Reunion.mac_runIfNotCompleted ('Reunion',sVersion, actionBuildThirdPartyDB,120),
	// seq_core,
	Reunion.mac_runIfNotCompleted ('Reunion',sVersion, desprayFiles,400)
);
										
EXPORT all := SEQUENTIAL(
	Reunion._config.set_v_version(sVersion),
	Reunion._config.set_feed_version(feedversion),
	if(mode = 1
	,SEQUENTIAL(output('QUARTERLY - FULL BUILD'), seq_full)
	,SEQUENTIAL(output('MONTHLY - CORE BUILD'), seq_core)	
	),
	// Orbit3.Proc_Orbit3_CreateBuild_npf('MyLife',sVersion)
);

END;