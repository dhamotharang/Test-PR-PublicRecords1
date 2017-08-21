import doxie,ut;

f := Files().Base.NonMember.Built(trim(bbb_id) <> '');

export Key_BBB_Non_Member_Id := index(f,{bbb_id},{f},'~thor_data400::key::bbb_non_member_id_'+doxie.Version_SuperKey);
