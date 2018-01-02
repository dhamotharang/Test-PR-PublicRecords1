import doxie,ut, data_services;

f := project(Files().Base.NonMember.Built(bdid <> 0), transform(BBB2.Layouts_Files.Base.NonMember, self := left));

export Key_BBB_Non_Member_BDID := index(f,{bdid},{f},data_services.data_location.prefix('bbb') + 'thor_data400::key::bbb_non_member_bdid_'+doxie.Version_SuperKey);
