import ut, risk_indicators, address, RiskWise;

export AWD510_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, unsigned3 history_date=999999, boolean OFAC=true) := 

FUNCTION

// calculate inCalif in here
inCalif := false;

Models.Layout_ModelOut doModel(clam le) := transform

	// code goes here	
	
     SELF.score := '222';
	SELF.seq := le.seq;
	SELF.ri := [];
END;
out := PROJECT(clam, doModel(LEFT));


// need to project boca shell results into layout.output, look at daves email on jan 27th
Risk_Indicators.Layout_Output into_layout_output(clam le) := transform
	self.seq := le.seq;
	self.socllowissue := (string)le.SSN_Verification.Validation.low_issue_date;
	self.soclhighissue := (string)le.SSN_Verification.Validation.high_issue_date;
	self.socsverlevel := le.iid.NAS_summary;
	self := le.iid;
	self := le.shell_input;
	self := [];
end;
iid := project(clam, into_layout_output(left));


Layout_ModelOut addReasons(Layout_ModelOut le, iid ri) := transform
	SELF.ri := RiskWise.mmReasonCodes(ri, 4, OFAC, inCalif);
	SELF := le;
end;
final := join(out, iid, left.seq=right.seq, addReasons(left, right));

RETURN (final);

END;