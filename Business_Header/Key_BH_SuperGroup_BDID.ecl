import doxie, ut, header_services, Data_Services, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
	bh_super_record_bdid := PRTE2_Business_Header.Files().Base.Super_Group.built;
#ELSE
	bh_super_record_bdid := Business_Header.Prep_Build.applyBusinessGroupingInj(Business_Header.Files().Base.Super_Group.built);
#END;

export Key_BH_SuperGroup_BDID := index(bh_super_record_bdid,{bdid},{group_id},
ut.foreign_prod+'thor_Data400::key::bh_supergroup_bdid_' + doxie.Version_SuperKey);
