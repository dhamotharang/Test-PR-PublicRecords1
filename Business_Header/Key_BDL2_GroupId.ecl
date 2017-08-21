Import Data_Services, business_header_ss, ut, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
in_base := dataset([],Business_header.Layout_BDL2);
#ELSE
in_base := distribute(Business_Header.files().base.bdl2.built, hash(group_id, bdl));
#END;

in_base_ded := dedup(sort(in_base, group_id, bdl, local), group_id, bdl, local);

export Key_BDL2_GroupId := index(in_base_ded, {group_id},{bdl}, '~thor_data400::key::business_header.bdl2_groupId_' + business_header_ss.key_version);
 