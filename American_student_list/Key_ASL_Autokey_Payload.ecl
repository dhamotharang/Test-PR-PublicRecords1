import autokeyb2,standard,doxie,ut,American_student_list;

keyname     := thor_cluster +'key::american_student::autokey::qa::payload';
asl_base    := File_american_student_Autokeys;

autokeyb2.MAC_FID_Payload(asl_base ,'','','','','','','','','',DID,0,keyname,plk,'');
export Key_ASL_Autokey_Payload :=plk; 