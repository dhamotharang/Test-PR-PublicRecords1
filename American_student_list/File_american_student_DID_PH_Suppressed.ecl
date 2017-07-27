Import ut;
Base_File := American_student_list.File_american_student_DID;

ut.mac_suppress_by_phonetype(Base_File,telephone,st,PhSuppressed,true,did);

export File_American_Student_Did_Ph_Suppressed := PhSuppressed: persist('persist::asl_keybuild');
