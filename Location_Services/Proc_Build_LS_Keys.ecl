import header, ut;

ut.MAC_SK_BuildProcess_v2(header.Key_AptBuildings, '~thor_data400::key::hdr_apt_bldgs',do1);

ut.MAC_SK_Move_v2('~thor_data400::key::hdr_apt_bldgs','Q',do2,2);

export Proc_Build_LS_Keys := sequential(do1,do2);
