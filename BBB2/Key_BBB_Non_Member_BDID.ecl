import doxie,ut;

f := project(Files().Base.NonMember.Built(bdid <> 0), transform(BBB2.Layouts_Files.Base.NonMember, self := left));

export Key_BBB_Non_Member_BDID := index(f,{bdid},{f},'~thor_data400::key::bbb_non_member_bdid_'+doxie.Version_SuperKey);
