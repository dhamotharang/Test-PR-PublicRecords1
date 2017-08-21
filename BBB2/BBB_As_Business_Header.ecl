#OPTION('multiplePersistInstances',FALSE);
import business_header,business_headerv2;

export BBB_As_Business_Header
 :=
 fBBB_As_Business_Header(bbb2.Files().Base.Member.BusinessHeader, bbb2.Files().Base.NonMember.BusinessHeader)
 :	persist(PersistNames.AsBusHeader);