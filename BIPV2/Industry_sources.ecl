IMPORT AMIDIR, BBB2, BusReg, CALBUS, Corp2, DCAV2, Diversity_Certification, DNB_FEINV2, EBR, Edgar, FBNV2, Frandx,
			 govdata, InfoUSA, LaborActions_WHD, NCPDP, OIG, OSHAIR, Spoke, TXBUS, YellowPages, Experian_CRDB,Infutor_narb,
			 Equifax_Business_Data
			 //,Workers_Compensation, Zoom
;

export Industry_sources :=
	  AMIDIR.AMIDIR_As_Industry
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
	+ Equifax_Business_Data.As_Industry
	+ Infutor_NARB.As_Industry
	//+ Workers_Compensation.As_Industry  //*** removed as per Dave Wright, Bug# 57807
	//+ Zoom.Zoom_As_Industry							//*** removed zoom due to no reseller agreement as per bug# 132603
	;


// As of 11/12/2012, other sources identified that contain "industry" related data
/* 
IRS5500(retirement)
IDEXEC 
SheilaGreco 
*/
