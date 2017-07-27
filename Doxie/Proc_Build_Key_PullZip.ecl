import ut;

ut.MAC_SK_BuildProcess_v2(key_pullZip, '~thor_data400::key::pullZip', a,true);
ut.MAC_SK_Move_v2('~thor_data400::key::pullZip', 'Q', b);

export Proc_Build_Key_pullZip := sequential(a, b);
