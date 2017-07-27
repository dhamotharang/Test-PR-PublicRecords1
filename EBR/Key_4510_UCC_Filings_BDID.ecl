import doxie;

f := File_4510_UCC_Filings_Base_bdid(bdid <> 0);

export Key_4510_UCC_Filings_BDID := index(f,{bdid},{f},KeyName_4510_UCC_Filings_BDID + '_' + doxie.Version_SuperKey);
