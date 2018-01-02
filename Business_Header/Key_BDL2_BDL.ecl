import business_header_ss, ut, data_services;

in_base := distribute(Business_Header.files().base.bdl2.built, hash(bdl, bdid, group_id));

in_base_ded := dedup(sort(in_base, bdl, bdid, group_id, local), bdl, bdid, group_id, local);

export Key_BDL2_BDL := index(in_base_ded, {bdl},{bdid,group_id}, data_services.data_location.prefix() + 'thor_data400::key::business_header.bdl2_BDL_' + business_header_ss.key_version);

