import DueDiligence;


EXPORT RegularExpressions := MODULE

    SHARED STARTS_WITH := '^';
    SHARED ENDS_WITH := '.*$';
    
    
    //Common/shared list for expressions
    SHARED COMMON_ALCOHOL := '(((?=.*(\\b|\\B)(PUB))(?=.*(\\b|\\B)(INTOX|CONSUM|DRIN(G|K))))|((?=.*(\\b|\\B)(OPEN))(?=.*(\\b|\\B)(CONT)))|((?=.*(\\b|\\B)(ALC))(?=.*(\\b|\\B)(VIO|BLOOD)))|((?=.*(\\b|\\B)(BAC))(?=.*(\\b|\\B)(ALC)))|((?=.*(\\b|\\B)(CONSUM))(?=.*(\\b|\\B)(UNDERAGE|MINOR)))|((?=.*(\\b|\\B)(UNDER))(?=.*(\\b|\\B)(INFL)))|((?=.*(\\b|\\B)(REFUSE))(?=.*(\\b|\\B)(BLOOD|BREA)))|(?=.*(\\b|\\B)(ALCOH|DRUNK|INTOX|LIQUOR|BEER)))';
    SHARED COMMON_ARSON := '(?=.*(\\b|\\B)(ARSO|BURN))';
    SHARED COMMON_BREAKING_AND_ENTERING := '(((?=.*(\\b|\\B)(BREAK))(?=.*(\\b|\\B)(ENT|IN)))|((?=.*(\\b|\\B)(HOME))(?=.*(\\b|\\B)(INV)))|(?=.*(\\b|\\B)(B(\\s)?\\&(\\s)?E)))';
    SHARED COMMON_BURGLARY := '((?=.*(\\b|\\B)(B(RG|U(GL|RG|RL(A|G)))))((?!.*(\\b|\\B)(PITTSBURGH))))';
    SHARED COMMON_CAR_JACK := '(((?=.*(\\b|\\B)(JACK))(?=.*(\\b|\\B)(CAR|VEH)))|(?=.*(\\b|\\B)(CARJACK)))';
    SHARED COMMON_CHILD := '(?=.*(\\b|\\B)(CH(ILD|D|LD)|MINO|JUV))';     
    SHARED COMMON_CONTROLLED_SUBSTANCE := '(((?=.*(\\b|\\B)(C(N(T(L|R(\\/CNFT|L|OL(LED)?)?)?)?)|ON(\'T|T(R)?)|CTL))(?=.*(\\b|\\B)(SUB)))|((?=.*(\\b|\\B)(CNTRLD))(?=.*(\\b|\\B)(SBSTNC)))|((?=.*(\\b|\\B)(CON))(?=.*(\\b|\\B)(SB)))|((?=.*(\\b|\\B)(CONTROLLED))(?=.*(\\b|\\B)(SUBSTANCE)))|((?=.*(\\b|\\B)(CTR))(?=.*(\\b|\\B)(SU)))|(?=.*(\\b|\\B)(C(\\.S\\.|\\/S(UBSTANCE)?|ONSUB|ONT(\\.|\\/)SUB|\\-SUB))))';
    SHARED COMMON_COUNTERFEIT := '((?=.*(\\b|\\B)(COUNTER))|((?=.*(\\b|\\B)(ILL))(?=.*(\\b|\\B)(MONEY))))';
    SHARED COMMON_CRIMINAL_PROCEEDS := '((?=.*(\\b|\\B)(PROCEEDS))(?=.*(\\b|\\B)(ACQ(UIR)?|CRIM|DRUG)))';
    SHARED COMMON_DISORDERLY_CONDUCT := '((((?=.*(\\b|\\B)(DISOR))(?=.*(\\b|\\B)(CON)))|((?=.*(\\b|\\B)(PEAC))(?=.*(\\b|\\B)(DIST|BREACH)))|((?=.*(\\b|\\B)(FAL))(?=.*(\\b|\\B)(911)))|(?=.*(\\b|\\B)(URINAT)))(?!.*' + COMMON_ALCOHOL + '))';
    SHARED COMMON_DOMESTIC_FAMILY := '((((?=.*(\\b|\\B)(AB(AN(DON)?|ON|SE|US)|CRUEL|E(ND|XPLOIT)|INJ|M(IST|STR)|NEG|RECK))((?=.*(\\b|\\B)(ADULT|C(ARETAKER|UST)|ELDER|PA(RENT|TIENT)|RESIDENT|WLF))|' + COMMON_CHILD + '))|((?=.*(\\b|\\B)(FAMILY))(?=.*(\\b|\\B)(VIOL)))|(?=.*(\\b|\\B)(DOMESTIC|CHILDEND)))(?!.*(\\b|\\B)(ANI|DOMESTICALLY|F(ISH|OWL)|GAME|SECURITIES)))';
    SHARED COMMON_DRUG := '((?=.*(\\b|\\B)(ALPRA(X|Z)|A(M(MONIA|PH)|NHY)|BARBITUATE|C(A(RFE|NNA)|H(E)?M|O(CA|DEINE|KE)|RA(C|N)K)|D(ARVO|ESTROMETH|GS|I(AZEPAM|HYDRO|MTHYL)|R(GS|UG))|E(CSTASY|PHED)|FENT|G(HB|RAMS)|H(A(LLUC|RIHUANA|SH(ISH)?)|ER(ION|OI)|OX|YDRO(C|MORPH))|LSD|M(AIRHUANA|AR(I|J|U)|DMA|E(HT|TH)|RHNA)|N(ARC|ITROU|ORTEST)|O(PI(ATE|UM)|XY)|P(ENTAZ|H(ARM|EN(CYC|LACET|YL(ACETONE)?)?)|RE(SC|CS))|SCHEDULE|STEROID|VALIUM|XANAX|((?=.*(\\b|\\B)(CONTR))(?=.*(\\b|\\B)(DANG)))|((?=.*(\\b|\\B)(SCH(ED)?))(?=.*(\\b|\\B)(\\s(I(I(I)?)?|IV|V(I)?)\\s)))|' + COMMON_CONTROLLED_SUBSTANCE + '))(?!.*(\\b|\\B)(SCHEME|CRACKING|PROGRAM)))';
    SHARED COMMON_DRUG_PARAPHERNALIA := '(?=.*(\\b|\\B)(DGPARA|PAR(A(PH)?)|PARP|((?=.*(\\b|\\B)(DR))(?=.*(\\b|\\B)(PAR)))))';
    SHARED COMMON_DRUG_SLIM := '((?=.*(\\b|\\B)(C(S|D(S)?|OC)|MJ|THC|((?=.*(\\b|\\B)(C))(?=.*(\\b|\\B)(SUB)))))(?!.*(\\b|\\B)(RCSP)))';
    SHARED COMMON_DUI := '(((?=.*(\\b|\\B)(DR(IV|VG)?|MV|OPER|VESSEL))((?=.*(\\b|\\B)(ALC|BAC|C(HEM|ONSUME)|I(MPAIR|NTOX)|OWI|UNDER))|((?=.*(\\b|\\B)(UND))(?=.*(\\b|\\B)(INF)))))|(?=.*(\\b|\\B)((\\()?D((\\s|\\.)+)?(U|W)((\\s|\\.)+)?I(\\.)?(\\))?)|DWR))';
    SHARED COMMON_EXPLOSIVES := '((?=.*(\\b|\\B)(EXPLOS|NUCLEAR|BOMB|GRENADE|WMD))|((?=.*(\\b|\\B)(DES))(?=.*(\\b|\\B)(DEV|MASS)))|((?=.*(\\b|\\B)(WEAP))(?=.*(\\b|\\B)(MASS)))|((?=.*(\\b|\\B)(TEAR))(?=.*(\\b|\\B)(GAS)))|((?=.*(\\b|\\B)(BIO))(?=.*(\\b|\\B)(AGENT|TOXIN))))';
    SHARED COMMON_FALSE_STATEMENT := '(((?=.*(\\b|\\B)(FALSE))(?=.*(\\b|\\B)(IDENTIF|PERSONAT|INFORM|STATE)))|((?=.*(\\b|\\B)(FAIL))(?=.*(\\b|\\B)(IDENTIF)))|(?=.*(\\b|\\B)(FICTICOUS\\s\\(INFO\\))))';
    SHARED COMMON_FORGERY := '(?=.*(\\b|\\B)(F(ORG(E|R)?|RGD)|TRADEM|UTTER))';
    SHARED COMMON_FRAUD := '(?=.*(\\b|\\B)((DE)?FRAUD|CHEAT))';
    SHARED COMMON_GANG := '(((?=.*(\\b|\\B)(GANG))|((?=.*(\\b|\\B)(GNG))(?=.*(\\b|\\B)(STR|CRM))))(?!.*(\\b|\\B)(ENGANG)))';
    SHARED COMMON_IDENTITY_FRAUD := '(((?=.*(\\b)(ID))|(?=.*(\\b|\\B)(ID(EN(TITY)?))))(?=.*(\\b|\\B)(TH(E)?FT|FRAUD|ST(EA)?L|TAK|CRIM|OBTAIN)))';
    SHARED COMMON_IMPORT_EXPORT := '(?=.*(\\b|\\B)(IMPORT|EXPORT))';
    SHARED COMMON_KIDNAPPING := '((?=.*(\\b|\\B)(ABDU|K(DN(A)?P|I(D(A|D|N(A(P)?)?|PNG)?|N(D)?AP|PN)|NDN)))|((?=.*(\\b|\\B)(CHILD))(?=.*(\\b|\\B)(STEAL))))';
    SHARED COMMON_LAB := '((?=.*(\\b|\\B)(LAB))(?=.*(\\b|\\B)(OPER\\/MAIN|OPERAT|MAIN)))';
    SHARED COMMON_MANUFACTURING := '(?=.*(\\b|\\B)(MA(N(F(CTR)?|UF)?|UF)|MDP|MFG|MNF))';
    SHARED COMMON_MANUFACTURING_DELIVERY_SELLING := '(((?=.*(\\b|\\B)(CONV|DE(AL|L(IVERY)?)|DIS(T(RB)?)?|DS(PNS|T)+|PR(EP|OCS|OD)+|S\\/D|SALE|(\\-)?SELL|TRAN))|' + COMMON_MANUFACTURING + ')(?!.*(\\b|\\B)(DIS(ARMING|CHAR|PLAY|C|AB)|CHILD|BRANDISH|SENT)))';
    SHARED COMMON_MANUFACTURING_STANDALONE_ACRONYM := '(?=.*(\\b|\\B)((MAN\\/DEL)|(DEL\\/(MAN|SELL)|DIS\\/POS|DIST(\\,|\\/DEL(\\/SELL)?|POSS)|DIST(\\/POSS|RB\\/SELL|RIBUTE\\/PID)|(MAN|MFG)\\/DEL|POSS\\/SELL|S\\/M\\/D|SL\\/DEL(\\/POS)?|\\(DIST\\,\\sSELL\\))))';
    SHARED COMMON_MISAPPROPRIATION_FUNDS := '((?=.*(\\b|\\B)(MISAP(L(Y)?|P)?))(?=.*(\\b|\\B)((F(ID(C|U(C)?))?|UD(U|I)C)|UNDS|P(ROP|UBLIC)|TRUST|ASSIST|SECURITY|MON(EY|IES))))';
    SHARED COMMON_MONEY_LAUNDER_TAX_EVASION := '((((?=.*(\\b|\\B)(UNTAX|UNSTAM|TAX|STAM))|((?=.*(\\b|\\B)(TX))(?=.*(\\b|\\B)(STAM))))(?=.*(\\b|\\B)(CIG|TOB|ALC|LIQ|FOOD)))((?!.*(\\b|\\B)(REDE(E)?M|MISAPPROP|USE|FALSE))(?!.*(' + COMMON_DRUG + COMMON_DRUG_SLIM + '))))';
    SHARED COMMON_MONEY_TRANSMITTER := '(((?=.*(\\b|\\B)(TRANS))(?=.*(\\b|\\B)(EMB)))|(?=.*(\\b|\\B)(\\$TRANS|TRANSMITTER)))';
    SHARED COMMON_OBTAIN_PROPERTY := '(((?=.*(\\b|\\B)(PRET))(?=.*(\\b|\\B)(FAL|FLS)))|((?=.*(\\b|\\B)(OBT))(?=.*(\\b|\\B)(MONEY|PROP|MERCH|CASH))))';
    SHARED COMMON_PORN := '(((?=.*(\\b|\\B)(PHOTO))(?=.*(\\b|\\B)(INDEC|LEWD|OBSC)))|((?=.*(\\b|\\B)(OBSC))(?=.*(\\b|\\B)(MATER)))|(?=.*(\\b|\\B)(PO(RN|SS\\sOBSC))))';
    SHARED COMMON_POSSESSION := '((?=.*(\\b|\\B)(POS|POSN|PCS|USE))|((?=.*(\\b|\\B)(CONST))(?=.*(\\b|\\B)(POS))))';
    SHARED COMMON_POSSESSION_WITH_INTENT := '(?=.*(\\b|\\B)(PWI(T|D)|PSNW\\/I|(P|W)ID|W\\.I\\.T\\.D))';
    SHARED COMMON_RACKETEERING := '(?=.*(\\b|\\B)(R(ACKE|ICO)|SHARK))';
    SHARED COMMON_SEX := '((?=.*(\\b|\\B)(ENTIC(I|EMENT)|FO(NDL|RNICA)|IN(CEST|DEC(ENT)?|TERCOURSE)|L(ASCIVI|EWD|UR(E|ING))|M(ASTERBA|LST|OLEST)|PEEPING|S((E)?X|OD(O)?MY)))|((?=.*(\\b|\\B)(LASC))(?=.*(\\b|\\B)(ACT)))|((?=.*(\\b|\\B)(IND))(?=.*(\\b|\\B)(LIB|PROP|EXPO)))|((?=.*(\\b|\\B)(VIOL))(?=.*(\\b|\\B)(DAT(E|ING))))|((?=.*(\\b|\\B)(EXPOS))(?=.*(\\b|\\B)(GENI)))|((?=.*(\\b|\\B)(' + COMMON_CHILD + '))(?=.*(\\b|\\B)(M(IST|O(E|L|SL)))))|((?=.*(\\b|\\B)(' + COMMON_CHILD + '))(?=.*(\\b|\\B)(ENTI|INDE))))';
    SHARED COMMON_STRUCTURING := '((((?=.*(\\b|\\B)(STRUCT))(?=.*(\\b|\\B)(TRAN)))|(?=.*(\\b|\\B)(STRUCTURESFINANCIALTRANSACTTOEVADEREPORT)))(?!.*(\\b|\\B)(DESTRUCTIVE)))';
    SHARED COMMON_SUPPORT := '(?=.*(\\b|\\B)(SP(((O)?R|P)T)?|SUP(O(O)?RT|RT|T)?|SUPP(O(R)?T|PORT|RT|T)))';
    SHARED COMMON_TERRORISM := '(((?=.*(\\b|\\B)(TERROR(ISM|IST)|HIJACK))|((?=.*(\\b|\\B)(PLAN|ATT|CONSP|PERF|THREAT))((?=.*(\\b|\\B)(ACT))(?=.*(\\b|\\B)(VIO)))(?!.*(\\b|\\B)(BATTERY|MANUFACTURE)))|((?=.*(\\b|\\B)(TEACH))(?=.*(\\b|\\B)(SYND)))|((?=.*(\\b|\\B)(THREAT))(?=.*(\\b|\\B)(CATAST))))((?!.*(\\b|\\B)(TERRORI(ZE|STIC)|KIDNAP))(?!.*(' + COMMON_CAR_JACK + '))))';
    SHARED COMMON_THEFT := '((?=.*(\\b|\\B)(TH(E(F(T)?|T)|FT)|ST(EAL|L(G)?|OLE)))|((?=.*(\\b|\\B)(KEEP))(?=.*(\\b|\\B)(PROP))))';
    SHARED COMMON_TRAFFIC := '((((?=.*(\\b|\\B)(SEAT))(?=.*(\\b|\\B)(BELT|REST|CHILD)))|' +
                              '((?=.*(\\b|\\B)(SAFE))(?=.*(\\b|\\B)(BELT|RESTR)))|' +
                              '((?=.*(\\b|\\B)(LIC))(?=.*(\\b|\\B)(DRIV|VALID|PLAT|SUS|REG)))|' +
                              '((?=.*(\\b|\\B)(VEH))(?=.*(\\b|\\B)(FEE|COMM)))|' +
                              '((?=.*(\\b|\\B)(TRAF))(?=.*(\\b|\\B)(DEVIC)))|' +
                              '((?=.*(\\b|\\B)(INS))(?=.*(\\b|\\B)(VEH|PROOF)))|' +
                              '((?=.*(\\b|\\B)(SUS))(?=.*(\\b|\\B)(DRIV|MV)))|' +
                              '((?=.*(\\b|\\B)(EXP))(?=.*(\\b|\\B)(REG|METER)))|' +
                              '((?=.*(\\b|\\B)(REG))(?=.*(\\b|\\B)(TAG|PLAT)))|' +
                              '((?=.*(\\b|\\B)(TEMP))(?=.*(\\b|\\B)(TAG|REG)))|' +
                              '((?=.*(\\b|\\B)(VALID))(?=.*(\\b|\\B)(STICK)))|' +
                              '((?=.*(\\b|\\B)(FAIL))(?=.*(\\b|\\B)(REG|TOLL)))|' +
                              '((?=.*(\\b|\\B)(SCEN))(?=.*(\\b|\\B)(L(EAVE|V))))|' +
                              '((?=.*(\\b|\\B)(HIT))(?=.*(\\b|\\B)(RUN)))|' +
                              '((?=.*(\\b|\\B)(FOLLO))(?=.*(\\b|\\B)(CLOS)))|' +
                              '((?=.*(\\b|\\B)(FIN))(?=.*(\\b|\\B)(MAINTAIN|RES)))|' +
                              '((?=.*(\\b|\\B)(VIOL))((?=.*(\\b|\\B)(WEIG|PARK|METER|PLATE))|((?=.*(\\b|\\B)(BAS))(?=.*(\\b|\\B)(RUL)))|((?=.*(\\b|\\B)(INST))(?=.*(\\b|\\B)(PERM)))))|' +
                              '((?=.*(\\b|\\B)(STOP))(?=.*(\\b|\\B)(SIGN)))|' +
                              '((?=.*(\\b|\\B)(RED))(?=.*(\\b|\\B)(LIGHT)))|' +
                              '((?=.*(\\b|\\B)(DIS))(?=.*(\\b|\\B)(TC))(?=.*(\\b|\\B)(DEV)))|' +
                              '((?=.*(\\b|\\B)(PASS))(?=.*(\\b|\\B)(OBS|REST)))|' +
                              '((?=.*(\\b|\\B)(HAB))(?=.*(\\b|\\B)(OFF)))|' +
                              '((?=.*(\\b|\\B)(CLEAR))(?=.*(\\b|\\B)(DIST)))|' +
                              '(?=.*(\\b|\\B)(A(CDA|XLES)|B(ICYC|OAT)|D(R(IV(ING)?|VNG)|WLS)|FMRF|H(ELMET|IGHWAY)|INSURANCE|LANE|M(ETER|O(PED|TOR|VING)|VI)|NONMOVING|ONE\\-WAY|P(ARKING|EDE|LATES)|S(IGNAL|P(DG|EED)|TNS)|UNINSUR|VEHICLE)))' +
                              '(?!.*(\\b|\\B)(COMVICTIONS)))';
    SHARED COMMON_TRAFFICKING_ITEMS := '(((?=.*(\\b|\\B)(PROM|ADVER|PLACE))((?=.*(\\b|\\B)(PROS|POST|PORN|STAT|SEX|OBSC|PHOTO))|' + COMMON_CHILD + '))|((?=.*(\\b|\\B)(TRAF|TRANS|MOVE))((?=.*(\\b|\\B)(ALIEN|ORGAN|SEX|LABOR|HUMAN|FOOD))|' + COMMON_CHILD + ')))';
    SHARED COMMON_TRAFFICKING_TERMS := '(?=.*(\\b|\\B)((TRFF(CKING|ICKING|K(G|NG)+)?)|(TRFK(G|ING)?)|(TRAFF(\\.|C(HILD|KG|K(I)?NG)|ICKING|IK(GN|ING)?|ING|K(G|ICKING|NG)?|RKG)?)|(TRAF(\\.|\\/|CK(G\\.|ING)+|ICK(\\.|ING)?|IK(G|ING)+)+)))';
    SHARED COMMON_TRAFFICKING_WAYS := '(?=.*(\\b|\\B)(PAND|PIMP|PAMPER|SMUG|TRAFFICK|PROM\\.PROST|PROM\\/PROS))';
    SHARED COMMON_TRANSPORT_PROCEEDS := '(((?=.*(\\b|\\B)(TRANSPORT))(?=.*(\\b|\\B)(VIOLATION)))|((?=.*(\\b|\\B)(CURR))(?=.*(\\b|\\B)(EXCHA)))|((?=.*(\\b|\\B)(TRANS))(?=.*(\\b|\\B)(PROCEED))))';
    SHARED COMMON_WEAPON := '((?=.*(\\b|\\B)(AMM(O|UNI)|ARM(O|ED)|CCW|CONTRA|DISCHARG|F(\\-|IRE)ARM|GUN|KNIFE|PISTOL|RAZOR|RIFLE|RVOLV|SWORD|(\\()?U(\\.|\\s)?U(\\.|\\s)?W(\\.|\\))?|UCW|WEA(P(ON)?)?|WEP|WPN))((?!.*(\\b|\\B)(AMMONIA|(SUB)?CONTRACT|PARKING))|((?!.*(\\b|\\B)(ARM))(?=.*(\\b|\\B)(ROB)))))';
    SHARED COMMON_WITH_INTENT := '(?=.*(\\b|\\B)(INT(ENT)?|WI(T)?|W\\/((\\s)?INTENT|I(NT(\\.)?)?)?|W\\.I\\.T\\.D))';
    
    
    SHARED COMMON_AGGRAVATED_ASSAULT := '((?=.*(\\b|\\B)(A(\\s)?\\&(\\s)?b|A\\/B|AA\\/(DW|PO|SBI)|AAWW|AW(DW(ISI|WITKISI)?)))|((?=.*(\\b|\\B)(AG(G|RV|A)?))|' + COMMON_WITH_INTENT + ')(?=.*(\\b|\\B)(A(LST|S(AULT|L(T)?|S(LT)?|T|U(A)?LT))|B(AT(RY|T)|TRY)|INJ)))';
    SHARED COMMON_ASSAULT := '(((?=.*(\\b|\\B)(MALIC))(?=.*(\\b|\\B)(WOUND)))|((?=.*(\\b|\\B)(CRIM))(?=.*(\\b|\\B)(ASS)))|(?=.*(\\b)(ASS))|(?=.*(\\b|\\B)(A(LST|S((AU)?LT|U(A)?LT)|SAULT|SS(A(ULT)?|LT))|B(AT(T|RY)|TRY)|INTIMIDATE|STRANGU|THREATEN)))';
    SHARED COMMON_ASSAULT_DEADLY_INTENT := '(((?=.*(\\b|\\B)(AS(S|A)|INT))(?=.*(\\b|\\B)(KILL)))|((?=.*(\\b|\\B)(DEAD))(?=.*(\\b|\\B)(COND)))|((?=.*(\\b|\\B)(IMPED))(?=.*(\\b|\\B)(BR)))|(?=.*(\\b|\\B)(AA\\/DW|AAWW|AW(DWISI|I(K|T(K)?))|SHOOTING))|((' + COMMON_ASSAULT + ')((?=.*(\\b|\\B)(DEAD|DANG))|' + COMMON_WEAPON + ')))';
    SHARED COMMON_ASSAULT_COMBINED := '((' + COMMON_ASSAULT + '|' + COMMON_ASSAULT_DEADLY_INTENT + '|' + COMMON_AGGRAVATED_ASSAULT + ')((?!.*(\\b|\\B)(ASS(I(GN|S(T(AN(CE|T))?)?)|T|UR)|HARAS))(?!.*' + COMMON_SEX + ')))'; //
    SHARED COMMON_CHECK := '((?=.*(\\b|\\B)(CH(ECK|K|EC)))|((?=.*(\\b|\\B)(CK))((?=.*(\\b|\\B)(WORTH|BAD|UTTER|BOGUS|NSF))|' + COMMON_FRAUD + ')))';
    SHARED COMMON_CHILD_SUPPORT := '((' + COMMON_CHILD + COMMON_SUPPORT + ')|((?=.*(\\b|\\B)(NON(\\-(\\s)?|\\/)?|NUN))' + COMMON_SUPPORT + ')|(?=.*(\\b|\\B)(NSUP)))';
    SHARED COMMON_ORGANIZED_CRIME := '((((?=.*(\\b)(OGR|OR(A|G|I(G)?)))|(?=.*(\\b|\\B)(\\-O(GR|R(A|G|I(G)?))|\\/O(GR|R(G|I(G)?))|ORG(\\.|(A|I)N|N|R|Z)|SYND)))((?=.*(\\b|\\B)(ACT|C(IM|R(IM|M(\\.)?))))|' + COMMON_THEFT + '))|((?=.*(\\b|\\B)(OG))(?=.*(\\b|\\B)(CRIM))(?=.*(\\b|\\B)(ACT))))';
    SHARED COMMON_ROBBERY := '(((?=.*(\\b|\\B)(ATT))(?=.*(\\b|\\B)(ROB)))|((?=.*(\\b|\\B)(SAFE))(?=.*(\\b|\\B)(CRACK)))|(?=.*(\\b|\\B)(ROB(B|ER)|SAFECRACK)))';
    SHARED COMMON_ROBBERY_ARMED := '((((?=.*(\\b)(ROB))((?=.*(\\b|\\B)(AGG|DEAD|DDL|DW|SER|BOD))|' + COMMON_WEAPON + '))|(?=.*(\\b|\\B)(ARMED\\/ROB))|(?=.*(\\b|\\B)(A(\\s)?\\&(\\s)?ROB)))(?!.*(\\b|\\B)(PROBATION)))';
    SHARED COMMON_ROBBERY_BANK := '(((?=.*(\\b|\\B)(ROB))(?=.*(\\b|\\B)(BANK)))|((?=.*(\\b|\\B)(ROBB))(?=.*(\\b|\\B)(BAN))))';
    
    





    EXPORT EXPRESSION_INFRACTIONS_AND_ORDINANCES := STARTS_WITH + '(?=.*(\\b|\\B)(ORDINANCE|NOISE|MUSIC|LOUD|ANIMAL|DOG|CAT|CODE|RABIES|VACC))' + ENDS_WITH;
    EXPORT EXPRESSION_HUNTING_AND_FISHING := STARTS_WITH + '(?=.*(\\b|\\B)(FISH|HUNT|PHEASANT))' + ENDS_WITH;
    EXPORT EXPRESSION_ZONING := STARTS_WITH + '(?=.*(\\b|\\B)(ZONING))' + ENDS_WITH;
    EXPORT EXPRESSION_COURT_CHARGES := STARTS_WITH + '(((?=.*(\\b|\\B)(CONTEMPT))(?=.*(\\b|\\B)(COURT)))|((?=.*(\\b|\\B)(FAIL))(?=.*(\\b|\\B)(APPEAR)))|((?=.*(\\b|\\B)(COURT))(?=.*(\\b|\\B)(ORDER)))|((?=.*(\\b|\\B)(JUMP))(?=.*(\\b|\\B)(BAIL|BOND)))|(?=.*(\\b|\\B)(FTA)))' + ENDS_WITH;
    EXPORT EXPRESSION_ALCOHOL_RELATED := STARTS_WITH + '(' + COMMON_ALCOHOL + '(?!.*(\\b|\\B)(FTA)))' + ENDS_WITH;
    EXPORT EXPRESSION_TRAFFIC_OFFENSES := STARTS_WITH + '(((?=.*(\\b|\\B)(ST))(?=.*(\\b|\\B)(SN)))|((?=.*(\\b|\\B)(RD))(?=.*(\\b|\\B)(LT)))|(?=.*(\\b|\\B)(TRAFFIC|NDL))|' + COMMON_TRAFFIC + ')' + ENDS_WITH;
    EXPORT EXPRESSION_DUI := STARTS_WITH + COMMON_DUI + ENDS_WITH;
    EXPORT EXPRESSION_CHILD_SUPPORT := STARTS_WITH + COMMON_CHILD_SUPPORT + ENDS_WITH;
    EXPORT EXPRESSION_ALIEN_AND_IMMIGRATION := STARTS_WITH + '((?=.*(\\b|\\B)(ALIEN|IMMIG))(?!.*(\\b|\\B)(SMUG)))' + ENDS_WITH;
    EXPORT EXPRESSION_DISORDERLY_CONDUCT := STARTS_WITH + COMMON_DISORDERLY_CONDUCT + ENDS_WITH;
    EXPORT EXPRESSION_TRESPASSING := STARTS_WITH + '(?=.*(\\b|\\B)(TRES))' + ENDS_WITH;
    EXPORT EXPRESSION_SHOPLIFTING := STARTS_WITH + '(?=.*(\\b|\\B)(SHOPL))' + ENDS_WITH;
    EXPORT EXPRESSION_ORGANIZED_RETAIL_THEFT := STARTS_WITH + '(((?=.*(\\b|\\B)(ORG))(?=.*(\\b|\\B)(RET)))((?!.*(\\b|\\B)(RETAL|ENDANGER))(?!.*' + COMMON_FORGERY + ')))' + ENDS_WITH;
    
    
    EXPORT EXPRESSION_GAMBLING_BITCOIN := STARTS_WITH + '(((?=.*(\\b|\\B)(PROM))(?=.*(\\b|\\B)(GAM)))|(?=.*(\\b|\\B)(GAMING|CASINO|BITCOIN|GAMBL|PROM\\/GA(B)?M|LOTTERY)))' + ENDS_WITH;
    EXPORT EXPRESSION_COMPUTER := STARTS_WITH + '((?=.*(\\b|\\B)(COMPU))(?!.*(\\b|\\B)(RAPE|COMPUL)))' + ENDS_WITH;
    EXPORT EXPRESSION_FALSE_STATEMENTS_IMPERSONATION_IDENTIFICATION := STARTS_WITH + COMMON_FALSE_STATEMENT + ENDS_WITH;
    EXPORT EXPRESSION_TAMPERING := STARTS_WITH + '((((?=.*(\\b|\\B)(TAM))(?=.*(\\b|\\B)(EVI)))|(?=.*(\\b|\\B)(TAMP)))(?!.*(\\b|\\B)(STAMP|ME(TH|HT|TA))))' + ENDS_WITH;
    EXPORT EXPRESSION_OBSTRUCTION := STARTS_WITH + '((?=.*(\\b|\\B)(OBSTR))(?!.*(\\b|\\B)(TRAFF|HIGH|FIRE)))' + ENDS_WITH;
    EXPORT EXPRESSION_PERJURY := STARTS_WITH + '(?=.*(\\b|\\B)(PERJU))' + ENDS_WITH;
    
    
    EXPORT EXPRESSION_VANDALISM := STARTS_WITH + '((?=.*(\\b|\\B)(VAND))(?!.*(\\b|\\B)(SERVAND)))' + ENDS_WITH;
    EXPORT EXPRESSION_DESTRUCTION_OF_PROPERTY := STARTS_WITH + '((((?=.*(\\b|\\B)(PROP))(?=.*(\\b|\\B)(D(AMA|EST))))|(?=.*(\\b|\\B)(DESTR(U|OY)|DAMAGE)))((?!.*(\\b|\\B)(DEV|ANIM|REG))(?!.*' + COMMON_DUI + ')))' + ENDS_WITH;
    EXPORT EXPRESSION_RESISTING_ARREST_ESCAPE_ELUDE := STARTS_WITH + '((((?=.*(\\b|\\B)(RES))(?=.*(\\b|\\B)(AR(R)?ST)))|((?=.*(\\b|\\B)(EVAD))(?=.*(\\b|\\B)(AR(R|ST)|DET|FUGI)))|((?=.*(\\b|\\B)(ABSCON))(?=.*(\\b|\\B)(PAROLE)))|(?=.*(\\b|\\B)(ELUD(E|I)|ESCAP(E)?|EVAD(E|ING)|FL(EE|IGHT)|RESIST|SCAPE)))((?!.*(\\b|\\B)(RAPE|PERSISTENT|RESISTER))(?!.*(' + COMMON_SEX + '|' + COMMON_ALCOHOL + '|' + COMMON_DUI + '))))' + ENDS_WITH;
    EXPORT EXPRESSION_VIOLATING_ORDERS := STARTS_WITH + '(((?=.*(\\b)(ORD))(?=.*(\\b)(RESTRAIN|PR(O)?T|VIOL)))|((?=.*(\\b)(CIV))(?=.*(\\b)(PROT))))' + ENDS_WITH;
    EXPORT EXPRESSION_FUGITIVE_OR_WARRANT := STARTS_WITH + '(?=.*(\\b|\\B)(FUGITIVE|WARRANT))' + ENDS_WITH;
    EXPORT EXPRESSION_CYBER_STALKING := STARTS_WITH + '(?=.*(\\b|\\B)(CYBER))' + ENDS_WITH;
    EXPORT EXPRESSION_STALKING_HARASSMENT_TERRORIZE := STARTS_WITH + '(?=.*(\\b|\\B)(STALK|HAR(R)?AS|TERRORI(ZE|STIC)))' + ENDS_WITH;
    EXPORT EXPRESSION_ANIMAL_FIGHTING := STARTS_WITH + '(((?=.*(\\b|\\B)(ANIMA|DOG))(?=.*(\\b|\\B)(FIGHT)))|(?=.*(\\b|\\B)(COCKFIGHT|SPEC\\sDOG)))' + ENDS_WITH;
    EXPORT EXPRESSION_DOMESTIC_AND_FAMILY_VIOLENCE_OR_ABUSE := STARTS_WITH + COMMON_DOMESTIC_FAMILY + ENDS_WITH;
    EXPORT EXPRESSION_ASSAULT := STARTS_WITH + COMMON_ASSAULT_COMBINED + ENDS_WITH;
    EXPORT EXPRESSION_BREAKING_AND_ENTERING := STARTS_WITH + COMMON_BREAKING_AND_ENTERING + ENDS_WITH;
    EXPORT EXPRESSION_BURGLARY := STARTS_WITH + COMMON_BURGLARY + ENDS_WITH;
    EXPORT EXPRESSION_ARSON := STARTS_WITH + COMMON_ARSON + ENDS_WITH;
    EXPORT EXPRESSION_KIDNAPPING_ABDUCTION := STARTS_WITH + COMMON_KIDNAPPING + ENDS_WITH;
    EXPORT EXPRESSION_MURDER_MANSLAUGHTER := STARTS_WITH + '((?=.*(\\b|\\B)(HOM((I|O)C)|KILL|M(A)?NSL|MRDER|MSLGRT|MUR))(?!.*(\\b|\\B)(MURATIC)))' + ENDS_WITH;
    
    
    EXPORT EXPRESSION_RAPE := STARTS_WITH + '((?=.*(\\b|\\B)(RAPE))(?!.*(\\b|\\B)(STAT)))' + ENDS_WITH;
    EXPORT EXPRESSION_STATUTORY_RAPE := STARTS_WITH + '((?=.*(\\b|\\B)(STAT))(?=.*(\\b|\\B)(RAPE)))' + ENDS_WITH;
    EXPORT EXPRESSION_SEX_OFFENSES := STARTS_WITH + '(' + COMMON_SEX + '(?!.*(\\b|\\B)(FAILURE)))' + ENDS_WITH;
    EXPORT EXPRESSION_PROSTITUTION := STARTS_WITH + '(?=.*(\\b|\\B)(PROST|POSTITUTION))' + ENDS_WITH;
    EXPORT EXPRESSION_PORNOGRAPHY := STARTS_WITH + COMMON_PORN + ENDS_WITH;
    EXPORT EXPRESSION_SOLICITATION := STARTS_WITH + '(?=.*(\\b|\\B)(SOLIC))' + ENDS_WITH;
    
    
    EXPORT EXPRESSION_LARCENY := STARTS_WITH + '(((?=.*(\\b|\\B)(LARY))(?=.*(\\b|\\B)(AUTO|MER))|(?=.*(\\b|\\B)(LAR(C|A))))(?!.*(\\b|\\B)(GR)))' + ENDS_WITH;
    EXPORT EXPRESSION_THEFT := STARTS_WITH + '((' + COMMON_THEFT + '|((?=.*(\\b|\\B)(UNAUTH))(?=.*(\\b|\\B)(VEH)))|((?=.*(\\b|\\B)(CRIM))(?=.*(\\b|\\B)(CONVER))))(?!.*(\\b|\\B)(IDENTITY|FELON|SHOPL|LARC|((?=.*(\\b|\\B)(ORG))(?=.*(\\b|\\B)(RET))))))' + ENDS_WITH;
    EXPORT EXPRESSION_FELONY_OR_AGGRAVATED_THEFT := STARTS_WITH + '((?=.*(\\b|\\B)(FEL|AGG))' + COMMON_THEFT + ')' + ENDS_WITH;
    EXPORT EXPRESSION_CAR_JACK := STARTS_WITH + COMMON_CAR_JACK + ENDS_WITH;
    EXPORT EXPRESSION_ROBBERY := STARTS_WITH + COMMON_ROBBERY + ENDS_WITH;
    EXPORT EXPRESSION_ARMED_ROBBERY := STARTS_WITH + '(' + COMMON_ROBBERY_ARMED + '(?!.*' + COMMON_CAR_JACK + '))' + ENDS_WITH;
    EXPORT EXPRESSION_BANK_ROBBERY := STARTS_WITH + COMMON_ROBBERY_BANK + ENDS_WITH;
    EXPORT EXPRESSION_GRAND_LARCENY := STARTS_WITH + '((?=.*(\\b|\\B)(LARC))(?=.*(\\b|\\B)(GR)))' + ENDS_WITH;
    
    
    EXPORT EXPRESSION_OBTAIN_PROPERTY_BY_FALSE_PRETENSES := STARTS_WITH + COMMON_OBTAIN_PROPERTY + ENDS_WITH;
    EXPORT EXPRESSION_CONCEALMENT_OF_FUNDS_OR_PROPERTY := STARTS_WITH + '(((?=.*(\\b|\\B)(CONCEAL))(?=.*(\\b|\\B)(FUN|MONEY|PRO(C|P))))(?!.*' + COMMON_CHILD + '))' + ENDS_WITH;
    EXPORT EXPRESSION_TAX_OFFENSES := STARTS_WITH + '((?=.*(\\b|\\B)(TAX))(?!.*(\\b|\\B)(TAXI)))' + ENDS_WITH;
    EXPORT EXPRESSION_MISAPPROPRIATION_OF_FUNDS := STARTS_WITH + COMMON_MISAPPROPRIATION_FUNDS + ENDS_WITH;
    EXPORT EXPRESSION_EMBEZZLEMENT := STARTS_WITH + '(?=.*(\\b|\\B)(EMB(E)?Z))' + ENDS_WITH;
    EXPORT EXPRESSION_FRAUD := STARTS_WITH + '(' + COMMON_FRAUD + '(?!.*' + COMMON_CHECK + '))' + ENDS_WITH;
    EXPORT EXPRESSION_CHECK_FRAUD_BAD_CHECK := STARTS_WITH + '(' + COMMON_CHECK + '(?!.*(' + COMMON_THEFT + '|' + COMMON_OBTAIN_PROPERTY + ')))' + ENDS_WITH;
    EXPORT EXPRESSION_IDENTITY_FRAUD_AND_THEFT := STARTS_WITH + '(' + COMMON_IDENTITY_FRAUD + '(?!.*(\\b|\\B)(MEDICAID|RIDSTLVEH|PUB\\sAID|AVOID|DILANDID)))' + ENDS_WITH;
    EXPORT EXPRESSION_ORGANIZED_FRAUD := STARTS_WITH + '((?=.*(\\b|\\B)(ORG))' + COMMON_FRAUD + ')' + ENDS_WITH;
    EXPORT EXPRESSION_INSURANCE_FRAUD := STARTS_WITH + '((?=.*(\\b|\\B)(INSUR))((?=.*(\\b|\\B)(FALSE))|' + COMMON_FRAUD + '))' + ENDS_WITH;
    EXPORT EXPRESSION_HEALTHCARE_FRAUD := STARTS_WITH + '(((?=.*(\\b|\\B)(UNAUTH))(?=.*(\\b|\\B)(USE))(?=.*(\\b|\\B)(PROVIDER)))|(?=.*(\\b|\\B)(MEDICAID))|((?=.*(\\b|\\B)(HEALTH))((?=.*(\\b|\\B)(FALSE|PLAN))|' + COMMON_FRAUD + ')))' + ENDS_WITH;
    EXPORT EXPRESSION_MORTGAGE_FRAUD := STARTS_WITH + '((?=.*(\\b|\\B)(MORTGAGE))' + COMMON_FRAUD + ')' + ENDS_WITH;
    EXPORT EXPRESSION_TAX_FRAUD := STARTS_WITH + '(((?=.*(\\b|\\B)(TAX))((?=.*(\\b|\\B)(EVAS))|' + COMMON_FRAUD + '))(?!.*(\\b|\\B)(TAXI)))' + ENDS_WITH;
    EXPORT EXPRESSION_CREDIT_CARD_FRAUD := STARTS_WITH + '((((?=.*(\\b|\\B)(FIN|CRED))(?=.*(\\b|\\B)(CARD)))|((?=.*(\\b|\\B)(FALSE))(?=.*(\\b|\\B)(EMBOSS))))(?!.*' + COMMON_CHECK + '))' + ENDS_WITH;
    EXPORT EXPRESSION_BANK_FRAUD := STARTS_WITH + '((' + COMMON_FRAUD + '((?=.*(\\b|\\B)(BANK))|((?=.*(\\b|\\B)(FIN))(?=.*(\\b|\\B)(INST)))))(?!.*' + COMMON_CHECK + '))' + ENDS_WITH;
    EXPORT EXPRESSION_WIRE_FRAUD := STARTS_WITH + '((' + COMMON_FRAUD + '(?=.*(\\b|\\B)(WIRE)))(?!.*' + COMMON_CHECK + '))' + ENDS_WITH;
    EXPORT EXPRESSION_SECURITIES_FRAUD := STARTS_WITH + '((((?=.*(\\b|\\B)(SECURITIES))(?=.*(\\b|\\B)(FALSE)))|((?=.*(\\b|\\B)(UNREG))(?=.*(\\b|\\B)(LOAN|BROK|ADVIS|BROKER\\/DEALER|AGENT|INVEST)))|((?=.*(\\b|\\B)(SECUR))(((?=.*(\\b|\\B)(FALSE))(?=.*(\\b|\\B)(REP|STATE)))|' + COMMON_FRAUD + ')))(?!.*' + COMMON_CHECK + '))' + ENDS_WITH;
    EXPORT EXPRESSION_FORGERY_AND_DEVICES := STARTS_WITH + '((' + COMMON_FORGERY + '|' + COMMON_COUNTERFEIT + ')(?!.*' + COMMON_CHECK + '))' + ENDS_WITH;
    
    
    EXPORT EXPRESSION_DRUGS := STARTS_WITH + '((' + COMMON_DRUG + '|' + 
                                              '(' + COMMON_POSSESSION + '(' + COMMON_DRUG_SLIM + '|' + COMMON_DRUG_PARAPHERNALIA + ')))' +
                                              '(?!.*(' + COMMON_DUI + '|' + COMMON_TRAFFIC + '|' + COMMON_ALCOHOL + '|' + COMMON_FRAUD + '|' + COMMON_ASSAULT_COMBINED + '|' + COMMON_DISORDERLY_CONDUCT + '|' + COMMON_ROBBERY + '|' + COMMON_ROBBERY_ARMED + '|' + COMMON_ROBBERY_BANK + ')))' + ENDS_WITH; 
    EXPORT EXPRESSION_WEAPONS := STARTS_WITH + '(' + COMMON_WEAPON +  '(?!.*(' + COMMON_SEX + '|' + COMMON_TRAFFIC + '|' + COMMON_THEFT + '|' + COMMON_ASSAULT_COMBINED + '|' + COMMON_ROBBERY + '|' + COMMON_ROBBERY_ARMED + '|' + COMMON_ROBBERY_BANK + ')))' + ENDS_WITH;                                                 
    EXPORT EXPRESSION_DISTRIBUTION_DRUGS_OR_WEAPONS := STARTS_WITH + '((' + COMMON_MANUFACTURING_STANDALONE_ACRONYM + '|' + COMMON_LAB + '|' + COMMON_POSSESSION_WITH_INTENT + '|' +
                                                                        '(' + COMMON_POSSESSION + COMMON_WITH_INTENT + ')|' +
                                                                        '(' + COMMON_WITH_INTENT + COMMON_MANUFACTURING_DELIVERY_SELLING + ')|' +
                                                                        '(' + COMMON_WITH_INTENT + '(' + COMMON_DRUG + '|' + COMMON_WEAPON + '|' + COMMON_DRUG_PARAPHERNALIA + '|' + COMMON_DRUG_SLIM + '))|' +
                                                                        '(' + COMMON_MANUFACTURING_DELIVERY_SELLING + '(' + COMMON_DRUG + '|' + COMMON_WEAPON + '|' + COMMON_DRUG_PARAPHERNALIA + '|' + COMMON_DRUG_SLIM + '))|' +
                                                                        '(((?=.*(\\b|\\B)(MAINTAIN))(?=.*(\\b|\\B)(DWELLING|VEH)))(' + COMMON_DRUG + '|' + COMMON_WEAPON + '|' + COMMON_DRUG_PARAPHERNALIA + '|' + COMMON_DRUG_SLIM + ')))' +
                                                                        '((?!.*(\\b|\\B)(DRIV))(?!.*(' + COMMON_DUI + COMMON_THEFT + COMMON_ALCOHOL + '))))' + ENDS_WITH;
    EXPORT EXPRESSION_EXPLOSIVES_DESTRUCTION_DEVICES := STARTS_WITH + '(' + COMMON_EXPLOSIVES + '(?!.*' + COMMON_ARSON + '))' + ENDS_WITH;
    EXPORT EXPRESSION_TRAFFICKING_SMUGGLING := STARTS_WITH + '((' + COMMON_TRAFFICKING_WAYS + '|' + 
                                                                   COMMON_TRAFFICKING_TERMS + '|' + 
                                                                   COMMON_TRAFFICKING_ITEMS + '|' +
                                                                   '(' + COMMON_CHILD + '(?=.*(\\b|\\B)(SALE|TRANS)))|' +
                                                                   '((?=.*(\\b|\\B)(TRA(F|NS)|MOVE))((?=.*(\\b|\\B)(FOOD|ALIEN|ORGAN|SEX|LABOR|HUMAN))|' + COMMON_DRUG_SLIM + '|' + COMMON_DRUG + '|' + COMMON_CONTROLLED_SUBSTANCE + '|' + COMMON_WEAPON + '|' + COMMON_CHILD + ')))' +
                                                                   '((?!.*(\\b|\\B)(OFFENSE|BLOCK|CHAPTER|OBSTRUCTING|ABANDON|((?=.*(\\b|\\B)(SER))(?=.*(\\b|\\B)(REM)))))(?!.*(' + COMMON_DUI + '|' + COMMON_TRAFFIC + '|' + COMMON_ALCOHOL + '))))' + ENDS_WITH;
    
        
    EXPORT EXPRESSION_CHOP_SHOP := STARTS_WITH + '((?=.*(\\b|\\B)(CHOP))(?!.*(\\b|\\B)(PSYCHOPATH)))' + ENDS_WITH;
    EXPORT EXPRESSION_GANG := STARTS_WITH + COMMON_GANG + ENDS_WITH;
    EXPORT EXPRESSION_EXTORTION_BLACKMAIL := STARTS_WITH + '(?=.*(\\b|\\B)(EXTOR|BLACKM))' + ENDS_WITH;
    EXPORT EXPRESSION_TREASON_ESPIONAGE := STARTS_WITH + '(?=.*(\\b|\\B)(TREASO|ESPIO))' + ENDS_WITH;
    EXPORT EXPRESSION_INSIDER_TRADING_MANIPULATION := STARTS_WITH + '((?=.*(\\b|\\B)(TRADE|MARK|DEC))(?=.*(\\b|\\B)(PRAC)))' + ENDS_WITH;
    EXPORT EXPRESSION_INTERCEPTION_OF_COMMUNICATION_WIRETAPPING := STARTS_WITH + '((?=.*(\\b|\\B)(INTERCEPT|WIRE|EAVESDROP|((?=.*(\\b|\\B)(RECO))(?=.*(\\b|\\B)(DEV)))))((?!.*(\\b|\\B)(C(ABLE|ELL|OP(PER)?)|DAMAG|ELECTRICAL|PIPES))(?!.*(' + COMMON_FRAUD + COMMON_THEFT + '))))' + ENDS_WITH;
    EXPORT EXPRESSION_TRANSPORTATION_VIOLATIONS := STARTS_WITH + COMMON_TRANSPORT_PROCEEDS + ENDS_WITH;
    EXPORT EXPRESSION_IMPORT_EXPORT := STARTS_WITH + COMMON_IMPORT_EXPORT + ENDS_WITH;
    EXPORT EXPRESSION_CRIMINAL_PROCEEDS := STARTS_WITH + COMMON_CRIMINAL_PROCEEDS + ENDS_WITH;
    EXPORT EXPRESSION_TERRORISM := STARTS_WITH + COMMON_TERRORISM + ENDS_WITH;
    EXPORT EXPRESSION_RACKETEERING_OR_LOAN_SHARKING := STARTS_WITH + COMMON_RACKETEERING + ENDS_WITH;
    EXPORT EXPRESSION_ORGANIZED_CRIME := STARTS_WITH + '(' + COMMON_ORGANIZED_CRIME + '(?!.*(\\b|\\B)(RETAIL)))' + ENDS_WITH;
    EXPORT EXPRESSION_STRUCTURING := STARTS_WITH + COMMON_STRUCTURING + ENDS_WITH;
    EXPORT EXPRESSION_MONEY_TRANSMITTER := STARTS_WITH + COMMON_MONEY_TRANSMITTER + ENDS_WITH;
    EXPORT EXPRESSION_MONEY_LAUNDERING_TAX_EVASION := STARTS_WITH + COMMON_MONEY_LAUNDER_TAX_EVASION + ENDS_WITH;
    EXPORT EXPRESSION_MONEY_OR_CREDIT_CARD_LAUNDERING := STARTS_WITH + '((?=.*(\\b|\\B)(L(AU(N)?D(ER)?|UADER)))(?!.*(\\b|\\B)(DILAUDID)))' + ENDS_WITH;
    EXPORT EXPRESSION_CORRUPTION_OR_BRIBERY := STARTS_WITH + '((?=.*(\\b|\\B)(CORRUPT|BRIB))(?!.*(\\b|\\B)(DISTRIBUTE|MINOR)))' + ENDS_WITH;
    
    
    
    EXPORT NOT_PO_ADDRESS_EXPRESSION := '^((?!((P[\\s\\.]*O[\\.\\s]*)|(POST[\\s]*OFFICE[\\s]*))+BOX).)*$';  //finds reference to anything other than po box or post office box

    EXPORT FELONY_NOT_REDUCED := '^(?=.*(\\b|\\B)(FELONY))(?!.*(\\b|\\B)(REDUCED))(?!.*(\\b|\\B)(NON-FELONY)).*$';
    EXPORT SPECIFIC_KEYWORD_TRAFFIC := '^(?=.*\\b(TRAFFIC)\\b).*$';
    EXPORT SPECIFIC_KEYWORD_INFRACTION := '^(?=.*\\b(INFRACTION)\\b).*$';
    EXPORT SPECIFIC_KEYWORD_MISDEMEANOR:= '^(?=.*\\b(MISDEMEANOR)\\b).*$';
		
END;