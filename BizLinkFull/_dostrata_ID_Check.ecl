import BIPV2_Strata,strata,bipv2;
export _dostrata_ID_Check(dataset(recordof(BizLinkFull.File_BizHead)) pDataset2 = BizLinkFull.File_BizHead,string pversion = bipv2.KeySuffix ,boolean pIsTesting = false) := BIPV2_Strata.mac_BIP_ID_Check(pDataset2,'BizLinkFull','filebizhead',pversion,pIsTesting);
