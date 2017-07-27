IMPORT MemberPoint;
	EXPORT Confidence := MODULE
	
		//Given confidence score returns the ConfidenceStarRate described associated to PhoneScoreBounds
		EXPORT STRING6 getStarRate(UNSIGNED4 score):= FUNCTION
			bounds:= MemberPoint.Constants.PhoneScore;
			rate:= MemberPoint.Constants.ConfidenceStarRateMod;
			RETURN MAP( score >= bounds.HighMin => rate.High,
									score >= bounds.MidMin => rate.Mid,
									score >= bounds.LowMin => rate.Low,
									rate.None);
		END;

		//Retrieve confidence score (High, Middle, Low) based on phone score
		EXPORT getConfidencePhoneScore(STRING3 phoneScore):= FUNCTION
			numScore := (UNSIGNED)phoneScore; 
			RETURN MAP( phoneScore = '' =>  '', 	
									numScore <= MemberPoint.Constants.PhoneScore.LowMax => 'L',
									numScore BETWEEN  MemberPoint.Constants.PhoneScore.MidMin 
																AND MemberPoint.Constants.PhoneScore.MidMax  => 'M',
									numScore >= MemberPoint.Constants.PhoneScore.HighMin => 'H',
									''); 
		END;
		
	END;