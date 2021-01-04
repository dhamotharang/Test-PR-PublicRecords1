EXPORT Results := MODULE,VIRTUAL
    SHARED ScoreMessageLayout := RECORD
        STRING2 MessageType;
        STRING5 Code;
        STRING158 Description;
    END;

	SHARED RCToMessage(SET OF STRING5 rc) := FUNCTION
		// The real version of this needs to be done carefully and quickly. Consider a dictionary (and don't forget ONCE in roxie world)
  		d := DATASET(rc,{ STRING5 Code });
		ScoreMessageLayout into(d le) := TRANSFORM
	  		SELF.MessageType := '??';
			SELF.Code := le.code;
			SELF.Description := '??' + le.code + '??';
		END;
		RETURN PROJECT(d,into(LEFT));
  	END;

	// These are export layouts - provided to 'publish' up through esp etc
	// Do NOT use these unless you need to publish - for INTERNAL use there are much, much better ways to do this
	EXPORT BaseLayout := RECORD
		STRING TransactionId;
		STRING name;        //model_id from the request.ProductOptions.InsuranceScore.Models
		STRING description; //model_desc;
		STRING20 score;
		DATASET(ScoreMessageLayout)  Messages := DATASET([], ScoreMessageLayout);
		DATASET(ScoreMessageLayout)  Messages1 := DATASET([], ScoreMessageLayout);
		STRING status_code := '';
		STRING status_message := '';
	END;

	EXPORT Base() := DATASET([],BaseLayout);

	EXPORT NVPair := RECORD
	    STRING Name;
	    STRING Value;
	END;

	EXPORT AttrLayout := RECORD
		BaseLayout;
		STRING ScoreCard := ''; // The name of the scorecard used for a multi-scorecardmodel
		DATASET(NVPair) Attributes{MAXCOUNT(500)} := DATASET([], NVPair);
	END;

	EXPORT Attr() := DATASET([],AttrLayout);

	EXPORT RC_Contributions_Layout := RECORD
		NVPair.Name; //attribute name
		REAL contribValue; // Actual points - expected points
		STRING5 rc_code;
	END;

	EXPORT ValidationLayout := RECORD
		AttrLayout;
		DATASET(NVPair) PointsAssignment{MAXCOUNT(500)} := DATASET([], NVPair);
		STRING10 score_date;
		REAL raw_score;
		REAL calc_temp_score; // intermediate score expression;
		BOOLEAN INSUFFICIENT_INFO := FALSE;
		BOOLEAN NO_HIT := FALSE;
		DATASET(RC_Contributions_Layout) reason_codes_base := DATASET([], RC_Contributions_Layout);
	END;

	EXPORT Validation() := DATASET([],ValidationLayout);

	EXPORT StatsLayout := RECORD
		STRING ModelID;
		STRING ModelName;
		STRING ScoreCard;
		STRING Attribute;
		REAL LowerBound;
		REAL UpperBound;
		REAL PointAssignment;
		STRING PointMethod;
		REAL ExpectedPoint;
		REAL BestPoint;
		STRING5 ReasonCode;
		UNSIGNED RecordCount;
		REAL4 Percentage;
	END;

	EXPORT Stats() := DATASET([],StatsLayout);
END;
