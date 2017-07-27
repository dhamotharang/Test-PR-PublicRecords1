EXPORT Constants := MODULE

	export Defaults := module
		export integer MaxResults          := 2000;
		export integer MaxResultsPerAcctno := 20;
		export integer DIDScoreThreshold   := 80;
	end;
	
	export Limits := module
		export integer MAX_JOIN_LIMIT := 10000;
	end;
	
	export AlphaNumericOnlyChars := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
	
	export PropertySubject_Types := module
		export string Owner_1 := 'Owner_1';
		export string Owner_2 := 'Owner_2';
		export string Buyer_1 := 'Buyer_1';
		export string Buyer_2 := 'Buyer_2';
		export string Borrower_1 := 'Borrower_1';
		export string Borrower_2 := 'Borrower_2';
		export string Assessee_1 := 'Assessee_1';
		export string Assessee_2 := 'Assessee_2';
		export string Seller_1 := 'Seller_1';
		export string Seller_2 := 'Seller_2';
	end;
	
END;