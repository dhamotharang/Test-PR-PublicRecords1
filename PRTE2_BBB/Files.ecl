IMPORT BBB2, bipv2;

export Files := module

	EXPORT BBB_Member_In 				:= DATASET(constants.In_Prefix + 'member', 				Layouts.Member_Base_Layout, 		CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
	EXPORT BBB_Member_Ins_In 		:= DATASET(constants.In_Prefix + 'member_ins', 		Layouts.Member_Base_Layout, 		CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
	EXPORT BBB_Nonmember_In 		:= DATASET(constants.In_Prefix + 'nonmember', 		Layouts.NonMember_Base_Layout, 	CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
	EXPORT BBB_Nonmember_Ins_In := DATASET(constants.In_Prefix + 'nonmember_ins', Layouts.NonMember_Base_Layout, 	CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
	
	EXPORT BBB_Member_Base 		:= DATASET(constants.Base_Member, 	 Layouts.Member_Base_Layout, 		FLAT);
	EXPORT BBB_Nonmember_Base := DATASET(constants.Base_NonMember, Layouts.NonMember_Base_Layout, FLAT);
	
	EXPORT Key_BBB_BDID 							:= PROJECT(bbb_member_Base(BDID > 0), 		TRANSFORM(Layouts.Member_Key_Bdid, 		SELF := LEFT));
	EXPORT Key_BBB_Non_Member_BDID 		:= PROJECT(bbb_nonmember_Base(BDID > 0), 	TRANSFORM(Layouts.Nonmember_Key_Bdid, SELF := LEFT));
	EXPORT Key_BBB_LinkIds 						:= PROJECT(bbb_member_Base, 	 TRANSFORM(Layouts.Member_Key_Linkids, 		SELF := LEFT));
	EXPORT Key_BBB_Non_Member_LinkIds := PROJECT(bbb_nonmember_Base, TRANSFORM(Layouts.Nonmember_Key_Linkids, SELF := LEFT));
	
end;