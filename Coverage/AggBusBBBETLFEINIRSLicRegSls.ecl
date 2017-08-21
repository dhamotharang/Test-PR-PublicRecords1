/* 
W20080227-135603 used in AggBus, BBB, FEIN, IRS, LicReg, SalesTax, Tradeline
Miscellaneous business includes:
BBB members, BBB nonmembers, DCA, DNB, FCC, FEIN, Deadco, USABiz, IRS 5500, IRS nonprofit, IA sales tax, Tradeline
*/

shared BbbMbr        := bbb2.Files.base.member.qa;
shared BbbNMbr       := bbb2.files.base.nonmember.qa;
shared Dca1           := dca.File_DCA_Base;
shared Dnb1           := DNB.File_DNB_Base;
shared Fcc1           := FCC.File_FCC_base; 
shared DnbFein       := DNB.File_DNB_FEIN_In;
shared DeadComp      := InfoUSA.File_Deadco_base;
shared ABIUS         := InfoUSA.File_ABIUS_Company_Base;
shared IRS55001       := IRS5500.File_IRS5500_Base;
shared IRS_NonProfit := govdata.File_IRS_NonProfit_Base;
shared IA_SalesTax   := govdata.File_IA_SalesTax_Base;
shared EBR1           := EBR.File_0010_Header_Base;





//ut.macGetCoverageDates(martin	,'MartinDale Hubbell'    , dt_first_seen ,dt_last_seen ,Hubbell_coverage,false	);
//ut.macGetCoverageDates(abusreg	,'Business Registrations',dt_first_seen	,dt_last_seen  ,Busreg_coverage	,true 	);
                     

ut.macGetCoverageDates(BbbMbr        ,'Better Business Bureau - Members'                    ,report_date         ,report_date,       	 BbbMbr_coverage,      true );
ut.macGetCoverageDates(BbbNMbr       ,'Better Business Bureau - Non Members'                ,report_date         ,report_date,      	 BbbNMbr_coverage,	   true );
ut.macGetCoverageDates(Dca1           ,'Directory of Corporate Affiliations (DCA) - Public' ,update_date         ,update_date,           Dca_coverage,		   true );
ut.macGetCoverageDates(Dnb1           ,'DMI'                                                ,report_date         ,report_date,           Dnb_coverage,		   true );
ut.macGetCoverageDates(Fcc1           ,'FCC Licenses'                                       ,date_license_issued ,date_of_last_change,   Fcc_coverage,         true );
ut.macGetCoverageDates(DnbFein       ,'Federal Employer Identification Numbers'             ,date_of_input_data  ,date_of_input_data,    DnbFein_coverage, 	   true );
ut.macGetCoverageDates(DeadComp      ,'Inactive Businesses'                                 ,dt_first_seen       ,dt_last_seen,     	 DeadComp_coverage,	   true );
ut.macGetCoverageDates(ABIUS         ,'United States Businesses + Corporate Linkage'        ,date_added          ,date_added,            ABIUS_coverage,	   true );
ut.macGetCoverageDates(IRS55001      ,'IRS Form 5500'                                       ,trans_date          ,trans_date,      	     IRS5500_coverage,	   true );
ut.macGetCoverageDates(IRS_NonProfit ,'IRS Non-Profit Charitable Organizations'             ,ruling_date         ,ruling_date,		     IRS_NonProfit_coverage,   true );
ut.macGetCoverageDates(IA_SalesTax   ,'Iowa Sales Tax Registrations'                        ,issue_date	         ,issue_date,  		     IA_SalesTax_coverage,	   true );
ut.macGetCoverageDates(EBR1          ,'Experian Business Credit Reports'                    ,extract_date	     ,extract_date,		     EBR_coverage,		       true );
     
all_coverage := (BbbMbr_coverage +
	             BbbNMbr_coverage	+
		 Dca_coverage		+ 
		 Dnb_coverage		+ 
		 Fcc_coverage      	+ 
		 DnbFein_coverage 	+ 
		 DeadComp_coverage	+ 
		 ABIUS_coverage		+ 
		 IRS5500_coverage	+
		 IRS_NonProfit_coverage	+ 
		 IA_SalesTax_coverage	+ 
		 EBR_coverage);		 
output(all_coverage, all);