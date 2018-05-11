EXPORT RegularExpressions2(STRING textToSearch, STRING offenseScore) := MODULE

		SHARED trimTextToSearch := TRIM(textToSearch, LEFT, RIGHT);
		SHARED offenseScoreIsTraffic := TRIM(offenseScore, LEFT, RIGHT) = DueDiligence.Constants.TRAFFIC;
		
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
		SHARED EXPRESSION_EXPOSIVES := '(EXPLOS|NUCLEAR|BOMB|GRENADE|((MASS).*(DES))|((DES).*(DEV)))';
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
                                  TAX_OFFENSES, HIJACKING, CHOP_SHOP, EXCLUDE_RELATED_TRAFFIC, SMUGGLING, TRAFFICKING, EXPOSIVES, WEAPONS_OFFENSES, 
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

    SHARED expressionDS := DATASET([{ExpressionEnum.CORRUPT_BRIBE,	    EXPRESSION_CORRUPT_BRIBE,	72},
                                    {ExpressionEnum.LAUNDER,	          EXPRESSION_LAUNDER,	71},
                                    {ExpressionEnum.ORGANIZED_CRIME,	  EXPRESSION_ORGANIZED_CRIME,	70},
                                    {ExpressionEnum.TERROR,	            EXPRESSION_TERROR,	69},
                                    {ExpressionEnum.FRAUD,	            EXPRESSION_FRAUD,	68},
                                    {ExpressionEnum.ID_THEFT,	          EXPRESSION_ID_THEFT,	67},
                                    {ExpressionEnum.COUNTERFEIT,	      EXPRESSION_COUNTERFEIT,	66},
                                    {ExpressionEnum.CHECK_FRAUD,	      EXPRESSION_CHECK_FRAUD,	65},
                                    {ExpressionEnum.FORGERY,	          EXPRESSION_FORGERY,	64},
                                    {ExpressionEnum.EMBEZZLEMENT,	      EXPRESSION_EMBEZZLEMENT,	63},
                                    {ExpressionEnum.FALSE_PRETENSES,	  EXPRESSION_FALSE_PRETENSES,	62},
                                    {ExpressionEnum.INTERCEPT_COMMUNICATION,	EXPRESSION_INTERCEPT_COMMUNICATION,	61},
                                    {ExpressionEnum.WIRE,	              EXPRESSION_WIRE,	60},
                                    {ExpressionEnum.INSIDER_TRADING,	  EXPRESSION_INSIDER_TRADING,	59},
                                    {ExpressionEnum.TREASON_ESPIONAGE,  EXPRESSION_TREASON_ESPIONAGE,	58},
                                    {ExpressionEnum.EXTORTION,	        EXPRESSION_EXTORTION,	57},
                                    {ExpressionEnum.CONCEALMENT_OF_FUNDS,	EXPRESSION_CONCEALMENT_OF_FUNDS,	56},
                                    {ExpressionEnum.TAX_OFFENSES,	      EXPRESSION_TAX_OFFENSES,	55},
                                    {ExpressionEnum.HIJACKING,	        EXPRESSION_HIJACKING,	54},
                                    {ExpressionEnum.CHOP_SHOP,	        EXPRESSION_CHOP_SHOP,	53},
                                    {ExpressionEnum.EXCLUDE_RELATED_TRAFFIC,	EXPRESSION_EXCLUDE_RELATED_TRAFFIC,	52},
                                    {ExpressionEnum.SMUGGLING,	        EXPRESSION_SMUGGLING,	51},
                                    {ExpressionEnum.TRAFFICKING,	      EXPRESSION_TRAFFICKING,	50},
                                    {ExpressionEnum.EXPOSIVES,	        EXPRESSION_EXPOSIVES,	49},
                                    {ExpressionEnum.WEAPONS_OFFENSES,	  EXPRESSION_WEAPONS_OFFENSES,	48},
                                    {ExpressionEnum.DRUG_OFFENSES,	    EXPRESSION_DRUG_OFFENSES,	47},
                                    {ExpressionEnum.DISTRIBUTION_MANUFACTURING_TRANSPORTATION,	EXPRESSION_DISTRIBUTION_MANUFACTURING_TRANSPORTATION,	46},
                                    {ExpressionEnum.MURDER_HOMOCIDE_MANSLAUGHTER,	EXPRESSION_MURDER_HOMOCIDE_MANSLAUGHTER,	45},
                                    {ExpressionEnum.ASSULT_WITH_INTENT_TO_KILL,	EXPRESSION_ASSULT_WITH_INTENT_TO_KILL,	44},
                                    {ExpressionEnum.KIDNAPPING_OR_ABDUCTION,	EXPRESSION_KIDNAPPING_OR_ABDUCTION,	43},
                                    {ExpressionEnum.GRAND_LARCENY,	    EXPRESSION_GRAND_LARCENY,	42},
                                    {ExpressionEnum.BANK_ROBBERY,	      EXPRESSION_BANK_ROBBERY,	41},
                                    {ExpressionEnum.ARMED_ROBBERY,	    EXPRESSION_ARMED_ROBBERY,	40},
                                    {ExpressionEnum.ROBBERY,	          EXPRESSION_ROBBERY,	39},
                                    {ExpressionEnum.FELONY_THEFT,	      EXPRESSION_FELONY_THEFT,	38},
                                    {ExpressionEnum.MISDEMEANOR_THEFT,	EXPRESSION_MISDEMEANOR_THEFT,	37},
                                    {ExpressionEnum.LARCENY,	          EXPRESSION_LARCENY,	36},
                                    {ExpressionEnum.ORGANIZED_RETAIL_THEFT,	EXPRESSION_ORGANIZED_RETAIL_THEFT,	35},
                                    {ExpressionEnum.ARSON,	            EXPRESSION_ARSON,	34},
                                    {ExpressionEnum.BURGLARY,	          EXPRESSION_BURGLARY,	33},
                                    {ExpressionEnum.BREAKING_AND_ENTERING,	EXPRESSION_BREAKING_AND_ENTERING,	32},
                                    {ExpressionEnum.SOLICITATION,	      EXPRESSION_SOLICITATION,	31},
                                    {ExpressionEnum.PORN,	              EXPRESSION_PORN,	30},
                                    {ExpressionEnum.PROSTITUTION,	      EXPRESSION_PROSTITUTION,	29},
                                    {ExpressionEnum.SEXUAL_ASSAULT_AND_BATTERY,	EXPRESSION_SEXUAL_ASSAULT_AND_BATTERY,	28},
                                    {ExpressionEnum.SEXUAL_ABUSE,	      EXPRESSION_SEXUAL_ABUSE,	27},
                                    {ExpressionEnum.STATUTORY_RAPE,	    EXPRESSION_STATUTORY_RAPE,	26},
                                    {ExpressionEnum.RAPE,	              EXPRESSION_RAPE,	25},
                                    {ExpressionEnum.MOLESTATION,	      EXPRESSION_MOLESTATION,	24},
                                    {ExpressionEnum.AGGRAVATED_ASSAULT_OR_BATTERY,	EXPRESSION_AGGRAVATED_ASSAULT_OR_BATTERY,	23},
                                    {ExpressionEnum.ASSAULT_WITH_DEADLY_WEAPON,	EXPRESSION_ASSAULT_WITH_DEADLY_WEAPON,	22},
                                    {ExpressionEnum.ASSAULT,	          EXPRESSION_ASSAULT,	21},
                                    {ExpressionEnum.DOMESTIC_VIOLENCE,	EXPRESSION_DOMESTIC_VIOLENCE,	20},
                                    {ExpressionEnum.ANIMAL_FIGHTING,	  EXPRESSION_ANIMAL_FIGHTING,	19},
                                    {ExpressionEnum.STALKING_HARASSMENT,	EXPRESSION_STALKING_HARASSMENT,	18},
                                    {ExpressionEnum.CYBER_STALKING,	    EXPRESSION_CYBER_STALKING,	17},
                                    {ExpressionEnum.VIOLATE_RESTRAINING_ORDER,	EXPRESSION_VIOLATE_RESTRAINING_ORDER,	16},
                                    {ExpressionEnum.RESISTING_ARREST,	  EXPRESSION_RESISTING_ARREST,	15},
                                    {ExpressionEnum.PROPERTY_DESTRUCTION,	EXPRESSION_PROPERTY_DESTRUCTION,	14},
                                    {ExpressionEnum.VANDALISM,	        EXPRESSION_VANDALISM,	13},
                                    {ExpressionEnum.PERJURY,	          EXPRESSION_PERJURY,	12},
                                    {ExpressionEnum.OBSTRUCTION,	      EXPRESSION_OBSTRUCTION,	11},
                                    {ExpressionEnum.TAMPERING,	        EXPRESSION_TAMPERING,	10},
                                    {ExpressionEnum.COMPUTER_OFFENSES,	EXPRESSION_COMPUTER_OFFENSES,	9},
                                    {ExpressionEnum.GAMBLING_BITCOIN,	  EXPRESSION_GAMBLING_BITCOIN,	8},
                                    {ExpressionEnum.SHOPLIFTING,	      EXPRESSION_SHOPLIFTING,	7},
                                    {ExpressionEnum.ALIEN_OFFENSES,	    EXPRESSION_ALIEN_OFFENSES,	6},
                                    {ExpressionEnum.TRAFFIC_OFFENSES,	  EXPRESSION_ALIEN_OFFENSES,	5},
                                    {ExpressionEnum.DUI,	              EXPRESSION_DUI,	4},
                                    {ExpressionEnum.TRESPASSING,	      EXPRESSION_TRESPASSING,	3},
                                    {ExpressionEnum.DISORDERLY_CONDUCT,	EXPRESSION_DISORDERLY_CONDUCT,	2},
                                    {ExpressionEnum.PUBLIC_INTOXICATION,	EXPRESSION_PUBLIC_INTOXICATION,	1}], ExpressionDSLayout);
                                
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
																							MAX(doesTextContainExpression(ExpressionEnum.SMUGGLING), doesTextContainExpression(ExpressionEnum.TRAFFICKING)));
		EXPORT foundExplosives := doesTextContainExpression(ExpressionEnum.EXPOSIVES);
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
		EXPORT foundTrafficOffenses := expressionDCT[ExpressionEnum.TRAFFIC_OFFENSES].expressionWeight;
		EXPORT foundDUI := doesTextContainExpression(ExpressionEnum.DUI);
		EXPORT foundTrespassing := doesTextContainExpression(ExpressionEnum.TRESPASSING);
		EXPORT foundDisorderlyConduct := doesTextContainExpression(ExpressionEnum.DISORDERLY_CONDUCT);
		EXPORT foundPublicIntoxication := doesTextContainExpression(ExpressionEnum.PUBLIC_INTOXICATION);
		

END;