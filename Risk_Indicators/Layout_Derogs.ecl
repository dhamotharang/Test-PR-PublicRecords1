export Layout_Derogs :=
RECORD
	BOOLEAN bankrupt := false;
	UNSIGNED4 date_last_seen := 0;
	STRING1 filing_type := '';
	STRING35 disposition := '';	
	UNSIGNED1 filing_count := 0;
	UNSIGNED1 filing_count120 := 0;
	UNSIGNED1 bk_recent_count := 0;
	UNSIGNED1 bk_dismissed_recent_count := 0;
	UNSIGNED1 bk_dismissed_historical_count := 0;
	UNSIGNED1 bk_dismissed_historical_cnt120 := 0;
	UNSIGNED1 bk_disposed_recent_count := 0;
	UNSIGNED1 bk_disposed_historical_count := 0;
	UNSIGNED1 bk_disposed_historical_cnt120 := 0;
	UNSIGNED1 bk_count30 := 0;
	UNSIGNED1 bk_count90 := 0;
	UNSIGNED1 bk_count180 := 0;
	UNSIGNED1 bk_count12 := 0;
	UNSIGNED1 bk_count24 := 0;
	UNSIGNED1 bk_count36 := 0;
	UNSIGNED1 bk_count60 := 0;
	STRING3   bk_chapter := '';
	INTEGER   bk_count12_6mos := 0;
	INTEGER   bk_count12_12mos := 0;
	INTEGER   bk_count12_24mos := 0;
	
	UNSIGNED1 liens_recent_unreleased_count := 0;
	UNSIGNED1 liens_historical_unreleased_count := 0;
	UNSIGNED1 liens_unreleased_count30 := 0;
	UNSIGNED1 liens_unreleased_count90 := 0;
	UNSIGNED1 liens_unreleased_count180 := 0;
	UNSIGNED1 liens_unreleased_count12 := 0;
	UNSIGNED1 liens_unreleased_count24 := 0;
	UNSIGNED1 liens_unreleased_count36 := 0;
	UNSIGNED1 liens_unreleased_count60 := 0;
	UNSIGNED1 liens_unreleased_count84 := 0;
	string8 last_liens_unreleased_date := '';
	string8 liens_last_unrel_date84 := '';
	INTEGER   liens_unreleased_count12_6mos := 0;
	INTEGER   liens_unreleased_count12_12mos := 0;
	INTEGER   liens_unreleased_count12_24mos := 0;
	
	UNSIGNED1 liens_recent_released_count := 0;
	UNSIGNED1 liens_historical_released_count := 0;
	UNSIGNED1 liens_released_count30 := 0;
	UNSIGNED1 liens_released_count90 := 0;
	UNSIGNED1 liens_released_count180 := 0;
	UNSIGNED1 liens_released_count12 := 0;
	UNSIGNED1 liens_released_count24 := 0;
	UNSIGNED1 liens_released_count36 := 0;
	UNSIGNED1 liens_released_count60 := 0;
	UNSIGNED1 liens_released_count84 := 0;
	UNSIGNED4 last_liens_released_date := 0;
	UNSIGNED4 liens_last_rel_date84 := 0;
	
	UNSIGNED1 criminal_count := 0;
	UNSIGNED1 criminal_count30 := 0;
	UNSIGNED1 criminal_count90 := 0;
	UNSIGNED1 criminal_count180 := 0;
	UNSIGNED1 criminal_count12 := 0;
	UNSIGNED1 criminal_count24 := 0;
	UNSIGNED1 criminal_count36 := 0;
	UNSIGNED1 criminal_count60 := 0;
	UNSIGNED4 last_criminal_date := 0;
	UNSIGNED1 felony_count := 0;
	UNSIGNED4 last_felony_date := 0;
	
	UNSIGNED1 nonfelony_criminal_count12 := 0;  // added for riskview attributes 5.0, populated only in FCRA shell
	UNSIGNED4 last_nonfelony_criminal_date := 0; // added for riskview attributes 5.0, populated only in FCRA shell

	INTEGER   criminal_count12_6mos := 0;
	INTEGER   criminal_count12_12mos := 0;
	INTEGER   criminal_count12_24mos := 0;
	
	UNSIGNED1 eviction_recent_unreleased_count := 0;
	UNSIGNED1 eviction_historical_unreleased_count := 0;
	UNSIGNED1 eviction_recent_released_count := 0;
	UNSIGNED1 eviction_historical_released_count := 0;
	UNSIGNED1 eviction_count := 0;
	UNSIGNED1 eviction_count30 := 0;
	UNSIGNED1 eviction_count90 := 0;
	UNSIGNED1 eviction_count180 := 0;
	UNSIGNED1 eviction_count12 := 0;
	UNSIGNED1 eviction_count24 := 0;
	UNSIGNED1 eviction_count36 := 0;
	UNSIGNED1 eviction_count60 := 0;
	UNSIGNED1 eviction_count84 := 0;
	UNSIGNED4 last_eviction_date := 0;
	INTEGER   eviction_count12_6mos := 0;
	INTEGER   eviction_count12_12mos := 0;
	INTEGER   eviction_count12_24mos := 0;
	
	UNSIGNED1 arrests_count := 0;
	UNSIGNED1 arrests_count30 := 0;
	UNSIGNED1 arrests_count90 := 0;
	UNSIGNED1 arrests_count180 := 0;
	UNSIGNED1 arrests_count12 := 0;
	UNSIGNED1 arrests_count24 := 0;
	UNSIGNED1 arrests_count36 := 0;
	UNSIGNED1 arrests_count60 := 0;
	UNSIGNED4 date_last_arrest := 0;
	
	BOOLEAN foreclosure_flag := false;
	STRING8 last_foreclosure_date := '';

END;