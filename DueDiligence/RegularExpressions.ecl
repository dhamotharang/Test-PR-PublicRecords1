import DueDiligence;


EXPORT RegularExpressions := MODULE

    //USED FOR ExpressionEnum.TRAFFICKING_SMUGGLING & ExpressionEnum.TRAFFIC_OFFENSES
    SHARED EXPRESSION_SHARED_TRAFFIC_RELATED := '(?=.*(\\b|\\B)(SIGNAL|ONE-WAY|LANE|MOPED|SPEED|IMPEDE|(NON)?MOVING))';
    
    //USED FOR ExpressionEnum.DIST_MANUF_TRANS & ExpressionEnum.DRUG_OFFENSE & ExpressionEnum.WEAPONS_OFFENSES
    SHARED EXPRESSION_SHARED_DRUG_RELATED := '((?=.*(\\b|\\B)(ALPRAZ|AMMONIA|AMPH|ANHY|BARBITUATE|C\\/S(UBSTANCE)?|CANNA|CDS|CHEM|COC(A)?|CODEINE|CRACK(?!ED)|CS|DARVO|DIAZEPAM|DI(HYDRO|MTHYL){1}|DRUG|ECSTASY|EPHED|HALLUC|HARIHUANA|HER(ION|OI){1}|HYDRO(C|MORPH){1}|LSD|MAIRHUANA|MAR(I|J){1}|ME(TH|HT){1}|NARC|NITROU|OPI(ATE|UM){1}|OXY|PENTAZ|PHARM|PHEN(CYC|LACET|YL(ACETONE)?){1}|VALIUM))|((?=.*(\\b|\\B)(CONTR))(?=.*(\\b|\\B)(DANG|SUB)))|((?=.*(\\b|\\B)(CONT))(?=.*(\\b|\\B)(SUB)))|((?=.*(\\b|\\B)(CNTR))(?=.*(\\b|\\B)(SUB))))';
    SHARED EXPRESSION_SHARED_WEAPON_RELATED := '(((?=.*(\\b|\\B)(AMMO))(?!.*(\\b|\\B)(AMMONIA)))|((?=.*(\\b|\\B)(CONTRA))(?!.*(\\b|\\B)(CONTRACT)))|((?=.*(\\b|\\B)(CCW))(?!.*(\\b|\\B)(PARKING)))|(?=.*(\\b|\\B){1}(UUW|WEA(P)?|W(PN|EP){1}|FIREARM|GUN|AMMUNI|ARMO|KNIFE|ARMED|DISCHARG|PISTOL|RIFLE|SWORD|RAZOR|UCW)))(?!.*(\\b|\\B)(SUBCONTRACT|((?=.*(\\b|\\B)(ARM))(?=.*(\\b|\\B)(ROB)))))';
    
    
    //USED FOR ExpressionEnum.DIST_MANUF_TRANS
    SHARED EXPRESSION_DIST_MANUF_TRANS_DELIVERY := '((?=.*(\\b|\\B)(MAN(U)?F|MAUF|MFG))|((?=.*(\\b|\\B)(DEL))(?!.*(\\b|\\B)(SENT|C(HIL)?D)))|(?=.*(\\b|\\B)(TRAN))|((?=.*(\\b|\\B)(DIS))(?!.*(\\b|\\B)(DISARMING|DISPLAY|DISC)))|(?=.*(\\b|\\B)(DST)))';

    //USED FOR ExpressionEnum.FELONY_THEFT & ExpressionEnum.THEFT
    SHARED EXPRESSION_THEFT_STOLE := '(TH(E)?FT|ST(EA)?L|STLG|STOLE)';
    SHARED EXPRESSION_THEFT_STOLE_LARC := EXPRESSION_THEFT_STOLE + '|(LARC)';
    SHARED EXPRESSION_UNAUTH_VEH := '((?=.*(\\b|\\B)(UNAUTH))(?=.*(\\b|\\B)(VEH)))';
    SHARED EXPRESSION_EXCLUDE_IDENTITY_SHOPLIFT := '(IDENTITY|SHOPL)';
    SHARED EXPRESSION_EXCLUDE_ORG_RET := '((?=.*(\\b|\\B)(RET))(?=.*(\\b|\\B)(ORG)))';
    SHARED EXPRESSION_SHARED_FELONY_THEFT := '((?=.*(\\b|\\B)(' + EXPRESSION_THEFT_STOLE_LARC + '))|' + EXPRESSION_UNAUTH_VEH + ')';
    


 
		EXPORT EXPRESSION_CORRUPT_BRIBE := '^(?=.*(\\b|\\B)(CORRUPT|BRIB))(?!.*(\\b|\\B)(DISTRIBUTE|MINOR)).*$';
		EXPORT EXPRESSION_LAUNDER := '^(?=.*(\\b|\\B)(LAUNDER|LUADER)).*$';
		EXPORT EXPRESSION_ORGANIZED_CRIME := '^(?=.*(\\b|\\B)(ORG))(?=.*(\\b|\\B)(CRI(M)?|THEFT))(?!.*(\\b|\\B)(FORG|RETAIL)).*$'; 
		EXPORT EXPRESSION_TERRORISM := '^(?=.*(\\b|\\B)(TERROR))(?!.*(\\b|\\B)(KIDNAP|TERROR(IZE|ISTIC){1})).*$';
    EXPORT EXPRESSION_COUNTERFEIT := '^(?=.*(\\b|\\B)(COUNTER)).*$';
    EXPORT EXPRESSION_COMMUNICATE_WIRE_DEVICE := '^((((?=.*(\\b|\\B)(INTERCEPT))(?!.*(\\b|\\B)(CABLE)))|((?=.*(\\b|\\B)(RECO))(?=.*(\\b|\\B)(DEV)))|(?=.*(\\b|\\B)(WIRE)))(?!.*(\\b|\\B)(COPPER|ELECTRICAL|PIPES|THEFT|COP|DAMAG|CELL|FRAUD|STEAL))).*$';
    
    EXPORT EXPRESSION_INSIDER_TRADING := '^(?=.*(\\b|\\B)(DEC|TRADE|MARK))(?=.*(\\b|\\B)(PRAC)).*$';
    EXPORT EXPRESSION_TREASON_ESPIONAGE := '^(?=.*(\\b|\\B)(TREASO|ESPIO)).*$';
    EXPORT EXPRESSION_EXTORTION := '^(?=.*(\\b|\\B)(EXTOR)).*$';
    EXPORT EXPRESSION_HIJACKING := '^(?=.*(\\b|\\B)(HIJA|CAR(\\s)?JACK)).*$';
    EXPORT EXPRESSION_CHOP_SHOP := '^(?=.*(\\b|\\B)(CHOP)).*$';

    EXPORT EXPRESSION_TRAFFICKING_SMUGGLING := '^(((?=.*(\\b|\\B)(PROMO))(?=.*(\\b|\\B)(PROS|PORN|MINO|STAT|SEX|CHILD|OBSC|PHOTO)))|(?=.*(\\b|\\B)(PAND|PIMP|PAMPER|TRAFFICK|SMUG))|((?=.*(\\b|\\B)(TRAF))(?=.*(\\b|\\B)(DR(U|G){1}|CO(C|N|KE|N(TRABAND|SPIR){1}){1}|FIREARM|ORGAN|SEX|LABOR|HUMAN|ALIEN|STOLE|SUBSTANCE|CANNABIS|FOOD|MARIJ|DISTRIB|CS|GRAM|OPIUM))))(?!.*(\\b|\\B)(OFFENSE|STOP|HABIT|PEDES|DEVICE|BLOCK|CHAPTER|OBSTRUCTING|DRUNK|D(U|W){1}I|' + EXPRESSION_SHARED_TRAFFIC_RELATED + ')).*$';
    EXPORT EXPRESSION_EXPLOSIVES := '^((?=.*(\\b|\\B)(EXPLOS|NUCLEAR|BOMB|GRENADE))|((?=.*(\\b|\\B)(MASS))(?=.*(\\b|\\B)(DES)))|((?=.*(\\b|\\B)(DES))(?=.*(\\b|\\B)(DEV)))).*$';
		EXPORT EXPRESSION_DIST_MANUF_TRANS := '^(' + EXPRESSION_DIST_MANUF_TRANS_DELIVERY + '(' + EXPRESSION_SHARED_DRUG_RELATED + '|((((?=.*(\\b|\\B)(W\\/I))(?=.*(\\b|\\B)(MANFCTR)))|(((?=.*(\\b|\\B)(POSS))(?=.*(\\b|\\B)(WI)))(?=.*(\\b|\\B)(DEL))?))|' + EXPRESSION_SHARED_WEAPON_RELATED + '))).*$';                                         
    EXPORT EXPRESSION_WEAPONS_OFFENSES := '^' + EXPRESSION_SHARED_WEAPON_RELATED + '.*$';  
		EXPORT EXPRESSION_DRUG_OFFENSES := '^(((?=.*(\\b|\\B)(POSS))(?=.*(\\b|\\B)(MJ|THC|CS|((?=.*(\\b|\\B)(CON))(?=.*(\\b|\\B)(SUB))))))|' + EXPRESSION_SHARED_DRUG_RELATED + ').*$';  

    EXPORT EXPRESSION_FRAUD := '^((?=.*(\\b|\\B)((DE)?FRAUD))|((?=.*(\\b|\\B)(CRED|FIN))(?=.*(\\b|\\B)(CARD)))).*$';
    EXPORT EXPRESSION_CHECK_FRAUD := '^((?=.*(\\b|\\B)(CHEC(K)?|CHK))|((?=.*(\\b|\\B)(CK))(?=.*(\\b|\\B)(WORTH|BAD|FRA|BOGUS)))).*$';
    EXPORT EXPRESSION_FORGERY := '^(?=.*(\\b|\\B)(FORG(E|R)?)).*$';
    EXPORT EXPRESSION_EMBEZZLEMENT := '^(?=.*(\\b|\\B)(EMBEZ|TRANSMITTER)).*$';
    EXPORT EXPRESSION_TAX_OFFENSES := '^(?=.*(\\b|\\B)(TAX)).*$';
		EXPORT EXPRESSION_CONCEALMENT_OF_FUNDS := '^(?=.*(\\b|\\B)(CONCEAL))(?=.*(\\b|\\B)(FUN|MONEY|PROC))(?!.*(\\b|\\B)(CHILD)).*$'; 
		EXPORT EXPRESSION_FALSE_PRETENSES := '^(((?=.*(\\b|\\B)(PRET))(?=.*(\\b|\\B)(FAL|FLS)))|((?=.*(\\b|\\B)(OBT))(?=.*(\\b|\\B)(MONEY|PROP|MERCH|CASH)))|(?=.*(\\b|\\B)(PRETENS))).*$';
		
    EXPORT EXPRESSION_GRAND_LARCENY := '^(?=.*(\\b|\\B)(GR))(?=.*(\\b|\\B)(LARC)).*$';
		EXPORT EXPRESSION_BANK_ROBBERY := '^(?=.*(\\b|\\B)(BAN))(?=.*(\\b|\\B)(ROBB))(?!.*(\\b|\\B)(BATTERY)).*$'; 
		EXPORT EXPRESSION_ARMED_ROBBERY := '^(((?=.*\\b(ROB))(?=.*(\\b|\\B)(ARM|UUW|WEA(P|PON)?|WPN|WEP|FIREARM|GUN|AMMUNI|ARMOR|CONTRA|KNIFE|AMMO(?!NIA))))|(?=.*(\\b|\\B)((A\\s?\\&\\s?ROB)|ARMED\\/ROB)))(?!.*(\\b|\\B)(PROBATION)).*$'; 
		EXPORT EXPRESSION_ROBBERY := '^(((?=.*(\\b|\\B)(ATT))(?=.*(\\b|\\B)(ROB)))|(?=.*(\\b|\\B)(ROBB|ROBER))).*$';
    EXPORT EXPRESSION_ID_THEFT := '^(((?=.*(\\b|\\B)(ID(ENTITY)?))(?=.*(\\b|\\B)(TH(E)?FT|FRAUD|ST(EA)?L)))|((?=.*(\\b|\\B)(TAK))(?=.*(\\b|\\B)(IDEN)))).*$';
    EXPORT EXPRESSION_FELONY_THEFT := '(^(?=.*(\\b|\\B)(FEL))' + EXPRESSION_SHARED_FELONY_THEFT + '(?!.*(\\b|\\B)' + EXPRESSION_EXCLUDE_IDENTITY_SHOPLIFT + ').*$)|(^' + 
                                      EXPRESSION_SHARED_FELONY_THEFT + '(?!.*(\\b|\\B)(' + EXPRESSION_EXCLUDE_IDENTITY_SHOPLIFT + '|' + EXPRESSION_EXCLUDE_ORG_RET + ')).*$)';
		
    EXPORT EXPRESSION_THEFT := '^((?=.*(\\b|\\B)' + EXPRESSION_THEFT_STOLE + ')|' + EXPRESSION_UNAUTH_VEH + ')(?!.*(\\b|\\B)(' + EXPRESSION_EXCLUDE_IDENTITY_SHOPLIFT + '|(FELON)))(?!.*(\\b|\\B)(' + EXPRESSION_EXCLUDE_ORG_RET + ')).*$';
    EXPORT EXPRESSION_LARCENY := '^(?=.*(\\b|\\B)(LARC))(?!.*(\\b|\\B)(GR)).*$';  
   
    EXPORT EXPRESSION_SOLICITATION := '^(?=.*(\\b|\\B)(SOLIC)).*$';
		EXPORT EXPRESSION_PORN := '^(?=.*(\\b|\\B)(PORN)).*$';
		EXPORT EXPRESSION_PROSTITUTION := '^(?=.*(\\b|\\B)(PROST|POSTITUTION)).*$';
		EXPORT EXPRESSION_SEXUAL_ASSAULT_BATTERY := '^(?=.*(\\b|\\B)(S(E)?X))(?=.*(\\b|\\B)(ASS|ASA|ASLT|BATT|BTRY)).*$';  
		EXPORT EXPRESSION_SEXUAL_ABUSE := '^(?=.*(\\b|\\B)(S(E)?X|INTERCOURSE|SOD(O)?MY|LEWD|INDECENT|INCEST|ENTICEMENT)).*$';
		EXPORT EXPRESSION_STATUTORY_RAPE := '^(?=.*(\\b|\\B)(STAT))(?=.*(\\b|\\B)(RAPE)).*$';
		EXPORT EXPRESSION_RAPE := '^(?!.*(\\b|\\B)(STAT))(?=.*(\\b|\\B)(RAPE)).*$';  
		EXPORT EXPRESSION_MOLESTATION := '^(?=.*(\\b|\\B)(MOLEST)).*$';
   
    EXPORT EXPRESSION_MURDER := '^(?=.*(\\b|\\B)(M(A)?NSL|MUR(?!ATIC)|HOM(I|O){1}C|KILL|MRDER)).*$';  
		EXPORT EXPRESSION_ASSULT_INTENT_TO_KILL := '^((?=.*(\\b|\\B)(AWI(K|T|TK){1}|(INT\\sTO\\sKILL)))|((?=.*(\\b|\\B)(ASS|ASA))(?=.*(\\b|\\B)(KILL)))|((?=.*(\\b|\\B)(DEAD))(?=.*(\\b|\\B)(COND)))).*$';  
		EXPORT EXPRESSION_KIDNAPPING := '^(?=.*(\\b|\\B)(KIDNA(P)?|ABDU|KDN(A)?P|KIN(D)?AP|KID(D|NPNG){1}|KNDN|KIPN)).*$';
		EXPORT EXPRESSION_ARSON := '^(?=.*(\\b|\\B)(ARSO|BURN)).*$';
		EXPORT EXPRESSION_BURGLARY := '^(?=.*(\\b|\\B)(BUR(L)?G)).*$';
		EXPORT EXPRESSION_BREAKING_AND_ENTERING := '^(((?=.*(\\b|\\B)(BREAK))(?=.*(\\b|\\B)(ENT|IN)))|(?=.*(\\b|\\B)(B\\s?\\&\\s?E))).*$';  
		EXPORT EXPRESSION_AGGRAVATED_ASSAULT := '^(((?=.*(\\b|\\B)(AGG))((?=.*\\b(ASS))|(?=.*(\\b|\\B)(ASLT|BATT|BTRY))))|^(?=.*(\\b|\\B)((A\\s?\\&\\s?B)|AA\\/(DW|PO|SBI){1}|AAWW)))(?!.*(\\b|\\B)(S(E)?X)).*$';
		EXPORT EXPRESSION_ASSAULT_DEADLY_WEAPON := '^(?=.*\\b(ASS))(?=.*(\\b|\\B)(DEAD|DANG|WEAP)).*$';
		EXPORT EXPRESSION_ASSAULT := '^((?=.*\\b(ASS(?!IST)))|(?=.*(\\b|\\B)(BATT|ASLT|BTRY)))(?!.*(\\b|\\B)(HARAS)).*$';
		EXPORT EXPRESSION_DOMESTIC_VIOLENCE := '^(((?=.*(\\b|\\B)(DOMESTIC))(?!.*(\\b|\\B)(ANI|SECURITIES|DOMESTICALLY|FOWL|FISH|GAME)))|((?=.*(\\b|\\B)(FAMILY))(?=.*(\\b|\\B)(VIOL)))).*$';
		EXPORT EXPRESSION_ANIMAL_FIGHTING := '^(((?=.*(\\b|\\B)(ANIMA))(?=.*(\\b|\\B)(FIGHT)))|(?=.*(\\b|\\B)(COCKFIGHT))).*$';
		EXPORT EXPRESSION_STALKING_HARASSMENT := '^(?=.*(\\b|\\B)(STALK|HAR(R)?AS|TERROR(IZE|ISTIC){1})).*$';
		EXPORT EXPRESSION_CYBER_STALKING := '^(?=.*(\\b|\\B)(CYBER)).*$';
		EXPORT EXPRESSION_VIOLATE_ORDER := '^(((?=.*\\b(RESTRAIN|PROT))(?=.*\\b(ORD)))|((?=.*\\b(CIV))(?=.*\\b(PROT)))).*$';
		EXPORT EXPRESSION_RESISTING_ARREST := '^((((?=.*(\\b|\\B)(RESIST|ESCAPE|ELUDE|FLEE))(?!.*(\\b|\\B)(SEX|RAPE|MV|PERSISTENT|RESISTER|DWI|DUI|INTOX|DNA))))|(?=.*(\\b|\\B)(SCAPE|ELUDI|ABSCON\\sPAROLE))|(?=.*(\\b|\\B)(EVAD))(?=.*(\\b|\\B)(ARR|FUGI))).*$'; 
		EXPORT EXPRESSION_PROPERTY_DESTRUCTION := '^((((?=.*(\\b|\\B)(DESTRU|DESTROY))(?!.*(\\b|\\B)(DEV|ANIM))))|((?=.*(\\b|\\B)(DAMA))(?=.*(\\b|\\B)(PROP)))).*$';  
		EXPORT EXPRESSION_VANDALISM := '^(?=.*(\\b|\\B)(VAND)).*$';  

		EXPORT EXPRESSION_PERJURY := '^(?=.*(\\b|\\B)(PERJU)).*$';
		EXPORT EXPRESSION_OBSTRUCTION := '^(?=.*(\\b|\\B)(OBSTR)).*$';
		EXPORT EXPRESSION_TAMPERING := '^(((?=.*(\\b|\\B)(TAMP))(?!.*(\\b|\\B)(STAMP|ME(TH|HT|TA){1})))|((?=.*(\\b|\\B)(TAM))(?=.*(\\b|\\B)(EVI)))).*$';   
		EXPORT EXPRESSION_COMPUTER_OFFENSES := '^(?=.*(\\b|\\B)(COMPU))(?!.*(\\b|\\B)(RAPE|COMPUL)).*$';  
		EXPORT EXPRESSION_GAMBLING_BITCOIN := '^(?=.*(\\b|\\B)(GAMBL|BITCOIN|GAMING|CASINO)).*$';
		
		EXPORT EXPRESSION_ORGANIZED_RETAIL_THEFT := '^(?=.*(\\b|\\B)(ORG))(?=.*(\\b|\\B)(RET))(?!.*(\\b|\\B)(FORGERY|RETAL|ENDANGER)).*$';  
		EXPORT EXPRESSION_SHOPLIFTING := '^(?=.*(\\b|\\B)(SHOPL)).*$';
		EXPORT EXPRESSION_ALIEN_OFFENSES := '^(?=.*(\\b|\\B)(ALIEN))(?!.*(\\b|\\B)(SMUG)).*$'; 
		EXPORT EXPRESSION_DUI := '^((?=.*\\b(D\\.?W\\.?I\\.?|D\\.?U\\.?I\\.?|D\\.?W\\.?R\\.?))|((?=.*(\\b|\\B)(DRIV))(?=.*(\\b|\\B)(UND)))|((?=.*(\\b|\\B)(DRIV|DRVG|OPER))(?=.*(\\b|\\B)(INTOX|BAC|ALCOHOL|IMPAIRED)))|((?=.*(\\b|\\B)(OPER))(?=.*(\\b|\\B)(UNDER))(?=.*(\\b|\\B)(INFLUENCE)))).*$';
    EXPORT EXPRESSION_TRAFFIC_OFFENSES := '^(' + EXPRESSION_SHARED_TRAFFIC_RELATED + '|(((((?=.*(\\b|\\B)(STOP))(?=.*(\\b|\\B)(SIGN)))|((?=.*(\\b|\\B)(DRIV))(?=.*(\\b|\\B)(LIC)))|((?=.*(\\b|\\B)(SUSP))(?=.*(\\b|\\B)(DRIV|MV|LIC)))|((?=.*(\\b|\\B)(EXP))(?=.*(\\b|\\B)(REG)))|((?=.*(\\b|\\B)(FAIL))(?=.*(\\b|\\B)(TOLL)))|((?=.*(\\b|\\B)(OBST))(?=.*(\\b|\\B)(PASSAGE)))|((?=.*(\\b|\\B)(VEH))(?=.*(\\b|\\B)(INSURE)))|((?=.*(\\b|\\B)(PROOF))(?=.*(\\b|\\B)(INS)))|((?=.*(\\b|\\B)(FIN))(?=.*(\\b|\\B)(MAINTAIN|RES)))|((?=.*(\\b|\\B)(BELT))(?=.*(\\b|\\B)(SEAT|SAFETY)))|((?=.*(\\b|\\B)(EXPIRE))(?=.*(\\b|\\B)(METER)))|((?=.*(\\b|\\B)(FOLLOW))(?=.*(\\b|\\B)(TOO))(?=.*(\\b|\\B)(CLOSELY))))|(?=.*(\\b|\\B)(SPD(G)?|TRAFFIC|PARKING|DRIV(E|ING){1}|INSURANCE|VEHICLE|HIGHWAY|DIS\\sTC\\sDEV|ST\\sSN|STNS|DWLS|FMFR|MVI|RD\\sLT|NDL|RED\\sLIGHT|PLATES|VIOL\\sOF\\sBASIC\\sRULE))))).*$';
   
		EXPORT EXPRESSION_TRESPASSING := '^(?=.*(\\b|\\B)(TRES)).*$';
		EXPORT EXPRESSION_DISORDERLY_CONDUCT := '^(?=.*(\\b|\\B)(DISOR))(?=.*(\\b|\\B)(CON)).*$';
		EXPORT EXPRESSION_ALCOHOL_RELATED := '^(((?=.*(\\b|\\B)(PUB))(?=.*(\\b|\\B)(CONSU|INTOX)))|((?=.*(\\b|\\B)(OPEN))(?=.*(\\b|\\B)(CONT)))|((?=.*(\\b|\\B)(BAC))(?=.*(\\b|\\B)(ALC)))|((?=.*(\\b|\\B)(DRING))(?=.*(\\b|\\B)(PUBLIC)))|((?=.*(\\b|\\B)(UNDERAGE|MINOR))(?=.*(\\b|\\B)(CONSUM)))|(?=.*(\\b|\\B)(LIQUOR|INTOX|ALCOH))).*$';
    
		EXPORT EXPRESSION_COURT_CHARGES := '^(((?=.*(\\b|\\B)(CONTEMPT))(?=.*(\\b|\\B)(COURT)))|((?=.*(\\b|\\B)(FAIL))(?=.*(\\b|\\B)(APPEAR)))|(?=.*(\\b|\\B)(FTA))).*$';
		EXPORT EXPRESSION_ZONING := '^(?=.*(\\b|\\B)(ZONING)).*$';
		EXPORT EXPRESSION_HUNTING_FISHING := '^(?=.*(\\b|\\B)(FISH|HUNT)).*$';
    
    EXPORT NOT_PO_ADDRESS_EXPRESSION := '^((?!((P[\\s\\.]*O[\\.\\s]*)|(POST[\\s]*OFFICE[\\s]*))+BOX).)*$';  //finds reference to anything other than po box or post office box

    EXPORT FELONY_NOT_REDUCED := '^(?=.*(\\b|\\B)(FELONY))(?!.*(\\b|\\B)(REDUCED))(?!.*(\\b|\\B)(NON-FELONY)).*$';
    EXPORT SPECIFIC_KEYWORD_TRAFFIC := '^(?=.*\\b(TRAFFIC)\\b).*$';
    EXPORT SPECIFIC_KEYWORD_INFRACTION := '^(?=.*\\b(INFRACTION)\\b).*$';
    EXPORT SPECIFIC_KEYWORD_MISDEMEANOR:= '^(?=.*\\b(MISDEMEANOR)\\b).*$';
		
END;