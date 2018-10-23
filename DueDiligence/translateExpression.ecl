IMPORT DueDiligence, STD;

EXPORT translateExpression := MODULE

    //List of category levels
    EXPORT LEVEL_9 := 9;
    EXPORT LEVEL_8 := 8;
    EXPORT LEVEL_7 := 7;
    EXPORT LEVEL_6 := 6;
    EXPORT LEVEL_5 := 5;
    EXPORT LEVEL_4 := 4;
    EXPORT LEVEL_3 := 3;
    EXPORT LEVEL_2 := 2;
    SHARED LEVEL_0 := 0;  //not actual level - used to catch if it doesn't fall into a level hit (ie UNCATEGORIZED)
    
    //Enums - unique identifier for expressions, used as weight. When weight changes, just need to change order of the enum list here
    EXPORT ExpressionEnum := ENUM(UNCATEGORIZED = 0, NO_OFFENSE_PROVIDED, INFRACTIONS_AND_ORDINANCES, HUNTING_AND_FISHING, ZONING, COURT_CHARGES, ALCOHOL_RELATED, 
                                  TRAFFIC_OFFENSES, DUI, CHILD_SUPPORT, ALIEN_AND_IMMIGRATION, DISORDERLY_CONDUCT, TRESPASSING,
                                  SHOPLIFTING, ORGANIZED_RETAIL_THEFT, GAMBLING_BITCOIN, COMPUTER, FALSE_STATEMENTS_IMPERSONATION_IDENTIFICATION, TAMPERING, OBSTRUCTION,
                                  PERJURY, VANDALISM, DESTRUCTION_OF_PROPERTY, RESISTING_ARREST_ESCAPE_ELUDE, VIOLATING_ORDERS, FUGITIVE_OR_WARRANT, CYBER_STALKING,
                                  STALKING_HARASSMENT_TERRORIZE, ANIMAL_FIGHTING, DOMESTIC_AND_FAMILY_VIOLENCE_OR_ABUSE, ASSAULT, BREAKING_AND_ENTERING,
                                  BURGLARY, ARSON, KIDNAPPING_ABDUCTION, MURDER_MANSLAUGHTER, RAPE, STATUTORY_RAPE, SEX_OFFENSES, PROSTITUTION, PORNOGRAPHY, SOLICITATION,
                                  LARCENY, THEFT, FELONY_OR_AGGRAVATED_THEFT, CAR_JACK, ROBBERY, ARMED_ROBBERY, BANK_ROBBERY, GRAND_LARCENY, OBTAIN_PROPERTY_BY_FALSE_PRETENSES,
                                  CONCEALMENT_OF_FUNDS_OR_PROPERTY, TAX_OFFENSES, MISAPPROPRIATION_OF_FUNDS, EMBEZZLEMENT, FRAUD, CHECK_FRAUD_BAD_CHECK, IDENTITY_FRAUD_AND_THEFT,
                                  ORGANIZED_FRAUD, INSURANCE_FRAUD, HEALTHCARE_FRAUD, MORTGAGE_FRAUD, TAX_FRAUD, CREDIT_CARD_FRAUD, BANK_FRAUD, WIRE_FRAUD, SECURITIES_FRAUD, 
                                  FORGERY_AND_DEVICES, DRUGS, WEAPONS, DISTRIBUTION_DRUGS_OR_WEAPONS, EXPLOSIVES_DESTRUCTION_DEVICES, TRAFFICKING_SMUGGLING, CHOP_SHOP, GANG, 
                                  EXTORTION_BLACKMAIL, TREASON_ESPIONAGE, INSIDER_TRADING_MANIPULATION, INTERCEPTION_OF_COMMUNICATION_WIRETAPPING, TRANSPORTATION_VIOLATIONS, 
                                  IMPORT_EXPORT, CRIMINAL_PROCEEDS, TERRORISM, RACKETEERING_OR_LOAN_SHARKING, ORGANIZED_CRIME, STRUCTURING, MONEY_TRANSMITTER, 
                                  MONEY_LAUNDERING_TAX_EVASION, MONEY_OR_CREDIT_CARD_LAUNDERING, CORRUPTION_OR_BRIBERY);
    

                                  
                                  
    SHARED ExpressionDSLayout := RECORD
      UNSIGNED4 expressionWeight; //unique identifier used as a weight
      STRING expressionToUse;
      UNSIGNED1 expressionCategory; 
      STRING100 expressionText;     
    END;
    

    SHARED expressionDS := DATASET([{ExpressionEnum.UNCATEGORIZED, 				        DueDiligence.Constants.EMPTY,		                                        LEVEL_0, 	 'Uncategorized'},
                                    {ExpressionEnum.NO_OFFENSE_PROVIDED,		      DueDiligence.Constants.EMPTY,		                                        LEVEL_2,	 'No Offense Provided'},
                                    {ExpressionEnum.INFRACTIONS_AND_ORDINANCES,	  DueDiligence.RegularExpressions.EXPRESSION_INFRACTIONS_AND_ORDINANCES,	LEVEL_2,	 'Infractions and Ordinances'},
                                    {ExpressionEnum.HUNTING_AND_FISHING,	        DueDiligence.RegularExpressions.EXPRESSION_HUNTING_AND_FISHING,	        LEVEL_2,	 'Hunting and Fishing'},
                                    {ExpressionEnum.ZONING,	                      DueDiligence.RegularExpressions.EXPRESSION_ZONING,	                    LEVEL_2,	 'Zoning'},
                                    {ExpressionEnum.COURT_CHARGES,	              DueDiligence.RegularExpressions.EXPRESSION_COURT_CHARGES,	              LEVEL_2,	 'Court Charges'},
                                    {ExpressionEnum.ALCOHOL_RELATED,	            DueDiligence.RegularExpressions.EXPRESSION_ALCOHOL_RELATED,	            LEVEL_2,	 'Alcohol Related'},
                                    {ExpressionEnum.TRAFFIC_OFFENSES,	            DueDiligence.RegularExpressions.EXPRESSION_TRAFFIC_OFFENSES,	          LEVEL_2,	 'Traffic Offense'},
                                    {ExpressionEnum.DUI,	                        DueDiligence.RegularExpressions.EXPRESSION_DUI,	                        LEVEL_2,	 'DUI'},
                                    {ExpressionEnum.CHILD_SUPPORT,	              DueDiligence.RegularExpressions.EXPRESSION_CHILD_SUPPORT,	              LEVEL_2,	 'Child Support'},
                                    {ExpressionEnum.ALIEN_AND_IMMIGRATION,	      DueDiligence.RegularExpressions.EXPRESSION_ALIEN_AND_IMMIGRATION,	      LEVEL_2,	 'Alien Offenses'},
                                    {ExpressionEnum.DISORDERLY_CONDUCT,	          DueDiligence.RegularExpressions.EXPRESSION_DISORDERLY_CONDUCT,	        LEVEL_2,	 'Disorderly Conduct'},
                                    {ExpressionEnum.TRESPASSING,	                DueDiligence.RegularExpressions.EXPRESSION_TRESPASSING,	                LEVEL_2,	 'Trespassing'},
                                    {ExpressionEnum.SHOPLIFTING,	                DueDiligence.RegularExpressions.EXPRESSION_SHOPLIFTING,	                LEVEL_2,	 'Shoplifting'},
                                    {ExpressionEnum.ORGANIZED_RETAIL_THEFT,	      DueDiligence.RegularExpressions.EXPRESSION_ORGANIZED_RETAIL_THEFT,	    LEVEL_2,	 'Organized Retail Theft'},
                                    {ExpressionEnum.GAMBLING_BITCOIN,	            DueDiligence.RegularExpressions.EXPRESSION_GAMBLING_BITCOIN,            LEVEL_3,	 'Gambling / Bitcoin'},
                                    {ExpressionEnum.COMPUTER,	                    DueDiligence.RegularExpressions.EXPRESSION_COMPUTER,	                  LEVEL_3,	 'Computer'},
                                    {ExpressionEnum.FALSE_STATEMENTS_IMPERSONATION_IDENTIFICATION,	 DueDiligence.RegularExpressions.EXPRESSION_FALSE_STATEMENTS_IMPERSONATION_IDENTIFICATION,	 LEVEL_3,	 'False Statements, Impersonation, Identification'},
                                    {ExpressionEnum.TAMPERING,	                  DueDiligence.RegularExpressions.EXPRESSION_TAMPERING,	                  LEVEL_3,	 'Tampering'},
                                    {ExpressionEnum.OBSTRUCTION,	                DueDiligence.RegularExpressions.EXPRESSION_OBSTRUCTION,	                LEVEL_3,	 'Obstruction'},
                                    {ExpressionEnum.PERJURY,	                    DueDiligence.RegularExpressions.EXPRESSION_PERJURY,	                    LEVEL_3,	 'Perjury'},
                                    {ExpressionEnum.VANDALISM,	                  DueDiligence.RegularExpressions.EXPRESSION_VANDALISM,	                  LEVEL_4,	 'Vandalism'},
                                    {ExpressionEnum.DESTRUCTION_OF_PROPERTY,	    DueDiligence.RegularExpressions.EXPRESSION_DESTRUCTION_OF_PROPERTY,	    LEVEL_4,	 'Destruction of Property'},
                                    {ExpressionEnum.RESISTING_ARREST_ESCAPE_ELUDE,	 DueDiligence.RegularExpressions.EXPRESSION_RESISTING_ARREST_ESCAPE_ELUDE,	 LEVEL_4,	 'Resisting Arrest / Escape'},
                                    {ExpressionEnum.VIOLATING_ORDERS,	            DueDiligence.RegularExpressions.EXPRESSION_VIOLATING_ORDERS,	          LEVEL_4,	 'Violating Orders'},
                                    {ExpressionEnum.FUGITIVE_OR_WARRANT,	        DueDiligence.RegularExpressions.EXPRESSION_FUGITIVE_OR_WARRANT,	        LEVEL_4,	 'Fugitive or Warrant'},
                                    {ExpressionEnum.CYBER_STALKING,	              DueDiligence.RegularExpressions.EXPRESSION_CYBER_STALKING,	            LEVEL_4,	 'Cyber Stalking'},
                                    {ExpressionEnum.STALKING_HARASSMENT_TERRORIZE,	 DueDiligence.RegularExpressions.EXPRESSION_STALKING_HARASSMENT_TERRORIZE,	 LEVEL_4,	 'Stalking / Harassment / Terrorize'},
                                    {ExpressionEnum.ANIMAL_FIGHTING,	            DueDiligence.RegularExpressions.EXPRESSION_ANIMAL_FIGHTING,	            LEVEL_4,	 'Animal Fighting'},
                                    {ExpressionEnum.DOMESTIC_AND_FAMILY_VIOLENCE_OR_ABUSE,	 DueDiligence.RegularExpressions.EXPRESSION_DOMESTIC_AND_FAMILY_VIOLENCE_OR_ABUSE,	 LEVEL_4,	 'Domestic / Family Violence or Abuse'},
                                    {ExpressionEnum.ASSAULT,	                    DueDiligence.RegularExpressions.EXPRESSION_ASSAULT,	                    LEVEL_4,	 'Assault'},
                                    {ExpressionEnum.BREAKING_AND_ENTERING,	      DueDiligence.RegularExpressions.EXPRESSION_BREAKING_AND_ENTERING,	      LEVEL_4,	 'Breaking and Entering'},
                                    {ExpressionEnum.BURGLARY,	                    DueDiligence.RegularExpressions.EXPRESSION_BURGLARY,	                  LEVEL_4,	 'Burglary'},
                                    {ExpressionEnum.ARSON,	                      DueDiligence.RegularExpressions.EXPRESSION_ARSON,	                      LEVEL_4,	 'Arson'},
                                    {ExpressionEnum.KIDNAPPING_ABDUCTION,	        DueDiligence.RegularExpressions.EXPRESSION_KIDNAPPING_ABDUCTION,	      LEVEL_4,	 'Kidnapping / Abduction'},
                                    {ExpressionEnum.MURDER_MANSLAUGHTER,	        DueDiligence.RegularExpressions.EXPRESSION_MURDER_MANSLAUGHTER,	        LEVEL_4,	 'Murder / Homicide'},
                                    {ExpressionEnum.RAPE,	                        DueDiligence.RegularExpressions.EXPRESSION_RAPE,	                      LEVEL_5,	 'Rape'},
                                    {ExpressionEnum.STATUTORY_RAPE,	              DueDiligence.RegularExpressions.EXPRESSION_STATUTORY_RAPE,	            LEVEL_5,	 'Statutory Rape'},
                                    {ExpressionEnum.SEX_OFFENSES,	                DueDiligence.RegularExpressions.EXPRESSION_SEX_OFFENSES,	              LEVEL_5,	 'Sex Offenses'},
                                    {ExpressionEnum.PROSTITUTION,	                DueDiligence.RegularExpressions.EXPRESSION_PROSTITUTION,	              LEVEL_5,	 'Prostitution '},
                                    {ExpressionEnum.PORNOGRAPHY,	                DueDiligence.RegularExpressions.EXPRESSION_PORNOGRAPHY,	                LEVEL_5,	 'Pornography'},
                                    {ExpressionEnum.SOLICITATION,	                DueDiligence.RegularExpressions.EXPRESSION_SOLICITATION,	              LEVEL_5,	 'Solicitation'},
                                    {ExpressionEnum.LARCENY,	                    DueDiligence.RegularExpressions.EXPRESSION_LARCENY,	                    LEVEL_6,	 'Larceny'},
                                    {ExpressionEnum.THEFT,	                      DueDiligence.RegularExpressions.EXPRESSION_THEFT,	                      LEVEL_6,	 'Theft'},
                                    {ExpressionEnum.FELONY_OR_AGGRAVATED_THEFT,	  DueDiligence.RegularExpressions.EXPRESSION_FELONY_OR_AGGRAVATED_THEFT,	LEVEL_6,	 'Felony or Aggravated Theft'},
                                    {ExpressionEnum.CAR_JACK,	                    DueDiligence.RegularExpressions.EXPRESSION_CAR_JACK,	                  LEVEL_6,	 'Car Jack'},
                                    {ExpressionEnum.ROBBERY,	                    DueDiligence.RegularExpressions.EXPRESSION_ROBBERY,	                    LEVEL_6,	 'Robbery'},
                                    {ExpressionEnum.ARMED_ROBBERY,	              DueDiligence.RegularExpressions.EXPRESSION_ARMED_ROBBERY,	              LEVEL_6,	 'Armed Robbery'},
                                    {ExpressionEnum.BANK_ROBBERY,	                DueDiligence.RegularExpressions.EXPRESSION_BANK_ROBBERY,	              LEVEL_6,	 'Bank Robbery'},
                                    {ExpressionEnum.GRAND_LARCENY,	              DueDiligence.RegularExpressions.EXPRESSION_GRAND_LARCENY,	              LEVEL_6,	 'Grand Larceny'},
                                    {ExpressionEnum.OBTAIN_PROPERTY_BY_FALSE_PRETENSES,	  DueDiligence.RegularExpressions.EXPRESSION_OBTAIN_PROPERTY_BY_FALSE_PRETENSES,	 LEVEL_7,	 'Obtaining Property by False Pretenses'},
                                    {ExpressionEnum.CONCEALMENT_OF_FUNDS_OR_PROPERTY,	    DueDiligence.RegularExpressions.EXPRESSION_CONCEALMENT_OF_FUNDS_OR_PROPERTY,	 LEVEL_7,	 'Concealment of Funds'},
                                    {ExpressionEnum.TAX_OFFENSES,	                DueDiligence.RegularExpressions.EXPRESSION_TAX_OFFENSES,	              LEVEL_7,	 'Tax Offenses'},
                                    {ExpressionEnum.MISAPPROPRIATION_OF_FUNDS,	  DueDiligence.RegularExpressions.EXPRESSION_MISAPPROPRIATION_OF_FUNDS,	  LEVEL_7,	 'Misappropriation of Funds'},
                                    {ExpressionEnum.EMBEZZLEMENT,	                DueDiligence.RegularExpressions.EXPRESSION_EMBEZZLEMENT,	              LEVEL_7,	 'Embezzlement'},
                                    {ExpressionEnum.FRAUD,	                      DueDiligence.RegularExpressions.EXPRESSION_FRAUD,	                      LEVEL_7,	 'Fraud'},
                                    {ExpressionEnum.CHECK_FRAUD_BAD_CHECK,	      DueDiligence.RegularExpressions.EXPRESSION_CHECK_FRAUD_BAD_CHECK,	      LEVEL_7,	 'Check Fraud / Bad Check'},
                                    {ExpressionEnum.IDENTITY_FRAUD_AND_THEFT,	    DueDiligence.RegularExpressions.EXPRESSION_IDENTITY_FRAUD_AND_THEFT,	  LEVEL_7,	 'Identity Fraud & Theft'},
                                    {ExpressionEnum.ORGANIZED_FRAUD,	            DueDiligence.RegularExpressions.EXPRESSION_ORGANIZED_FRAUD,	            LEVEL_7,	 'Organized Fraud'},
                                    {ExpressionEnum.INSURANCE_FRAUD,	            DueDiligence.RegularExpressions.EXPRESSION_INSURANCE_FRAUD,	            LEVEL_7,	 'Insurance Fraud'},
                                    {ExpressionEnum.HEALTHCARE_FRAUD,	            DueDiligence.RegularExpressions.EXPRESSION_HEALTHCARE_FRAUD,	          LEVEL_7,	 'Healthcare Fraud'},
                                    {ExpressionEnum.MORTGAGE_FRAUD,	              DueDiligence.RegularExpressions.EXPRESSION_MORTGAGE_FRAUD,	            LEVEL_7,	 'Mortgage Fraud'},
                                    {ExpressionEnum.TAX_FRAUD,	                  DueDiligence.RegularExpressions.EXPRESSION_TAX_FRAUD,	                  LEVEL_7,	 'Tax Fraud'},
                                    {ExpressionEnum.CREDIT_CARD_FRAUD,	          DueDiligence.RegularExpressions.EXPRESSION_CREDIT_CARD_FRAUD,	          LEVEL_7,	 'Credit Card Fraud'},
                                    {ExpressionEnum.BANK_FRAUD,	                  DueDiligence.RegularExpressions.EXPRESSION_BANK_FRAUD,	                LEVEL_7,	 'Bank Fraud'},
                                    {ExpressionEnum.WIRE_FRAUD,                   DueDiligence.RegularExpressions.EXPRESSION_WIRE_FRAUD,	                LEVEL_7,	 'Wire Fraud'},
                                    {ExpressionEnum.SECURITIES_FRAUD,	            DueDiligence.RegularExpressions.EXPRESSION_SECURITIES_FRAUD,	          LEVEL_7,	 'Securities Fraud'},
                                    {ExpressionEnum.FORGERY_AND_DEVICES,	        DueDiligence.RegularExpressions.EXPRESSION_FORGERY_AND_DEVICES,	        LEVEL_7,	 'Forgery'},
                                    {ExpressionEnum.DRUGS,	                      DueDiligence.RegularExpressions.EXPRESSION_DRUGS,	                      LEVEL_8,	 'Drugs'},
                                    {ExpressionEnum.WEAPONS,	                    DueDiligence.RegularExpressions.EXPRESSION_WEAPONS,	                    LEVEL_8,	 'Weapons'},
                                    {ExpressionEnum.DISTRIBUTION_DRUGS_OR_WEAPONS,	 DueDiligence.RegularExpressions.EXPRESSION_DISTRIBUTION_DRUGS_OR_WEAPONS,	  LEVEL_8,	 'Distribution or Manufacturing of Drugs or Weapons'},
                                    {ExpressionEnum.EXPLOSIVES_DESTRUCTION_DEVICES,	 DueDiligence.RegularExpressions.EXPRESSION_EXPLOSIVES_DESTRUCTION_DEVICES,	  LEVEL_8,	 'Explosives / Destruction Devices'},
                                    {ExpressionEnum.TRAFFICKING_SMUGGLING,	      DueDiligence.RegularExpressions.EXPRESSION_TRAFFICKING_SMUGGLING,	      LEVEL_8,	 'Trafficking / Smuggling'},
                                    {ExpressionEnum.CHOP_SHOP,	                  DueDiligence.RegularExpressions.EXPRESSION_CHOP_SHOP,	                  LEVEL_9,	 'Chop Shop'},
                                    {ExpressionEnum.GANG,	                        DueDiligence.RegularExpressions.EXPRESSION_GANG,	                      LEVEL_9,	 'Gang'},
                                    {ExpressionEnum.EXTORTION_BLACKMAIL,	        DueDiligence.RegularExpressions.EXPRESSION_EXTORTION_BLACKMAIL,	        LEVEL_9,	 'Extortion / Blackmail'},
                                    {ExpressionEnum.TREASON_ESPIONAGE,	          DueDiligence.RegularExpressions.EXPRESSION_TREASON_ESPIONAGE,	          LEVEL_9,	 'Treason /  Espionage'},
                                    {ExpressionEnum.INSIDER_TRADING_MANIPULATION,	DueDiligence.RegularExpressions.EXPRESSION_INSIDER_TRADING_MANIPULATION,LEVEL_9,	 'Insider Trading / Manipulation'},
                                    {ExpressionEnum.INTERCEPTION_OF_COMMUNICATION_WIRETAPPING,	 DueDiligence.RegularExpressions.EXPRESSION_INTERCEPTION_OF_COMMUNICATION_WIRETAPPING,	 LEVEL_9,	 'Interception of Communication / Wiretapping'},
                                    {ExpressionEnum.TRANSPORTATION_VIOLATIONS,	  DueDiligence.RegularExpressions.EXPRESSION_TRANSPORTATION_VIOLATIONS,	  LEVEL_9,	 'Transportation Violations'},
                                    {ExpressionEnum.IMPORT_EXPORT,	              DueDiligence.RegularExpressions.EXPRESSION_IMPORT_EXPORT,	              LEVEL_9,	 'Import / Export'},
                                    {ExpressionEnum.CRIMINAL_PROCEEDS,	          DueDiligence.RegularExpressions.EXPRESSION_CRIMINAL_PROCEEDS,	          LEVEL_9,	 'Criminal Proceeds'},
                                    {ExpressionEnum.TERRORISM,	                  DueDiligence.RegularExpressions.EXPRESSION_TERRORISM,	                  LEVEL_9,	 'Terrorism'},
                                    {ExpressionEnum.RACKETEERING_OR_LOAN_SHARKING,	    DueDiligence.RegularExpressions.EXPRESSION_RACKETEERING_OR_LOAN_SHARKING,	    LEVEL_9,	 'Racketeering'},
                                    {ExpressionEnum.ORGANIZED_CRIME,	            DueDiligence.RegularExpressions.EXPRESSION_ORGANIZED_CRIME,	            LEVEL_9,	 'Organized Crime'},
                                    {ExpressionEnum.STRUCTURING,	                DueDiligence.RegularExpressions.EXPRESSION_STRUCTURING,	                LEVEL_9,	 'Structuring'},
                                    {ExpressionEnum.MONEY_TRANSMITTER,	          DueDiligence.RegularExpressions.EXPRESSION_MONEY_TRANSMITTER,	          LEVEL_9,	 'Money Transmitter'},
                                    {ExpressionEnum.MONEY_LAUNDERING_TAX_EVASION,	DueDiligence.RegularExpressions.EXPRESSION_MONEY_LAUNDERING_TAX_EVASION,            LEVEL_9,	 'Money Laundering Tax Evasion'},
                                    {ExpressionEnum.MONEY_OR_CREDIT_CARD_LAUNDERING,	  DueDiligence.RegularExpressions.EXPRESSION_MONEY_OR_CREDIT_CARD_LAUNDERING,	  LEVEL_9,	 'Money or Credit Card Laundering'},
                                    {ExpressionEnum.CORRUPTION_OR_BRIBERY,	      DueDiligence.RegularExpressions.EXPRESSION_CORRUPTION_OR_BRIBERY,	      LEVEL_9,	 'Corruption or Bribery'}], ExpressionDSLayout);
                                
                                
                                
    SHARED expressionDCT := DICTIONARY(expressionDS, {expressionWeight => expressionDS}); 
    
    
    SHARED additionalChecksToExpression(UNSIGNED4 enumReference, STRING1 offenseScore, UNSIGNED offenseCategory, STRING1 trafficFlag, BOOLEAN foundUsingExpression) := FUNCTION
                         
       additionalChecks := CASE(enumReference,
                                  ExpressionEnum.THEFT => MAP(offenseScore = DueDiligence.Constants.FELONY AND foundUsingExpression => ExpressionEnum.FELONY_OR_AGGRAVATED_THEFT,
                                                              foundUsingExpression => enumReference,
                                                              ExpressionEnum.UNCATEGORIZED),
                                  
                                  ExpressionEnum.TRAFFIC_OFFENSES => IF(offenseScore = DueDiligence.Constants.TRAFFIC OR 
                                                                        trafficFlag = DueDiligence.Constants.YES OR
                                                                        offenseCategory = 1073741824 OR
                                                                        foundUsingExpression, enumReference, ExpressionEnum.UNCATEGORIZED),
                                  
                                  ExpressionEnum.TRAFFICKING_SMUGGLING => IF(foundUsingExpression AND 
                                                                              offenseScore <> DueDiligence.Constants.TRAFFIC AND
                                                                              trafficFlag <> DueDiligence.Constants.YES, enumReference, ExpressionEnum.UNCATEGORIZED),
                                  
                                  ExpressionEnum.ALCOHOL_RELATED => IF(offenseCategory = 137438953472 OR foundUsingExpression, enumReference, ExpressionEnum.UNCATEGORIZED),
                                  
                                  ExpressionEnum.INFRACTIONS_AND_ORDINANCES => IF(offenseScore = DueDiligence.Constants.INFRACTION or foundUsingExpression, enumReference, ExpressionEnum.UNCATEGORIZED),
                                  
                                  ExpressionEnum.UNCATEGORIZED);            


        RETURN additionalChecks;
    END;
    
    
    
    //Common routine to determine if the text contains the definition of the expression
		SHARED doesTextContainExpression(UNSIGNED4 enumReference, STRING textToSearch, STRING1 offenseScore, UNSIGNED offenseCategory, STRING1 trafficFlag) := FUNCTION
    
        trimTextToSearch := TRIM(textToSearch, LEFT, RIGHT);
        
        expressionDetails := expressionDCT[enumReference];
        
        expressionResults := IF(REGEXFIND(expressionDetails.expressionToUse, textToSearch, NOCASE), expressionDetails.expressionWeight, ExpressionEnum.UNCATEGORIZED);
                                 
                                 
        expressionFound := expressionResults NOT IN [ExpressionEnum.UNCATEGORIZED];
                               
                               
        //if the enum passed in is in the following group, there are additional checks to make prior to just using the expression itself
        additionalChecks := IF(enumReference IN [ExpressionEnum.ALCOHOL_RELATED, ExpressionEnum.TRAFFIC_OFFENSES, ExpressionEnum.THEFT, ExpressionEnum.TRAFFICKING_SMUGGLING, ExpressionEnum.INFRACTIONS_AND_ORDINANCES],
                                additionalChecksToExpression(enumReference, offenseScore, offenseCategory, trafficFlag, expressionFound),
                                expressionResults);
        
        //If we haven't categorized the offense, and in level 2 accounting for empty and 'Not Specified' offenses so they don't falsely hit in other levels (level 2 is lowest)
        levelMatch := IF(additionalChecks = ExpressionEnum.UNCATEGORIZED,
                          MAP(expressionDetails.expressionCategory = LEVEL_2 AND trimTextToSearch = DueDiligence.Constants.EMPTY => ExpressionEnum.NO_OFFENSE_PROVIDED,
                              expressionDetails.expressionCategory = LEVEL_2 AND STD.str.ToUpperCase(trimTextToSearch) = 'NOT SPECIFIED' => ExpressionEnum.NO_OFFENSE_PROVIDED,
                              expressionDetails.expressionCategory = LEVEL_2 AND expressionDetails.expressionToUse = DueDiligence.Constants.EMPTY => ExpressionEnum.UNCATEGORIZED,
                              additionalChecks),
                          additionalChecks);
        
        RETURN levelMatch;
		END;
    
    
    
    

    EXPORT expressionDetails(ExpressionEnum expressionReference) := expressionDCT[expressionReference];
    EXPORT expressionTextByEnum(ExpressionEnum expressionReference) := expressionDCT[expressionReference].expressionText;
    EXPORT expressionDictionary := expressionDCT;
    
    
    EXPORT getMaxLevel(STRING charge, STRING1 offenseScore, UNSIGNED offenseCategory, STRING1 trafficFlag, UNSIGNED1 level) := FUNCTION
        
        tempCharge := charge + ' '; //adding blank to account for charges that end with schedule I/II/III/IV, etc.. (have to be surrounded by blanks)
          
        allInLevel := expressionDS(expressionCategory = level);
        
        determineMaxLevel := PROJECT(allInLevel, 
                                      TRANSFORM({RECORDOF(LEFT), UNSIGNED levelResult},
                                                resultedWeight := doesTextContainExpression(LEFT.expressionWeight, tempCharge, offenseScore, offenseCategory, trafficFlag);
                                                
                                                SELF.levelResult := resultedWeight;
                                                SELF := LEFT;));
        
        getMaxLevelByLevel := DEDUP(SORT(determineMaxLevel, -levelResult, -expressionWeight), expressionCategory);

        RETURN getMaxLevelByLevel[1].levelResult;
    END;
END;