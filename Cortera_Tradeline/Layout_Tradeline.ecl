EXPORT Layout_Tradeline := RECORD
	unsigned4	LINK_ID;			//	Number	9	Cortera unique identifier for a location
	string32	ACCOUNT_KEY;	//	Varchar	32	Unique key for a tradeline
	string2		SEGMENT_ID;		//	Number	2	Cortera unique Industry code describing the industry of the provider of the data
	string8		AR_DATE;			//	Number	8	Date of the trade record.  Format is YYYYMMDD
	string20	TOTAL_AR;			//	Number	20	Total accounts receivables due
	string20	CURRENT_AR;		//	Number	20	Current accounts receivables due
	string20	AGING_1TO30;	//	Number	20	Amount of accounts receivables that is 1-30 days past due
	string20	AGING_31TO60;	//	Number	20	Amount of accounts receivables that is 31-60 days past due
	string20	AGING_61TO90;	//	Number	20	Amount of accounts receivables that is 61-90 days past due
	string20	AGING_91PLUS;	//	Number	20	Amount of accounts receivables that is more than 91 days past due
	string20	CREDIT_LIMIT;	//	Number	20	Credit Limit reported by the provider.  Sparsely populated.
	string8		FIRST_SALE_DATE;	//	Number	8	Date of first sale reported by the provider. Sparsely populated.
	string8		LAST_SALE_DATE;	//	Number	8	Date of last sale reported by the provider. 
END;