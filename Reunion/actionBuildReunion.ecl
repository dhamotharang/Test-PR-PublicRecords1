IMPORT ut;

dCustomerDB:=reunion.mapping_reunion_customer_database;
dThirdPartyDB:=reunion.mapping_reunion_third_party_database;
dMain:=DISTRIBUTE(reunion.mapping_reunion_main,HASH(adl));
dOldAddresses:=reunion.mapping_reunion_old_addresses;
dRelatives:=DISTRIBUTE(reunion.mapping_reunion_relatives,HASH(main_adl));
dMainDist:= DEDUP(dMain(TRIM(date_of_death)='' AND get_other_elements=TRUE),adl,LOCAL);
dAliases:=reunion.mapping_reunion_alias;
dAdlScore:=reunion.mapping_reunion_adl_score;
dEmail:=reunion.mapping_reunion_email;
dCollege:=reunion.mapping_reunion_college;
dDeeds:=reunion.mapping_reunion_deed;
dTax:=reunion.mapping_reunion_tax;
dFlags:=reunion.mapping_indicator_flags;

dMainFiltered:=PROJECT(dMain(get_other_elements=TRUE),reunion.layouts.lMain);

j1:=JOIN(dRelatives,dMainDist,LEFT.main_adl=RIGHT.adl,TRANSFORM(reunion.layouts.lRelatives,SELF:=LEFT;),LOCAL);

ut.MAC_SF_BuildProcess(DEDUP(dCustomerDB,RECORD,ALL),'~thor::base::mylife::customer_database',actionBuildCustomerDB,2,,true);
ut.MAC_SF_BuildProcess(DEDUP(dThirdPartyDB,RECORD,ALL),'~thor::base::mylife::third_party_database',actionBuildThirdPartyDB,2,,true);
ut.MAC_SF_BuildProcess(DEDUP(dMainFiltered,RECORD,ALL),'~thor::base::mylife::main',actionBuildMain,2,,true);
ut.MAC_SF_BuildProcess(DEDUP(dOldAddresses,RECORD,ALL),'~thor::base::mylife::old_addresses',actionBuildOldAddresses,2,,true);
ut.MAC_SF_BuildProcess(DEDUP(j1,RECORD,ALL),'~thor::base::mylife::relatives',actionBuildRelatives,2,,true);
ut.MAC_SF_BuildProcess(DEDUP(dAliases,RECORD,ALL),'~thor::base::mylife::alias',actionBuildAliases,2,,true);
ut.MAC_SF_BuildProcess(dAdlScore,'~thor::base::mylife::adl_score',actionBuildAdlScore,2,,true);
ut.MAC_SF_BuildProcess(dEmail,'~thor::base::mylife::email',actionBuildEmail,2,,true);
ut.MAC_SF_BuildProcess(dCollege,'~thor::base::mylife::college',actionBuildCollege,2,,true);
ut.MAC_SF_BuildProcess(dDeeds,'~thor::base::mylife::deeds',actionBuildDeeds,2,,true);
ut.MAC_SF_BuildProcess(dTax,'~thor::base::mylife::tax',actionBuildTax,2,,true);
ut.MAC_SF_BuildProcess(dFlags,'~thor::base::mylife::flags',actionBuildFlags,2,,true);
										
EXPORT actionBuildReunion:=SEQUENTIAL(
  actionBuildCustomerDB,
	actionBuildThirdPartyDB,
	actionBuildMain,
	PARALLEL(
	  actionBuildRelatives,
		actionBuildOldAddresses,
		actionBuildAliases,
		actionBuildAdlScore,
		actionBuildEmail,
		actionBuildCollege,
		actionBuildDeeds,
		actionBuildTax,
		actionBuildFlags	
	)
);
