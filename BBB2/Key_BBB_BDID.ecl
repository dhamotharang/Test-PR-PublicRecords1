import doxie,ut;

f := project(Files().Base.Member.Built(bdid <> 0), transform(BBB2.Layouts_Files.Base.Member, self := left));

export Key_BBB_BDID := index(f,{bdid},{f},'~thor_data400::key::bbb_bdid_'+doxie.Version_SuperKey);
