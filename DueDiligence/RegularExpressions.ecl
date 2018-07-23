import DueDiligence;


EXPORT RegularExpressions := MODULE

    //USED FOR ExpressionEnum.TRAFFICKING_SMUGGLING & ExpressionEnum.TRAFFIC_OFFENSES
    SHARED EXPRESSION_SHARED_TRAFFIC_RELATED := '(?=.*\\b(SIGNAL|ONE-WAY|LANE|MOPED|SPEED|IMPEDE|(NON)?MOVING))';
    
    //USED FOR ExpressionEnum.DIST_MANUF_TRANS & ExpressionEnum.DRUG_OFFENSE & ExpressionEnum.WEAPONS_OFFENSES
    SHARED EXPRESSION_SHARED_DRUG_RELATED := '((?=.*\\b(ALPRAZ|AMMONIA|AMPH|ANHY|BARBITUATE|C\\/S(UBSTANCE)?|CANNA|CDS|CHEM|COC(A)?|CODEINE|CRACK|CS|DARVO|DIAZEPAM|DI(HYDRO|MTHYL){1}|DRUG|ECSTASY|EPHED|HALLUC|HARIHUANA|HER(ION|OI){1}|HYDRO(C|MORPH){1}|LSD|MAIRHUANA|MAR(I|J){1}|ME(TH|HT){1}|NARC|NITROU|OPI(ATE|UM){1}|OXY|PENTAZ|PHARM|PHEN(CYC|LACET|YL(ACETONE)?){1}|VALIUM))|((?=.*\\b(CONTR))(?=.*\\b(DANG|SUB)))|((?=.*\\b(CONT))(?=.*\\b(SUB)))|((?=.*\\b(CNTR))(?=.*\\b(SUB))))';
    SHARED EXPRESSION_SHARED_WEAPON_RELATED := '(((?=.*\\b(AMMO))(?!.*\\b(AMMONIA)))|((?=.*\\b(CONTRA))(?!.*\\b(CONTRACT)))|((?=.*\\b(CCW))(?!.*\\b(PARKING)))|(?=.*\\b(UUW|WEA(P)?|W(PN|EP){1}|FIREARM|GUN|AMMUNI|ARMO|KNIFE|ARMED|DISCHARG|PISTOL|RIFLE|SWORD|RAZOR|UCW)))(?!.*\\b(SUBCONTRACT|((?=.*\\b(ARM))(?=.*\\b(ROB)))))';
    
    
    //USED FOR ExpressionEnum.DIST_MANUF_TRANS
    SHARED EXPRESSION_DIST_MANUF_TRANS_DELIVERY := '((?=.*\\b(MAN(U)?F|MAUF|MFG))|((?=.*\\b(DEL))(?!.*\\b(SENT|C(HIL)?D)))|(?=.*\\b(TRAN))|((?=.*\\b(DIS))(?!.*\\b(DISARMING|DISPLAY|DISC)))|(?=.*\\b(DST)))';

    //USED FOR ExpressionEnum.FELONY_THEFT & ExpressionEnum.THEFT
    SHARED EXPRESSION_THEFT_STOLE := '(TH(E)?FT|ST(EA)?L|STLG|STOLE)';
    SHARED EXPRESSION_THEFT_STOLE_LARC := EXPRESSION_THEFT_STOLE + '|(LARC)';
    SHARED EXPRESSION_UNAUTH_VEH := '((?=.*\\b(UNAUTH))(?=.*\\b(VEH)))';
    SHARED EXPRESSION_EXCLUDE_IDENTITY_SHOPLIFT := '(IDENTITY|SHOPL)';
    SHARED EXPRESSION_EXCLUDE_ORG_RET := '((?=.*\\b(RET))(?=.*\\b(ORG)))';
    SHARED EXPRESSION_SHARED_FELONY_THEFT := '((?=.*\\b(' + EXPRESSION_THEFT_STOLE_LARC + '))|' + EXPRESSION_UNAUTH_VEH + ')';
    


 
		EXPORT EXPRESSION_CORRUPT_BRIBE := '^(?=.*\\b(CORRUPT|BRIB))(?!.*\\b(DISTRIBUTE|MINOR)).*$';
		EXPORT EXPRESSION_LAUNDER := '^(?=.*\\b(LAUNDER|LUADER)).*$';
		EXPORT EXPRESSION_ORGANIZED_CRIME := '^(?=.*\\b(ORG))(?=.*\\b(CRI(M)?|THEFT))(?!.*\\b(FORG|RETAIL)).*$'; 
		EXPORT EXPRESSION_TERRORISM := '^(?=.*\\b(TERROR(?!IZ(E|ING){1}|ISTIC)))(?!.*\\b(KIDNAP)).*$';
    EXPORT EXPRESSION_COUNTERFEIT := '^(?=.*\\b(COUNTER)).*$';
    EXPORT EXPRESSION_COMMUNICATE_WIRE_DEVICE := '^((?=.*\\b(INTERCEPT)(?!.*\\b(CABLE)))|(?=.*\\b(RECO)(?=.*\\b(DEV)))|(?=.*\\b(WIRE)))(?!.*\\b(COPPER|ELECTRICAL|PIPES|THEFT|COP|DAMAG|CELL|FRAUD|STEAL)).*$';
    
    EXPORT EXPRESSION_INSIDER_TRADING := '^(?=.*\\b(DEC|TRADE|MARK))(?=.*\\b(PRAC)).*$';
    EXPORT EXPRESSION_TREASON_ESPIONAGE := '^(?=.*\\b(TREASO|ESPIO)).*$';
    EXPORT EXPRESSION_EXTORTION := '^(?=.*\\b(EXTOR)).*$';
    EXPORT EXPRESSION_HIJACKING := '^(?=.*\\b(HIJA|CAR(\\s)?JACK)).*$';
    EXPORT EXPRESSION_CHOP_SHOP := '^(?=.*\\b(CHOP)).*$';

    EXPORT EXPRESSION_TRAFFICKING_SMUGGLING := '^(((?=.*\\b(PROMO))(?=.*\\b(PROS|PORN|MINO|STAT|SEX|CHILD|OBSC|PHOTO)))|(?=.*\\b(PAND|PIMP|PAMPER|TRAFFICK|SMUG))|((?=.*\\b(TRAF))(?=.*\\b(DR(U|G){1}|CO(C|N|KE|N(TRABAND|SPIR){1}){1}|FIREARM|ORGAN|SEX|LABOR|HUMAN|ALIEN|STOLE|SUBSTANCE|CANNABIS|FOOD|MARIJ|DISTRIB|CS|GRAM|OPIUM))))(?!.*\\b(OFFENSE|STOP|HABIT|PEDES|DEVICE|BLOCK|CHAPTER|OBSTRUCTING|DRUNK|D(U|W){1}I|' + EXPRESSION_SHARED_TRAFFIC_RELATED + ')).*$';
    EXPORT EXPRESSION_EXPLOSIVES := '^((?=.*\\b(EXPLOS|NUCLEAR|BOMB|GRENADE))|((?=.*\\b(MASS))(?=.*\\b(DES)))|((?=.*\\b(DES))(?=.*\\b(DEV)))).*$';
		EXPORT EXPRESSION_DIST_MANUF_TRANS := '^(' + EXPRESSION_DIST_MANUF_TRANS_DELIVERY + '(' + EXPRESSION_SHARED_DRUG_RELATED + '|((((?=.*\\b(W\\/I))(?=.*\\b(MANFCTR)))|(((?=.*\\b(POSS))(?=.*\\b(WI)))(?=.*\\b(DEL))?))|' + EXPRESSION_SHARED_WEAPON_RELATED + '))).*$';                                         
    EXPORT EXPRESSION_WEAPONS_OFFENSES := '^' + EXPRESSION_SHARED_WEAPON_RELATED + '.*$';  
		EXPORT EXPRESSION_DRUG_OFFENSES := '^(((?=.*\\b(POSS))(?=.*\\b(MJ|THC|CS|((?=.*\\b(CON))(?=.*\\b(SUB))))))|' + EXPRESSION_SHARED_DRUG_RELATED + ').*$';  

    EXPORT EXPRESSION_FRAUD := '^((?=.*\\b((DE)?FRAUD))|((?=.*\\b(CRED|FIN))(?=.*\\b(CARD)))).*$';
    EXPORT EXPRESSION_CHECK_FRAUD := '^((?=.*\\b(CHEC(K)?|CHK))|((?=.*\\b(CK))(?=.*\\b(WORTH|BAD|FRA|BOGUS)))).*$';
    EXPORT EXPRESSION_FORGERY := '^(?=.*\\b(FORG(E|R)?)).*$';
    EXPORT EXPRESSION_EMBEZZLEMENT := '^(?=.*\\b(EMBEZ|TRANSMITTER)).*$';
    EXPORT EXPRESSION_TAX_OFFENSES := '^(?=.*\\b(TAX)).*$';
		EXPORT EXPRESSION_CONCEALMENT_OF_FUNDS := '^(?=.*\\b(CONCEAL))(?=.*\\b(FUN|MONEY|PROC))(?!.*\\b(CHILD)).*$'; 
		EXPORT EXPRESSION_FALSE_PRETENSES := '^(((?=.*\\b(PRET))(?=.*\\b(FAL|FLS)))|((?=.*\\b(OBT))(?=.*\\b(MONEY|PROP|MERCH|CASH)))|(?=.*\\b(PRETENS))).*$';
		
    EXPORT EXPRESSION_GRAND_LARCENY := '^(?=.*\\b(GR))(?=.*\\b(LARC)).*$';
		EXPORT EXPRESSION_BANK_ROBBERY := '^(?=.*\\b(BAN))(?=.*\\b(ROBB))(?!.*\\b(BATTERY)).*$'; 
		EXPORT EXPRESSION_ARMED_ROBBERY := '^(((?=.*\\b(ROB))(?=.*\\b(ARM|UUW|WEA(P|PON)?|WPN|WEP|FIREARM|GUN|AMMUNI|ARMOR|CONTRA|KNIFE|AMMO(?!NIA))))|(?=.*\\b((A\\s?\\&\\s?ROB)|ARMED\\/ROB)))(?!.*\\b(PROBATION)).*$'; 
		EXPORT EXPRESSION_ROBBERY := '^(((?=.*\\b(ATT))(?=.*\\b(ROB)))|(?=.*\\b(ROBB|ROBER))).*$';
    EXPORT EXPRESSION_ID_THEFT := '^(((?=.*\\b(ID(ENTITY)?))(?=.*\\b(TH(E)?FT|FRAUD|ST(EA)?L)))|((?=.*\\b(TAK))(?=.*\\b(IDEN)))).*$';
    EXPORT EXPRESSION_FELONY_THEFT := '(^(?=.*\\b(FEL))' + EXPRESSION_SHARED_FELONY_THEFT + '(?!.*\\b' + EXPRESSION_EXCLUDE_IDENTITY_SHOPLIFT + ').*$)|(^' + 
                                      EXPRESSION_SHARED_FELONY_THEFT + '(?!.*\\b(' + EXPRESSION_EXCLUDE_IDENTITY_SHOPLIFT + '|' + EXPRESSION_EXCLUDE_ORG_RET + ')).*$)';
		
    EXPORT EXPRESSION_THEFT := '^((?=.*\\b' + EXPRESSION_THEFT_STOLE + ')|' + EXPRESSION_UNAUTH_VEH + ')(?!.*\\b(' + EXPRESSION_EXCLUDE_IDENTITY_SHOPLIFT + '|(FELON)))(?!.*\\b(' + EXPRESSION_EXCLUDE_ORG_RET + ')).*$';
    EXPORT EXPRESSION_LARCENY := '^(?=.*\\b(LARC))(?!.*\\b(GR)).*$';  
   
    EXPORT EXPRESSION_SOLICITATION := '^(?=.*\\b(SOLIC)).*$';
		EXPORT EXPRESSION_PORN := '^(?=.*\\b(PORN)).*$';
		EXPORT EXPRESSION_PROSTITUTION := '^(?=.*\\b(PROST|POSTITUTION)).*$';
		EXPORT EXPRESSION_SEXUAL_ASSAULT_BATTERY := '^(?=.*\\b(S(E)?X))(?=.*\\b(ASS|ASA|ASLT|BATT|BTRY)).*$';  
		EXPORT EXPRESSION_SEXUAL_ABUSE := '^(?=.*\\b(S(E)?X|INTERCOURSE|SOD(O)?MY|LEWD|INDECENT|INCEST|ENTICEMENT)).*$';
		EXPORT EXPRESSION_STATUTORY_RAPE := '^(?=.*\\b(STAT))(?=.*\\b(RAPE)).*$';
		EXPORT EXPRESSION_RAPE := '^(?!.*\\b(STAT))(?=.*\\b(RAPE)).*$';  
		EXPORT EXPRESSION_MOLESTATION := '^(?=.*\b(MOLEST)).*$';
   
    EXPORT EXPRESSION_MURDER := '^(?=.*\\b(M(A)?NSL|MUR(?!ATIC)|HOM(I|O){1}C|KILL|MRDER)).*$';  
		EXPORT EXPRESSION_ASSULT_INTENT_TO_KILL := '^((?=.*\\b(AWI(K|T|TK){1}|(INT\\sTO\\sKILL)))|((?=.*\\b(ASS|ASA))(?=.*\\b(KILL)))|((?=.*\\b(DEAD))(?=.*\\b(COND)))).*$';  
		EXPORT EXPRESSION_KIDNAPPING := '^(?=.*\\b(KIDNA(P)?|ABDU|KDN(A)?P|KIN(D)?AP|KID(D|NPNG){1}|KNDN|KIPN)).*$';
		EXPORT EXPRESSION_ARSON := '^(?=.*\\b(ARSO|BURN)).*$';
		EXPORT EXPRESSION_BURGLARY := '^(?=.*\\b(BUR(L)?G)).*$';
		EXPORT EXPRESSION_BREAKING_AND_ENTERING := '^(((?=.*\\b(BREAK))(?=.*\\b(ENT|IN)))|(?=.*\\b(B\\s?\\&\\s?E))).*$';  
		EXPORT EXPRESSION_AGGRAVATED_ASSAULT := '^(((?=.*\\b(AGG))(?=.*\\b(AS(S|LT){1}|BATT|BTRY)))|^(?=.*\\b((A\\s?\\&\\s?B)|AA\\/(DW|PO|SBI){1}|AAWW)))(?!.*\\b(S(E)?X)).*$';
		EXPORT EXPRESSION_ASSAULT_DEADLY_WEAPON := '^(?=.*\\b(ASS))(?=.*\\b(DEAD|DANG|WEAP)).*$';
		EXPORT EXPRESSION_ASSAULT := '^(?=.*\\b(ASS(?!IST)|BATT|ASLT|BTRY))(?!.*\\b(HARAS)).*$';
		EXPORT EXPRESSION_DOMESTIC_VIOLENCE := '^(?=.*\\b(DOMESTIC))(?!.*\\b(ANI|SECURITIES|DOMESTICALLY|FOWL|FISH|GAME))(?=.*\\b(FAMILY|VIOL)).*$';
		EXPORT EXPRESSION_ANIMAL_FIGHTING := '^(((?=.*\\b(ANIMA))(?=.*\\b(FIGHT)))|(?=.*\\b(COCKFIGHT))).*$';
		EXPORT EXPRESSION_STALKING_HARASSMENT := '^(?=.*\\b(STALK|HAR(R)?AS|TERROR(IZE|ISTIC){1})).*$';
		EXPORT EXPRESSION_CYBER_STALKING := '^(?=.*\\b(CYBER)).*$';
		EXPORT EXPRESSION_VIOLATE_ORDER := '^(((?=.*\\b(RESTRAIN|PROT))(?=.*\\b(ORD)))|((?=.*\\b(CIV))(?=.*\\b(PROT)))).*$';
		EXPORT EXPRESSION_RESISTING_ARREST := '^((((?=.*\\b(RESIST|ESCAPE|ELUDE|FLEE))(?!.*\\b(SEX|RAPE|MV|PERSISTENT|RESISTER|DWI|DUI|INTOX|DNA))))|(?=.*\\b(SCAPE|ELUDI|ABSCON\\sPAROLE))|(?=.*\\b(EVAD))(?=.*\\b(ARR|FUGI))).*$'; 
		EXPORT EXPRESSION_PROPERTY_DESTRUCTION := '^((((?=.*\\b(DESTRU|DESTROY))(?!.*\\b(DEV|ANIM))))|(?=.*\\b(DAMA|PROP))).*$';  
		EXPORT EXPRESSION_VANDALISM := '^(?=.*\\b(VAND)).*$';  

		EXPORT EXPRESSION_PERJURY := '^(?=.*\\b(PERJU)).*$';
		EXPORT EXPRESSION_OBSTRUCTION := '^(?=.*\\b(OBSTR)).*$';
		EXPORT EXPRESSION_TAMPERING := '^(((?=.*\\b(TAMP))(?!.*\\b(STAMP|ME(TH|HT|TA){1})))|((?=.*\\b(TAM))(?=.*\\b(EVI)))).*$';   
		EXPORT EXPRESSION_COMPUTER_OFFENSES := '^(?=.*\\b(COMPU))(?!.*\b(RAPE|COMPUL)).*$';  
		EXPORT EXPRESSION_GAMBLING_BITCOIN := '^(?=.*\\b(GAMBL|BITCOIN|GAMING|CASINO)).*$';
		
		EXPORT EXPRESSION_ORGANIZED_RETAIL_THEFT := '^(?=.*\\b(ORG))(?=.*\\b(RET))(?!.*\\b(FORGERY|RETAL|ENDANGER)).*$';  
		EXPORT EXPRESSION_SHOPLIFTING := '^(?=.*\\b(SHOPL)).*$';
		EXPORT EXPRESSION_ALIEN_OFFENSES := '^(?=.*\\b(ALIEN))(?!.*\\b(SMUG)).*$'; 
		EXPORT EXPRESSION_DUI := '^((?=.*\\b(D.?W.?I.?|D.?U.?I.?|D.?W.?R.?))|((?=.*\\b(DRIV))(?=.*\\b(UND)))|((?=.*\\b(DRIV|DRVG))(?=.*\\b(INTOX|BAC|ALCOHOL|IMPAIRED)))|((?=.*\\b(OPEN))(?=.*\\b(UNDER))(?=.*\\b(INFLUENCE)))).*$';
    EXPORT EXPRESSION_TRAFFIC_OFFENSES := '^(' + EXPRESSION_SHARED_TRAFFIC_RELATED + '|(((((?=.*\\b(STOP))(?=.*\\b(SIGN)))|((?=.*\\b(DRIV))(?=.*\\b(LIC)))|((?=.*\\b(SUSP))(?=.*\\b(DRIV|MV|LIC)))|((?=.*\\b(EXP))(?=.*\\b(REG)))|((?=.*\\b(FAIL))(?=.*\\b(TOLL)))|((?=.*\\b(OBST))(?=.*\\b(PASSAGE)))|((?=.*\\b(VEH))(?=.*\\b(INSURE)))|((?=.*\\b(PROOF))(?=.*\\b(INS)))|((?=.*\\b(FIN))(?=.*\\b(MAINTAIN|RES)))|((?=.*\\b(BELT))(?=.*\\b(SEAT|SAFETY)))|((?=.*\\b(EXPIRE))(?=.*\\b(METER)))|((?=.*\\b(FOLLOW))(?=.*\\b(TOO))(?=.*\\b(CLOSELY))))|(?=.*\\b(SPD(G)?|TRAFFIC|PARKING|DRIV(E|ING){1}|INSURANCE|VEHICLE|HIGHWAY|DIS\\sTC\\sDEV|ST\\sSN|STNS|DWLS|FMFR|MVI|RD\\sLT|NDL|RED\\sLIGHT|PLATES|VIOL\\sOF\\sBASIC\\sRULE))))).*$';
   
		EXPORT EXPRESSION_TRESPASSING := '^(?=.*\\b(TRES)).*$';
		EXPORT EXPRESSION_DISORDERLY_CONDUCT := '^(?=.*\\b(DISOR))(?=.*\\b(CON)).*$';
		EXPORT EXPRESSION_ALCOHOL_RELATED := '^(((?=.*\\b(PUB))(?=.*\\b(CONSU|INTOX)))|((?=.*\\b(OPEN))(?=.*\\b(CONT)))|((?=.*\\b(BAC))(?=.*\\b(ALC)))|((?=.*\\b(DRING))(?=.*\\b(PUBLIC)))|((?=.*\\b(UNDERAGE|MINOR))(?=.*\\b(CONSUM)))|(?=.*\\b(LIQUOR|INTOX|ALCOH))).*$';
    
		EXPORT EXPRESSION_COURT_CHARGES := '^(((?=.*\\b(CONTEMPT))(?=.*\\b(COURT)))|((?=.*\\b(FAIL))(?=.*\\b(APPEAR)))|(?=.*\\b(FTA))).*$';
		EXPORT EXPRESSION_ZONING := '^(?=.*\\b(ZONING)).*$';
		EXPORT EXPRESSION_HUNTING_FISHING := '^(?=.*\\b(FISH|HUNT)).*$';
    
    EXPORT NOT_PO_ADDRESS_EXPRESSION := '^((?!((P[\\s\\.]*O[\\.\\s]*)|(POST[\\s]*OFFICE[\\s]*))+BOX).)*$';  //finds reference to anything other than po box or post office box

    EXPORT FELONY_NOT_REDUCED := '^(?=.*\\b(FELONY))(?!.*\\b(REDUCED))(?!.*\\b(NON-FELONY)).*$';
    EXPORT SPECIFIC_KEYWORD_TRAFFIC := '^(?=.*\\b(TRAFFIC)\\b).*$';
    EXPORT SPECIFIC_KEYWORD_INFRACTION := '^(?=.*\\b(INFRACTION)\\b).*$';
    EXPORT SPECIFIC_KEYWORD_MISDEMEANOR:= '^(?=.*\\b(MISDEMEANOR)\\b).*$';
		

END;