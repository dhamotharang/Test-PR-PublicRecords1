import doxie,ut;

f := Files().Base.Member.Built(trim(bbb_id) <> '');

export Key_BBB_id := index(f,{bbb_id},{f},'~thor_data400::key::bbb_id_'+doxie.Version_SuperKey);
