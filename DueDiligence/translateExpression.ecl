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
    EXPORT ExpressionEnum := ENUM(UNCATEGORIZED = 0, NO_OFFENSE_PROVIDED, HUNTING_AND_FISHING, ZONING, COURT_CHARGES, ALCOHOL_RELATED, DISORDERLY_CONDUCT, TRESPASSING, 
                                  TRAFFIC_OFFENSES, DUI, ALIEN_OFFENSES, SHOPLIFTING, ORGANIZED_RETAIL_THEFT, GAMBLING_BITCOIN, COMPUTER_OFFENSES, TAMPERING, 
                                  OBSTRUCTION, PERJURY, VANDALISM, PROPERTY_DESTRUCTION, RESISTING_ARREST, VIOLATE_ORDER, CYBER_STALKING, 
                                  STALKING_HARASSMENT, ANIMAL_FIGHTING, DOMESTIC_VIOLENCE, ASSAULT, ASSAULT_DEADLY_WEAPON, AGGRAVATED_ASSAULT, 
                                  BREAKING_AND_ENTERING, BURGLARY, ARSON, KIDNAPPING, ASSULT_INTENT_TO_KILL, MURDER, 
                                  MOLESTATION, RAPE, STATUTORY_RAPE, SEXUAL_ABUSE, SEXUAL_ASSAULT_BATTERY, PROSTITUTION, PORN, SOLICITATION, LARCENY, 
                                  THEFT, FELONY_THEFT, ID_THEFT, ROBBERY, ARMED_ROBBERY, BANK_ROBBERY, GRAND_LARCENY, FALSE_PRETENSES, 
                                  CONCEALMENT_OF_FUNDS, TAX_OFFENSES, EMBEZZLEMENT, FORGERY, CHECK_FRAUD, FRAUD, DRUG_OFFENSES, WEAPONS_OFFENSES, 
                                  DIST_MANUF_TRANS, EXPLOSIVES, TRAFFICKING_SMUGGLING, CHOP_SHOP, HIJACKING, EXTORTION, 
                                  TREASON_ESPIONAGE, INSIDER_TRADING, COMMUNICATE_WIRE_DEVICE, COUNTERFEIT, TERRORISM, ORGANIZED_CRIME, LAUNDER, CORRUPT_BRIBE );
    

                                  
                                  
    SHARED ExpressionDSLayout := RECORD
      UNSIGNED4   expressionWeight; //unique identifier used as a weight
      STRING      expressionToUse;
      UNSIGNED1   expressionCategory; 
      STRING100    expressionText;     
    END;
    

    SHARED expressionDS := DATASET([{ExpressionEnum.UNCATEGORIZED, 				    DueDiligence.Constants.EMPTY,		                                    LEVEL_0, 		'Uncategorized'},
                                    {ExpressionEnum.NO_OFFENSE_PROVIDED,		  DueDiligence.Constants.EMPTY,		                                    LEVEL_2,		'No Offense Provided'},
                                    {ExpressionEnum.HUNTING_AND_FISHING,		  DueDiligence.RegularExpressions.EXPRESSION_HUNTING_FISHING,			    LEVEL_2,		'Hunting and Fishing'},
                                    {ExpressionEnum.ZONING,						        DueDiligence.RegularExpressions.EXPRESSION_ZONING,					        LEVEL_2,		'Zoning'},
                                    {ExpressionEnum.COURT_CHARGES, 				    DueDiligence.RegularExpressions.EXPRESSION_COURT_CHARGES,			      LEVEL_2, 		'Court Charges'},
                                    {ExpressionEnum.ALCOHOL_RELATED, 			    DueDiligence.RegularExpressions.EXPRESSION_ALCOHOL_RELATED,			    LEVEL_2, 		'Alcohol Related'},
                                    {ExpressionEnum.DISORDERLY_CONDUCT, 		  DueDiligence.RegularExpressions.EXPRESSION_DISORDERLY_CONDUCT,		  LEVEL_2, 		'Disorderly Conduct'},
                                    {ExpressionEnum.TRESPASSING, 				      DueDiligence.RegularExpressions.EXPRESSION_TRESPASSING,				      LEVEL_2, 		'Trespassing'},
                                    {ExpressionEnum.TRAFFIC_OFFENSES,			    DueDiligence.RegularExpressions.EXPRESSION_TRAFFIC_OFFENSES,		    LEVEL_2, 		'Traffic Offense'},
                                    {ExpressionEnum.DUI, 						          DueDiligence.RegularExpressions.EXPRESSION_DUI,						          LEVEL_2, 		'DUI'},
                                    {ExpressionEnum.ALIEN_OFFENSES, 			    DueDiligence.RegularExpressions.EXPRESSION_ALIEN_OFFENSES,			    LEVEL_2, 		'Alien Offenses'},
                                    {ExpressionEnum.SHOPLIFTING, 				      DueDiligence.RegularExpressions.EXPRESSION_SHOPLIFTING, 			      LEVEL_2, 		'Shoplifting'},
                                    {ExpressionEnum.ORGANIZED_RETAIL_THEFT, 	DueDiligence.RegularExpressions.EXPRESSION_ORGANIZED_RETAIL_THEFT, 	LEVEL_2, 		'Organized Retail Theft'},
                                    {ExpressionEnum.GAMBLING_BITCOIN, 			  DueDiligence.RegularExpressions.EXPRESSION_GAMBLING_BITCOIN, 		    LEVEL_3, 		'Gambling/Bitcoin'},
                                    {ExpressionEnum.COMPUTER_OFFENSES, 			  DueDiligence.RegularExpressions.EXPRESSION_COMPUTER_OFFENSES, 		  LEVEL_3, 		'Computer'},
                                    {ExpressionEnum.TAMPERING, 					      DueDiligence.RegularExpressions.EXPRESSION_TAMPERING, 				      LEVEL_3, 		'Tampering'},
                                    {ExpressionEnum.OBSTRUCTION, 				      DueDiligence.RegularExpressions.EXPRESSION_OBSTRUCTION, 			      LEVEL_3, 		'Obstruction'},
                                    {ExpressionEnum.PERJURY, 					        DueDiligence.RegularExpressions.EXPRESSION_PERJURY, 				        LEVEL_3, 		'Perjury'},
                                    {ExpressionEnum.VANDALISM, 				      	DueDiligence.RegularExpressions.EXPRESSION_VANDALISM, 				      LEVEL_4, 		'Vandalism'},
                                    {ExpressionEnum.PROPERTY_DESTRUCTION, 		DueDiligence.RegularExpressions.EXPRESSION_PROPERTY_DESTRUCTION, 	  LEVEL_4, 		'Destruction of Property'},
                                    {ExpressionEnum.RESISTING_ARREST, 			  DueDiligence.RegularExpressions.EXPRESSION_RESISTING_ARREST, 		    LEVEL_4, 		'Resisting Arrest/Escape/Elude'},
                                    {ExpressionEnum.VIOLATE_ORDER, 	          DueDiligence.RegularExpressions.EXPRESSION_VIOLATE_ORDER, 			    LEVEL_4, 	  'Violating Orders'},
                                    {ExpressionEnum.CYBER_STALKING, 			    DueDiligence.RegularExpressions.EXPRESSION_CYBER_STALKING, 			    LEVEL_4, 		'Cyber Stalking'},
                                    {ExpressionEnum.STALKING_HARASSMENT, 		  DueDiligence.RegularExpressions.EXPRESSION_STALKING_HARASSMENT, 	  LEVEL_4, 		'Stalking/Harassment/Terrorize'},
                                    {ExpressionEnum.ANIMAL_FIGHTING, 			    DueDiligence.RegularExpressions.EXPRESSION_ANIMAL_FIGHTING, 		    LEVEL_4, 		'Animal Fighting'},
                                    {ExpressionEnum.DOMESTIC_VIOLENCE, 			  DueDiligence.RegularExpressions.EXPRESSION_DOMESTIC_VIOLENCE, 		  LEVEL_4, 		'Domestic/Family Violence'},
                                    {ExpressionEnum.ASSAULT, 					        DueDiligence.RegularExpressions.EXPRESSION_ASSAULT, 				        LEVEL_4, 		'Assault-All Types'},
                                    {ExpressionEnum.ASSAULT_DEADLY_WEAPON, 	  DueDiligence.RegularExpressions.EXPRESSION_ASSAULT_DEADLY_WEAPON, 	LEVEL_4, 	  'Assault with a Deadly Weapon'},
                                    {ExpressionEnum.AGGRAVATED_ASSAULT, 	    DueDiligence.RegularExpressions.EXPRESSION_AGGRAVATED_ASSAULT, 	    LEVEL_4, 	  'Aggravated Assault/Battery'},
                                    {ExpressionEnum.BREAKING_AND_ENTERING, 		DueDiligence.RegularExpressions.EXPRESSION_BREAKING_AND_ENTERING, 	LEVEL_4, 		'Breaking and Entering'},
                                    {ExpressionEnum.BURGLARY, 					      DueDiligence.RegularExpressions.EXPRESSION_BURGLARY, 				        LEVEL_4, 		'Burglary'},
                                    {ExpressionEnum.ARSON, 						        DueDiligence.RegularExpressions.EXPRESSION_ARSON, 					        LEVEL_4, 		'Arson'},
                                    {ExpressionEnum.KIDNAPPING, 	            DueDiligence.RegularExpressions.EXPRESSION_KIDNAPPING, 			        LEVEL_4, 	  'Kidnapping/Abduction'},
                                    {ExpressionEnum.ASSULT_INTENT_TO_KILL, 	  DueDiligence.RegularExpressions.EXPRESSION_ASSULT_INTENT_TO_KILL, 	LEVEL_4, 	  'Assault with Intent to Kill/Intent to Kill/Deadly Conduct'},
                                    {ExpressionEnum.MURDER, 	                DueDiligence.RegularExpressions.EXPRESSION_MURDER, 	                LEVEL_4, 	  'Murder/Homicide/Manslaughter'},
                                    {ExpressionEnum.MOLESTATION, 				      DueDiligence.RegularExpressions.EXPRESSION_MOLESTATION, 			      LEVEL_5, 		'Molestation'},
                                    {ExpressionEnum.RAPE, 						        DueDiligence.RegularExpressions.EXPRESSION_RAPE, 					          LEVEL_5, 		'Rape'},
                                    {ExpressionEnum.STATUTORY_RAPE, 			    DueDiligence.RegularExpressions.EXPRESSION_STATUTORY_RAPE, 			    LEVEL_5, 		'Statutory Rape'},
                                    {ExpressionEnum.SEXUAL_ABUSE, 				    DueDiligence.RegularExpressions.EXPRESSION_SEXUAL_ABUSE, 			      LEVEL_5, 		'Sexual Abuse'},
                                    {ExpressionEnum.SEXUAL_ASSAULT_BATTERY, 	DueDiligence.RegularExpressions.EXPRESSION_SEXUAL_ASSAULT_BATTERY, 	LEVEL_5, 	  'Sexual Assault and Battery'},
                                    {ExpressionEnum.PROSTITUTION, 				    DueDiligence.RegularExpressions.EXPRESSION_PROSTITUTION, 			      LEVEL_5, 		'Prostitution'},
                                    {ExpressionEnum.PORN, 						        DueDiligence.RegularExpressions.EXPRESSION_PORN, 					          LEVEL_5, 		'Pornography'},
                                    {ExpressionEnum.SOLICITATION, 				    DueDiligence.RegularExpressions.EXPRESSION_SOLICITATION, 			      LEVEL_5, 		'Solicitation'},
                                    {ExpressionEnum.LARCENY, 					        DueDiligence.RegularExpressions.EXPRESSION_LARCENY, 				        LEVEL_6, 		'Larceny'},
                                    {ExpressionEnum.THEFT, 			              DueDiligence.RegularExpressions.EXPRESSION_THEFT, 		              LEVEL_6, 		'Theft'},
                                    {ExpressionEnum.FELONY_THEFT, 				    DueDiligence.RegularExpressions.EXPRESSION_FELONY_THEFT, 			      LEVEL_6, 		'Felony Theft'},
                                    {ExpressionEnum.ID_THEFT, 					      DueDiligence.RegularExpressions.EXPRESSION_ID_THEFT, 				        LEVEL_6, 		'Identity Theft'},
                                    {ExpressionEnum.ROBBERY, 					        DueDiligence.RegularExpressions.EXPRESSION_ROBBERY, 				        LEVEL_6, 		'Robbery'},
                                    {ExpressionEnum.ARMED_ROBBERY, 			    	DueDiligence.RegularExpressions.EXPRESSION_ARMED_ROBBERY, 			    LEVEL_6, 		'Armed Robbery'},
                                    {ExpressionEnum.BANK_ROBBERY, 				    DueDiligence.RegularExpressions.EXPRESSION_BANK_ROBBERY, 			      LEVEL_6, 		'Bank Robbery'},
                                    {ExpressionEnum.GRAND_LARCENY, 			    	DueDiligence.RegularExpressions.EXPRESSION_GRAND_LARCENY, 			    LEVEL_6, 		'Grand Larceny'},
                                    {ExpressionEnum.FALSE_PRETENSES, 		    	DueDiligence.RegularExpressions.EXPRESSION_FALSE_PRETENSES, 		    LEVEL_7, 		'Obtaining Property by False Pretenses'},
                                    {ExpressionEnum.CONCEALMENT_OF_FUNDS, 		DueDiligence.RegularExpressions.EXPRESSION_CONCEALMENT_OF_FUNDS, 	  LEVEL_7, 		'Concealment of Funds'},
                                    {ExpressionEnum.TAX_OFFENSES, 				    DueDiligence.RegularExpressions.EXPRESSION_TAX_OFFENSES, 			      LEVEL_7, 		'Tax Offenses'},
                                    {ExpressionEnum.EMBEZZLEMENT, 				    DueDiligence.RegularExpressions.EXPRESSION_EMBEZZLEMENT, 			      LEVEL_7, 		'Embezzlement'},
                                    {ExpressionEnum.FORGERY, 					        DueDiligence.RegularExpressions.EXPRESSION_FORGERY, 				        LEVEL_7, 		'Forgery'},
                                    {ExpressionEnum.CHECK_FRAUD, 				      DueDiligence.RegularExpressions.EXPRESSION_CHECK_FRAUD, 		      	LEVEL_7, 		'Check Fraud/Bad Check'},
                                    {ExpressionEnum.FRAUD, 						        DueDiligence.RegularExpressions.EXPRESSION_FRAUD, 					        LEVEL_7, 		'Fraud'},
                                    {ExpressionEnum.DRUG_OFFENSES, 				    DueDiligence.RegularExpressions.EXPRESSION_DRUG_OFFENSES, 			    LEVEL_8, 		'Drugs'},
                                    {ExpressionEnum.WEAPONS_OFFENSES, 			  DueDiligence.RegularExpressions.EXPRESSION_WEAPONS_OFFENSES, 		    LEVEL_8, 		'Weapons'},
                                    {ExpressionEnum.DIST_MANUF_TRANS, 	      DueDiligence.RegularExpressions.EXPRESSION_DIST_MANUF_TRANS, 	      LEVEL_8, 	  'Dist/Manuf/Trans/Delivery-Drugs or Weapons'},
                                    {ExpressionEnum.EXPLOSIVES, 				      DueDiligence.RegularExpressions.EXPRESSION_EXPLOSIVES, 				      LEVEL_8, 		'Explosives/Destruction Devices'},
                                    {ExpressionEnum.TRAFFICKING_SMUGGLING, 		DueDiligence.RegularExpressions.EXPRESSION_TRAFFICKING_SMUGGLING, 	LEVEL_8, 		'Trafficking/Smuggling'},
                                    {ExpressionEnum.CHOP_SHOP, 				      	DueDiligence.RegularExpressions.EXPRESSION_CHOP_SHOP, 				      LEVEL_9, 		'Chop Shop'},
                                    {ExpressionEnum.HIJACKING, 				      	DueDiligence.RegularExpressions.EXPRESSION_HIJACKING, 				      LEVEL_9, 		'Hijacking'},
                                    {ExpressionEnum.EXTORTION, 				      	DueDiligence.RegularExpressions.EXPRESSION_EXTORTION, 				      LEVEL_9, 		'Extortion'},
                                    {ExpressionEnum.TREASON_ESPIONAGE, 		  	DueDiligence.RegularExpressions.EXPRESSION_TREASON_ESPIONAGE, 	  	LEVEL_9, 		'Treason/Espionage'},
                                    {ExpressionEnum.INSIDER_TRADING, 			    DueDiligence.RegularExpressions.EXPRESSION_INSIDER_TRADING, 		    LEVEL_9, 		'Insider Trading/Manipulation'},
                                    {ExpressionEnum.COMMUNICATE_WIRE_DEVICE, 	DueDiligence.RegularExpressions.EXPRESSION_COMMUNICATE_WIRE_DEVICE, LEVEL_9, 	  'Interception of Communication/Wiretapping'},
                                    {ExpressionEnum.COUNTERFEIT, 				      DueDiligence.RegularExpressions.EXPRESSION_COUNTERFEIT, 			      LEVEL_9, 		'Counterfeiting'},
                                    {ExpressionEnum.TERRORISM, 					      DueDiligence.RegularExpressions.EXPRESSION_TERRORISM, 					    LEVEL_9, 		'Links to Terrorism'},
                                    {ExpressionEnum.ORGANIZED_CRIME, 		    	DueDiligence.RegularExpressions.EXPRESSION_ORGANIZED_CRIME, 		    LEVEL_9, 		'Links to Organized Crime'},
                                    {ExpressionEnum.LAUNDER, 					        DueDiligence.RegularExpressions.EXPRESSION_LAUNDER, 				        LEVEL_9, 		'Money or Credit Card Laundering'},
                                    {ExpressionEnum.CORRUPT_BRIBE, 				    DueDiligence.RegularExpressions.EXPRESSION_CORRUPT_BRIBE, 			    LEVEL_9, 		'Corruption or Bribery'}], ExpressionDSLayout);
                                
                                
                                
    SHARED expressionDCT := DICTIONARY(expressionDS, {expressionWeight => expressionDS}); 
    
    
    SHARED additionalChecksToExpression(UNSIGNED4 enumReference, STRING1 offenseScore, UNSIGNED offenseCategory, STRING1 trafficFlag, BOOLEAN foundUsingExpression) := FUNCTION
        
        felonyTheftCheck := enumReference = ExpressionEnum.FELONY_THEFT AND 
                            offenseScore = DueDiligence.Constants.FELONY AND 
                            foundUsingExpression;
                                            
        trafficOffenseCheck := enumReference = ExpressionEnum.TRAFFIC_OFFENSES AND 
                               (offenseScore = DueDiligence.Constants.TRAFFIC OR 
                                trafficFlag = DueDiligence.Constants.YES OR
                                offenseCategory = 1073741824 OR
                                foundUsingExpression);
        
        traffickSmuggleCheck := enumReference = ExpressionEnum.TRAFFICKING_SMUGGLING AND 
                                foundUsingExpression AND 
                                offenseScore <> DueDiligence.Constants.TRAFFIC AND
                                trafficFlag <> DueDiligence.Constants.YES;
                                
        alcoholCheck := enumReference = ExpressionEnum.ALCOHOL_RELATED AND
                        (offenseCategory = 137438953472 OR
                         foundUsingExpression);
                                         
                                         
        additionalChecks := IF(felonyTheftCheck OR trafficOffenseCheck OR traffickSmuggleCheck OR alcoholCheck, enumReference, ExpressionEnum.UNCATEGORIZED);


        RETURN expressionDCT[additionalChecks].expressionWeight;
    END;
    
    
    
    //Common routine to determine if the text contains the definition of the expression
		SHARED doesTextContainExpression(UNSIGNED4 enumReference, STRING textToSearch, STRING1 offenseScore, UNSIGNED offenseCategory, STRING1 trafficFlag) := FUNCTION
    
        trimTextToSearch := TRIM(textToSearch, LEFT, RIGHT);
        
        expressionDetails := expressionDCT[enumReference];
        
        expressionResults := MAP(trimTextToSearch = DueDiligence.Constants.EMPTY => ExpressionEnum.NO_OFFENSE_PROVIDED,
                                 STD.str.ToUpperCase(trimTextToSearch) = 'NOT SPECIFIED' => ExpressionEnum.NO_OFFENSE_PROVIDED,
                                 expressionDetails.expressionToUse = DueDiligence.Constants.EMPTY => ExpressionEnum.UNCATEGORIZED,
                                 IF(REGEXFIND(expressionDetails.expressionToUse, trimTextToSearch, NOCASE), expressionDetails.expressionWeight, ExpressionEnum.UNCATEGORIZED));
                                 
                                 
        expressionFound := expressionResults NOT IN [ExpressionEnum.NO_OFFENSE_PROVIDED, ExpressionEnum.UNCATEGORIZED];
                               
                               
        //if the enum passed in is in the following group, there are additional checks to make prior to just using the expression itself
        additionalChecks := IF(enumReference IN [ExpressionEnum.ALCOHOL_RELATED, ExpressionEnum.TRAFFIC_OFFENSES, ExpressionEnum.FELONY_THEFT, ExpressionEnum.TRAFFICKING_SMUGGLING],
                                additionalChecksToExpression(enumReference, offenseScore, offenseCategory, trafficFlag, expressionFound),
                                expressionResults);
                                
        RETURN additionalChecks;
		END;
    
    
    
    

    EXPORT expressionDetails(ExpressionEnum expressionReference) := expressionDCT[expressionReference];
    EXPORT expressionTextByEnum(ExpressionEnum expressionReference) := expressionDCT[expressionReference].expressionText;
    
    
    EXPORT getMaxLevel(STRING charge, STRING1 offenseScore, UNSIGNED offenseCategory, STRING1 trafficFlag, UNSIGNED1 level) := FUNCTION
        allInLevel := expressionDS(expressionCategory = level);
        
        determineMaxLevel := PROJECT(allInLevel, 
                                      TRANSFORM({RECORDOF(LEFT), UNSIGNED levelResult},
                                                resultedWeight := doesTextContainExpression(LEFT.expressionWeight, charge, offenseScore, offenseCategory, trafficFlag);
                                                
                                                SELF.levelResult := resultedWeight;
                                                SELF := LEFT;));
        
        getMaxLevelByLevel := DEDUP(SORT(determineMaxLevel, -levelResult, -expressionWeight), expressionCategory);

      
        RETURN getMaxLevelByLevel[1].levelResult;
    END;
END;