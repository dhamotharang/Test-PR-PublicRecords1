EXPORT PostBeneficiaryFraud_ReasonCodes(Layout_PostBeneficiaryFraud.Final_Plus pbf) := FUNCTION
	
	r := Models.PostBeneficiaryFraud_Reasons(pbf);
	rc_rec := IF(r.rcPBF010, r.makeRC('010')) &
		        IF(r.rcPBF020, r.makeRC('020')) &
		        IF(r.rcPBF030, r.makeRC('030')) &
		        IF(r.rcPBF040, r.makeRC('040')) &
		        IF(r.rcPBF050, r.makeRC('050')) &
		        IF(r.rcPBF060, r.makeRC('060')) &
		        IF(r.rcPBF070, r.makeRC('070')) &
		        IF(r.rcPBF080, r.makeRC('080')) &
		        IF(r.rcPBF090, r.makeRC('090')) &
		        IF(r.rcPBF100, r.makeRC('100')) &
		        IF(r.rcPBF110, r.makeRC('110')) &
		        IF(r.rcPBF120, r.makeRC('120')) &
		        IF(r.rcPBF130, r.makeRC('130')) &
		        IF(r.rcPBF140, r.makeRC('140')) &
		        IF(r.rcPBF150, r.makeRC('150')) &
		        IF(r.rcPBF160, r.makeRC('160')) &
		        IF(r.rcPBF170, r.makeRC('170')) &
		        IF(r.rcPBF180, r.makeRC('180')) &
		        IF(r.rcPBF190, r.makeRC('190')) &
		        IF(r.rcPBF200, r.makeRC('200')) &
		        IF(r.rcPBF210, r.makeRC('210')) &
		        IF(r.rcPBF220, r.makeRC('220'));

  // Do not change the count > 0 to an EXISTS because EXISTS doesn't work correctly... it returns false
	// in situations when the answer is actually true.
	RETURN IF(COUNT(rc_rec) > 0, rc_rec, r.makeRC('000'));
	
END;

