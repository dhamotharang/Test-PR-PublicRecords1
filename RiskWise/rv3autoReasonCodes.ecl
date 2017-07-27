import risk_indicators, models;

export rv3autoReasonCodes(
	risk_indicators.Layout_Boca_Shell clam,
	integer1 cnt=4,
	boolean inCalif=false,
	boolean PreScreenOptOut=false
	) := FUNCTION
	
	r := Reasons( clam, PrescreenOptOut:=PreScreenOptOut );
	rcs_corr := 
		if(r.rc91, r.makeRC('91')) &
		if(r.rc92, r.makeRC('92')) &
		if(r.rc93, r.makeRC('93')) &
		if(r.rc94, r.makeRC('94')) &
		if(r.rc95, r.makeRC('95'));
	rcs :=
		if(inCalif, r.makeRC('35')) &
		if(r.rc02, r.makeRC('02')) &
		if(r.rc03, r.makeRC('03')) &
		if(r.rc97, r.makeRC('97')) &
		if(r.rc50, r.makeRC('50')) &
		if(r.rc42, r.makeRC('42')) &
		if(r.rc43, r.makeRC('43')) &
		if(r.rc98, r.makeRC('98')) &
		if(r.rcEV, r.makeRC('EV')) &
		if(r.rc9H, r.makeRC('9H')) &
		if(r.rc9A, r.makeRC('9A')) &
		if(r.rc9B, r.makeRC('9B')) &
		if(r.rcPV, r.makeRC('PV')) &
		if(r.rc9E, r.makeRC('9E')) &
		if(r.rc9J, r.makeRC('9J')) &
		if(r.rc19, r.makeRC('19')) &
		if(r.rc20, r.makeRC('20')) &
		if(r.rc9C, r.makeRC('9C')) &
		if(r.rc9D, r.makeRC('9D')) &
		// if(r.rc21, r.makeRC('21')) &
		if(r.rc22, r.makeRC('22')) &
		if(r.rc23, r.makeRC('23')) &
		if(r.rc24, r.makeRC('24')) &
		if(r.rc25, r.makeRC('25')) &
		if(r.rc26, r.makeRC('26')) &
		if(r.rc28, r.makeRC('28')) &
		if(r.rc27, r.makeRC('27')) &
		if(r.rc9F, r.makeRC('9F')) &
		if(r.rc77, r.makeRC('77')) &
		if(r.rc78, r.makeRC('78')) &
		if(r.rc79, r.makeRC('79')) &
		if(r.rc80, r.makeRC('80')) &
		if(r.rc81, r.makeRC('81')) &
		if(r.rcMS, r.makeRC('MS')) &
		if(r.rcMI, r.makeRC('MI')) &
		// if(NOT r.rcMI AND r.rc38, r.makeRC('38')) &
		if(r.rc9G, r.makeRC('9G')) &
		if(r.rc06, r.makeRC('06')) &
		if(r.rc07, r.makeRC('07')) &
		if(r.rc08, r.makeRC('08')) &
		if(r.rc09, r.makeRC('09')) &
		if(r.rc11, r.makeRC('11')) &
		if(r.rc12, r.makeRC('12')) &
		if(r.rc14, r.makeRC('14')) &
		if(r.rc15, r.makeRC('15')) &
		if(r.rc16, r.makeRC('16')) &
		if(r.rc72, r.makeRC('72')) &
		if(r.rc04, r.makeRC('04')) &
		if(r.rc45, r.makeRC('45')) &
		if(r.rc49, r.makeRC('49')) &
		if(r.rc37, r.makeRC('37')) &
		if(r.rc48, r.makeRC('48')) &
		if(r.rc99, r.makeRC('99')) &
		if(r.rc10, r.makeRC('10')) &
		if(r.rc71, r.makeRC('71')) &
		if(r.rc51, r.makeRC('51')) &
		if(r.rc52, r.makeRC('52')) &
		if(r.rc9I, r.makeRC('9I')) &
		if(r.rc73, r.makeRC('73')) &
		if(r.rc74, r.makeRC('74')) &
		if(r.rc82, r.makeRC('82')) &
		if(r.rc29, r.makeRC('29')) &
		if(r.rc30, r.makeRC('30')) &
		if(r.rc31, r.makeRC('31')) &
		if(r.rc83, r.makeRC('83'))
	;

	rcs2 := map(
		0 < count(rcs_corr) => rcs_corr,
		risk_indicators.rcSet.isCode36(rcs[1].hri) => r.makeRC('36'),
		rcs[1].hri = '35' => choosen(rcs,1),
		rcs
	);
	return choosen( rcs2 + r.makeRC('00') + r.makeRC('00') + r.makeRC('00') + r.makeRC('00') + r.makeRC('00') + r.makeRC('00'), cnt );
END;

