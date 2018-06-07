import DueDiligence;

  EXPORT DictionaryValues_LegalEvents   := MODULE
	
	
	EXPORT LegalEventTypeDescription_layout  :=  RECORD
	   unsigned4     legalEventTypeWeight;
	   STRING50      LegalEventTypeDescription;
  END;
 
 
 EXPORT GetLegalEventTypeDescriptions()   := FUNCTION
//===========================================================
//=== DICTIONARY Values for Legal Event Types            ====
//===========================================================
 
 LegalEventTypeTEXT := dataset(
 [		
 {0,'No Legal Event Type Found'},
 {DueDiligence.Constants.PUBLIC_INTOXICATION_CODE,'Public Intoxication'},
 {DueDiligence.Constants.DISORDERLY_CONDUCT_CODE, 'Disorderly Conduct'},
 {DueDiligence.Constants.TRESPASSING_CODE,        'Tresspassing'},
 {DueDiligence.Constants.DUI_CODE,                'DUI'},
 {DueDiligence.Constants.TRAFFIC_OFFENSES_CODE,'   '},       //***Traffic Offenses are not searched 
 {DueDiligence.Constants.ALIEN_OFFENSES_CODE,'Alien Offenses'},
 {DueDiligence.Constants.SHOPLIFTING_CODE,'Shoplifting'},
 {DueDiligence.Constants.GAMBLING_BITCOIN_CODE,'Gambling or Bitcoin'},
 {DueDiligence.Constants.COMPUTER_OFFENSES_CODE,'Computer'},
 {DueDiligence.Constants.TAMPERING_CODE,'Tampering'},
 {DueDiligence.Constants.OBSTRUCTION_CODE,'Obstruction'},
 {DueDiligence.Constants.PERJURY_CODE,'Perjury'},
 {DueDiligence.Constants.VANDALISM_CODE,'Vandalism'},
 {DueDiligence.Constants.PROPERTY_DESTRUCTION_CODE,'Destruction of Property'},
 {DueDiligence.Constants.RESISTING_ARREST_CODE,'Resisting Arrests'},
 {DueDiligence.Constants.VIOLATE_RESTRAINING_ORDER_CODE,'Violating Orders'},
 {DueDiligence.Constants.CYBER_STALKING_CODE,'Cyber stalking'},
 {DueDiligence.Constants.STALKING_HARASSMENT_CODE,'Stalking or Harassment'},
 {DueDiligence.Constants.ANIMAL_FIGHTING_CODE,'Animal Fighting'},
 {DueDiligence.Constants.DOMESTIC_VIOLENCE_CODE,'Domestic Violence'},
 {DueDiligence.Constants.ASSAULT_CODE,'Assault - All Types'},
 {DueDiligence.Constants.ASSAULT_WITH_DEADLY_WEAPON_CODE,'Assault with a Deadly Weapon'},
 {DueDiligence.Constants.AGGRAVATED_ASSAULT_OR_BATTERY_CODE,'Aggravated Assault or Battery'},
 {DueDiligence.Constants.MOLESTATION_CODE,'Molestation'},
 {DueDiligence.Constants.RAPE_CODE,'Rape'},
 {DueDiligence.Constants.STATUTORY_RAPE_CODE,'Statutory Rape'},
 {DueDiligence.Constants.SEXUAL_ABUSE_CODE,'Sexual Abuse'},
 {DueDiligence.Constants.SEXUAL_ASSAULT_AND_BATTERY_CODE,'Sexual Assault and Battery'},
 {DueDiligence.Constants.PROSTITUTION_CODE,'Prostitution'},
 {DueDiligence.Constants.PORN_CODE,'Pornography'},
 {DueDiligence.Constants.SOLICITATION_CODE,'Solicitation'},
 {DueDiligence.Constants.BREAKING_AND_ENTERING_CODE,'Breaking and Entering'},
 {DueDiligence.Constants.BURGLARY_CODE,'Burglary'},
 {DueDiligence.Constants.ARSON_CODE,'Arson'},
 {DueDiligence.Constants.ORGANIZED_RETAIL_THEFT_CODE,'Organized Retail Theft'},
 {DueDiligence.Constants.LARCENY_CODE,'Larceny'},
 {DueDiligence.Constants.MISDEMEANOR_THEFT_CODE,'Misdemeanor Theft'},
 {DueDiligence.Constants.FELONY_THEFT_CODE,'Felony Theft'},
 {DueDiligence.Constants.ROBBERY_CODE,'Robbery'},
 {DueDiligence.Constants.ARMED_ROBBERY_CODE,'Armed Robbery'},
 {DueDiligence.Constants.BANK_ROBBERY_CODE,'Bank Robbery'},
 {DueDiligence.Constants.GRAND_LARCENY_CODE,'Grand Larceny'},
 {DueDiligence.Constants.KIDNAPPING_OR_ABDUCTION_CODE,'Kidnapping or Abduction'},
 {DueDiligence.Constants.ASSULT_WITH_INTENT_TO_KILL_CODE,'Assault with Intent to Kill or Intent to Kill'},
 {DueDiligence.Constants.MURDER_HOMOCIDE_MANSLAUGHTER_CODE,'Murder, Homicide, Manslaughter '},
 {DueDiligence.Constants.DISTRIBUTION_MANUFACTURING_TRANSPORTATION_CODE,'Distribution of Drugs or Weapons'},
 {DueDiligence.Constants.DRUG_OFFENSES_CODE,'Drugs'},
 {DueDiligence.Constants.WEAPONS_OFFENSES_CODE,'Weapons '},
 {DueDiligence.Constants.EXPLOSIVES_CODE,'Explosives'},
 {DueDiligence.Constants.TRAFFICKING_CODE,'Trafficking'},
 {DueDiligence.Constants.SMUGGLING_CODE,'Smuggling'},
 {DueDiligence.Constants.CHOP_SHOP_CODE,'Chop Shop'},
 {DueDiligence.Constants.HIJACKING_CODE,'Hijacking'},
 {DueDiligence.Constants.TAX_OFFENSES_CODE,'Tax'},
 {DueDiligence.Constants.CONCEALMENT_OF_FUNDS_CODE,'Concealment of Funds'},
 {DueDiligence.Constants.EXTORTION_CODE,'Extortion'},
 {DueDiligence.Constants.TREASON_ESPIONAGE_CODE,'Treason or Espionage'},
 {DueDiligence.Constants.INSIDER_TRADING_CODE,'Insider Trading or Manipulation'},
 {DueDiligence.Constants.WIRE_CODE,'Wire'},   
 {DueDiligence.Constants.INTERCEPT_COMMUNICATION_CODE,'Interception of Communication'},
 {DueDiligence.Constants.FALSE_PRETENSES_CODE,'Obtaining Property by False Pretenses'},
 {DueDiligence.Constants.EMBEZZLEMENT_CODE,'Embezzlement'},
 {DueDiligence.Constants.FORGERY_CODE,'Forgery'},
 {DueDiligence.Constants.CHECK_FRAUD_CODE,'Check Fraud/Bad Check'},
 {DueDiligence.Constants.COUNTERFEIT_CODE,'Counterfeiting'},
 {DueDiligence.Constants.ID_THEFT_CODE,'Identity Theft'},
 {DueDiligence.Constants.FRAUD_CODE,'Fraud'},
 {DueDiligence.Constants.TERROR_CODE,'Links to Terrorism'},
 {DueDiligence.Constants.ORGANIZED_CRIME_CODE,'Links to Organized Crime'},
 {DueDiligence.Constants.LAUNDER_CODE,'Money or Credit Card Laundering'},
 {DueDiligence.Constants.CORRUPT_BRIBE_CODE,'Corruption or Bribery'},
 {999,'No Charge Provided'}
 ], 
 LegalEventTypeDescription_layout);
 
 
 LegalEventTypeAnswer := DICTIONARY(LegalEventTypeTEXT, { legalEventTypeWeight   => LegalEventTypeDescription} );       //The Weight results in Some Text
   
 
  RETURN LegalEventTypeAnswer;
 
 END;  //end of function
 
  
EXPORT ReportLegalEventTypeDesc := GetLegalEventTypeDescriptions();
 
 END;  //end of module