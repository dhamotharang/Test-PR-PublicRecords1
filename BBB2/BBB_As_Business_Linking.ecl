#OPTION('multiplePersistInstances',FALSE);
IMPORT business_header,business_headerv2;

EXPORT BBB_As_Business_Linking
 :=
 fBBB_As_Business_Linking(bbb2.Files().Base.Member.QA, bbb2.Files().Base.NonMember.QA)
 :	PERSIST(PersistNames.AsBusLinking);
 