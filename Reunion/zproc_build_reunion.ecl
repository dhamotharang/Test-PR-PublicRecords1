IMPORT ut;

dCustomerDB:=reunion.mapping_reunion_customer_database;
dThirdPartyDB:=reunion.mapping_reunion_third_party_database;
dMain:=reunion.mapping_reunion_main;
dOldAddresses:=reunion.mapping_reunion_old_addresses;
dRelatives:=DISTRIBUTE(reunion.mapping_reunion_relatives,HASH(main_adl));
dMainDist:= DEDUP(DISTRIBUTE(dMain(TRIM(date_of_death)='' AND get_other_elements=true),HASH(adl)),adl,LOCAL);
dAliases:=reunion.mapping_reunion_alias;

dMainFiltered:=PROJECT(dMain(get_other_elements=TRUE),reunion.layouts.lMain);

j1:=JOIN(dRelatives,dMainDist,LEFT.main_adl=RIGHT.adl,TRANSFORM(reunion.layouts.lRelatives,SELF:=LEFT;),LOCAL);

ut.MAC_SF_BuildProcess(DEDUP(dCustomerDB,RECORD,ALL),'~thor_data400::base::reunion::customer_database',actionBuildCustomerDB,2,,true);
ut.MAC_SF_BuildProcess(DEDUP(dThirdPartyDB,RECORD,ALL),'~thor_data400::base::reunion::third_party_database',actionBuildThirdPartyDB,2,,true);
ut.MAC_SF_BuildProcess(DEDUP(dMainFiltered,RECORD,ALL),'~thor_data400::base::reunion::main',actionBuildMain,2,,true);
ut.MAC_SF_BuildProcess(DEDUP(dOldAddresses,RECORD,ALL),'~thor_data400::base::reunion::old_addresses',actionBuildOldAddresses,2,,true);
ut.MAC_SF_BuildProcess(DEDUP(j1,RECORD,ALL),'~thor_data400::base::reunion::relatives',actionBuildRelatives,2,,true);
ut.MAC_SF_BuildProcess(DEDUP(dAliases,RECORD,ALL),'~thor_data400::base::reunion::alias',actionBuildAliases,2,,true);
										
EXPORT proc_build_reunion:=SEQUENTIAL(
  actionBuildCustomerDB,
	actionBuildThirdPartyDB,
	actionBuildMain,
	PARALLEL(
	  actionBuildRelatives,
		actionBuildOldAddresses,
		actionBuildAliases
	)
);