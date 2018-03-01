
EXPORT RegularExpressions(STRING textToSearch, STRING offenseScore) := MODULE

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
		
		//Common routine to determine if the text contains the definition of the expression
		SHARED doesTextContainExpression(STRING expression) := FUNCTION
				RETURN IF(REGEXFIND(expression, trimTextToSearch, NOCASE), TRUE, FALSE);
		END;


		//available exposed expressions
		EXPORT foundCorruptionOrBribery := doesTextContainExpression(EXPRESSION_CORRUPT_BRIBE);
		EXPORT foundLaundering := doesTextContainExpression(EXPRESSION_LAUNDER);
		EXPORT foundOrganizedCrime := doesTextContainExpression(EXPRESSION_ORGANIZED_CRIME);
		EXPORT foundTerror := doesTextContainExpression(EXPRESSION_TERROR);
		EXPORT foundFraud := doesTextContainExpression(EXPRESSION_FRAUD);
		EXPORT foundIdentityTheft := doesTextContainExpression(EXPRESSION_ID_THEFT);
		EXPORT foundCounterfeit := doesTextContainExpression(EXPRESSION_COUNTERFEIT);
		EXPORT foundCheckFraud := doesTextContainExpression(EXPRESSION_CHECK_FRAUD);
		EXPORT foundForgery := doesTextContainExpression(EXPRESSION_FORGERY);
		EXPORT foundEmbezzlement := doesTextContainExpression(EXPRESSION_EMBEZZLEMENT);
		EXPORT foundFalsePretense := doesTextContainExpression(EXPRESSION_FALSE_PRETENSES);
		EXPORT foundInterceptCommunication := doesTextContainExpression(EXPRESSION_INTERCEPT_COMMUNICATION);
		EXPORT foundWire := doesTextContainExpression(EXPRESSION_WIRE);
		EXPORT foundInsiderTrading := doesTextContainExpression(EXPRESSION_INSIDER_TRADING);
		EXPORT foundTreasonOrEspionage := doesTextContainExpression(EXPRESSION_TREASON_ESPIONAGE);
		EXPORT foundExtortion := doesTextContainExpression(EXPRESSION_EXTORTION);
		EXPORT foundConcealmentOfFunds := doesTextContainExpression(EXPRESSION_CONCEALMENT_OF_FUNDS);
		EXPORT foundTaxOffenses := doesTextContainExpression(EXPRESSION_TAX_OFFENSES);
		EXPORT foundHijacking := doesTextContainExpression(EXPRESSION_HIJACKING);
		EXPORT foundChopShop := doesTextContainExpression(EXPRESSION_CHOP_SHOP);
		
		EXPORT foundTraffickingOrSmuggling := MAP(doesTextContainExpression(EXPRESSION_SMUGGLING) => TRUE,
																							offenseScoreIsTraffic => FALSE,
																							doesTextContainExpression(EXPRESSION_TRAFFICKING));
		EXPORT foundExplosives := doesTextContainExpression(EXPRESSION_EXPOSIVES);
		EXPORT foundWeapons := doesTextContainExpression(EXPRESSION_WEAPONS_OFFENSES);
		EXPORT foundDrugs := doesTextContainExpression(EXPRESSION_DRUG_OFFENSES);
		EXPORT foundDistributionManufacturingTransportation := doesTextContainExpression(EXPRESSION_DISTRIBUTION_MANUFACTURING_TRANSPORTATION);
		
		EXPORT foundMurderHomocideManslaughter := doesTextContainExpression(EXPRESSION_MURDER_HOMOCIDE_MANSLAUGHTER);
		EXPORT foundAssultWithIntentToKill := doesTextContainExpression(EXPRESSION_ASSULT_WITH_INTENT_TO_KILL);
		EXPORT foundKidnappingOrAbduction := doesTextContainExpression(EXPRESSION_KIDNAPPING_OR_ABDUCTION);
		
		EXPORT foundGrandLarceny := doesTextContainExpression(EXPRESSION_GRAND_LARCENY);
		EXPORT foundBankRobbery := doesTextContainExpression(EXPRESSION_BANK_ROBBERY);
		EXPORT foundArmedRobbery := doesTextContainExpression(EXPRESSION_ARMED_ROBBERY);
		EXPORT foundRobbery := doesTextContainExpression(EXPRESSION_ROBBERY);
		EXPORT foundFelonlyTheft := doesTextContainExpression(EXPRESSION_FELONY_THEFT);
		EXPORT foundMisdemeanorTheft := doesTextContainExpression(EXPRESSION_MISDEMEANOR_THEFT);
		EXPORT foundLarceny := doesTextContainExpression(EXPRESSION_LARCENY);
		EXPORT foundOrganizedRetailTheft := doesTextContainExpression(EXPRESSION_ORGANIZED_RETAIL_THEFT);
		EXPORT foundArson := doesTextContainExpression(EXPRESSION_ARSON);
		EXPORT foundBurglary := doesTextContainExpression(EXPRESSION_BURGLARY);
		EXPORT foundBreakingAndEntering := doesTextContainExpression(EXPRESSION_BREAKING_AND_ENTERING);
		
		EXPORT foundSolicitation := doesTextContainExpression(EXPRESSION_SOLICITATION);
		EXPORT foundPorn := doesTextContainExpression(EXPRESSION_PORN);
		EXPORT foundProstitution := doesTextContainExpression(EXPRESSION_PROSTITUTION);
		EXPORT foundSexualAssaultAndBattery := doesTextContainExpression(EXPRESSION_SEXUAL_ASSAULT_AND_BATTERY);
		EXPORT foundSexualAbuse := doesTextContainExpression(EXPRESSION_SEXUAL_ABUSE);
		EXPORT foundStatutoryRape := doesTextContainExpression(EXPRESSION_STATUTORY_RAPE);
		EXPORT foundRape := doesTextContainExpression(EXPRESSION_RAPE);
		EXPORT foundMolestation := doesTextContainExpression(EXPRESSION_MOLESTATION);
		
		EXPORT foundAggravatedAssaultOrBattery := doesTextContainExpression(EXPRESSION_AGGRAVATED_ASSAULT_OR_BATTERY);
		EXPORT foundAssaultWithDeadlyWeapon := doesTextContainExpression(EXPRESSION_ASSAULT_WITH_DEADLY_WEAPON);
		EXPORT foundAssault := doesTextContainExpression(EXPRESSION_ASSAULT);
		EXPORT foundDomesticViolence := doesTextContainExpression(EXPRESSION_DOMESTIC_VIOLENCE);
		EXPORT foundAnimalFighting := doesTextContainExpression(EXPRESSION_ANIMAL_FIGHTING);
		EXPORT foundStalkingOrHarassment := doesTextContainExpression(EXPRESSION_STALKING_HARASSMENT);
		EXPORT foundCyberStalking := doesTextContainExpression(EXPRESSION_CYBER_STALKING);
		EXPORT foundViolateRestrainingOrder := doesTextContainExpression(EXPRESSION_VIOLATE_RESTRAINING_ORDER);
		EXPORT foundResistingArrest := doesTextContainExpression(EXPRESSION_RESISTING_ARREST);
		EXPORT foundPropertyDestruction := doesTextContainExpression(EXPRESSION_PROPERTY_DESTRUCTION);
		EXPORT foundVandalism := doesTextContainExpression(EXPRESSION_VANDALISM);
		
		EXPORT foundPerjury := doesTextContainExpression(EXPRESSION_PERJURY);
		EXPORT foundObstruction := doesTextContainExpression(EXPRESSION_OBSTRUCTION);
		EXPORT foundTampering := doesTextContainExpression(EXPRESSION_TAMPERING);
		EXPORT foundComputerOffenses := doesTextContainExpression(EXPRESSION_COMPUTER_OFFENSES);
		EXPORT foundGamblingOrBitcoin := doesTextContainExpression(EXPRESSION_GAMBLING_BITCOIN);
		
		EXPORT foundShoplifting := doesTextContainExpression(EXPRESSION_SHOPLIFTING);
		EXPORT foundAlienOffenses := doesTextContainExpression(EXPRESSION_ALIEN_OFFENSES);
		EXPORT foundTrafficOffenses := offenseScoreIsTraffic;
		EXPORT foundDUI := doesTextContainExpression(EXPRESSION_DUI);
		EXPORT foundTrespassing := doesTextContainExpression(EXPRESSION_TRESPASSING);
		EXPORT foundDisorderlyConduct := doesTextContainExpression(EXPRESSION_DISORDERLY_CONDUCT);
		EXPORT foundPublicIntoxication := doesTextContainExpression(EXPRESSION_PUBLIC_INTOXICATION);
		

END;