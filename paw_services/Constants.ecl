/*2011-04-04T15:17:00Z (Cristopher Albee)
Post review changes; re-review needed.
*/
export Constants := module
	export unsigned2 MAX_PHONES_PER_ADDR := 20;
	export unsigned2 MAX_PHONES_PER_DID := 200;
	export unsigned2 MAX_DATES_PER_POSITION := 20;
	export unsigned2 MAX_DATES_PER_EMPLOYER := 20;
	export unsigned2 MAX_FEINS_PER_EMPLOYER := 20;
	export unsigned2 MAX_COMPANY_NAMES_PER_EMPLOYER := 20;
	export unsigned2 MAX_ADDRS_PER_EMPLOYER := 20;
	export unsigned2 MAX_POSITIONS_PER_EMPLOYER := 20;
	export unsigned2 MAX_SSNS_PER_PERSON := 20;
	export unsigned2 MAX_NAMES_PER_PERSON := 20;
	export unsigned2 MAX_EMPLOYERS_PER_PERSON := 20;
	export string1   IS_CURRENT_RECORD := 'C';
	export unsigned  CONTACTID_LIMIT := 5000;

	EXPORT FCRA := MODULE
		EXPORT UNSIGNED2 MaxPawPerDID  := 100;
		EXPORT UNSIGNED2 MaxPawRecords := 10000;
	END;

end;
