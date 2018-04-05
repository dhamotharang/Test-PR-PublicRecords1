import Prte2_Busreg, Prte2_Corp, Prte2_FBN;

//AMIDIR, BBB2, BusReg, CALBUS, Corp2, DCAV2, Diversity_Certification, DNB_FEINV2, EBR, Edgar, FBNV2, Frandx,
//			 govdata, InfoUSA, LaborActions_WHD, NCPDP, OIG, OSHAIR, Spoke, TXBUS, YellowPages, Experian_CRDB
//;

export Industry_sources := prte2_busreg.as_industry
												 + PRTE2_CORP.as_industry
												// + PRTE2_FBN.as_industry
												 ;

//dataset([],Layouts.Base.Layout_Industry)
/*	  AMIDIR.AMIDIR_As_Industry
	+ BBB2.BBB_As_Industry
	+ BusReg.BusReg_As_Industry
	+ CALBUS.Calbus_As_Industry
	+ Corp2.As_Industry
	+ DCAV2.As_Industry
	+ Diversity_Certification.As_Industry
	+ DNB_FEINV2.As_Industry
	+ EBR.EBR_As_Industry
	+ Edgar.Edgar_As_Industry
	+ Experian_CRDB.As_Industry	
	+ FBNV2.FBNV2_As_Industry
	+ Frandx.As_Industry
	+ govdata.IRS_Non_Profit_As_Industry
	+ govdata.OR_Workers_As_Industry
	+ InfoUSA.ABIUS_Company_As_Industry
	+ InfoUSA.DEADCO_As_Industry
	+ LaborActions_WHD.As_Industry
	+ NCPDP.As_Industry
	+ OIG.OIG_As_Industry
	+ OSHAIR.Cleaned_OSHAIR_Inspection_As_Industry
	+ Spoke.As_Industry
	+ TXBUS.Cleaned_TXBUS_As_Industry
	+ YellowPages.YellowPages_As_Industry
*/