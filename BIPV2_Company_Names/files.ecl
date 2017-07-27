IMPORT Data_Services;
export files :=
MODULE
export Constants :=
MODULE
	export Components :=
	MODULE
		export _401KPlan  :=
		MODULE
			export Regex := '(INC|CORP).*?((401([(\\s]*K[)]?)|RETIREMENT) .*?\\bPLAN\\b)'; //for ("401K..PLAN" or "RETIREMENT..PLAN") following INC or CORP
			export Code := 'K';
		END;//401KPlan
	END;//Components
END;//Constants
export Classes :=
dataset(
[
{0, 'EVERYTHING'}
,{1, 'HOSPITAL'}
]
,BIPV2_Company_Names.layouts.layout_classes
);
export CoNameAbbrv :=
dataset(
[
 {'COMPUTER COMMUNICATIONS AND COMPATIBILITY','3COM'}
,{'MINNESOTA, MINING, AND MANUFACTURING COMPANY LIMITED','3M'}   // Possibly move to pretranslate
,{'MN, MINING, AND MANUFACTURING COMPANY LIMITED','3M'}
,{'ALLEN AND WRIGHT ROOT BEER','A&W ROOT BEER'}
,{'AMERICAN FAMILY LIFE ASSURANCE COMPANY OF COLUMBUS','AFLAC'}
,{'A HOLDING COMPANY OF  ALBERT HEIJN','AHOLD'}
,{'ALUMINUM COMPANY OF AMERICA','ALCOA'}
,{'ANONIMA LOMBARDA FABBRICA AUTOMOBILE','ALFA ROMEO'}
,{'AMERICAN BEVERAGE COMPANY','AMBEV'}
,{'HERB ALPERT AND JERRY MOSS','A&M RECORDS'}
,{'AMERICAN MULTI-CINEMA','AMC THEATRES'}
,{'ADVANCED MICRO DEVICES','AMD'}
,{'APPLIED MOLECULAR GENETICS','AMGEN'}
,{'AMERICA OIL COMPANY','AMOCO'}
,{'AMERICA ONLINE','AOL'}
,{'THE GREAT ATLANTIC AND PACIFIC TEA COMPANY','A&P'}
,{'ANIMA SANA IN CORPORE SANO','ASICS'}
,{'AMERICA TELEPHONE AND TELEGRAPH','AT&T'}
,{'ARRAY TECHNOLOGIES INCORPORATED','ATI'}
,{'BUSINESS COMMUNICATIONS COMPANY','BCC RESEARCH'}
,{'BROKEN HILL PROPRIETARY','BHP'}
,{'BEVERLY & JENSEN','BJ\'S'}
,{'BAVARIAN MOTOR WORKS','BMW'}
,{'BRITISH PETROLEUM','BP'}
,{'BRADLEY, VOORHEES & DAY','BVD'}
,{'COMPUTER ASSOCIATES','CA'}
,{'COLUMBIA BROADCASTING SYSTEM','CBS'}
,{'INSURANCE COMPANY OF NORTH AMERICA','CIGNA'}
,{'CONTINENTAL OIL & TRANSPORTATION CO.','CONOCO'}
,{'CONNECTICUT LEATHER COMPANY','COLECO'} // Possibly move to pretranslate
,{'CT LEATHER COMPANY','COLECO'}
,{'COMMUNICATIONS AND BROADCAST','COMCAST'}
,{'COMMUNICATIONS SATELLITES','COMSAT'}
,{'CONSUMER VALUE STORES','CVS'}
,{'DIGITAL EQUIPMENT CORPORATION','DEC'}
,{'DALSEY, HILLBLOM AND LYNN','DHL'}
,{'DONNA KARAN NEW YORK','DKNY'} //
,{'DONNA KARAN NY','DKNY'}
,{'ELECTRONIC ARTS','EA GAMES'}
,{'ELECTRONIC DATA SYSTEMS','EDS'}
,{'ENTERTAINMENT AND SPORTS PROGRAMMING NETWORK','ESPN'}
,{'ENVIRONMENTAL SYSTEMS RESEARCH INSTITUTE','ESRI'}
,{'FEDERAL EXPRESS CORPORATION','FEDEX'}
,{'FABBRICA ITALIANA AUTOMOBILE TORINO','FIAT'}
,{'FLORISTS\' TRANSWORLD DELIVERY','FTD'}
,{'GEORGIA BANK & TRUST','GB&T'} // Possibly move to pretranslate
,{'GA BANK & TRUST','GB&T'}
,{'GENERAL ELECTRIC','GE'}
,{'GOVERNMENT EMPLOYEES INSURANCE COMPANY','GEICO'}
,{'GENERAL MOTORS','GM'}
,{'GENERAL NUTRITION CENTERS','GNC'}
,{'GENERAL TELEPHONE & ELECTRONICS CORPORATION','GTE'}
,{'HENNES & MAURITZ','H&M'}
,{'HENRY W AND RICHARD BLOCH','H&R BLOCK'}
,{'HIGH TECH COMPUTER CORPORATION','HTC'}
,{'INTERNATIONAL BUSINESS MACHINES','IBM'}
,{'IMAGINE GAMES NETWORK','IGN'}
,{'INTERNATIONAL NETHERLANDS GROUP','ING'}
,{'INTEGRATED ELECTRONICS','INTEL'}
,{'JAPAN AIRLINES','JAL'}
,{'JAMES B LANSING','JBL'}
,{'JAMES CASH PENNEY','JCPENNEY'}
,{'JAPAN VICTOR COMPANY','JVC'}
,{'KENTUCKY FRIED CHICKEN','KFC'} // Possibly move to pretranslate
,{'KY FRIED CHICKEN','KFC'}
,{'KYOTO CERAMICS','KYOCERA'}
,{'LINEA GOLDSTAR','LG'}
,{'MICROWAVE COMMUNICATIONS, INC','MCI'}
,{'METRO-GOLDWYN-MAYER','MGM'}
,{'MICROCOMPUTER SOFTWARE','MICROSOFT'}
,{'NATIONAL BISCUIT COMPANY','NABISCO'}
,{'NATIONAL CASH REGISTER','NCR'}
,{'NIPPON ELECTRIC COMPANY','NEC'}
,{'NORTHERN TELECOM AND BAY NETWORKS','NORTEL NETWORKS'}
,{'PHILADELPHIA STORAGE BATTERY COMPANY','PHILCO'}
,{'PACIFIC GAS AND ELECTRIC COMPANY','PG&E'}
,{'PURVEYORS OF WONDER ENTERTAINMENT','POW'}
,{'QUALITY UNIT AMPLIFIED DOMESTIC','QUAD'}
,{'QUALITY COMMUNICATION','QUALCOMM'}
,{'QUALITY VALUE AND CONVENIENCE','QVC'}
,{'RADIO CORPORATION OF AMERICA','RCA'}
,{'SVENSKA AEROPLAN AKTIEBOLAGET','SAAB'}
,{'SERVICE GAMES','SEGA'}
,{'SOUTHERN PACIFIC RAILROAD INTERNAL COMMUNICATIONS','SPRINT'}
,{'TEXAS COMPANY USA','TEXACO'} // Possibly move to pretranslate
,{'TX COMPANY USA','TEXACO'}
//,{'UNITED KY BANK','KY BANK'} //
//,{'UNITED OHIO INSURANCE CO','OH INSURANCE'} //
//,{'UNITED TEXAS INVESTORS','TX INVESTORS'} //
,{'THE INFORMATION BUS COMPANY','TIBCO'}
,{'THANK GOD IT\'S FRIDAY','TGI FRIDAY\'S'}
,{'THANK GOODNESS IT\'S FRIDAY','TGI FRIDAY\'S'}
,{'THE ULTIMATE COLLECTION OF WINSOCK SOFTWARE','TUCOWS'}
,{'TRANSWORLD AIRLINES','TWA'}
,{'UNDER ARMOUR INC','UA'}
,{'UNITED AIRLINES','UAL'}
,{'UNDERWRITERS LABORATORIES','UL'}
,{'UNION OIL COMPANY OF CALIFORNIA','UNOCAL'}
,{'UNITED PARCEL SERVICE OF AMERICA, INC','UPS'}
,{'US STEEL CORPORATION','USX'}
,{'VOLKSWAGEN','VW'}
,{'AMERICAN AUTOMOBILE ASSOCIATION','AAA'}
,{'AUTOMATIC DATA PROCESSING','ADP'}
,{'AMERICAN INTERNATIONAL GROUP','AIG'}
,{'AMERICAN MACHINE & FOUNDRY','AMF'}
,{'AMERICA ONLINE','AOL'}
,{'ARMANI EXCHANGE','AX'}
,{'BARNES & NOBLE','B&N'}
,{'BETTER BUSINESS BUREAU','BBB'}
,{'CALVIN KLEIN','CK'}
,{'CALIFORNIA PIZZA KITCHEN','CPK'} // Possibly move to pretranslate
,{'CA PIZZA KITCHEN','CPK'}					//Alternative
,{'DISCOUNT SHOE WAREHOUSE','DSW'}
,{'ELECTRONICS BOUTIQUE X','EBX'}
,{'EASTERN MOUNTAIN SPORTS','EMS'}
,{'FEDERAL NATIONAL MORTGAGE ASSOCIATION','FANNIE MAE'}
,{'FOR US, BY US','FUBU'}
,{'HEWLETT PACKARD','HP'}
,{'INDEPENDENT BREWERIES COMPANY','IBC'}
,{'INDUSTRIAL LIGHT AND MAGIC','ILM'}
,{'INTERMOUNTAIN RURAL ELECTRIC ASSOCIATION','IREA'}
,{'KLYNVELD PEAT MARWICK GOERDELER','KPMG'}
,{'MICROSOFT NETWORK','MSN'}
,{'MINI VACATIONS INCORPORATED','MVI'}
,{'NEW BELGIUM BREWERY','NBB'}
,{'PROCTOR AND GAMBLE','P&G'}
,{'THE PENSION BENEFIT GUARANTY CORPORATION','PBGC'}
,{'RECREATIONAL EQUIPMENT, INC','REI'}
,{'SOUTHWESTERN BELL CORPORATION','SBC'}
,{'THE COUNTRY\'S BEST YOGURT','TCBY'}
,{'UNITED MISSOURI BANK','UMB'}
,{'UNITED SERVICES AUTOMOBILE ASSOCIATION','USAA'}
,{'BRADLEY, VOORHEES, AND DAY','BVD'}
,{'YOSHIDA MANUFACTURING CORPORATION','YKK'}
,{'BADISCHE ANILIN UND SODA FABRIKEN','BASF'}
,{'CHESSIE SEABOARD MULTIPLIER','CSX'}
,{'KONINKLIJKE LUCHTVAART MAATSCHAPPIJ N.V.','KLM'}
,{'UNITED BANK OF SWITZERLAND','UBS'}
,{'BANK OF HAWAII','BANKOH'} // Possibly move to pretranslate
,{'BANK OF HI','BANKOH'}
//The following three come from file/key and I put them here
,{'BANK OF NY','BNY MELLON'} //for BANK OF NEW YORK
,{'BALTIMORE COUNTY MD','COUNTY BALTIMORE'} //FOR BALTIMORE COUNTY MARYLAND
,{'WA MUTUAL BANK','WA MUTUAL (CHASE)'} //FOR WASHINGTON MUTUAL BANK
,{'HAWAII GOVERNMENT EMPLOYEES ASSOCIATION','HGEA'} // Possibly move to pretranslate
,{'HI GOVERNMENT EMPLOYEES ASSOCIATION','HGEA'}
,{'HAWAII VISITORS & CONVENTION BUREAU','HVCB'} // Possibly move to pretranslate
,{'HI VISITORS & CONVENTION BUREAU','HVCB'}
,{'JEWISH COMMUNITY CENTER','JCC'}
,{'MENTAL HEALTH MENTAL RETARDATION','MHMR'}
,{'PARENT TEACHER STUDENT ASSOCIATION','PTSA'}
,{'VETERANS AFFAIRS MEDICAL CENTER','VAMC'}
], BIPV2_Company_Names.layouts.layout_CoNameAbbrv)
//+PULL(PROJECT(BIPV2_Company_Names.key_preferred,TRANSFORM(BIPV2_Company_Names.layouts.layout_CoNameAbbrv,SELF.from:=LEFT.cname;SELF.to:=LEFT.preferred_name;)));
+PROJECT(BIPV2_Company_Names.key_preferred,TRANSFORM(BIPV2_Company_Names.layouts.layout_CoNameAbbrv,SELF.from:=LEFT.cname;SELF.to:=LEFT.preferred_name;));
export CoNameStd :=
dataset(
[
 {'LEXIS NEXIS RISK INFORMATION AND ANALYTICS GROUP','LEXISNEXIS RIAG'} //the LN RIAG ones have to be above the LN ones since it looks for a leading match and replaces
,{'LEXIS-NEXIS RISK INFORMATION AND ANALYTICS GROUP','LEXISNEXIS RIAG'}
,{'LEXISNEXIS RISK INFORMATION AND ANALYTICS GROUP','LEXISNEXIS RIAG'}
,{'NEXIS LEXIS RISK INFORMATION AND ANALYTICS GROUP','LEXISNEXIS RIAG'} //the LN RIAG ones have to be above the LN ones since it looks for a leading match and replaces
,{'NEXIS-LEXIS RISK INFORMATION AND ANALYTICS GROUP','LEXISNEXIS RIAG'}
,{'NEXISLEXIS RISK INFORMATION AND ANALYTICS GROUP','LEXISNEXIS RIAG'}
,{'LEXIS NEXIS','LEXISNEXIS'}
,{'LEXIS-NEXIS','LEXISNEXIS'}
,{'LEXISNEXIS','LEXISNEXIS'}
,{'NEXIS LEXIS','LEXISNEXIS'}
,{'NEXIS-LEXIS','LEXISNEXIS'}
,{'NEXISLEXIS','LEXISNEXIS'}
,{'FIFTH THIRD BANK','53 BANK'}
,{'5TH 3RD BANK','53 BANK'}
,{'5/3 BANK','53 BANK'}
,{'5 3 BANK','53 BANK'}
,{'TWENTY-ONE C','21C'}
,{'21 C','21C'}
,{'TWENTYONE C','21C'}
,{'TWENTY ONE C','21C'}
], BIPV2_Company_Names.layouts.layout_CoNameAbbrv);
export CoNameStdPlusAbbrv := CoNameAbbrv + CoNameStd;
export Translations_shortlist:=DATASET([
//{'I','1', [0]} //changing from I or V could be risky, but as long as we are consistent
{'II','2', [0]}
,{'III', '3', [0]}
,{'IV', '4', [0]}
//,{'V', '5', [0]}
,{'VI','6',  [0]}
,{'VII', '7', [0]}
,{'VIII', '8', [0]}
,{'IX', '9', [0]}
//,{'X', '10', [0]}
,{'XI', '11', [0]}
,{'XII', '12', [0]}
,{'XIII', '13', [0]}
,{'XIV', '14', [0]}
,{'XV', '15', [0]}
,{'XVI', '16', [0]}
,{'XVII', '17', [0]}
,{'XVIII', '18', [0]}
,{'XIX', '19', [0]}
,{'XX', '20', [0]}
,{'XXI', '21', [0]}
,{'XXII', '22', [0]}
,{'XXIII', '23', [0]}
,{'XXIV', '24', [0]}
,{'XXV', '25', [0]}
,{'XXVI', '26', [0]}
,{'XXVII', '27', [0]}
,{'XXVIII', '28', [0]}
,{'XXIX', '29', [0]}
,{'XXX', '30', [0]}
,{'XXXI', '31', [0]}
,{'XXXII', '32', [0]}
,{'XXXIII', '33', [0]}
,{'XXXIV', '34', [0]}
,{'XXXV', '35', [0]}
,{'XXXVI', '36', [0]}
,{'XXXVII', '37', [0]}
,{'XXXVIII', '38', [0]}
,{'XXXIX', '39', [0]}
,{'XXXX', '40', [0]}
,{'XXXXI', '41', [0]}
,{'XXXXII', '42', [0]}
,{'XXXXIII', '43', [0]}
,{'XXXXIV', '44', [0]}
,{'XXXXV', '45', [0]}
,{'XXXXVI', '46', [0]}
,{'XXXXVII', '47', [0]}
,{'XXXXVIII', '48', [0]}
,{'XXXXIX', '49', [0]}
// ,{'L', '50', [0]}
// ,{'LI', '51', [0]}
,{'LII', '52', [0]}
,{'LIII', '53', [0]}
// ,{'LIV', '54', [0]}
// ,{'LV', '55', [0]}
,{'LVI', '56', [0]}
,{'LVII', '57', [0]}
,{'LVIII', '58', [0]}
,{'LIX', '59', [0]}
// ,{'LX', '60', [0]}
,{'LXI', '61', [0]}
,{'LXII', '62', [0]}
,{'LXIII', '63', [0]}
,{'LXIV', '64', [0]}
,{'LXV', '65', [0]}
,{'LXVI', '66', [0]}
,{'LXVII', '67', [0]}
,{'LXVIII', '68', [0]}
,{'LXIX', '69', [0]}
,{'LXX', '70', [0]}
,{'LXXI', '71', [0]}
,{'LXXII', '72', [0]}
,{'LXXIII', '73', [0]}
,{'LXXIV', '74', [0]}
,{'LXXV', '75', [0]}
,{'LXXVI', '76', [0]}
,{'LXXVII', '77', [0]}
,{'LXXVIII', '78', [0]}
,{'LXXIX', '79', [0]}
,{'LXXX', '80', [0]}
,{'LXXXI', '81', [0]}
,{'LXXXII', '82', [0]}
,{'LXXXIII', '83', [0]}
,{'LXXXIV', '84', [0]}
,{'LXXXV', '85', [0]}
,{'LXXXVI', '86', [0]}
,{'LXXXVII','87', [0]}
,{'LXXXVIII', '88', [0]}
,{'LXXXIX', '89', [0]}
,{'XC', '90', [0]}
,{'XCI', '91', [0]}
,{'XCII', '92', [0]}
,{'XCIII', '93', [0]}
,{'XCIV', '94', [0]}
,{'XCV', '95', [0]}
,{'XCVI', '96', [0]}
,{'XCVII', '97', [0]}
,{'XCVIII', '98', [0]}
,{'XCIX', '99', [0]}
,{'CXV', '115', [0]}
,{'CIX', '109', [0]}
// ,{'CX', '110', [0]}
,{'AND', '&', [0]}
,{'ONE','1',[0]}
,{'TWO','2',[0]}
,{'THREE','3',[0]}
,{'FOUR','4',[0]}
,{'FIVE','5',[0]}
,{'SIX','6',[0]}
,{'SEVEN','7',[0]}
,{'EIGHT','8',[0]}
,{'NINE','9',[0]}
,{'TEN','10',[0]}
,{'ELEVEN','11',[0]}
,{'TWELVE','12',[0]}
,{'THIRTEEN','13',[0]}
,{'FOURTEEN','14',[0]}
,{'FIFTEEN','15',[0]}
,{'SIXTEEN','16',[0]}
,{'SEVENTEEN','17',[0]}
,{'EIGHTTEEN','18',[0]}
,{'NINETEEN','19',[0]}
,{'TWENTY','20',[0]}
,{'FIRST','1ST',[0]}
,{'SECOND','2ND',[0]}
,{'THIRD','3RD',[0]}
,{'FOURTH','4TH',[0]}
,{'FIFTH','5TH',[0]}
,{'SIXTH','6TH',[0]}
,{'SEVENTH','7TH',[0]}
,{'EIGHTH','8TH',[0]}
,{'NINTH','9TH',[0]}
,{'TENTH','10TH',[0]}
,{'ELEVENTH','11TH',[0]}
,{'TWELFTH','12TH',[0]}
,{'THIRTEENTH','13TH',[0]}
,{'FOURTEENTH','14TH',[0]}
,{'FIFTEENTH','15TH',[0]}
,{'SIXTEENTH','16TH',[0]}
,{'SEVENTEENTH','17TH',[0]}
,{'EIGHTTEENTH','18TH',[0]}
,{'NINETEENTH','19TH',[0]}
,{'TWENTIETH','20TH',[0]}
],BIPV2_Company_Names.layouts.layout_Translations);
export Translations :=
dataset(
[
//There are two passes through this list.  The logical dataset generally translates to a full word.
//In the second pass, we should take those terms to an abbreviation.
//  Why?  just to save space?  is the counter argument to be closer to typos?
//EVERYTHING
// {'I','1', [0]} //changing from I or V could be risky, but as long as we are consistent
// ,{'II','2', [0]}
// ,{'III', '3', [0]}
// ,{'IV', '4', [0]}
// ,{'V', '5', [0]}
// ,{'VI','6',  [0]}
// ,{'VII', '7', [0]}
// ,{'VIII', '8', [0]}
// ,{'IX', '9', [0]}
// ,{'X', '10', [0]}
// ,{'XI', '11', [0]}
// ,{'XII', '12', [0]}
// ,{'XIII', '13', [0]}
// ,{'XIV', '14', [0]}
// ,{'XV', '15', [0]}
// ,{'XVI', '16', [0]}
// ,{'XVII', '17', [0]}
// ,{'XVIII', '18', [0]}
// ,{'XIX', '19', [0]}
// ,{'XX', '20', [0]}
// ,{'XXI', '21', [0]}
// ,{'XXII', '22', [0]}
// ,{'XXIII', '23', [0]}
// ,{'XXIV', '24', [0]}
// ,{'XXV', '25', [0]}
// ,{'XXVI', '26', [0]}
// ,{'XXVII', '27', [0]}
// ,{'XXVIII', '28', [0]}
// ,{'XXIX', '29', [0]}
// ,{'XXX', '30', [0]}
// ,{'XXXI', '31', [0]}
// ,{'XXXII', '32', [0]}
// ,{'XXXIII', '33', [0]}
// ,{'XXXIV', '34', [0]}
// ,{'XXXV', '35', [0]}
// ,{'XXXVI', '36', [0]}
// ,{'XXXVII', '37', [0]}
// ,{'XXXVIII', '38', [0]}
// ,{'XXXIX', '39', [0]}
// ,{'LIII', '53', [0]}
// ,{'AND', '&', [0]}
//NOT PUTTING TOO MUCH THOUGHT INTO THESE AS THEY MAY COLLIDE WITH DAVID WHEELOCK'S LIST
//SOME MAY BE BACKWARDS ACCORDING TO COMMENT ABOVE
{'HOPSITAL', 'HOSPITAL', [0]}
,{'HOSP', 'HOSPITAL', [0]}
,{'ASSC', 'ASSOCIATION', [0]}
,{'ASSOCIATIO', 'ASSOCIATION', [0]}
,{'ASSOCI', 'ASSOCIATION', [0]}
,{'PHCY', 'PHARMACY', [0]}
,{'TRNSPRTN', 'TRANSPORTATION', [0]}
,{'SERVICE', 'SVC', [0]}
,{'SERVICES', 'SVC', [0]}
,{'SVCS', 'SVC', [0]}
 // TECHLGY ??
 // CNTRY CT JVNL
 //CMNTY
// ,{'L.L.C.','LLC', [0]}     //THESE DONT WORK BECAUSE THEY GET PREPPED INTO L L C, WHICH IS 3 WORDS
// ,{'L.L.L.P.','LLLP', [0]}
// ,{'L.L.P.','LLP', [0]}
// ,{'L.P.','LP', [0]}
// ,{'P.L.L.C.','PLLC', [0]}
,{'NETWORD', 'NTWRK', [0]}
,{'FLOORING', 'FLRNG', [0]}
,{'APPAREL', 'APPRL', [0]}
,{'CHRIST', 'CHRST', [0]}
,{'CHRISTIAN', 'CHRST', [0]} //merging christian with christ
,{'SCHOOL', 'SCHL', [0]}
,{'CENTRAL', 'CNTRL', [0]}
// ,{'CONTROL', 'CNTRL', [0]} //do i want to merge this with central?  is this a reall abbr?
,{'INCORPORATED', 'INC', [0]} //this needs to move in the direction of my extraction list
//HOSPITAL
,{'INPAT', 'IN PATIENT', [1]}
,{'IP', 'IN PATIENT', [1]}
// ,{'ASSOCIA', 'ASSOCIATION', [0]}     //now in dataset
// ,{'ASSOCIAT', 'ASSOCIATION', [0]}    //now in dataset
//FROM TOM'S ABBREV LIST
// ,{'AIR FORCE BASE','AFB', [0]}
// ,{'BANKOHANA','BANKOH', [0]}
// ,{'BAR B QUE','BBQ', [0]}
// ,{'DALLAS/FORT','DFW', [0]}
// ,{'DESIGNOF','DESIGN OF', [0]}
// ,{'DALLAS FORT WORTH','DFW', [0]}
// ,{'DOLGENCORP','DOLGEN CORP', [0]}
// ,{'DOTOF','DOT OF', [0]}
// ,{'EMERGENCY ROOM','ER', [0]}
// ,{'HGEA/AFSCME','HGEA', [0]}
// ,{'HUMAN RESOURCES','HR', [0]}
// ,{'HIGH SCHOOL','HS', [0]}
// ,{'NEW YORK CITY','NYC', [0]}
// ,{'ORIGINAL EQUIPMENT MANUFACTURER','OEM', [0]}
// ,{'PROFESSIONAL ASSOCIATION','PA', [0]}
// ,{'PERSONAL COMPUTER','PC', [0]}
// ,{'PINEAPPLEHEAVILY','PINEAPPLE HEAVILY', [0]}
// ,{'PARENT TEACHER STUDENT ASSOCIATION','PTSA', [0]}
// ,{'RADIO CONTROLLED','RC', [0]}
// ,{'REALESTATE','REAL ESTATE', [0]}
// ,{'SBSTNC','SBS INC', [0]}
// ,{'SHEET METAL','SHTMTL', [0]}
// ,{'WORDS"HARRYS','WORDS HARRYS', [0]}
]
,BIPV2_Company_Names.layouts.layout_Translations
)
+ Translations_shortlist
+ dataset(Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::cemtemp::Translations', BIPV2_Company_Names.layouts.layout_Translations, thor)
+ dataset(Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::bipv2::companyname::Abbreviations', BIPV2_Company_Names.layouts.layout_Translations, thor)
+ dataset(Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::bipv2::companyname::NumberConversions', BIPV2_Company_Names.layouts.layout_Translations, thor)
;
export TranslationsKey :=
index(
	Translations,
	{from},
	{Translations},
	// '~thor_data400::BIP2.0::Translations'
	// '~thor_data400::bip2.0::translations::20130523::date'
	Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::bip2.0::translations::qa::date'
);
export TranslationsKeyBuild := build(TranslationsKey, width(1));
export Extractions_btype :=
/*
Corp., Inc. (Corporation, Incorporated): used to denote corporations (public or otherwise). These are the only terms universally accepted by all 51 corporation chartering jurisdictions in the United States. However in some states other suffixes may be used to identify a corporation, such as Ltd., Co./Company, or the Italian term S.p.A. (in Connecticut; see under Italy). Some states that allow the use of "Company" prohibit the use of "and Company", "and Co.", "& Company" or "& Co.". In most states sole proprietorships and partnerships may register a fictitious "doing business as" name with the word "Company" in it. For a full list of allowed designations by state, see the table below. See also Delaware corporation, Nevada corporation, Massachusetts business trust.
Doing Business As (DBA): denotes a business name used by a person or entity that is different from the person's or entity's true name. Filing requiments vary and are not permitted for some types of businesses or professional practices.
General partnership is a partnership in which all the partners are jointly liable for the debts of the partnership. It is typically created by agreement rather than being created by a public filing.
LLC, LC, Ltd. Co. (limited liability company): a form of business whose owners enjoy limited liability, but which is not a corporation. Allowable abbreviations vary by state. Note that Ltd. by itself is not a valid abbreviation for an LLC, because in some states (e.g. Texas), it may denote a corporation instead. See also Series LLC. For U.S. federal tax purposes, an LLC with two or more members is treated as a partnership, and an LLC with one member is treated as a sole proprietorship.
LLLP (limited liability limited partnership): a combination of LP and LLP, available in some states
LLP (limited liability partnership): a partnership where a partner's liability for the debts of the partnership is limited except in the case of liability for acts of professional negligence or malpractice. In some states LLPs may only be formed for purposes of practicing a licensed profession, typically attorneys, accountants and architects. This is often the only form of limited partnership allowed for law firms (as opposed to general partnerships).
LP (limited partnership): a partnership where at least one partner has unlimited liability and one or more partners have limited liability
PLLC (professional limited liability company): Some states do not allow certain professionals to form an LLC that would limit the liability that results from the services the professionals provide such as doctors, medical care; lawyers, legal advice; and accountants, accounting services, when the company formed offers the services of the professionals. Instead states allow a PLLC or in the LLC statutes, the liability limitation only applies to the business side, such as creditors of the company, as opposed to the service side, the level of medical care, legal services, or accounting provided to clients. This is meant to maintain the higher ethical standards that these professionals have committed themselves to by becoming licensed in their profession and not immune to malpractice suits.
Professional corporations (abbreviated as PC or P.C.) are those corporate entities for which many corporation statutes make special provision, regulating the use of the corporate form by licensed professionals such as attorneys, architects, accountants, and doctors.
Sole proprietorship: a business consisting of a single owner, not in a separately recognized business form
*/
dataset([
{'CAORPORATION','CORP',[0]}
,{'CCORP','CORP',[0]}
,{'CORPORATON','CORP',[0]}
,{'CCORPORATION','CORP',[0]}
,{'CIORPORATION','CORP',[0]}
,{'CIRPORATION','CORP',[0]}
,{'COCRP','CORP',[0]}
,{'COIRPORATION','CORP',[0]}
,{'COMP','CO',[0]}
,{'COMPAN','CO',[0]}
,{'COMPANY','CO',[0]}
,{'COMPNY','CO',[0]}
,{'CONRPORATION','CORP',[0]}
,{'COORP','CORP',[0]}
,{'COORPORATION','CORP',[0]}
,{'COPARATION','CORP',[0]}
,{'COPOR','CORP',[0]}
,{'COPORATION','CORP',[0]}
,{'COPORRATION','CORP',[0]}
,{'COPORTATION','CORP',[0]}
,{'COPPORATION','CORP',[0]}
,{'COPR','CORP',[0]}
,{'COPRATION','CORP',[0]}
,{'COPRCORP','CORP',[0]}
,{'COPROAITON','CORP',[0]}
,{'COPROATION','CORP',[0]}
,{'COPROPRATION','CORP',[0]}
,{'COPROR','CORP',[0]}
,{'COPRORAITON','CORP',[0]}
,{'COPRORATION','CORP',[0]}
,{'COPRP','CORP',[0]}
,{'COPRPORATION','CORP',[0]}
,{'COPRPRATION','CORP',[0]}
,{'COPRR','CORP',[0]}
,{'CORAPORATION','CORP',[0]}
,{'CORCORP','CORP',[0]}
,{'COROP','CORP',[0]}
,{'COROPO','CORP',[0]}
,{'COROPOR','CORP',[0]}
,{'COROPORATION','CORP',[0]}
,{'COROPOTAION','CORP',[0]}
,{'COROPRAITON','CORP',[0]}
,{'COROPRATION','CORP',[0]}
,{'CORPAORATION','CORP',[0]}
,{'CORPAORTION','CORP',[0]}
,{'CORPARAITION','CORP',[0]}
,{'CORPARATION','CORP',[0]}
,{'CORPAROATION','CORP',[0]}
,{'CORPARTATION','CORP',[0]}
,{'CORPARTION','CORP',[0]}
,{'CORPATION','CORP',[0]}
,{'CORPC','CORP',[0]}
,{'CORPCO','CORP',[0]}
,{'CORPCORP','CORP',[0]}
,{'CORPIORATION','CORP',[0]}
,{'CORPIRATIOIN','CORP',[0]}
,{'CORPO','CORP',[0]}
,{'CORPOAITON','CORP',[0]}
,{'CORPOARATION','CORP',[0]}
,{'CORPOARTATION','CORP',[0]}
,{'CORPOARTION','CORP',[0]}
,{'CORPOATIN','CORP',[0]}
,{'CORPOATION','CORP',[0]}
,{'CORPOIRATION','CORP',[0]}
,{'CORPOORATION','CORP',[0]}
,{'CORPOPATION','CORP',[0]}
,{'CORPOPORATION','CORP',[0]}
,{'CORPOPRATION','CORP',[0]}
,{'CORPOPRATIOON','CORP',[0]}
,{'CORPOR','CORP',[0]}
,{'CORPORA','CORP',[0]}
,{'CORPORAATION','CORP',[0]}
,{'CORPORACTION','CORP',[0]}
,{'CORPORAIOTN','CORP',[0]}
,{'CORPORAITION','CORP',[0]}
,{'CORPORAITN','CORP',[0]}
,{'CORPORAITNO','CORP',[0]}
,{'CORPORAITON','CORP',[0]}
,{'CORPORAPTION','CORP',[0]}
,{'CORPORARATION','CORP',[0]}
,{'CORPORARTION','CORP',[0]}
,{'CORPORAT','CORP',[0]}
,{'CORPORATAION','CORP',[0]}
,{'CORPORATATION','CORP',[0]}
,{'CORPORATCATION','CORP',[0]}
,{'CORPORATI','CORP',[0]}
,{'CORPORATIAON','CORP',[0]}
,{'CORPORATIATION','CORP',[0]}
,{'CORPORATICIN','CORP',[0]}
,{'CORPORATICON','CORP',[0]}
,{'CORPORATIIN','CORP',[0]}
,{'CORPORATIION','CORP',[0]}
,{'CORPORATIN','CORP',[0]}
,{'CORPORATIN','CORP',[0]}
,{'CORPORATINN','CORP',[0]}
,{'CORPORATINO','CORP',[0]}
,{'CORPORATINON','CORP',[0]}
,{'CORPORATIO','CORP',[0]}
,{'CORPORATIOAN','CORP',[0]}
,{'CORPORATIOIN','CORP',[0]}
,{'CORPORATIOINI','CORP',[0]}
,{'CORPORATION','CORP',[0]}
,{'CORPORATIONA','CORP',[0]}
,{'CORPORATIONAN','CORP',[0]}
,{'CORPORATIONAT','CORP',[0]}
,{'CORPORATIONATION','CORP',[0]}
,{'CORPORATIONC','CORP',[0]}
,{'CORPORATIONCO','CORP',[0]}
,{'CORPORATIONCORP','CORP',[0]}
,{'CORPORATIONCORPOR','CORP',[0]}
,{'CORPORATIONCORPORAT','CORP',[0]}
,{'CORPORATIONCORPORATION','CORP',[0]}
,{'CORPORATIONION','CORP',[0]}
,{'CORPORATIONN','CORP',[0]}
,{'CORPORATIONNC','CORP',[0]}
,{'CORPORATIONNN','CORP',[0]}
,{'CORPORATIONNNN','CORP',[0]}
,{'CORPORATIONNO','CORP',[0]}
,{'CORPORATIONO','CORP',[0]}
,{'CORPORATIONON','CORP',[0]}
,{'CORPORATIONORATION','CORP',[0]}
,{'CORPORATIONP','CORP',[0]}
,{'CORPORATIONPO','CORP',[0]}
,{'CORPORATIONPORATIO','CORP',[0]}
,{'CORPORATIONPORATION','CORP',[0]}
,{'CORPORATIONR','CORP',[0]}
,{'CORPORATIONRP','CORP',[0]}
,{'CORPORATIONRPORATION','CORP',[0]}
,{'CORPORATIONT','CORP',[0]}
,{'CORPORATIONTION','CORP',[0]}
,{'CORPORATIOON','CORP',[0]}
,{'CORPORATIOOON','CORP',[0]}
,{'CORPORATIOPN','CORP',[0]}
,{'CORPORATIOTN','CORP',[0]}
,{'CORPORATIPN','CORP',[0]}
,{'CORPORATIPON','CORP',[0]}
,{'CORPORATITON','CORP',[0]}
,{'CORPORATOIIN','CORP',[0]}
,{'CORPORATOIN','CORP',[0]}
,{'CORPORATOION','CORP',[0]}
,{'CORPORATONI','CORP',[0]}
,{'CORPORATRION','CORP',[0]}
,{'CORPORATTION','CORP',[0]}
,{'CORPORIATION','CORP',[0]}
,{'CORPORIATON','CORP',[0]}
,{'CORPOROATION','CORP',[0]}
,{'CORPORORATION','CORP',[0]}
,{'CORPOROTATION','CORP',[0]}
,{'CORPORPATIOIN','CORP',[0]}
,{'CORPORPATION','CORP',[0]}
,{'CORPORPORATION','CORP',[0]}
,{'CORPORRATION','CORP',[0]}
,{'CORPORTAIN','CORP',[0]}
,{'CORPORTAION','CORP',[0]}
,{'CORPORTAITON','CORP',[0]}
,{'CORPORTATION','CORP',[0]}
,{'CORPORTORATION','CORP',[0]}
,{'CORPOTAION','CORP',[0]}
,{'CORPOTATION','CORP',[0]}
,{'CORPOTRAITON','CORP',[0]}
,{'CORPOTRATION','CORP',[0]}
,{'CORPP','CORP',[0]}
,{'CORPPORAITON','CORP',[0]}
,{'CORPPORATION','CORP',[0]}
,{'CORPPRATION','CORP',[0]}
,{'CORPR','CORP',[0]}
,{'CORPRATION','CORP',[0]}
,{'CORPRIATON','CORP',[0]}
,{'CORPROAITN','CORP',[0]}
,{'CORPROAITON','CORP',[0]}
,{'CORPROATIN','CORP',[0]}
,{'CORPROATION','CORP',[0]}
,{'CORPROPATION','CORP',[0]}
,{'CORPRORATION','CORP',[0]}
,{'CORPRORTATION','CORP',[0]}
,{'CORPROTATION','CORP',[0]}
,{'CORPRPORATION','CORP',[0]}
,{'CORRP','CORP',[0]}
,{'CORRPORATION','CORP',[0]}
,{'CORTPORATION','CORP',[0]}
,{'COTRPORATION','CORP',[0]}
,{'CPORATION','CORP',[0]}
,{'CPORPORATION','CORP',[0]}
,{'CPROPORATION','CORP',[0]}
,{'CPRORATION','CORP',[0]}
,{'CROOP','CORP',[0]}
,{'CROPORATION','CORP',[0]}
,{'CROPRATION','CORP',[0]}
,{'CROPRORATION','CORP',[0]}
,{'CRORPORATION','CORP',[0]}
,{'CRPORATIN','CORP',[0]}
,{'CRPORATION','CORP',[0]}
,{'CRPRATION','CORP',[0]}
//Added from Bug: 177163 #2
,{'CORPS','CORP',[0]}
,{'CORPERTION','CORP',[0]}
,{'CORPN','CORP',[0]}
,{'CORPORATIOBN','CORP',[0]}
,{'CORPORTED','CORP',[0]}
//end of Bug: 177163 #2
//Added from Bug: 177163 #3
,{'INCORPORTED','INC',[0]}
//end of Bug: 177163 #3
,{'INCOR','INC',[0]}
,{'INCORP','INC',[0]}
,{'INCORPO','INC',[0]}
,{'INCORPOR','INC',[0]}
,{'INCORPORA','INC',[0]}
,{'INCORPORAT','INC',[0]}
,{'INCORPORATI','INC',[0]}
,{'INCORPORATIO','INC',[0]}
,{'INCORPORATION','INC',[0]}
,{'INCORPORATE','INC',[0]}
,{'INCORPORATED','INC',[0]}
,{'LIMITED','LTD',[0]}
,{'LMTD','LTD',[0]}
//Although we are not translating these, they are needed to set extracted_btype switch
,{'INC', 'INC', [0]}
,{'LLC', 'LLC', [0]}
,{'LTD', 'LTD', [0]}
,{'CORP', 'CORP', [0]}
,{'CORPORATION', 'CORPORATION', [0]}
,{'LLLP', 'LLLP', [0]}
 ,{'PLLP', 'PLLP', [0]}
 ,{'PLLC', 'PLLC', [0]}
,{'LLP', 'LLP', [0]}
,{'GGGPPP', 'GP', [0]}
,{'PPPAAA', 'PA', [0]}
,{'FAMILY_LP', 'FAMILY LP', [0]}
,{'L__C', 'LC', [0]}
//,{'LXYZP', 'LP', [0]}
,{'LP', 'LP', [0]}
,{'CO__LC', 'CO LC', [0]}
,{'CO__PA', 'CO PA', [0]}
,{'P__C', 'PC', [0]}
,{'CCCOOO', 'CO', [0]}
]
,BIPV2_Company_Names.layouts.layout_Translations);
export Extractions_lowv :=
dataset([
 {'OF', [0]}
,{'THE', [0]}
//,{'TO', [0]}
//,{'FOR', [0]}
]
,BIPV2_Company_Names.layouts.layout_Extractions);
export State_prefixes    := ['AMERICAN','DISTRICT','NEW','NORTH','PUERTO','RHODE','SOUTH','UNITED','VIRGIN','WEST'];
export Of_exclusions     := ['BANK','PARADE','HOUSE','FREDERICK\'S','FLOWERAMA'];
export cnp_number_exclusions := ['360'];
export Geo_prefixes      := ['AT','OF'];
export Geo_directionals  := ['NE','NW','SE','SW','NO','SO','EA','WE','N','S','E','W'];
export StoreNbr_prefixes := ['STR','NO','BR','ST','STORE','NUMBER','BRANCH','SHOP','SRU'];
export Company_StoreNbr_Names :=
dataset([
 {1,'7-ELEVEN CONVENIENCE'}
,{2,'A B C FINE WINE & SPIRITS'}
,{3,'A C O HARDWARE'}
,{4,'A G EDWARDS'}
,{5,'AARON BROS ART & FRMNG'}
,{6,'AARON RENTS'}
,{7,'ABC CORP'}
,{8,'ABC SUPPLY CO'}
,{9,'ABERCROMBIE & FITCH'}
,{10,'ACE CASH EXPRESS INC'}
,{11,'ACE HARDWARE DEALER'}
,{12,'ACME'}
,{13,'ACT-1 PERSONNEL SERVICES'}
,{14,'ADVANCE AMERICA'}
,{15,'ADVANCE AUTO PARTS'}
,{16,'ADVANTAGE AUTO STORES'}
,{17,'AEROPOSTALE, INC.'}
,{18,'AEROTEK'}
,{19,'AEROTEK/TEK'}
,{20,'AERUS ELECTROLUX'}
,{21,'ALBERTSONS - SAVON'}
,{22,'ALBERTSONS DIST CTR'}
,{23,'ALBERTSON\'S EXPRESS'}
,{24,'ALBERTSON\'S, INC.'}
,{25,'ALDI'}
,{26,'ALFA INSURANCE'}
,{27,'ALLSUP\'S'}
,{28,'ALPHAGRAPHICS'}
,{29,'AMERICAN EAGLE'}
,{30,'AMERICAN EAGLE OUTFITTERS'}
,{31,'AMERICAN GENERAL FINANCE CORPORATION'}
,{32,'AMERISTOP FOOD MART'}
,{33,'AMOCO'}
,{34,'AMY\'S HALLMARK'}
,{35,'AMY\'S HALLMARK SHOP'}
,{36,'ANN TAYLOR'}
,{37,'ANN TAYLOR LOFT'}
,{38,'ANNIE SEZ'}
,{39,'ANNTAYLOR'}
,{40,'APPLE INC'}
,{41,'APPLE MARKET'}
,{42,'APRIA HEALTH CARE'}
,{43,'ARAMARK'}
,{44,'ARBY\'S'}
,{45,'ARMY & AIR FORCE EXCHANGE'}
,{46,'AUTO ZONE'}
,{47,'AUTOZONE'}
,{48,'BAILEY BANKS & BIDDLE'}
,{49,'BAKER BROTHERS'}
,{50,'BANANA REPUBLIC'}
,{51,'BANK OF AMERICA'}
,{52,'BANK OF OKLAHOMA'}
,{53,'BANKATLANTIC'}
,{54,'BARNES & NOBLE'}
,{55,'BARNES NOBLE BOOKSELLERS'}
,{56,'BASKIN ROBBINS'}
,{57,'BASS SHOE FACTORY OUTLET'}
,{58,'BATH & BODY WORKS'}
,{59,'BATH & BODY WORKS'}
,{60,'BATTERIES PLUS'}
,{61,'BEALL\'S'}
,{62,'BEALLS OUTLET'}
,{63,'BEAUTY EXPRESS'}
,{64,'BED BATH & BEYOND'}
,{65,'BEL AIR MARKET'}
,{66,'BELK, INC'}
,{67,'BEN FRANKLIN'}
,{68,'BENNIGAN\'S'}
,{69,'BEST BUY'}
,{70,'BEST BUY STORES LP'}
,{71,'BI - LO'}
,{72,'BIG 5 SPORTING GOODS'}
,{73,'BIG KMART'}
,{74,'BIG LOTS'}
,{75,'BIG \'O\' TIRES'}
,{76,'BILLS DOLLAR'}
,{77,'BI-LO'}
,{78,'BJS WHOLESALE CLUB'}
,{79,'BLOCKBUSTER'}
,{80,'BLOCKBUSTER VIDEO'}
,{81,'BOB EVANS'}
,{82,'BOJANGLES'}
,{83,'BOMBAY'}
,{84,'BONANZA'}
,{85,'BONEFISH GRILL'}
,{86,'BOOKS-A-MILLION'}
,{87,'BORDERS INC'}
,{88,'BOSTON MARKET'}
,{89,'BOUTIQUE CLAIRES'}
,{90,'BRAKES PLUS INC'}
,{91,'BRAUM\'S ICE CREAM & DAIRY'}
,{92,'BRIDGESTONE FIRESTONE'}
,{93,'BROOKS BROTHERS'}
,{94,'BROOKS DRUG'}
,{95,'BROOKS PHARMACY'}
,{96,'BROOKSTONE CO INC'}
,{97,'BUEHLER\'S BUY LOW'}
,{98,'BUFFALO WILD WINGS'}
,{99,'BUILD A BEAR'}
,{100,'BUMPER TO BUMPER'}
,{101,'BURGER KING'}
,{102,'BURKE\'S OUTLET'}
,{103,'BURLINGTON COAT FACTORY'}
,{104,'CAMELOT MUSIC'}
,{105,'CAPTAIN D\'S SEAFOOD'}
,{106,'CAREFUSION , INC.'}
,{107,'CARIBOU COFFEE COMPANY, INC.'}
,{108,'CARLS JR'}
,{109,'CARNIVAL SHOE'}
,{110,'CARQUEST AUTO PARTS'}
,{111,'CARRABBAS ITALIAN GRILL INC'}
,{112,'CARROWS'}
,{113,'CARVEL'}
,{114,'CASEY\'S GEN'}
,{115,'CASEY\'S INC'}
,{116,'CASH'}
,{117,'CASH AMERICA PAWN'}
,{118,'CASH AND CARRY'}
,{119,'CASUAL MALE BIG AND TALL'}
,{120,'CATHERINE\'S'}
,{121,'CATO'}
,{122,'CCH INC'}
,{123,'CHAMPS INC'}
,{124,'CHAMPS SPORTS'}
,{125,'CHARLOTTE RUSSE INC'}
,{126,'CHASE'}
,{127,'CHECK \'N GO'}
,{128,'CHECKER AUTO PARTS'}
,{129,'CHECKERS'}
,{130,'CHEST MEDICINE'}
,{131,'CHEVRON'}
,{132,'CHEVRON CSI'}
,{133,'CHEVRON STATIONS'}
,{134,'CHICK-FIL-A'}
,{135,'CHICO\'S'}
,{136,'CHIEF AUTO PARTS'}
,{137,'CHILDRENS PLACE'}
,{138,'CHILDRENS WORLD LEARNING CTR'}
,{139,'CHILDTIME CHILDREN\'S CTR'}
,{140,'CHILIS'}
,{141,'CHILI\'S GRILL & BAR'}
,{142,'CHIPOTLE'}
,{143,'CHIPOTLE MEXICAN GRILL'}
,{144,'CHUCK E CHEESE'}
,{145,'CHURCHS CHICKEN'}
,{146,'CICIS PIZZA'}
,{147,'CIGARETTES CHEAPER'}
,{148,'CINNABON'}
,{149,'CINTAS CORP'}
,{150,'CIRCLE K'}
,{151,'CIRCUIT CITY'}
,{152,'CITGO INC'}
,{153,'CITI TRENDS INC'}
,{154,'CITIZENS BANK'}
,{155,'CITY MARKET'}
,{156,'CLAYTON HOMES'}
,{157,'COASTLINE DISTRIBUTION'}
,{158,'COLD STONE CREAMERY'}
,{159,'COLDSTONE CREAMERY'}
,{160,'COMFORT KEEPERS'}
,{161,'COMPUSA'}
,{162,'CONOCO'}
,{163,'CONSUMER VALUE STORES'}
,{164,'CONVENIENT FOOD MART'}
,{165,'COSTCO'}
,{166,'COSTCO WHOLESALE / COSTCO PHARMACY'}
,{167,'COSTCO WHOLESALE CORP'}
,{168,'CRACKER BARREL'}
,{169,'CRACKER BARREL OLD COUNTRY'}
,{170,'CRATE & BARREL'}
,{171,'CUB FOODS'}
,{172,'CUB PHARMACY'}
,{173,'CUMBERLAND FARMS'}
,{174,'CVS FL LLC'}
,{175,'CVS GENERAL INC'}
,{176,'CVS PHARMACY'}
,{177,'CVS, L.L.C.'}
,{178,'CVSPHARMACY'}
,{179,'D\' ANGELOS SANDWICH SHOP'}
,{180,'DAIRY MART'}
,{181,'DAIRY QUEEN'}
,{182,'DEL TACO'}
,{183,'DENNY\'S'}
,{184,'DENNYS REST'}
,{185,'DENNY\'S RESTAURANT'}
,{186,'DIAMOND SHAMROCK'}
,{187,'DIAMOND SHAMROCK STATIONS INC'}
,{188,'DIAMOND VOGEL PAINT'}
,{189,'DICK\'S SPORTING GOODS'}
,{190,'DIETER 66'}
,{191,'DILLARDS'}
,{192,'DISCOUNT AUTO PARTS'}
,{193,'DISCOUNT DOLLAR CO'}
,{194,'DISCOUNT FOOD MART'}
,{195,'DISNEY LLC'}
,{196,'DOLLAR GENERAL'}
,{197,'DOLLAR TREE'}
,{198,'DOLLAR TREE STORES'}
,{199,'DOMINICKS COMPANY'}
,{200,'DOMINOS PIZZA'}
,{201,'DON PABLO\'S'}
,{202,'DRESS FOR LESS'}
,{203,'DRUG EMPORIUM'}
,{204,'DRUG TOWN'}
,{205,'DRYCLEAN USA'}
,{206,'DUANE READE INC'}
,{207,'DUNKIN DONUTS'}
,{208,'DURON PINTS WALLCOVERINGS'}
,{209,'E Z LINER INDUSTRIES'}
,{210,'E Z MART'}
,{211,'EASY SPIRIT'}
,{212,'EASY SPIRIT OUTLET'}
,{213,'EB GAMES'}
,{214,'ECKERD'}
,{215,'ECKERD DRUG'}
,{216,'ECKERD DRUGS'}
,{217,'ECONO LUBE AND TUNE'}
,{218,'EDDIE BAUER'}
,{219,'EDIBLE ARRANGEMENTS'}
,{220,'EDWARD JONES'}
,{221,'EINSTEIN BROS BAGELS'}
,{222,'EL POLLO LOCO'}
,{223,'ELDER-BEERMAN'}
,{224,'ELECTROLUX LLC'}
,{225,'ENTERPRISE RAC'}
,{226,'ENTERPRISE RENT A CAR'}
,{227,'EXTENDED STAY AMERICA'}
,{228,'EXTRA SPACE STORAGE'}
,{229,'EXXON'}
,{230,'EXXON'}
,{231,'EYEMASTERS'}
,{232,'EZ MART'}
,{233,'EZ MONEY LOAN SERVICES'}
,{234,'EZ PAWN'}
,{235,'FACTORY CONNECTION'}
,{236,'FAMILY CHRISTIAN STORES, INC.'}
,{237,'FAMILY DOLLAR'}
,{238,'FAMOUS FOOTWEAR'}
,{239,'FAREWAY'}
,{240,'FARM FRESH'}
,{241,'FARM FRESH SUPERMARKET'}
,{242,'FARMER JACK\'S'}
,{243,'FAS MART'}
,{244,'FASHION BUG'}
,{245,'FASHION BUG PLUS INC'}
,{246,'FASMART'}
,{247,'FAST FRAME'}
,{248,'FASTFRAME'}
,{249,'FAZOLI\'S'}
,{250,'FEDEX KINKO\'S'}
,{251,'FERGUSON ENTERPRISE INC'}
,{252,'FINISH LINE'}
,{253,'FIRESTONE'}
,{254,'FITNESS 19 CA, LLC'}
,{255,'FLASH FOODS'}
,{256,'FLEETPRIDE'}
,{257,'FLOWERAMA OF AMERICA INC'}
,{258,'FLYING J TRAVEL PLAZA'}
,{259,'FOOD 4 LESS'}
,{260,'FOOD CITY'}
,{261,'FOOD EMPORIUM, INC.'}
,{262,'FOOD LION LLC'}
,{263,'FOOD MART'}
,{264,'FOOD WORLD'}
,{265,'FOOT LOCKER'}
,{266,'FOOTACTION'}
,{267,'FOOTACTION USA'}
,{268,'FOOTLOCKER'}
,{269,'FRED MEYER JEWELERS'}
,{270,'FRED MEYER, INC.'}
,{271,'FREDERICK\'S OF HOLLYWOOD'}
,{272,'FRED\'S'}
,{273,'FRED\'S DOLLAR'}
,{274,'FREDS PHARMACY'}
,{275,'FRED\'S SUPER DOLLAR'}
,{276,'FRIEDMAN\'S JEWELERS'}
,{277,'FRYS MARKETPLACE'}
,{278,'FUDDRUCKERS INC'}
,{279,'FUEL MART'}
,{280,'FYE'}
,{281,'GAME CRAZY INC'}
,{282,'GAME STOP'}
,{283,'GAMESTOP'}
,{284,'GANDER MOUNTAIN'}
,{285,'GAP INC'}
,{286,'GCR TIRE CENTER'}
,{287,'GENERAL NUTRITION CENTER'}
,{288,'GENERAL NUTRITION CENTERS'}
,{289,'GIANT EAGLE'}
,{290,'GIANT FOOD'}
,{291,'GIANT FOOD'}
,{292,'GLEN\'S MARKETS'}
,{293,'GNC KK'}
,{294,'GOLDEN CORRAL'}
,{295,'GOLDEN GALLON'}
,{296,'GOODYEAR'}
,{297,'GOODY\'S FAMILY CLOTHING'}
,{298,'GORDON\'S JEWELERS'}
,{299,'GRAINGER'}
,{300,'GREAT CLIPS'}
,{301,'GUESS FACTORY'}
,{302,'GUITAR CENTER'}
,{303,'GYMBOREE'}
,{304,'H E B FOOD'}
,{305,'H&R BLOCK & ASSOCIATES'}
,{306,'HAIR CUTTERY'}
,{307,'HAIRMASTERS'}
,{308,'HALLMARK CREATIONS'}
,{309,'HANCOCK FABRICS'}
,{310,'HAPPY HARRY\'S'}
,{311,'HARDEE\'S'}
,{312,'HARLEY-DAVIDSON'}
,{313,'HARRIS TEETER SUPERMARKET'}
,{314,'HD SUPPLY ELECTRICAL'}
,{315,'HEALTH MART'}
,{316,'HEB'}
,{317,'HEB FOOD'}
,{318,'HERB CHAMBERS, INC.'}
,{319,'HESS'}
,{320,'HIBBETT SPORTS'}
,{321,'HICKORY FARMS'}
,{322,'HOBBY LOBBY'}
,{323,'HOBBY LOBBY HOB-LOB'}
,{324,'HOLIDAY STATIONSTORES'}
,{325,'HOLLISTER CO'}
,{326,'HOLLYWOOD VIDEO'}
,{327,'HOME DEPOT'}
,{328,'HOME INSTEAD SENIOR CARE'}
,{329,'HOMEGOODS'}
,{330,'HOMETOWN BUFFET, INC.'}
,{331,'HOT TOPIC INC'}
,{332,'HOULIHANS'}
,{333,'HUDDLE HOUSE'}
,{334,'HUGHES SUPPLY DIV'}
,{335,'HUGHES SUPPLY INC'}
,{336,'HUNGRY HOWIE\'S'}
,{337,'HY-VEE'}
,{338,'IHOP'}
,{339,'IKEA'}
,{340,'IKEA NORTH AMERICA'}
,{341,'INGLES'}
,{342,'INTERNATIONAL HOUSE OF PANCAKES'}
,{343,'INTERSTATE HOTELS CORPORATION'}
,{344,'J. C. PENNEY CO, INC'}
,{345,'J. CREW, INC'}
,{346,'JACK IN THE BOX'}
,{347,'JACK\'S HAMBURGERS'}
,{348,'JAMBA JUICE'}
,{349,'JANI KING'}
,{350,'JC PENNEY'}
,{351,'JEWEL - OSCO'}
,{352,'JEWEL OSCO'}
,{353,'JEWEL-OSCO'}
,{354,'JIFFY LUBE'}
,{355,'JIMMY JOHN\'S'}
,{356,'JO-ANN'}
,{357,'JOES TRADER'}
,{358,'JOHN DEERE LANDSCAPES, INC'}
,{359,'JOHNNY ROCKETS'}
,{360,'JOURNEYS INC.'}
,{361,'JUST BRAKES'}
,{362,'JUSTICE'}
,{363,'K MART'}
,{364,',KAISER PERMANENTE PHARM'}
,{365,'KANGAROO EXPRESS'}
,{366,'KANGAROO EXPRESS'}
,{367,'KASH N KARRY'}
,{368,'KATZ & BESTHOFF, INC.'}
,{369,'KAY JEWELERS'}
,{370,'KB TOYS'}
,{371,'KELLY SERVICES'}
,{372,'KERR DRUG'}
,{373,'KETTLE RESTRURANT'}
,{374,'KFC'}
,{375,'KINDERCARE LEARNING CTR'}
,{376,'KING SMOOTHIE'}
,{377,'KINKOS INC'}
,{378,'KIRKLANDS'}
,{379,'KIRLIN\'S HALLMARK'}
,{380,'KITCHEN COLLECTION'}
,{381,'KMART CORPORATION'}
,{382,'KMART PHARMACY'}
,{383,'KOHLS'}
,{384,'KRAGEN AUTO PARTS'}
,{385,'KRISPY KREME'}
,{386,'KROGER'}
,{387,'KROGER PHARMACY'}
,{388,'KWIK KOPY'}
,{389,'KWIK KOPY PRINTING'}
,{390,'KWIK PANTRY'}
,{391,'KWIK SHOP'}
,{392,'KWIK STOP'}
,{393,'KWIK TRIP INC'}
,{394,'LA PETITE ACADEMY'}
,{395,'LA QUINTA'}
,{396,'LA QUINTA INN'}
,{397,'LABOR READY'}
,{398,'LADY FOOT LOCKER'}
,{399,'LADY FOOTLOCKER'}
,{400,'LANE BRYANT'}
,{401,'LANE BRYANT OUTLET LLC'}
,{402,'LANE BRYANT/CACIQUE LLC'}
,{403,'LEGGETT & PLATT'}
,{404,'L\'EGGS HANES BALI PLAYTEX'}
,{405,'LENS CRAFTERS'}
,{406,'LENSCRAFTERS INC'}
,{407,'LESLIES POOLMART'}
,{408,'LEVI\'S OUTLET BY DESIGNS'}
,{409,'LIBERTY TAX SERVICE'}
,{410,'LIDS'}
,{411,'LIFE UNIFORM'}
,{412,'LIL\' CHAMP'}
,{413,'LIMITED TOO'}
,{414,'LIMITED, THE'}
,{415,'LINENS N THINGS'}
,{416,'LITTLE CAESAR\'S'}
,{417,'LITTLE GENERAL'}
,{418,'LITTMAN JEWELERS'}
,{419,'LIZ CLAIBORNE OUTLET'}
,{420,'LOAF \'N JUG'}
,{421,'LOAN MART'}
,{422,'LONE STAR STEAKHOUSE'}
,{423,'LONG JOHN SILVERS'}
,{424,'LONGHORN STEAKHOUSE'}
,{425,'LONGS DRUG'}
,{426,'LONGS DRUGS'}
,{427,'LOVES'}
,{428,'LOVE\'S COUNTRY'}
,{429,'LOVE\'S TRAVEL STOP'}
,{430,'LOWES'}
,{431,'LOWES FOODS'}
,{432,'MACYS'}
,{433,'MAIL BOXES ETC INC'}
,{434,'MAILBOXES ETC'}
,{435,'MAPCO EXPRESS INC'}
,{436,'MARATHON'}
,{437,'MARBLE SLAB CREAMERY'}
,{438,'MARCOS PIZZA'}
,{439,'MARSHALLS'}
,{440,'MARTINS FOOD MARKET'}
,{441,'MAS CLUB'}
,{442,'MASTERCUTS'}
,{443,'MATTRESS DISCOUNTERS'}
,{444,'MATTRESS FIRM'}
,{445,'MAURICES'}
,{446,'MAVERIK COUNTRY STORES'}
,{447,'MC DONALDS'}
,{448,'MCDONALD\'S'}
,{449,'MCDONALDS RESTAURANT'}
,{450,'MEIJER'}
,{451,'MEINEKE CAR CARE CTR'}
,{452,'MENARDS'}
,{453,'MEN\'S WAREHOUSE'}
,{454,'MERLE NORMAN'}
,{455,'MERRY MAIDS'}
,{456,'MERVYN\'S'}
,{457,'MICHAELS'}
,{458,'MIDAS MUFFLER'}
,{459,'MIDWAY 66'}
,{460,'MINUTECLINIC LLC'}
,{461,'MIRASTAR'}
,{462,'MOBIL'}
,{463,'MONEY MART'}
,{464,'MONRO MUFFLER BRAKE INC'}
,{465,'MOTEL 6'}
,{466,'MOTHERHOOD MATERNITY'}
,{467,'MOVIE GALLERY'}
,{468,'MRS WINNERS CHKN BISCUITS'}
,{469,'MURPHY OIL USA, INC'}
,{470,'MURPHY USA'}
,{471,'NAPA AUTO PARTS'}
,{472,'NATIONAL CASH ADVANCE LLC'}
,{473,'NATIONAL CITY BANK'}
,{474,'NDCBU'}
,{475,'NEIGHBORHOOD MARKET'}
,{476,'NEIMAN MARCUS'}
,{477,'NEXTEL RETAIL'}
,{478,'NINE WEST OUTLET'}
,{479,'NOB HILL FOODS'}
,{480,'NORDSTROM'}
,{481,'NTB'}
,{482,'NU-WAY OIL CO.'}
,{483,'O\'CHARLEY\'S'}
,{484,'OFFICE DEPOT'}
,{485,'OFFICE MAX'}
,{486,'OFFICEMAX'}
,{487,'OLD COUNTRY BUFFET'}
,{488,'OLD NAVY'}
,{489,'OLIVE GARDEN'}
,{490,'OLIVE GARDEN ITALIAN RESTAURANT'}
,{491,'ORANGE JULIUS'}
,{492,'ORECK FLOOR CARE CENTER'}
,{493,'O\'REILLY AUTO PARTS'}
,{494,'ORKIN'}
,{495,'ORKIN PEST CONTROL'}
,{496,'ORSCHELIN FARM AND HOME'}
,{497,'OSCO DRUG'}
,{498,'OUTBACK STEAKHOUSE'}
,{499,'PACIFIC SUNWEAR'}
,{500,'PACSUN'}
,{501,'PAK MAIL'}
,{502,'PANDA EXPRESS'}
,{503,'PANERA BREAD'}
,{504,'PANERA BREAD F RESUP'}
,{505,'PAPA JOHN\'S'}
,{506,'PAPA JOHN\'S PIZZA'}
,{507,'PARADE OF SHOES'}
,{508,'PARADIES SHOPS LLC'}
,{509,'PARTS DEPOT INC'}
,{510,'PATHMARK'}
,{511,'PATHMARK SUPERMARKETS'}
,{512,'PATTERSON DENTAL'}
,{513,'PAY-LESS SELF SERVICE SHOES CO., INC.'}
,{514,'PAYLESS SHOE SOURCE'}
,{515,'PAYLESS SHOES'}
,{516,'PAYLESS SHOESOURCE'}
,{517,'PCA/COUNCE'}
,{518,'PCA/LOS ANGELES'}
,{519,'PCA/NEWARK,'}
,{520,'PCA/PLANO'}
,{521,'PCA/VALDOSTA'}
,{522,'PEARLE VISION'}
,{523,'PEARLE VISION CTR'}
,{524,'PEP BOYS'}
,{525,'PERFUMANIA'}
,{526,'PERKINS RESTAURANT'}
,{527,'PET SUPERMARKET INC.'}
,{528,'PETCO'}
,{529,'PETSMART'}
,{530,'PF CHANGS'}
,{531,'PHILLIPS 66/KICKS'}
,{532,'PHILLY CONNECTION'}
,{533,'PICK \'N SAVE'}
,{534,'PIERCING PAGODA'}
,{535,'PIGGLY WIGGLY , INC.'}
,{536,'PILOT OIL'}
,{537,'PINCH A PENNY'}
,{538,'PIP PRINTING'}
,{539,'PIZZA HUT'}
,{540,'PIZZERIA UNO'}
,{541,'PLAY IT AGAIN SPORTS'}
,{542,'PONDEROSA'}
,{543,'POPEYE\'S'}
,{544,'PORTAMEDIC'}
,{545,'POSTAL ANNEX'}
,{546,'POSTAL INSTANT PRESS'}
,{547,'POTTERY BARN'}
,{548,'PRICE CHOPPER'}
,{549,'PRIDE CLEANERS'}
,{550,'PRIMA 7-11'}
,{551,'PRO HARDWARE'}
,{552,'PS ORANGECO INC'}
,{553,'PUBLIX'}
,{554,'PUBLIX SUPER MARKET'}
,{555,'PUBLIX SUPER MARKETS INC'}
,{556,'QDOBA MEXICAN GRILL'}
,{557,'QUICK & REILLY'}
,{558,'QUICKTRIP'}
,{559,'QUIK STOP MARKET'}
,{560,'QUIKTRIP'}
,{561,'QUIPTRIP'}
,{562,'QUIZNO S'}
,{563,'QUIZNOS'}
,{564,'QUIZNO\'S CLASSIC SUBS'}
,{565,'QUIZNOS SUB'}
,{566,'QUIZNO\'S SUBS'}
,{567,'RACETRAC'}
,{568,'RACEWAY'}
,{569,'RACK ROOM SHOES'}
,{570,'RADIO SHACK'}
,{571,'RADIOSHACK'}
,{572,'RALEY\'S SUPERMARKET'}
,{573,'RALPHS'}
,{574,'RALPHS GROCERY COMPANY'}
,{575,'RED LOBSTER'}
,{576,'RED ROBIN BURGERS'}
,{577,'RED WING SHOE COMPANY, INC'}
,{578,'REGIONS BANK'}
,{579,'REGIS SALON'}
,{580,'RENT - WAY, INC'}
,{581,'RENT A CTR'}
,{582,'RICH OIL'}
,{583,'RISER FOODS/GIANT EAGLE'}
,{584,'RITE AID'}
,{586,'RITE AID DISCOUNT PHARMACY'}
,{587,'RITE AID PHARMACY'}
,{588,'RITZ CAMERA'}
,{589,'ROSS'}
,{590,'ROSS DRESS FOR LESS'}
,{591,'ROUNDY\'S SUPERMARKETS'}
,{592,'RUBY TUESDAY'}
,{593,'RUBY TUESDAYS INC.'}
,{594,'RUE 21'}
,{595,'RUSSELL STOVER'}
,{596,'RYAN\'S STEAK HOUSE'}
,{597,'SAFEWAY'}
,{598,'SAFEWAY PHARMACY'}
,{599,'SALLY BEAUTY'}
,{600,'SALLY BEAUTY SUPPLY'}
,{602,'SAM GOODY'}
,{603,'SAMS CLUB'}
,{604,'SAMUELS JEWELERS'}
,{605,'SAV ON'}
,{606,'SAV ON DRUG'}
,{607,'SAV ON DRUGS'}
,{608,'SAVE A LOT LIMITED'}
,{609,'SAVE MART'}
,{610,'SBARRO'}
,{611,'SCHNEIDER ELECTRIC'}
,{612,'SCHUCK\'S AUTO SUPPLY'}
,{613,'SCOTCHMAN'}
,{614,'SEARS'}
,{615,'SEARS DEALER'}
,{616,'SEARS OPTICAL'}
,{617,'SEARS PORTRAIT STUDIO'}
,{618,'SEARS ROEBUCK & CO'}
,{619,'SEARS ROEBUCK CO'}
,{620,'SELECT COMFORT'}
,{621,'SHAW\'S'}
,{622,'SHAWS - OSCO'}
,{623,'SHEETZ, INC.'}
,{624,'SHELL'}
,{625,'SHERWIN WILLIAMS CO'}
,{626,'SHERWIN-WILLIAMS'}
,{627,'SHOE SENSATION'}
,{628,'SHOE SHOW'}
,{629,'SHONEYS'}
,{630,'SHOP RITE'}
,{631,'SHOPKO'}
,{632,'SHOP\'N SAVE'}
,{633,'SHOPPERS FOOD WAREHOUSE'}
,{634,'SHORT STOP'}
,{635,'SIGMOR NUMBER, INC.'}
,{636,'SIGNS NOW'}
,{637,'SILVER & GOLD CONNECTION'}
,{638,'SIR SPEEDY'}
,{639,'SIR SPEEDY PRINTING'}
,{640,'SIR SPEEDY PRINTING CENTER'}
,{641,'SIZES UNLIMITED'}
,{642,'SIZZLER'}
,{643,'S-MART'}
,{644,'SMART & FINAL'}
,{645,'SMART STYLE'}
,{646,'SMARTSTYLE'}
,{647,'SMITH & HAWKEN'}
,{648,'SMITH BARNEY'}
,{649,'SNYDER\'S DRUG'}
,{650,'SODEXHO'}
,{651,'SOFTWARE ETC.'}
,{652,'SONIC DRIVE IN'}
,{653,'SONIC INC'}
,{654,'SOUPER SALAD'}
,{655,'SOUTH CENTRAL POOL'}
,{656,'SOUTHERN AUTO SUPPLY'}
,{657,'SPEEDWAY'}
,{658,'SPEEDY STOP'}
,{659,'SPENCER GIFTS'}
,{660,'SPRAGUE ENERGY CORP'}
,{661,'ST LOUIS BREAD'}
,{662,'STANDARD FEDERAL BANK'}
,{663,'STAPLES'}
,{664,'STARBUCKS'}
,{665,'STARBUCKS COFFEE'}
,{666,'STATE LIQUOR'}
,{667,'STEIN MART'}
,{668,'STEWARTS SHOP'}
,{669,'STOP AND SHOP'}
,{670,'STOP IN FOOD STORES'}
,{671,'STOP-N-GO'}
,{672,'STORAGE USA'}
,{673,'STRIDE RITE'}
,{674,'STRIDE RITE BOOTERY'}
,{675,'STRIPES'}
,{676,'STYLE AMERICA'}
,{677,'SUBWAY'}
,{678,'SUBWAY SANDWICH'}
,{679,'SUBWAY SANDWICH & SALAD'}
,{680,'SUBWAY SANDWICH SHOP'}
,{681,'SUBWAY SANDWICHES'}
,{682,'SUBWAY SANDWICHES & SALADS'}
,{683,'SUNCOAST'}
,{684,'SUNGLASS HUT'}
,{685,'SUNGLASS HUT AT KAAHUMANU CENTER'}
,{686,'SUNGLASS HUT AT KUKUI GROVE CENTER'}
,{687,'SUNGLASS HUT AT MACY\'S'}
,{688,'SUNGLASS HUT AT PEARLRIDGE CENTER'}
,{689,'SUNGLASS HUT AT WINDWARD MALL'}
,{690,'SUNMART'}
,{691,'SUNOCO'}
,{692,'SUPER FRESH'}
,{693,'SUPER S FOODS'}
,{694,'SUPER STOP'}
,{695,'SUPER STOP & SHOP'}
,{696,'SUPERAMERICA'}
,{697,'SUPERCUTS'}
,{698,'SUPERIOR POOL PRODUCTS'}
,{699,'SWEETBAY SUPERMARKET'}
,{700,'T J MAXX'}
,{701,'T. O. HAAS TIRE'}
,{702,'TACO BELL'}
,{703,'TACO BUENO'}
,{704,'TALBOT\'S'}
,{705,'TARGET'}
,{706,'TARGET CORPORATION'}
,{707,'TARGET OPTICAL'}
,{708,'TARGET PHARMACY'}
,{709,'TARGET STORE T'}
,{710,'TARGET STORES'}
,{711,'TARGET STORES T'}
,{712,'TERRIBLES'}
,{713,'TETCO'}
,{714,'TEXACO'}
,{715,'TEXACO XPRESS LUBE'}
,{716,'TGI FRIDAYS'}
,{717,'THE ALAMO'}
,{718,'THE BUCKLE INC'}
,{719,'THE CASUAL MALE BIG TALL'}
,{720,'THE DISCOVERY'}
,{721,'THE DRESS BARN INC'}
,{722,'THE MEDICINE SHOPPE'}
,{723,'THE PICTURE PEOPLE INC'}
,{724,'THE SHOE ZONE'}
,{725,'THE SPORTS AUTHORITY'}
,{726,'THE SUPERVALU'}
,{727,'THE U P S'}
,{728,'THE UPS STORES'}
,{729,'THINGS REMEMBERED'}
,{730,'THORNTON\'S GAS & FOODMART'}
,{731,'THRIFTY WHITE DRUG'}
,{732,'TIJUANA FLATS'}
,{733,'TIMES MARKET'}
,{734,'TIMEWISE FOOD'}
,{735,'TIRE DISTRIBUTION SYSTEMS'}
,{736,'TIRE KINGDOM, INC'}
,{737,'TIRES PLUS'}
,{738,'TJ MAXX'}
,{739,'T-MOBILE'}
,{740,'T-MOBILE - PLANT'}
,{741,'TOGOS EATERY'}
,{742,'TOM THUMB'}
,{743,'TOPS FRIENDLY MARKETS'}
,{744,'TORRID'}
,{745,'TOWN & COUNTRY FD'}
,{746,'TOWN & COUNTRY FOOD'}
,{747,'TOYS R US'}
,{748,'TRACTOR SUPPLY COMPANY'}
,{749,'TRADE SECRET'}
,{750,'TRAVEL CENTERS AMERICA'}
,{751,'TRUE VALUE'}
,{752,'TUESDAY MORNING INC'}
,{753,'TURKEY HILL, L.P.'}
,{754,'U S FOODSERVICE'}
,{755,'UHAUL CO.'}
,{756,'UKROP\'S SUPER MARKET'}
,{757,'UNITED DAIRY FARMERS'}
,{758,'UNITED SUPERMARKET'}
,{759,'UNITED SUPERMARKETS'}
,{760,'UPS'}
,{761,'VALERO CORNER'}
,{762,'VAN HEUSEN'}
,{763,'VERIZON WIRELESS'}
,{764,'VET CANTEEN SERVICE'}
,{765,'VILLA PIZZA'}
,{766,'VILLAGE PANTRY'}
,{767,'VITAMIN WORLD INC'}
,{768,'VONS'}
,{769,'WA MUTUAL'}
,{770,'WAFFLE HOUSE'}
,{771,'WAL MART'}
,{772,'WAL MART PHARMACY'}
,{773,'WALDBAUM INC'}
,{774,'WALDENBOOKS'}
,{775,'WALDENBOOKS/WALDENKIDS'}
,{776,'WALGREEN CO'}
,{777,'WALGREEN DRUG'}
,{778,'WALGREEN DRUG RX'}
,{779,'WALGREENS'}
,{780,'WALGREENS DRUG'}
,{781,'WALGREENS PHARMACY'}
,{782,'WALMART'}
,{783,'WAL-MART SUPERCENTER'}
,{784,'WALMART SUPERCENTER'}
,{785,'WALMART VISION CENTER'}
,{786,'WELLS FARGO'}
,{787,'WELLS FARGO BANK'}
,{788,'WENDY\'S'}
,{789,'WHATABURGER'}
,{790,'WHEREHOUSE MUSIC'}
,{791,'WHITE CAP'}
,{792,'WHITE CAP CONSTRUCTION'}
,{793,'WHITE HOUSE BLACK MARKET INC'}
,{794,'WHOLE FOODS'}
,{795,'WICKES LUMBER'}
,{796,'WIENERSCHNITZEL'}
,{797,'WILCO'}
,{798,'WILCO SERVICE STATION'}
,{799,'WILLIAMS SONOMA'}
,{800,'WILSON FARMS'}
,{801,'WILSONS LEATHER'}
,{802,'WINCO, INC.'}
,{803,'WINE & SPIRITS SHOPPE'}
,{804,'WINN DIXIE'}
,{806,'WINNDIXIE'}
,{807,'WINN-DIXIE'}
,{808,'WINN-DIXIE STORES INC'}
,{809,'WIRELESS TOYZ'}
,{810,'WOLF CAMERA & VIDEO'}
,{811,'WORLD SAVINGS'}
,{812,'XTRA LEASE'}
,{813,'ZALE OUTLET'}
,{814,'ZALES CORP'}
,{815,'ZALES JEWELERS'}
,{816,'ZALES OUTLET'}
,{817,'ZARA USA'}
,{818,'ZEE MEDICAL SERVICE CO'}
,{819,'7-ELEVEN'}
,{820,'7-ELEVEN FOOD'}
,{821,'RENT A CENTER'}
,{822,'HAAGEN-DAZS SHOP 826'}
,{823,'IN-OUT BURGER #166'}
,{824,'IN-N-OUT BURGERS #98'}
,{825,'JO-ANN FABRICS & CRAFTS # 1719'}
,{826,'KAY-BEE TOYS 8200'}
,{827,'RADIO SHACK 01-3101'}
,{828,'SONIC DRIVE-IN'}
,{829,'U-HAUL SRU#40684'}
,{830,'VERIZON WRLS 70146-01'}
,{831,'WAL-MART STORE #900'}
]
,BIPV2_Company_Names.layouts.layout_names);
export StrNbr_SF_Name    := Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::bip_V2::strNbrName::qa';
export StrNbr_SF_DS      := dataset(StrNbr_SF_Name,BIPV2_Company_Names.layouts.layout_Names,thor);
// export StrNbr_SF_DS      := dataset('xxx',BIPV2_Company_Names.layouts.layout_Names,thor,opt);
export StrNbr_Name       := Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::bip_V2::strNbrName::' + workunit;
export StrNbr_DS         := dataset(StrNbr_Name,BIPV2_Company_Names.layouts.layout_Names,thor);
// export StrNbr_DS         := dataset('xxx',BIPV2_Company_Names.layouts.layout_Names,thor,opt);
export data_Test :=
dataset(
[
{1,'ABBC WEST VIRGINIA FAMILY MEDICINE PC'}
,{3,'05-077 PTA NY CONGRESS & CAPTR'}
,{4,'05-077 PTA NEW YORK CONGRESS & CAPTREE ELEMENTARY SCHOOL PTA'}
,{5,'I C EVANS PARENT TEACHER ORGANIZATION'}
,{6,'10TH DISTRICT PTA STAR PROGRAM'}
,{7,'1000 PTO LLC'}
,{8,'TENTH DIST LA PTA PTSA'}
,{9,'ELEVEN LP PTA EX #476'}
,{10,'113 PTA EX'}
,{11,'THE 113000 PTA JAX CAR TRUST'}
,{12,'1226 OSBORN ELEMENTARY PTA CA'}
,{13,'133 PTO ALVARADO'}
,{14,'14TH. DISTRICT PTA OF KENTUCKY CONGRESS OF PARENTS AND TEACHERS, INC.'}
,{15,'16TH AVENUE SCHOOL PARENT TEACHER ORGANIZATION'}
,{16,'16TH DISTRICT PTA INC.'}
,{17,'18951 JOYCE KILMER PTA NEW JERSEY CONGRESS OF PARENT'}
,{18,'19-005 FRNTR CENTL PTA COUNCIL'}
,{19,'19-005 FRONTIER CENTRAL PTA COUNCIL'}
,{20,'FIRST BAPTIST CHURCH DAY SCHOOL PARENT TEACHER ORGANIZATION, INC.'}
,{21,'FIRST FLIGHT ELEMENTARY SCHOOL PARENT TEACHER ORGANIZATION INC.'}
,{22,'FIRST FLIGHT MIDDLE SCHOOL PTO INC'}
,{23,'FIRST STATE MONTESSORI ACADEMY PTO INC'}
,{24,'FIRST STEPS ANN ARBOR PARENT TEACHER ORGANIZATION'}
,{25,'210 G M REED ELEMENTARY PTA TX'}
,{26,'27585 PTA NJ CONGRESS'}
,{27,'27585 PTA NJ CONGRESS OF PARENTS, JEFFERSON TOWNSHIP MIDDLE SCHOOL PTA'}
,{28,'282 PARENT TEACHER ORGANIZATION, INC.'}
,{29,'THREE OAKS ELEMENTARY PTO INC'}
,{30,'THREE OAKS ELEMENTARY SCHOOL PARENT TEACHER ORGANIZATION'}
,{31,'THREE RIVERS PARENT TEACHER ORGANIZATION'}
,{32,'THREE RVERS P T A OHIO CNGRESS'}
,{33,'31ST DISTRICT PTA OFFICE'}
,{34,'33RD DISTRICT PTA CALIFORNIA CONGRESS OF PARENTS'}
,{35,'3930 WOODWAY ELEMENTARY PTA TE'}
,{36,'3M PTA PC'}
,{37,'4015 PTA STR'}
,{38,'456 PTA CS'}
,{39,'4644 ARMAND BAYOU ELEMENTARY SCHOOL PTA TEXAS CONGRESS'}
,{40,'FOURTH DISTRICT PTA INC'}
,{41,'FIVE FORKS MIDDLE SCHOOL PTA INC'}
,{42,'FIVE OAKS ACADEMY PTO INC'}
,{43,'FIVE POINTS PTO INC'}
,{44,'513 PTA USI'}
,{45,'5359 COLLEGE PTA CALIF CONGRES'}
,{46,'5406 BALLARD PTA CALIFORNIA CO'}
,{47,'5406 BALLARD PTA CALIFORNIA CONGRESS OF PARENTS'}
,{48,'5TH STREET ELEMENTARY PTO INC.'}
,{49,'SEVEN BRIDGES SCHOOL PARENT TEACHER ORGANIZATION, INC.'}
,{50,'SEVEN OAKS PTA 4429'}
,{51,'7BAR ELEMENTARY PTA FALL FESTIVAL'}
,{52,'SEVENTH ST SCHOOL PTO INC'}
,{53,'802 NEWMAN ELEMENTARY PTA CONG'}
,{54,'802 NEWMAN ELEMENTARY PTA CONGRESS OF PARENTS'}
,{55,'EIGHTH STREET ELEMENTARY SCHOOL PTO INC'}
,{56,'900 PTO LLC'}
,{57,'NINTH DISTRICT PTA INC'}
,{58,'A.A. NICK KERR MIDDLE SCHOOL PARENT TEACHER ORGANIZATION'}
,{59,'A B NEWELL PTA NBRASKA CNGRSS'}
,{60,'A B NEWELL PTA NEBRASKA CONGRESS OF PARENTS AND TEACHERS'}
,{61,'A.C. MOORE PTO (PARENT TEACHER ORGANIZATION)'}
,{62,'A C NEW MIDDLE SCHOOL PARENT TEACHER ASSOCIATION'}
,{63,'A. C. STEERE PARENT TEACHER ASSOCIATION'}
,{64,'A C WHELAN SCHOOL PTA SCHOLARSHIP FU'}
,{65,'A C WHELAN SCHOOL PTA SCHOLARSHIP FUND'}
,{66,'A D HENDERSON UNIVERSITY SCHOOL PTO INC'}
,{67,'A.E. FRAZIER ELEMENTARY SCHOOL PARENT TEACHER ORGANIZATION'}
,{68,'A. G. ELDER ELEMENTARY SCHOOL PARENT TEACHER ORGANIZATION'}
,{69,'A.H. ROBERTS PARENT TEACHER ORGANIZATION'}
,{70,'A IRVIN STUDLEY ELEMENTARY PARENT TEACHER ORGANIZATION INC'}
,{71,'A IRVIN STUDLEY ELEMENTARY PTO INC'}
,{72,'A M WINN PARENT TEACHER ASSOCIATION'}
,{73,'A MACARTHUR BARR MIDDLE SCHOOL PTA 04-058-P'}
,{74,'A N PRITZKER PARENT TEACHER ORGANIZATION'}
,{75,'A R REHABILITATION AND PHYSICAL THERAPY ASSOCIATION'}
,{76,'A SCOTT CROSSFIELD ELEMENTARY SCHOOL PARENT TEACHER ORGANIZATION'}
,{77,'A STEP AHEAD PRESCHOOL & MONTESSORI P T O INC'}
,{78,'A W SPENCE MIDDLE PARENT TEACHER ASSOCIATION'}
,{79,'AARON COHN MIDDLE SCHOOL PTO INC'}
,{80,'AARON PARKER PARENT TEACHER ORGANIZATION'}
,{81,'ABA PHYSICAL THERAPY ASSOCIATION'}
,{82,'ABC RV & MINI STORAGE L L C BY PTA LLC SHUR #38017'}
,{83,'ABINGDON ELEMENTARY PTA INC'}
,{84,'ABINGTON PARENT TEACHER ORGANIZATION'}
,{85,'ABRAHAM LINCOLN ELEMENTARY SCHOOL PARENT TEACHER ORGANIZATION'}
,{86,'ABRAHAM LINCOLN ELEMENTARY SCHOOL PTA INC'}
,{87,'ABRAHAM LINCOLN PTA 14'}
,{88,'ABRAMS COMMUNITY PARENT TEACHER ORGANIZATION INC'}
,{89,'ACADEMICS PLUS CHARTER SCHOOL PARENT TEACHER ORGANIZATION INC'}
,{90,'THE ACADEMY AT 5TH AVENUE PTO INC'}
,{91,'ACADEMY P T A LUBBOCK ISD'}
,{92,'ACADEMY PARENT TEACHER ORGANIZATION INCORPORATION (THE)'}
,{93,'ACADEMY PTA LUBBOCK ISD'}
,{94,'ACQUIPORT/AMSDELL I LTD PART PTA AMS #45'}
,{95,'ACTION PTO INC'}
,{96,'ACTON MIDDLE SCHOOL PARENT TEACHER ORGANIZATION P'}
,{97,'ACTON MIDDLE SCHOOL PARENT TEACHER ORGANIZATION (PTO)'}
,{98,'AFTON ELEMENTARY PARENT TEACHER ORGANIZATION'}
,{99,'AGAPE PTA SERVICES'}
,{100,'AGNOR HURT ELEMENTARY SCHOOL PARENT TEACHER ORGANIZATION'}
,{101,'AGS MIDDLE SCHOOL PTO INC'}
,{102,'ASHLAND PTO GRADES K-12'}
,{103,'BARNUM WOODS PTA 10-215'}
,{104,'BEMISS PTA 15.4.35'}
,{105,'BLUE RIDGE PTA 12.6.7'}
]
,BIPV2_Company_Names.layouts.layout_names
);
END;