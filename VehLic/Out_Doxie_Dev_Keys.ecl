import ut;

ut.MAC_SK_BuildProcess_v2(vehlic.Key_Vehicles_BDID,'~thor_data400::key::vehlic_bdid',do1,2);
ut.MAC_SK_Move_v2('~thor_data400::key::vehlic_bdid','Q',do2,2);

msg := output('/Only Doxie BDID Key Built Here./');


export Out_Doxie_Dev_Keys := sequential(do1,do2,msg);
