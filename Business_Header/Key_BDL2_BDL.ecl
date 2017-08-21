Import Data_Services, business_header_ss, ut, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
in_base := dataset([],Business_header.Layout_BDL2);
#ELSE
in_base := distribute(Business_Header.files().base.bdl2.built, hash(bdl, bdid, group_id));
#END;

in_base_ded := dedup(sort(in_base, bdl, bdid, group_id, local), bdl, bdid, group_id, local);

export Key_BDL2_BDL := index(in_base_ded, {bdl},{bdid,group_id}, '~thor_data400::key::business_header.bdl2_BDL_' + business_header_ss.key_version);

