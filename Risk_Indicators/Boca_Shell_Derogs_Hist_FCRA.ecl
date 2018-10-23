import Risk_Indicators, Riskview;

export Boca_Shell_Derogs_Hist_FCRA (GROUPED DATASET(layouts.layout_derogs_input) ids, 
				integer bsVersion, unsigned8 BSOptions=0,
				boolean IncludeLnJ = false,
				integer2 ReportingPeriod = 84
        ) := FUNCTION
 
	Bankruptcy := Risk_Indicators.Boca_Shell_Bankrucpty_FCRAHist(bsVersion, BSOptions, ids);
	BankLiens := if(bsVersion >= 3,
					Risk_Indicators.Boca_Shell_Liens_FCRAHist_tmsid(bsVersion, BSOptions, Bankruptcy),
					Risk_Indicators.Boca_Shell_Liens_FCRAHist(bsVersion, BSOptions, Bankruptcy));
	BankLiensCrim := Risk_Indicators.Boca_Shell_Crim_FCRAHist(bsVersion, BSOptions, BankLiens);
	BankLiensCrimSO := Risk_Indicators.Boca_Shell_SO_FCRAHist(bsVersion, BSOptions, BankLiensCrim);
  
	ids_formatted := project(ids, 
		transform(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus,
			SELF := LEFT;
			SELF := [];));

	BankLiensCrimSO_LNJ :=	Risk_Indicators.Boca_Shell_Liens_LnJ_FCRA_Hist(bsVersion, BSOptions, ids_formatted, IncludeLnJ, ReportingPeriod);									
  DerogsLNJ := JOIN(BankLiensCrimSO, BankLiensCrimSO_LNJ,
					LEFT.Did = Right.Did,
					RiskView.Transforms.GetLnJInfo(LEFT, RIGHT),
					LEFT OUTER);
	// output(BankLiens, named('BankLiens'));
	// output(BankLiensCrim, named('BankLiensCrim'));
	// output(BankLiensCrimSO, named('BankLiensCrimSO'));
	// output(BankLiensCrimSO_LNJ, named('BankLiensCrimSO_LNJ'));
	// output(DerogsLNJ, named('DerogsLNJ'));
	return group(DerogsLNJ, seq);


END;