import business_credit, ut;

EXPORT RecordNumberCheck(string pFilename = '') := function



AB_Dataset	:=  count(Business_Credit.Files(pFilename).AB);
AD_Dataset	:=	count(Business_Credit.Files(pFilename).AD);
AH_Dataset	:=	count(Business_Credit.Files(pFilename).AH);
BI_Dataset	:=	count(Business_Credit.Files(pFilename).BI);
BS_Dataset	:=	count(Business_Credit.Files(pFilename).BS);
CL_Dataset	:=	count(Business_Credit.Files(pFilename).CL);
IS_Dataset	:=	count(Business_Credit.Files(pFilename).IS);
MA_Dataset	:=	count(Business_Credit.Files(pFilename).MA);
MS_Dataset	:=	count(Business_Credit.Files(pFilename).MS);
PN_Dataset	:=	count(Business_Credit.Files(pFilename).PN);
TI_Dataset	:=	count(Business_Credit.Files(pFilename).TI);

AB_result := if(AB_Dataset <> sum(Business_Credit.Files(pFilename).ZZ,(unsigned)total_AB_segments),0,1);
AD_result := if(AD_Dataset <> sum(Business_Credit.Files(pFilename).ZZ,(unsigned)total_AD_segments),0,1);
AH_result := if(AH_Dataset <> sum(Business_Credit.Files(pFilename).ZZ,(unsigned)total_AH_segments),0,1);
BI_result := if(BI_Dataset <> sum(Business_Credit.Files(pFilename).ZZ,(unsigned)total_BI_segments),0,1);
BS_result := if(BS_Dataset <> sum(Business_Credit.Files(pFilename).ZZ,(unsigned)total_BS_segments),0,1);
CL_result := if(CL_Dataset <> sum(Business_Credit.Files(pFilename).ZZ,(unsigned)total_CL_segments),0,1);
IS_result := if(IS_Dataset <> sum(Business_Credit.Files(pFilename).ZZ,(unsigned)total_IS_segments),0,1);
MA_result := if(MA_Dataset <> sum(Business_Credit.Files(pFilename).ZZ,(unsigned)total_MA_segments),0,1);
MS_result := if(MS_Dataset <> sum(Business_Credit.Files(pFilename).ZZ,(unsigned)total_MS_segments),0,1);
PN_result := if(PN_Dataset <> sum(Business_Credit.Files(pFilename).ZZ,(unsigned)total_PN_segments),0,1);
TI_result := if(TI_Dataset <> sum(Business_Credit.Files(pFilename).ZZ,(unsigned)total_TI_segments),0,1);

	return	if(AB_result=0 or
					AD_result=0 or
					AH_result=0 or
					BI_result=0 or
					BS_result=0 or
					CL_result=0 or
					IS_result=0 or
					MA_result=0 or
					MS_result=0 or
					PN_result=0 or
					TI_result=0,fail('Number of Records Do Not Match Reported Records in ZZ Entries'));

end;