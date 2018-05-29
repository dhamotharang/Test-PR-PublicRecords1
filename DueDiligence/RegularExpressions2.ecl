import DueDiligence;


EXPORT RegularExpressions2(STRING textToSearch, STRING offenseScore, STRING1 trafficflag) := MODULE

		SHARED trimTextToSearch := TRIM(textToSearch, LEFT, RIGHT);
		SHARED offenseScoreIsTraffic := TRIM(offenseScore, LEFT, RIGHT) = DueDiligence.Constants.TRAFFIC;
    SHARED istraffic   := trafficflag = DueDiligence.Constants.YES;
    
		//List of expressions
		SHARED EXPRESSION_CORRUPT_BRIBE := '^(?=.*(CORRUPT|BRIB))(?!.*(DISTRIBUTE|MINOR)).*';
		SHARED EXPRESSION_LAUNDER :='(LAUNDER)';
		SHARED EXPRESSION_ORGANIZED_CRIME := '^(?=.*(ORG))(?=.*(CRIM|THEFT))(?!.*(FORG|RETAIL)).*'; 
		SHARED EXPRESSION_TERROR := '^(?=.*(TERROR(?!IZE)))(?!.*(KIDNAP)).*';
		SHARED EXPRESSION_FRAUD := '((DE)?FRAUD)';
		SHARED EXPRESSION_ID_THEFT := '^(?=.*\\b(ID(ENTITY)?)\\b)(?=.*\\b(THE?FT|FRAUD|ST(EA)?L)).*$';
		SHARED EXPRESSION_COUNTERFEIT := '(COUNTER)';
		SHARED EXPRESSION_CHECK_FRAUD := '((CHECK|CHK|CHEC)|((WORTH|BAD|FRA|BOGUS).*(CK)))';
		SHARED EXPRESSION_FORGERY := '(FORGE)';
		SHARED EXPRESSION_EMBEZZLEMENT := '(EMBEZ)';
		SHARED EXPRESSION_FALSE_PRETENSES := '((\\b(?=(FAL|FLS)))[\\w]*\\b(?=.*(PRET)))|(PRETENs)';
		SHARED EXPRESSION_INTERCEPT_COMMUNICATION := '^((?=.*(INTERCEPT))(?!.*(CABLE))).*';
		SHARED EXPRESSION_WIRE := '^(?=.*(WIRE))(?!.*(COP(PER)?|ELECTRICAL|PIPE|THEFT|DAMAG|CELL|FRAUD|STEAL)).*';
		SHARED EXPRESSION_INSIDER_TRADING := '(?=.*(DEC|TRADE|MARK))(?=.*(PRAC)).*$';
		SHARED EXPRESSION_TREASON_ESPIONAGE := '(TREASO|ESPIO)';
		SHARED EXPRESSION_EXTORTION := '(EXTOR)';
		SHARED EXPRESSION_CONCEALMENT_OF_FUNDS := '((\\b(?=(CONCEAL))[\\w]*\\b)+(?=.*(FUN|MONEY|PROC))+)(?!(.*CHILD))'; 
		SHARED EXPRESSION_TAX_OFFENSES := '(TAX)';
		SHARED EXPRESSION_HIJACKING := '(HIJA|CARJACK)';
		SHARED EXPRESSION_CHOP_SHOP := '(CHOP)';

		SHARED EXPRESSION_EXCLUDE_RELATED_TRAFFIC := '(?!.*\\b(ONE-WAY|SIGNAL|OFFENSE|STOP|HABIT|LANE|PEDES|MOPED|DEVICE|SPEED|BLOCK|CHAPTER|IMPEDE|(NON)?MOVING|OBSTRUCTING|DRUNK|DUI|DWI))';
		SHARED EXPRESSION_SMUGGLING := '(?=.*(SMUG))'; 
		SHARED EXPRESSION_TRAFFICKING := '((?=.*(\\bTRAFFICK))|(?=.*(\\bTRAF))(?=.*\\b(DRU|DRG|FIREARM|ORGAN|SEX|LABOR|HUMAN|CONTRABAND|ALIEN|STOLE|COC|SUBSTANCE|CANNABIS|FOOD|CON|COKE|MARIJ|DISTRIB|CS|CONSPIR|GRAM|OPIUM)))' + EXPRESSION_EXCLUDE_RELATED_TRAFFIC + '.*'; ; 
		SHARED EXPRESSION_EXPLOSIVES := '(EXPLOS|NUCLEAR|BOMB|GRENADE|((MASS).*(DES))|((DES).*(DEV)))';
		SHARED EXPRESSION_WEAPONS_OFFENSES := '(UUW|WEAP|WPN|WEA|WEP|FIREARM|GUN|AMMUNI|ARMOR|CONTRA(?!CT)|AMMO(?!NIA)|KNIFE|ARMED|DISCHARG)';  
		SHARED EXPRESSION_DRUG_OFFENSES := '(C\\/S|HYDROC|CODEINE|DIHYDRO|HYDROMORPH|PHENCYC|PENTAZ|ALPRAZ|ECSTASY|DARVO|CDS|MARI|COCA|METH|NARC|DRUG|HALLUC|EPHED|OXY|HEROI|OPIUM|ANHY|AMPH|AMMONIA|\\bCHEM|NITROU|CANNA|((?=.*(\\bCONTR))(?=.*(\\bSUB|\\bDANG)).*))';  
		SHARED EXPRESSION_DISTRIBUTION_MANUFACTURING_TRANSPORTATION := '^(?:(MAN(U)?F|MFG|TRAN(?!BAND)|DIS(?!(ARMING|C|H))))(?=.*(' + EXPRESSION_WEAPONS_OFFENSES + '|' + EXPRESSION_DRUG_OFFENSES + '))'; 

		SHARED EXPRESSION_MURDER_HOMOCIDE_MANSLAUGHTER := '(MANSL|MUR(?!ATIC)|HOMIC|HOMOC)';  
		SHARED EXPRESSION_ASSULT_WITH_INTENT_TO_KILL := '((INT).*(TO KILL)|AWIK|((ASS|ASA).*(KILL)))';  
		SHARED EXPRESSION_KIDNAPPING_OR_ABDUCTION := '(KIDNAP|ABDU)';

		SHARED EXPRESSION_GRAND_LARCENY := '((GR).*(LARC))';
		SHARED EXPRESSION_BANK_ROBBERY := '((BA(?!TTERY)).*(ROBB))'; 
		SHARED EXPRESSION_ARMED_ROBBERY := '^(?=.*(ROB))(?=.*(ARM|' + EXPRESSION_WEAPONS_OFFENSES + '))(?!.*(PROBATION)).*'; 
		SHARED EXPRESSION_ROBBERY := '(ROBB)';
		SHARED EXPRESSION_FELONY_THEFT := '^(?=.*(FEL))(?=.*(TH(E)?FT|ST(EA)?L|STLG|LARC|STOLE))(?!.*(IDENTITY|SHOP)).*$';
		SHARED EXPRESSION_MISDEMEANOR_THEFT := '^(?=.*(TH(E)?FT|ST(EA)?L|STLG|LARC|STOLE))(?!.*(IDENTITY|SHOP|FELON)).*$';
		SHARED EXPRESSION_LARCENY := '^(?=.*(LARC))(?!.*(GR)).*';  
		SHARED EXPRESSION_ORGANIZED_RETAIL_THEFT := '^(?=.*(ORG))(?=.*(RETAIL))(?!.*(RETAL|FORGERY|ENDANGER)).*';  
		SHARED EXPRESSION_ARSON := '(ARSO)';
		SHARED EXPRESSION_BURGLARY := '(BURG)';
		SHARED EXPRESSION_BREAKING_AND_ENTERING := '(((?=.*(\\bBREAK))(?=.*(\\bENT|\\bIN)))|(B[\\s]?&[\\s]?E)).*';  

		SHARED EXPRESSION_SOLICITATION := '(SOLIC)';
		SHARED EXPRESSION_PORN := '(PORN)';
		SHARED EXPRESSION_PROSTITUTION := '(PROST)';
		SHARED EXPRESSION_SEXUAL_ASSAULT_AND_BATTERY := '((SEX|SX)(?=.*(ASS|ASA|BATT|BTRY|ASLT)))';  
		SHARED EXPRESSION_SEXUAL_ABUSE := '(S(E)?X|INTERCOURSE|SODOMY)';
		SHARED EXPRESSION_STATUTORY_RAPE := '((STAT)(?=.*(RAPE)))';
		SHARED EXPRESSION_RAPE := '^(?=.*(RAPE))(?!.*(STAT)).*';  
		SHARED EXPRESSION_MOLESTATION := '(MOLEST)';

		SHARED EXPRESSION_AGGRAVATED_ASSAULT_OR_BATTERY := '(?!.*(SE?X))(((AGG).*(\\bASS|\\bBATT|\\bBTRY|\\bASLT))|(A[\\s]?&[\\s]?B))';
		SHARED EXPRESSION_ASSAULT_WITH_DEADLY_WEAPON := '((ASS).*(DEAD|DANG|WEAP))';
		SHARED EXPRESSION_ASSAULT := '(?!.*(ASSIST))(\\b((AS((S)|(LT)){1,2}))|BATT|BTRY)';
		SHARED EXPRESSION_DOMESTIC_VIOLENCE := '(?=.*(DOMESTIC))(?!.*(ANI|SECURITIES|DOMESTICALLY|FOWL|FISH|GAME)).*$';
		SHARED EXPRESSION_ANIMAL_FIGHTING := '((ANIMA).*(FIGHT))';
		SHARED EXPRESSION_STALKING_HARASSMENT := '(STALK|HARAS)';
		SHARED EXPRESSION_CYBER_STALKING := '(CYBER)';
		SHARED EXPRESSION_VIOLATE_RESTRAINING_ORDER := '(((?=.*(\\b(RESTRAIN|PROT)))(?=.*\\bORD))|((?=.*\\bCIV)(?=.*\\bPROT))).*';
		SHARED EXPRESSION_RESISTING_ARREST := '^(?=.*(\\bRESIST|\\bESCAPE|\\bELUDE|\\bFLEE))(?!.*(SEX|RAPE|MV|DWI|DUI|INTOX|DNA)).*'; 
		SHARED EXPRESSION_PROPERTY_DESTRUCTION := '(?=.*(DESTRU|DESTROY))(?!.*(DEV|ANIM)).*';  
		SHARED EXPRESSION_VANDALISM := '(?=(\\bVAND)).*';  

		SHARED EXPRESSION_PERJURY := '(PERJU)';
		SHARED EXPRESSION_OBSTRUCTION := '(OBSTR)';
		SHARED EXPRESSION_TAMPERING := '^(?=.*(\\bTAMP))(?!.*(STAMP|METH|MEHT|META)).*';   
		SHARED EXPRESSION_COMPUTER_OFFENSES := '^(?=.*(\\bCOMPU))(?!.*(RAPE|COMPUL)).*';  
		SHARED EXPRESSION_GAMBLING_BITCOIN := '(GAMBL|BITCOIN)';

		SHARED EXPRESSION_SHOPLIFTING := '(SHOPL)';
		SHARED EXPRESSION_ALIEN_OFFENSES := '^(?=.*(\\bALIEN))(?!.*(SMUG)).*'; 
		SHARED EXPRESSION_DUI := '(DWI|DUI|((DRIV).*(UND)))';
		SHARED EXPRESSION_TRESPASSING := '(TRES)';
		SHARED EXPRESSION_DISORDERLY_CONDUCT := '((DISOR).*(CON))';
		SHARED EXPRESSION_PUBLIC_INTOXICATION := '(?=.*(\\b(INTOX|CONSU)))(?=.*\\bPUB).*';
    
    SHARED ExpressionEnum := ENUM(CORRUPT_BRIBE, LAUNDER, ORGANIZED_CRIME, TERROR, FRAUD, ID_THEFT, COUNTERFEIT, CHECK_FRAUD, FORGERY, EMBEZZLEMENT, 
                                  FALSE_PRETENSES, INTERCEPT_COMMUNICATION, WIRE, INSIDER_TRADING, TREASON_ESPIONAGE, EXTORTION, CONCEALMENT_OF_FUNDS, 
                                  TAX_OFFENSES, HIJACKING, CHOP_SHOP, EXCLUDE_RELATED_TRAFFIC, SMUGGLING, TRAFFICKING, EXPLOSIVES, WEAPONS_OFFENSES, 
                                  DRUG_OFFENSES, DISTRIBUTION_MANUFACTURING_TRANSPORTATION, MURDER_HOMOCIDE_MANSLAUGHTER, ASSULT_WITH_INTENT_TO_KILL, 
                                  KIDNAPPING_OR_ABDUCTION, GRAND_LARCENY, BANK_ROBBERY, ARMED_ROBBERY, ROBBERY, FELONY_THEFT, MISDEMEANOR_THEFT, LARCENY, 
                                  ORGANIZED_RETAIL_THEFT, ARSON, BURGLARY, BREAKING_AND_ENTERING, SOLICITATION, PORN, PROSTITUTION, SEXUAL_ASSAULT_AND_BATTERY, 
                                  SEXUAL_ABUSE, STATUTORY_RAPE, RAPE, MOLESTATION, AGGRAVATED_ASSAULT_OR_BATTERY, ASSAULT_WITH_DEADLY_WEAPON, ASSAULT, 
                                  DOMESTIC_VIOLENCE, ANIMAL_FIGHTING, STALKING_HARASSMENT, CYBER_STALKING, VIOLATE_RESTRAINING_ORDER, RESISTING_ARREST, 
                                  PROPERTY_DESTRUCTION, VANDALISM, PERJURY, OBSTRUCTION, TAMPERING, COMPUTER_OFFENSES, GAMBLING_BITCOIN, SHOPLIFTING, 
                                  ALIEN_OFFENSES, TRAFFIC_OFFENSES, DUI, TRESPASSING, DISORDERLY_CONDUCT, PUBLIC_INTOXICATION);
    
    
    
    SHARED ExpressionDSLayout := RECORD
      UNSIGNED4   enumExpression;
      STRING      expression;
      UNSIGNED4   expressionWeight;
    END;

    SHARED expressionDS := DATASET([{ExpressionEnum.CORRUPT_BRIBE,	    EXPRESSION_CORRUPT_BRIBE,	DueDiligence.Constants.CORRUPT_BRIBE_CODE},
                                    {ExpressionEnum.LAUNDER,	          EXPRESSION_LAUNDER,	DueDiligence.Constants.LAUNDER_CODE},
                                    {ExpressionEnum.ORGANIZED_CRIME,	  EXPRESSION_ORGANIZED_CRIME,	DueDiligence.Constants.ORGANIZED_CRIME_CODE},
                                    {ExpressionEnum.TERROR,	            EXPRESSION_TERROR,	DueDiligence.Constants.TERROR_CODE},
                                    {ExpressionEnum.FRAUD,	            EXPRESSION_FRAUD,	DueDiligence.Constants.FRAUD_CODE},
                                    {ExpressionEnum.ID_THEFT,	          EXPRESSION_ID_THEFT,	DueDiligence.Constants.ID_THEFT_CODE},
                                    {ExpressionEnum.COUNTERFEIT,	      EXPRESSION_COUNTERFEIT,	DueDiligence.Constants.COUNTERFEIT_CODE},
                                    {ExpressionEnum.CHECK_FRAUD,	      EXPRESSION_CHECK_FRAUD,	DueDiligence.Constants.CHECK_FRAUD_CODE},
                                    {ExpressionEnum.FORGERY,	          EXPRESSION_FORGERY,	DueDiligence.Constants.FORGERY_CODE},
                                    {ExpressionEnum.EMBEZZLEMENT,	      EXPRESSION_EMBEZZLEMENT,	DueDiligence.Constants.EMBEZZLEMENT_CODE},
                                    {ExpressionEnum.FALSE_PRETENSES,	  EXPRESSION_FALSE_PRETENSES,	DueDiligence.Constants.FALSE_PRETENSES_CODE},
                                    {ExpressionEnum.INTERCEPT_COMMUNICATION,	EXPRESSION_INTERCEPT_COMMUNICATION,	DueDiligence.Constants.INTERCEPT_COMMUNICATION_CODE},
                                    {ExpressionEnum.WIRE,	              EXPRESSION_WIRE,	DueDiligence.Constants.WIRE_CODE},
                                    {ExpressionEnum.INSIDER_TRADING,	  EXPRESSION_INSIDER_TRADING,	DueDiligence.Constants.INSIDER_TRADING_CODE},
                                    {ExpressionEnum.TREASON_ESPIONAGE,  EXPRESSION_TREASON_ESPIONAGE,	DueDiligence.Constants.TREASON_ESPIONAGE_CODE},
                                    {ExpressionEnum.EXTORTION,	        EXPRESSION_EXTORTION,	DueDiligence.Constants.EXTORTION_CODE},
                                    {ExpressionEnum.CONCEALMENT_OF_FUNDS,	EXPRESSION_CONCEALMENT_OF_FUNDS,	DueDiligence.Constants.CONCEALMENT_OF_FUNDS_CODE},
                                    {ExpressionEnum.TAX_OFFENSES,	      EXPRESSION_TAX_OFFENSES,	DueDiligence.Constants.TAX_OFFENSES_CODE},
                                    {ExpressionEnum.HIJACKING,	        EXPRESSION_HIJACKING,	DueDiligence.Constants.HIJACKING_CODE},
                                    {ExpressionEnum.CHOP_SHOP,	        EXPRESSION_CHOP_SHOP,	DueDiligence.Constants.CHOP_SHOP_CODE},
                                    {ExpressionEnum.EXCLUDE_RELATED_TRAFFIC,	EXPRESSION_EXCLUDE_RELATED_TRAFFIC,	DueDiligence.Constants.EXCLUDE_RELATED_TRAFFIC_CODE},
                                    {ExpressionEnum.SMUGGLING,	        EXPRESSION_SMUGGLING,	DueDiligence.Constants.SMUGGLING_CODE},
                                    {ExpressionEnum.TRAFFICKING,	      EXPRESSION_TRAFFICKING,	DueDiligence.Constants.TRAFFICKING_CODE},
                                    {ExpressionEnum.EXPLOSIVES,	        EXPRESSION_EXPLOSIVES,	DueDiligence.Constants.EXPLOSIVES_CODE},
                                    {ExpressionEnum.WEAPONS_OFFENSES,	  EXPRESSION_WEAPONS_OFFENSES,	DueDiligence.Constants.WEAPONS_OFFENSES_CODE},
                                    {ExpressionEnum.DRUG_OFFENSES,	    EXPRESSION_DRUG_OFFENSES,	DueDiligence.Constants.DRUG_OFFENSES_CODE},
                                    {ExpressionEnum.DISTRIBUTION_MANUFACTURING_TRANSPORTATION,	EXPRESSION_DISTRIBUTION_MANUFACTURING_TRANSPORTATION,	DueDiligence.Constants.DISTRIBUTION_MANUFACTURING_TRANSPORTATION_CODE},
                                    {ExpressionEnum.MURDER_HOMOCIDE_MANSLAUGHTER,	EXPRESSION_MURDER_HOMOCIDE_MANSLAUGHTER,	DueDiligence.Constants.MURDER_HOMOCIDE_MANSLAUGHTER_CODE},
                                    {ExpressionEnum.ASSULT_WITH_INTENT_TO_KILL,	EXPRESSION_ASSULT_WITH_INTENT_TO_KILL,	DueDiligence.Constants.ASSULT_WITH_INTENT_TO_KILL_CODE},
                                    {ExpressionEnum.KIDNAPPING_OR_ABDUCTION,	EXPRESSION_KIDNAPPING_OR_ABDUCTION,	DueDiligence.Constants.KIDNAPPING_OR_ABDUCTION_CODE},
                                    {ExpressionEnum.GRAND_LARCENY,	    EXPRESSION_GRAND_LARCENY,	DueDiligence.Constants.GRAND_LARCENY_CODE},
                                    {ExpressionEnum.BANK_ROBBERY,	      EXPRESSION_BANK_ROBBERY,	DueDiligence.Constants.BANK_ROBBERY_CODE},
                                    {ExpressionEnum.ARMED_ROBBERY,	    EXPRESSION_ARMED_ROBBERY,	DueDiligence.Constants.ARMED_ROBBERY_CODE},
                                    {ExpressionEnum.ROBBERY,	          EXPRESSION_ROBBERY,	DueDiligence.Constants.ROBBERY_CODE},
                                    {ExpressionEnum.FELONY_THEFT,	      EXPRESSION_FELONY_THEFT,	DueDiligence.Constants.FELONY_THEFT_CODE},
                                    {ExpressionEnum.MISDEMEANOR_THEFT,	EXPRESSION_MISDEMEANOR_THEFT,	DueDiligence.Constants.MISDEMEANOR_THEFT_CODE},
                                    {ExpressionEnum.LARCENY,	          EXPRESSION_LARCENY,	DueDiligence.Constants.LARCENY_CODE},
                                    {ExpressionEnum.ORGANIZED_RETAIL_THEFT,	EXPRESSION_ORGANIZED_RETAIL_THEFT,	DueDiligence.Constants.ORGANIZED_RETAIL_THEFT_CODE},
                                    {ExpressionEnum.ARSON,	            EXPRESSION_ARSON,	DueDiligence.Constants.ARSON_CODE},
                                    {ExpressionEnum.BURGLARY,	          EXPRESSION_BURGLARY,	DueDiligence.Constants.BURGLARY_CODE},
                                    {ExpressionEnum.BREAKING_AND_ENTERING,	EXPRESSION_BREAKING_AND_ENTERING,	DueDiligence.Constants.BREAKING_AND_ENTERING_CODE},
                                    {ExpressionEnum.SOLICITATION,	      EXPRESSION_SOLICITATION,	DueDiligence.Constants.SOLICITATION_CODE},
                                    {ExpressionEnum.PORN,	              EXPRESSION_PORN,	DueDiligence.Constants.PORN_CODE},
                                    {ExpressionEnum.PROSTITUTION,	      EXPRESSION_PROSTITUTION,	DueDiligence.Constants.PROSTITUTION_CODE},
                                    {ExpressionEnum.SEXUAL_ASSAULT_AND_BATTERY,	EXPRESSION_SEXUAL_ASSAULT_AND_BATTERY,	DueDiligence.Constants.SEXUAL_ASSAULT_AND_BATTERY_CODE},
                                    {ExpressionEnum.SEXUAL_ABUSE,	      EXPRESSION_SEXUAL_ABUSE,	DueDiligence.Constants.SEXUAL_ABUSE_CODE},
                                    {ExpressionEnum.STATUTORY_RAPE,	    EXPRESSION_STATUTORY_RAPE,	DueDiligence.Constants.STATUTORY_RAPE_CODE},
                                    {ExpressionEnum.RAPE,	              EXPRESSION_RAPE,	DueDiligence.Constants.RAPE_CODE},
                                    {ExpressionEnum.MOLESTATION,	      EXPRESSION_MOLESTATION,	DueDiligence.Constants.MOLESTATION_CODE},
                                    {ExpressionEnum.AGGRAVATED_ASSAULT_OR_BATTERY,	EXPRESSION_AGGRAVATED_ASSAULT_OR_BATTERY,	DueDiligence.Constants.AGGRAVATED_ASSAULT_OR_BATTERY_CODE},
                                    {ExpressionEnum.ASSAULT_WITH_DEADLY_WEAPON,	EXPRESSION_ASSAULT_WITH_DEADLY_WEAPON,	DueDiligence.Constants.ASSAULT_WITH_DEADLY_WEAPON_CODE},
                                    {ExpressionEnum.ASSAULT,	          EXPRESSION_ASSAULT,	DueDiligence.Constants.ASSAULT_CODE},
                                    {ExpressionEnum.DOMESTIC_VIOLENCE,	EXPRESSION_DOMESTIC_VIOLENCE,	DueDiligence.Constants.DOMESTIC_VIOLENCE_CODE},
                                    {ExpressionEnum.ANIMAL_FIGHTING,	  EXPRESSION_ANIMAL_FIGHTING,	DueDiligence.Constants.ANIMAL_FIGHTING_CODE},
                                    {ExpressionEnum.STALKING_HARASSMENT,	EXPRESSION_STALKING_HARASSMENT,	DueDiligence.Constants.STALKING_HARASSMENT_CODE},
                                    {ExpressionEnum.CYBER_STALKING,	    EXPRESSION_CYBER_STALKING,	DueDiligence.Constants.CYBER_STALKING_CODE},
                                    {ExpressionEnum.VIOLATE_RESTRAINING_ORDER,	EXPRESSION_VIOLATE_RESTRAINING_ORDER,	DueDiligence.Constants.VIOLATE_RESTRAINING_ORDER_CODE},
                                    {ExpressionEnum.RESISTING_ARREST,	  EXPRESSION_RESISTING_ARREST,	DueDiligence.Constants.RESISTING_ARREST_CODE},
                                    {ExpressionEnum.PROPERTY_DESTRUCTION,	EXPRESSION_PROPERTY_DESTRUCTION,	DueDiligence.Constants.PROPERTY_DESTRUCTION_CODE},
                                    {ExpressionEnum.VANDALISM,	        EXPRESSION_VANDALISM,	DueDiligence.Constants.VANDALISM_CODE},
                                    {ExpressionEnum.PERJURY,	          EXPRESSION_PERJURY,	DueDiligence.Constants.PERJURY_CODE},
                                    {ExpressionEnum.OBSTRUCTION,	      EXPRESSION_OBSTRUCTION,	DueDiligence.Constants.OBSTRUCTION_CODE},
                                    {ExpressionEnum.TAMPERING,	        EXPRESSION_TAMPERING,	DueDiligence.Constants.TAMPERING_CODE},
                                    {ExpressionEnum.COMPUTER_OFFENSES,	EXPRESSION_COMPUTER_OFFENSES,	DueDiligence.Constants.COMPUTER_OFFENSES_CODE},
                                    {ExpressionEnum.GAMBLING_BITCOIN,	  EXPRESSION_GAMBLING_BITCOIN,	DueDiligence.Constants.GAMBLING_BITCOIN_CODE},
                                    {ExpressionEnum.SHOPLIFTING,	      EXPRESSION_SHOPLIFTING,	DueDiligence.Constants.SHOPLIFTING_CODE},
                                    {ExpressionEnum.ALIEN_OFFENSES,	    EXPRESSION_ALIEN_OFFENSES,	DueDiligence.Constants.ALIEN_OFFENSES_CODE},
                                    {ExpressionEnum.TRAFFIC_OFFENSES,	  DueDiligence.Constants.EMPTY,	DueDiligence.Constants.TRAFFIC_OFFENSES_CODE},
                                    {ExpressionEnum.DUI,	              EXPRESSION_DUI,	DueDiligence.Constants.DUI_CODE},
                                    {ExpressionEnum.TRESPASSING,	      EXPRESSION_TRESPASSING,	DueDiligence.Constants.TRESPASSING_CODE},
                                    {ExpressionEnum.DISORDERLY_CONDUCT,	EXPRESSION_DISORDERLY_CONDUCT,	DueDiligence.Constants.DISORDERLY_CONDUCT_CODE},
                                    {ExpressionEnum.PUBLIC_INTOXICATION,	EXPRESSION_PUBLIC_INTOXICATION,	DueDiligence.Constants.PUBLIC_INTOXICATION_CODE}], ExpressionDSLayout);
                                
    SHARED expressionDCT := DICTIONARY(expressionDS, {enumExpression => expressionDS}); 
		
		//Common routine to determine if the text contains the definition of the expression
		SHARED doesTextContainExpression(UNSIGNED4 expression) := FUNCTION
        
        expressionToUse := expressionDCT[expression];
        found := IF(REGEXFIND(expressionToUse.expression, trimTextToSearch, NOCASE), TRUE, FALSE);
        
        RETURN IF(found, expressionToUse.expressionWeight, 0);
		END;
    


		//available exposed expressions
		EXPORT foundCorruptionOrBribery := doesTextContainExpression(ExpressionEnum.CORRUPT_BRIBE);
		EXPORT foundLaundering := doesTextContainExpression(ExpressionEnum.LAUNDER);
		EXPORT foundOrganizedCrime := doesTextContainExpression(ExpressionEnum.ORGANIZED_CRIME);
		EXPORT foundTerror := doesTextContainExpression(ExpressionEnum.TERROR);
		EXPORT foundFraud := doesTextContainExpression(ExpressionEnum.FRAUD);
		EXPORT foundIdentityTheft := doesTextContainExpression(ExpressionEnum.ID_THEFT);
		EXPORT foundCounterfeit := doesTextContainExpression(ExpressionEnum.COUNTERFEIT);
		EXPORT foundCheckFraud := doesTextContainExpression(ExpressionEnum.CHECK_FRAUD);
		EXPORT foundForgery := doesTextContainExpression(ExpressionEnum.FORGERY);
		EXPORT foundEmbezzlement := doesTextContainExpression(ExpressionEnum.EMBEZZLEMENT);
		EXPORT foundFalsePretense := doesTextContainExpression(ExpressionEnum.FALSE_PRETENSES);
		EXPORT foundInterceptCommunication := doesTextContainExpression(ExpressionEnum.INTERCEPT_COMMUNICATION);
		EXPORT foundWire := doesTextContainExpression(ExpressionEnum.WIRE);
		EXPORT foundInsiderTrading := doesTextContainExpression(ExpressionEnum.INSIDER_TRADING);
		EXPORT foundTreasonOrEspionage := doesTextContainExpression(ExpressionEnum.TREASON_ESPIONAGE);
		EXPORT foundExtortion := doesTextContainExpression(ExpressionEnum.EXTORTION);
		EXPORT foundConcealmentOfFunds := doesTextContainExpression(ExpressionEnum.CONCEALMENT_OF_FUNDS);
		EXPORT foundTaxOffenses := doesTextContainExpression(ExpressionEnum.TAX_OFFENSES);
		EXPORT foundHijacking := doesTextContainExpression(ExpressionEnum.HIJACKING);
		EXPORT foundChopShop := doesTextContainExpression(ExpressionEnum.CHOP_SHOP);
		
		EXPORT foundTraffickingOrSmuggling := MAP(offenseScoreIsTraffic => 0,
                                              istraffic             => 0,
																							MAX(doesTextContainExpression(ExpressionEnum.SMUGGLING), doesTextContainExpression(ExpressionEnum.TRAFFICKING)));
		EXPORT foundExplosives := doesTextContainExpression(ExpressionEnum.EXPLOSIVES);
		EXPORT foundWeapons := doesTextContainExpression(ExpressionEnum.WEAPONS_OFFENSES);
		EXPORT foundDrugs := doesTextContainExpression(ExpressionEnum.DRUG_OFFENSES);
		EXPORT foundDistributionManufacturingTransportation := doesTextContainExpression(ExpressionEnum.DISTRIBUTION_MANUFACTURING_TRANSPORTATION);
		
		EXPORT foundMurderHomocideManslaughter := doesTextContainExpression(ExpressionEnum.MURDER_HOMOCIDE_MANSLAUGHTER);
		EXPORT foundAssultWithIntentToKill := doesTextContainExpression(ExpressionEnum.ASSULT_WITH_INTENT_TO_KILL);
		EXPORT foundKidnappingOrAbduction := doesTextContainExpression(ExpressionEnum.KIDNAPPING_OR_ABDUCTION);
		
		EXPORT foundGrandLarceny := doesTextContainExpression(ExpressionEnum.GRAND_LARCENY);
		EXPORT foundBankRobbery := doesTextContainExpression(ExpressionEnum.BANK_ROBBERY);
		EXPORT foundArmedRobbery := doesTextContainExpression(ExpressionEnum.ARMED_ROBBERY);
		EXPORT foundRobbery := doesTextContainExpression(ExpressionEnum.ROBBERY);
		EXPORT foundFelonlyTheft := doesTextContainExpression(ExpressionEnum.FELONY_THEFT);
		EXPORT foundMisdemeanorTheft := doesTextContainExpression(ExpressionEnum.MISDEMEANOR_THEFT);
		EXPORT foundLarceny := doesTextContainExpression(ExpressionEnum.LARCENY);
		EXPORT foundOrganizedRetailTheft := doesTextContainExpression(ExpressionEnum.ORGANIZED_RETAIL_THEFT);
		EXPORT foundArson := doesTextContainExpression(ExpressionEnum.ARSON);
		EXPORT foundBurglary := doesTextContainExpression(ExpressionEnum.BURGLARY);
		EXPORT foundBreakingAndEntering := doesTextContainExpression(ExpressionEnum.BREAKING_AND_ENTERING);
		
		EXPORT foundSolicitation := doesTextContainExpression(ExpressionEnum.SOLICITATION);
		EXPORT foundPorn := doesTextContainExpression(ExpressionEnum.PORN);
		EXPORT foundProstitution := doesTextContainExpression(ExpressionEnum.PROSTITUTION);
		EXPORT foundSexualAssaultAndBattery := doesTextContainExpression(ExpressionEnum.SEXUAL_ASSAULT_AND_BATTERY);
		EXPORT foundSexualAbuse := doesTextContainExpression(ExpressionEnum.SEXUAL_ABUSE);
		EXPORT foundStatutoryRape := doesTextContainExpression(ExpressionEnum.STATUTORY_RAPE);
		EXPORT foundRape := doesTextContainExpression(ExpressionEnum.RAPE);
		EXPORT foundMolestation := doesTextContainExpression(ExpressionEnum.MOLESTATION);
		
		EXPORT foundAggravatedAssaultOrBattery := doesTextContainExpression(ExpressionEnum.AGGRAVATED_ASSAULT_OR_BATTERY);
		EXPORT foundAssaultWithDeadlyWeapon := doesTextContainExpression(ExpressionEnum.ASSAULT_WITH_DEADLY_WEAPON);
		EXPORT foundAssault := doesTextContainExpression(ExpressionEnum.ASSAULT);
		EXPORT foundDomesticViolence := doesTextContainExpression(ExpressionEnum.DOMESTIC_VIOLENCE);
		EXPORT foundAnimalFighting := doesTextContainExpression(ExpressionEnum.ANIMAL_FIGHTING);
		EXPORT foundStalkingOrHarassment := doesTextContainExpression(ExpressionEnum.STALKING_HARASSMENT);
		EXPORT foundCyberStalking := doesTextContainExpression(ExpressionEnum.CYBER_STALKING);
		EXPORT foundViolateRestrainingOrder := doesTextContainExpression(ExpressionEnum.VIOLATE_RESTRAINING_ORDER);
		EXPORT foundResistingArrest := doesTextContainExpression(ExpressionEnum.RESISTING_ARREST);
		EXPORT foundPropertyDestruction := doesTextContainExpression(ExpressionEnum.PROPERTY_DESTRUCTION);
		EXPORT foundVandalism := doesTextContainExpression(ExpressionEnum.VANDALISM);
		
		EXPORT foundPerjury := doesTextContainExpression(ExpressionEnum.PERJURY);
		EXPORT foundObstruction := doesTextContainExpression(ExpressionEnum.OBSTRUCTION);
		EXPORT foundTampering := doesTextContainExpression(ExpressionEnum.TAMPERING);
		EXPORT foundComputerOffenses := doesTextContainExpression(ExpressionEnum.COMPUTER_OFFENSES);
		EXPORT foundGamblingOrBitcoin := doesTextContainExpression(ExpressionEnum.GAMBLING_BITCOIN);
		
		EXPORT foundShoplifting := doesTextContainExpression(ExpressionEnum.SHOPLIFTING);
		EXPORT foundAlienOffenses := doesTextContainExpression(ExpressionEnum.ALIEN_OFFENSES);
		EXPORT foundTrafficOffenses := IF(offenseScoreIsTraffic OR istraffic, expressionDCT[ExpressionEnum.TRAFFIC_OFFENSES].expressionWeight, 0);
		EXPORT foundDUI := doesTextContainExpression(ExpressionEnum.DUI);
		EXPORT foundTrespassing := doesTextContainExpression(ExpressionEnum.TRESPASSING);
		EXPORT foundDisorderlyConduct := doesTextContainExpression(ExpressionEnum.DISORDERLY_CONDUCT);
		EXPORT foundPublicIntoxication := doesTextContainExpression(ExpressionEnum.PUBLIC_INTOXICATION);
		

END;