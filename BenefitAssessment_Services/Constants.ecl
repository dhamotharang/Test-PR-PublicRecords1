EXPORT Constants := MODULE;
		EXPORT integer max_property_return_count := 5;
		EXPORT integer default_property_return_count := 3;
		EXPORT MAX_RECS := 1000; // 5 props per person, batch sends in 100 requests - 500 should be most.
		EXPORT COUNT_IN_RECS := 200;
		EXPORT MAX_FLAT_RECS := 3;
		EXPORT _7_Year_Filter := 7; //7-years, used in: professional Licenses, Watercrafts, aircrafts, marriage/divorce
		//BK- bankruptcy uses a 10 year filter but the data is already returned as such.
		EXPORT _12_Month_Filter := 1; //1- year, used in: people at work filter
		EXPORT _24_Month_Filter := 2; //2- years, used in: liens filter
		EXPORT ac_ACTIVE := 'A'; //we display only active aircrafts and not H-historical ones or I-Inactive
		EXPORT l_DEBTOR := 'D'; //we display only debtor lien records and bankruptcies

		// Party name types
		EXPORT STRING BUYER := 'BUYER';
		EXPORT STRING SELLER := 'SELLER';
		EXPORT STRING OWNER := 'OWNER';
		EXPORT STRING ASSESSEE := 'ASSESSEE';
		EXPORT STRING PROPERTY := 'PROPERTY';
		EXPORT STRING BORROWER := 'BORROWER';

END;