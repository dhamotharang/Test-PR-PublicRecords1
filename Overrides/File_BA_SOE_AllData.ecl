IMPORT $;
EXPORT File_BA_SOE_AllData := MODULE

	//Constants for file names.
	EXPORT AllDataSF := '~wwba::BA_SOE::SF::AllData';
	//EXPORT WeeklySF := '~CLASS::AA::SF::Weekly';
	//EXPORT DailySF   := '~CLASS::AA::SF::Daily';
	//EXPORT Base1   := '~ecltraining::in::namephonesupd1';
 // EXPORT Base2   := '~CLASS::AA::SF::NewBaseRollup1';
  
//you need export or shared since this record is being used out of this class.   
SHARED Rec := RECORD
		STRING SOURCE1;
		STRING ID1;
		STRING ORIG_NAME;
		STRING NAME;
		STRING REC_TYPE;
		STRING COUNTRY;
		STRING BIC;
		STRING SOURCE2;
		STRING ID2;
		STRING ORIG_NAME2;
		STRING NAME2;
		STRING REC_TYPE2;
		STRING COUNTRY2;
		STRING BIC2;
		STRING NAME_SCORE;
		STRING NAME_MISSING_SCORE;
		STRING BIC_SCORE;
		STRING BIC_TYPE_SCORE;
		STRING COUNTRY_SCORE;
		STRING COUNTRY_TYPE_SCORE;
		STRING FULL_MATCH_TOKENS;
		STRING FUZZY_MATCH_TOKENS;
		STRING MISSING_TOKENS;
		STRING NEGATIVE_SCORE;
		STRING MATCH_PERCENT;
		STRING TOTAL_SCORE;
		STRING UNIQUE_LINK_ID;

	END;
	
  //creating a datasets so it can be queried
	//EXPORT AllDataDS := DATASET(AllDataSF,Rec,THOR);
	EXPORT AllDataDS := DATASET(AllDataSF, Rec, csv(heading(single)));
	//EXPORT WeeklyDS  := DATASET(WeeklySF,Rec,THOR);
	//EXPORT DailyDS   := DATASET(DailySF,Rec,THOR);  
  
  
  
  
END;