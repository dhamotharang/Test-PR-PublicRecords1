// WFS2Model
import Risk_Indicators;

export AIN605_2_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC, string5 grade) := function

ain509 := Models.AIN509_0_0(clam, ofac, false);		// this model does not use the tweak

Models.Layout_ModelOut tweak_score(ain509 le, clam ri) := transform
	SELF.seq := le.seq;
	SELF.ri := le.ri;
	
	Auto_Index509 := (unsigned)le.score;
	
	AIN605 := map(Auto_Index509 > 800 => 651,
			    Auto_Index509 < 350 => 418,
			    -98.8775  + (2.14512 * Auto_Index509)  + (-0.00220974 * Auto_Index509*Auto_Index509)  + (0.000000876779 * Auto_Index509*Auto_Index509*Auto_Index509));
			    
	napCheck := if(ri.iid.nap_summary in [1,7,9] and AIN605 > 623, round(623 + (AIN605-623)/15), AIN605);
	nasCheck := if(ri.iid.nas_summary in [1,7,9] and napCheck > 615, round(615 + (napCheck-615)/15), napCheck);
	dobCheck := if(ri.ssn_verification.validation.dob_mismatch > 0 and nasCheck > 635, round(635 + (nasCheck-635)/15), nasCheck);
	AIN605_2 := if(ri.ssn_verification.validation.deceased and dobCheck > 609, round(609 + (dobCheck-609)/15), dobCheck);
				 
	AIN605_2_ := map(AIN605_2 < 400 => 400,
				  AIN605_2 > 850 => 850,
				  AIN605_2);
				  
	AIN605_2_0 := map(~ri.input_validation.ssn => 201,
				   ri.ssn_verification.validation.deceased or ri.ssn_verification.validation.dob_mismatch > 0 or 
								~ri.ssn_verification.validation.valid or ~ri.ssn_verification.validation.issued => 200,
				   grade not in ['C1','B3','B1','A2','A1','A0'] => 528,
				   AIN605_2_);

	SELF.score := (string)((integer)AIN605_2_0);
end;
final := join(ain509, clam, left.seq = right.seq, tweak_score(left,right), left outer);

RETURN final;

END;