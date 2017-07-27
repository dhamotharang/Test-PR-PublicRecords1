// WFSModel
import Risk_Indicators;

export AIN605_3_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC) := function

ain509 := Models.AIN509_0_0(clam, ofac, false);		// this model does not use the tweak

Models.Layout_ModelOut tweak_score(ain509 le, clam ri) := transform
	SELF.seq := le.seq;
	SELF.ri := le.ri;
	
	Auto_Index509 := (unsigned)le.score;
	
	AIN605 := map(Auto_Index509 > 800 => 651,
			    Auto_Index509 < 350 => 418,
			    -98.8775  + 2.14512 * Auto_Index509  + -0.00220974 * Auto_Index509*Auto_Index509  + 0.000000876779 * Auto_Index509*Auto_Index509*Auto_Index509);
			    
	napCheck := if(ri.iid.nap_summary in [1,7,9] and AIN605 > 623, round(623 + (AIN605-623)/15), AIN605);
	nasCheck := if(ri.iid.nas_summary in [1,7,9] and napCheck > 615, round(615 + (napCheck-615)/15), napCheck);
	dobCheck := if(ri.ssn_verification.validation.dob_mismatch > 0 and nasCheck > 635, round(635 + (nasCheck-635)/15), nasCheck);
	AIN605_3 := if(ri.ssn_verification.validation.deceased and dobCheck > 609, round(609 + (dobCheck-609)/15), dobCheck);
				 
	AIN605_3_0 := map(AIN605_3 < 400 => 400,
				   AIN605_3 > 850 => 850,
				   AIN605_3);
				  

	SELF.score := (string)((integer)AIN605_3_0);
end;
final := join(ain509, clam, left.seq = right.seq, tweak_score(left,right), left outer);

RETURN final;

END;