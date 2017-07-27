import risk_indicators;

export IDN605_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC) :=

FUNCTION

tbn509 := Models.TBN509_0_0(clam, OFAC);


Models.Layout_ModelOut tweak_score(tbn509 le, clam rt) := transform
	SELF.seq := le.seq;
	SELF.ri := le.ri;
	
	thindex := (integer)le.score;
	
	TBN605_1_0 := map(thindex <= 634 => '010',
				   thindex <= 643 => '020',
				   thindex <= 648 => '030',
				   thindex <= 653 => '040',
				   thindex <= 659 => '050',
				   thindex <= 666 => '060',
				   thindex <= 677 => '070',
				   thindex <= 692 => '080',
				   '090');
	

	SELF.score := MAP(
		rt.iid.socsvalflag in ['1','2'] => '010',		// override score for invalid/not yet issued socs to 010
		(INTEGER)TBN605_1_0 > 40 AND ( risk_indicators.rcSet.isCode02( rt.iid.decsflag ) OR risk_indicators.rcSet.isCode03( rt.iid.socsdobflag ) OR risk_indicators.rcSet.isCode39( rt.iid.socllowissue, rt.historydate ) ) => '010', // deceased OR ssn issued before dob OR ssn recently issued
		TBN605_1_0 
	);
end;
final := JOIN(tbn509, clam, LEFT.seq=RIGHT.seq,tweak_score(left,right), LEFT OUTER);

RETURN final;

END;