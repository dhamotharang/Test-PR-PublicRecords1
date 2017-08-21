import ut;

base	:=	VotersV2.File_Voters_Building;

ut.mac_suppress_by_phonetype(Base,phone,st,phone_suppression,true,did);	

ut.mac_suppress_by_phonetype(phone_suppression,work_phone,st,work_suppression,true,did);	

ut.mac_suppress_by_phonetype(work_suppression,other_phone,st,other_suppression,true,did);	

export File_Voters_Building_Keybuild := other_suppression : persist('~thor_dell400::persist::Voters_keybuild');