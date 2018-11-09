EXPORT FCRAPurpose := MODULE

	EXPORT integer NoValueProvided 											:= -1;
	EXPORT integer NoPermissiblePurpose 								:= 0;
	EXPORT integer Application 													:= 1;
	EXPORT integer Collections 													:= 2;
	EXPORT integer Government 													:= 3;
	EXPORT integer HealthcareCreditTransaction 					:= 4;
	EXPORT integer HealthcareLegitimateBusinessNeed 		:= 5;
	EXPORT integer InsuranceApplication 								:= 6;
	EXPORT integer InsurancePortfolioReview 						:= 7;
	EXPORT integer PortfolioReview 											:= 8;
	EXPORT integer PreScreening 												:= 9;
	EXPORT integer RentalCarLossDamageWaiver 						:= 10;
	EXPORT integer TenantScreening 											:= 11;
	EXPORT integer AccountReview 												:= 12;
	EXPORT integer InstructedByConsumer 								:= 13;

	EXPORT Params := INTERFACE
		EXPORT integer FCRAPurpose := NoValueProvided;
	END;

	is_val_ok(integer v) := ((v > NoPermissiblePurpose) and (v <= InstructedByConsumer)); 

	EXPORT integer Get(string in_fcra_purpose = '') := FUNCTION
		string g_val := '' : stored('FCRAPurpose');		
		integer val := (integer) IF(in_fcra_purpose <> '', in_fcra_purpose, g_val);
		integer ival := IF(is_val_ok(val), val, NoPermissiblePurpose); 
		return ival;				
	END;

END;