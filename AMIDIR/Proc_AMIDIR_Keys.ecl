import AMIDIR;

DID_key := buildindex(AMIDIR.Key_AMIDIR_DID);
BDID_key := buildindex(AMIDIR.Key_AMIDIR_BDID);
SSN_key  := buildindex(AMIDIR.Key_AMIDIR_SSN);
UPIN_key := buildindex(AMIDIR.Key_AMIDIR_UPIN);
Licnumber_key := buildindex(AMIDIR.Key_AMIDIR_Licnumber);
phyname_key := buildindex(AMIDIR.Key_AMIDIR_PHYName);
busname_key := buildindex(AMIDIR.Key_AMIDIR_BusName);
DEA_key := buildindex(AMIDIR.Key_AMIDIR_DEA);

export Proc_AMIDIR_Keys := sequential(DID_key,BDID_key,SSN_key,UPIN_key,Licnumber_key,
phyname_key,busname_key,DEA_key);