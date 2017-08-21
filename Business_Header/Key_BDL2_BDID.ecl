Import Data_Services, business_header_ss, ut, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
in_base := dataset([],Business_header.Layout_BDL2);
#ELSE
in_base := distribute(Business_Header.files().base.bdl2.built, hash(bdid, bdl));
#END;

in_base_ded := dedup(sort(in_base, bdid, bdl, local), bdid, bdl, local);

export Key_BDL2_BDID := index(in_base_ded, {bdid}, {bdl}, '~thor_data400::key::business_header.bdl2_bdid_' + business_header_ss.key_version);