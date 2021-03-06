// these fields have been added to the online and batch query.
// batch wants the new fields added to the end of the layout
// so pull them out of where they're located in final_denorm, and append them to the end
SEQ_NUMBERS := RECORD
	STRING1	PRI_seq_1;
	STRING1	PRI_seq_2;
	STRING1	PRI_seq_3;
	STRING1	PRI_seq_4;
	STRING1	PRI_seq_5;
	STRING1	PRI_seq_6;
	STRING1	PRI_seq_7;
	STRING1	PRI_seq_8;
	STRING1	Rep_PRI_seq_1;
	STRING1	Rep_PRI_seq_2;
	STRING1	Rep_PRI_seq_3;
	STRING1	Rep_PRI_seq_4;
	STRING1	Rep_PRI_seq_5;
	STRING1	Rep_PRI_seq_6;
	STRING1  Watchlist_seq_1;
	STRING1  Watchlist_seq_2;
	STRING1  Watchlist_seq_3;
	STRING1  Watchlist_seq_4;
	STRING1  Watchlist_seq_5;
	STRING1  Watchlist_seq_6;
	STRING1  Watchlist_seq_7;
	STRING1  RepWatchlist_seq_1;
	STRING1  RepWatchlist_seq_2;
	STRING1  RepWatchlist_seq_3;
	STRING1  RepWatchlist_seq_4;
	STRING1  RepWatchlist_seq_5;
	STRING1  RepWatchlist_seq_6;
	STRING1  RepWatchlist_seq_7;
END;

Chase_Rep_Attributes := RECORD
	STRING1 Rep_Lien_Unrel_Lvl := ''; // 0-5
	STRING1 Rep_Prop_Owner := ''; // 0-2
	STRING2 Rep_Prof_License_Category := ''; // (-1)-5
	STRING1 Rep_Accident_Count := ''; // 0-3
	STRING1 Rep_Paydayloan_Flag := ''; // Boolean (0-1)
	STRING2 Rep_Age_Lvl := ''; // 18, 25, 35, 45, 46
	STRING1 Rep_Bankruptcy_Count := ''; // 0-3
	STRING1 Rep_Ssns_Per_Adl := ''; // 0-4
	STRING1 Rep_Past_Arrest := ''; // Boolean (0-1)
	STRING3 Rep_Add1_Lres_Lvl := ''; // 0, 12, 24, 48, 72, 96, 192, 193
	STRING1 Rep_Criminal_Assoc_Lvl := ''; // 0, 1, 3, 4
	STRING1 Rep_Felony_Count := ''; // 0-2
END;

extra_fields := record
	string20		vercounty		:= '';
	string20 	RepCountyVerify := '';
	string8 sic_code := '';
	string8 naics_code := '';
	string105 business_description := '';
	unsigned1 recordcount := 0;
	
	string1		Hist_Addr_1_isBest		:= '';
	string1		Hist_Addr_2_isBest		:= '';
	string1		Hist_Addr_3_isBest		:= '';
	string3 SubjectSSNCount := '';
	string20 rep_verDL := '';
	string8 rep_deceasedDate := '';
	string8 rep_deceasedDOB := '';
	string15 rep_deceasedFirst := '';
	string20 rep_deceasedLast := '';
	string120 SOS_filing_name := '';
	STRING60  Watchlist_Table_2 := '';
	STRING120 Watchlist_Program_2 := '';
	STRING10  Watchlist_Record_Number_2 := '';
	STRING20  Watchlist_fname_2 := '';
	STRING20  Watchlist_lname_2 := '';
	STRING65  Watchlist_address_2 := '';
	STRING25  Watchlist_city_2 := '';
	STRING2   Watchlist_state_2 := '';
	STRING5   Watchlist_zip_2 := '';
	STRING30  Watchlist_country_2 := '';
	STRING200 Watchlist_Cmpy_2 := '';
	STRING60  Watchlist_Table_3 := '';
	STRING120 Watchlist_Program_3 := '';
	STRING10  Watchlist_Record_Number_3 := '';
	STRING20  Watchlist_fname_3 := '';
	STRING20  Watchlist_lname_3 := '';
	STRING65  Watchlist_address_3 := '';
	STRING25  Watchlist_city_3 := '';
	STRING2   Watchlist_state_3 := '';
	STRING5   Watchlist_zip_3 := '';
	STRING30  Watchlist_country_3 := '';
	STRING200 Watchlist_Cmpy_3 := '';
	STRING60  Watchlist_Table_4 := '';
	STRING120 Watchlist_Program_4 := '';
	STRING10  Watchlist_Record_Number_4 := '';
	STRING20  Watchlist_fname_4 := '';
	STRING20  Watchlist_lname_4 := '';
	STRING65  Watchlist_address_4 := '';
	STRING25  Watchlist_city_4 := '';
	STRING2   Watchlist_state_4 := '';
	STRING5   Watchlist_zip_4 := '';
	STRING30  Watchlist_country_4 := '';
	STRING200 Watchlist_Cmpy_4 := '';
	STRING60  Watchlist_Table_5 := '';
	STRING120 Watchlist_Program_5 := '';
	STRING10  Watchlist_Record_Number_5 := '';
	STRING20  Watchlist_fname_5 := '';
	STRING20  Watchlist_lname_5 := '';
	STRING65  Watchlist_address_5 := '';
	STRING25  Watchlist_city_5 := '';
	STRING2   Watchlist_state_5 := '';
	STRING5   Watchlist_zip_5 := '';
	STRING30  Watchlist_country_5 := '';
	STRING200 Watchlist_Cmpy_5 := '';
	STRING60  Watchlist_Table_6 := '';
	STRING120 Watchlist_Program_6 := '';
	STRING10  Watchlist_Record_Number_6 := '';
	STRING20  Watchlist_fname_6 := '';
	STRING20  Watchlist_lname_6 := '';
	STRING65  Watchlist_address_6 := '';
	STRING25  Watchlist_city_6 := '';
	STRING2   Watchlist_state_6 := '';
	STRING5   Watchlist_zip_6 := '';
	STRING30  Watchlist_country_6 := '';
	STRING200 Watchlist_Cmpy_6 := '';
	STRING60  Watchlist_Table_7 := '';
	STRING120 Watchlist_Program_7 := '';
	STRING10  Watchlist_Record_Number_7 := '';
	STRING20  Watchlist_fname_7 := '';
	STRING20  Watchlist_lname_7 := '';
	STRING65  Watchlist_address_7 := '';
	STRING25  Watchlist_city_7 := '';
	STRING2   Watchlist_state_7 := '';
	STRING5   Watchlist_zip_7 := '';
	STRING30  Watchlist_country_7 := '';
	STRING200 Watchlist_Cmpy_7 := '';
	STRING60  RepWatchlist_Table_2 := '';
	STRING120 RepWatchlist_Program_2 := '';
	STRING10  RepWatchlist_Record_Number_2 := '';
	STRING20  RepWatchlist_fname_2 := '';
	STRING20  RepWatchlist_lname_2 := '';
	STRING65  RepWatchlist_address_2 := '';
	STRING25  RepWatchlist_city_2 := '';
	STRING2   RepWatchlist_state_2 := '';
	STRING5   RepWatchlist_zip_2 := '';
	STRING30  RepWatchlist_country_2 := '';
	STRING200 RepWatchlist_Entity_Name_2 := '';
	STRING60  RepWatchlist_Table_3 := '';
	STRING120 RepWatchlist_Program_3 := '';
	STRING10  RepWatchlist_Record_Number_3 := '';
	STRING20  RepWatchlist_fname_3 := '';
	STRING20  RepWatchlist_lname_3 := '';
	STRING65  RepWatchlist_address_3 := '';
	STRING25  RepWatchlist_city_3 := '';
	STRING2   RepWatchlist_state_3 := '';
	STRING5   RepWatchlist_zip_3 := '';
	STRING30  RepWatchlist_country_3 := '';
	STRING200 RepWatchlist_Entity_Name_3 := '';
	STRING60  RepWatchlist_Table_4 := '';
	STRING120 RepWatchlist_Program_4 := '';
	STRING10  RepWatchlist_Record_Number_4 := '';
	STRING20  RepWatchlist_fname_4 := '';
	STRING20  RepWatchlist_lname_4 := '';
	STRING65  RepWatchlist_address_4 := '';
	STRING25  RepWatchlist_city_4 := '';
	STRING2   RepWatchlist_state_4 := '';
	STRING5   RepWatchlist_zip_4 := '';
	STRING30  RepWatchlist_country_4 := '';
	STRING200 RepWatchlist_Entity_Name_4 := '';
	STRING60  RepWatchlist_Table_5 := '';
	STRING120 RepWatchlist_Program_5 := '';
	STRING10  RepWatchlist_Record_Number_5 := '';
	STRING20  RepWatchlist_fname_5 := '';
	STRING20  RepWatchlist_lname_5 := '';
	STRING65  RepWatchlist_address_5 := '';
	STRING25  RepWatchlist_city_5 := '';
	STRING2   RepWatchlist_state_5 := '';
	STRING5   RepWatchlist_zip_5 := '';
	STRING30  RepWatchlist_country_5 := '';
	STRING200 RepWatchlist_Entity_Name_5 := '';
	STRING60  RepWatchlist_Table_6 := '';
	STRING120 RepWatchlist_Program_6 := '';
	STRING10  RepWatchlist_Record_Number_6 := '';
	STRING20  RepWatchlist_fname_6 := '';
	STRING20  RepWatchlist_lname_6 := '';
	STRING65  RepWatchlist_address_6 := '';
	STRING25  RepWatchlist_city_6 := '';
	STRING2   RepWatchlist_state_6 := '';
	STRING5   RepWatchlist_zip_6 := '';
	STRING30  RepWatchlist_country_6 := '';
	STRING200 RepWatchlist_Entity_Name_6 := '';
	STRING60  RepWatchlist_Table_7 := '';
	STRING120 RepWatchlist_Program_7 := '';
	STRING10  RepWatchlist_Record_Number_7 := '';
	STRING20  RepWatchlist_fname_7 := '';
	STRING20  RepWatchlist_lname_7 := '';
	STRING65  RepWatchlist_address_7 := '';
	STRING25  RepWatchlist_city_7 := '';
	STRING2   RepWatchlist_state_7 := '';
	STRING5   RepWatchlist_zip_7 := '';
	STRING30  RepWatchlist_country_7 := '';
	STRING200 RepWatchlist_Entity_Name_7 := '';
	SEQ_NUMBERS;
	Chase_Rep_Attributes;
end;

export Layout_Final_Batch := record
	string30	acctno;
	business_risk.Layout_Final_Denorm - extra_fields - RepSSNValid - Attributes - BusRiskIndicators - RepRiskIndicators;
	string3 fd_score1;
	string3 fd_score2;
	string3 fd_score3;
	string4	fd_Reason1;
	string100	fd_Desc1;
	string4	fd_Reason2;
	string100	fd_Desc2;
	string4	fd_Reason3;
	string100	fd_Desc3;
	string4	fd_Reason4;
	string100	fd_Desc4;
	extra_fields - recordcount - SEQ_NUMBERS;
end;
