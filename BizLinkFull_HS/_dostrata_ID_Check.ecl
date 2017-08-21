import BIPV2_Strata,strata,bipv2;
export _dostrata_ID_Check(dataset(recordof(BizLinkFull_HS.File_BizHead)) pDataset2 = BizLinkFull_HS.File_BizHead,string pversion = bipv2.KeySuffix ,boolean pIsTesting = false) := BIPV2_Strata.mac_BIP_ID_Check(pDataset2,'BizLinkFull_HS','filebizhead',pversion,pIsTesting);

