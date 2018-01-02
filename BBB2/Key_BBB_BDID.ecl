import doxie,ut, data_services;

f := project(Files().Base.Member.Built(bdid <> 0), transform(BBB2.Layouts_Files.Base.Member, self := left));

export Key_BBB_BDID := index(f,{bdid},{f},data_services.data_location.prefix('bbb') + 'thor_data400::key::bbb_bdid_'+doxie.Version_SuperKey);
