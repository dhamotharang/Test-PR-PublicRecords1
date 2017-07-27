EXPORT Codes_Company := Module
	Export getPracCompany_USTAT(boolean isprac_VerifiedOther, boolean isprac_LBN_Exact,boolean isprac_DBA_Exact,boolean isprac_LBN_Corr,boolean isprac_DBA_Corr,
															boolean isPrac_Missing_CompanyName,boolean isprac_low_score_FKAName,boolean isprac_FKAName,
															boolean isprac_LBN_aug,boolean isprac_DBA_aug) := Function
			score_isprac_VerifiedOther := if(isprac_VerifiedOther,Healthcare_Shared.Constants.ustat_Company_Ver_Other,0);						//2												
			score_isprac_LBN_Exact := if(isprac_LBN_Exact,Healthcare_Shared.Constants.ustat_Company_Ver_High_Lbn,0);									//4
			score_isprac_DBA_Exact := if(isprac_DBA_Exact,Healthcare_Shared.Constants.ustat_Company_Ver_High_Dba,0);									//8
			score_isprac_LBN_Corr  := if(isprac_LBN_Corr ,Healthcare_Shared.Constants.ustat_Company_Cor_High_Lbn,0);									//256
			score_isprac_DBA_Corr  := if(isprac_DBA_Corr ,Healthcare_Shared.Constants.ustat_Company_Cor_High_Dba,0);									//512
			score_isPrac_Missing_CompanyName:= if(isPrac_Missing_CompanyName,Healthcare_Shared.Constants.ustat_Company_Rep_Missing,0);//4096
			score_isprac_low_score_FKAName:=if(isprac_low_score_FKAName,Healthcare_Shared.Constants.ustat_Company_Rep_Low_Fka,0);		  //16384
			score_isprac_FKAName:= if(isprac_FKAName,Healthcare_Shared.Constants.ustat_Company_Rep_Fka,0);												    //32768
			score_isprac_LBN_aug := if(isprac_LBN_aug,Healthcare_Shared.Constants.ustat_Company_Aug_High_Lbn,0);											//33554432
			score_isprac_DBA_aug := if(isprac_DBA_aug,Healthcare_Shared.Constants.ustat_Company_Aug_High_Dba,0);											//67108864

			prac_company_st := score_isprac_VerifiedOther + score_isprac_LBN_Exact + score_isprac_DBA_Exact + score_isprac_LBN_Corr + 
												 score_isprac_DBA_Corr + score_isPrac_Missing_CompanyName + score_isprac_low_score_FKAName +
												 score_isprac_FKAName + score_isprac_LBN_aug + score_isprac_DBA_aug;
			return prac_company_st;
	end;
	
	
	Export getBillCompany_USTAT(boolean isBill_LBN_Exact,boolean isBill_DBA_Exact,boolean isBill_LBN_Corr,boolean isBill_DBA_Corr,
															boolean isBill_Missing_CompanyName,boolean isBill_low_score_FKAName,boolean isBill_FKAName,
															boolean isBill_LBN_aug,boolean isBill_DBA_aug) := Function
			score_isBill_LBN_Exact := if(isBill_LBN_Exact,Healthcare_Shared.Constants.ustat_Company_Ver_High_Lbn,0);									//4
			score_isBill_DBA_Exact := if(isBill_DBA_Exact,Healthcare_Shared.Constants.ustat_Company_Ver_High_Dba,0);									//8
			score_isBill_LBN_Corr  := if(isBill_LBN_Corr ,Healthcare_Shared.Constants.ustat_Company_Cor_High_Lbn,0);									//256
			score_isBill_DBA_Corr  := if(isBill_DBA_Corr ,Healthcare_Shared.Constants.ustat_Company_Cor_High_Dba,0);									//512
			score_isBill_Missing_CompanyName:= if(isBill_Missing_CompanyName,Healthcare_Shared.Constants.ustat_Company_Rep_Missing,0);//4096
			score_isBill_low_score_FKAName:=if(isBill_low_score_FKAName,Healthcare_Shared.Constants.ustat_Company_Rep_Low_Fka,0);		//16384
			score_isBill_FKAName:= if(isBill_FKAName,Healthcare_Shared.Constants.ustat_Company_Rep_Fka,0);												    //32768
			score_isBill_LBN_aug := if(isBill_LBN_aug,Healthcare_Shared.Constants.ustat_Company_Aug_High_Lbn,0);											//33554432
			score_isBill_DBA_aug := if(isBill_DBA_aug,Healthcare_Shared.Constants.ustat_Company_Aug_High_Dba,0);											//67108864

			bill_company_st := score_isBill_LBN_Exact + score_isBill_DBA_Exact + score_isBill_LBN_Corr + 
												 score_isBill_DBA_Corr + score_isBill_Missing_CompanyName + score_isBill_low_score_FKAName +
												 score_isBill_FKAName + score_isBill_LBN_aug + score_isBill_DBA_aug;
			return bill_company_st;
	end;
End;