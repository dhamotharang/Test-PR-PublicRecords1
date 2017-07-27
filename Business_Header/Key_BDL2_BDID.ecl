import business_header_ss, ut;

in_base := distribute(Business_Header.files().base.bdl2.built, hash(bdid, bdl));

in_base_ded := dedup(sort(in_base, bdid, bdl, local), bdid, bdl, local);

export Key_BDL2_BDID := index(in_base_ded, {bdid}, {bdl}, '~thor_data400::key::business_header.bdl2_bdid_' + business_header_ss.key_version);