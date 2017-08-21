export Phones := MODULE

shared	phone_type := ['PHONE','Phone'];
// do not look here ['PHONE','Phone','OtherInformation','OtherInformation2','AltAddress','CONTACT'];
shared phone_only := ['PHONE','Phone'];

string TrimRight(string s) := TRIM(REGEXREPLACE('[ (.,+;?*&:#%"\'/\\\\-]+$',s,''),LEFT,RIGHT);
export GetPhone(string rtype, string info) := TrimRight(
	MAP(
		rtype not in phone_type => '',
		REGEXFIND('^[+]*[0-9() .-]+',info,NOCASE) AND rtype in phone_only => REGEXFIND('([+]*[0-9() .-]+)',info,1,NOCASE),
		REGEXFIND('^([+]*[0-9() +-]+)[,./]* *[0-9A-Z]*',info,NOCASE) AND rtype in phone_only
								=> REGEXFIND('^([+]*[0-9() +-]+)',info,1,NOCASE),
		REGEXFIND('\\bPHONE:?',info,NOCASE) => REGEXFIND('\\bPHONE:? *([0-9() +.-]+)',info,1,NOCASE),
		REGEXFIND('\\bTELECOPIEUR:?',info,NOCASE) => REGEXFIND('\\bTELECOPIEUR:? *([0-9() +-]+)',info,1,NOCASE),
		REGEXFIND('\\bTELEPHONE:?',info,NOCASE) => REGEXFIND('\\bTELEPHONE:? *([0-9() +-]+)',info,1,NOCASE),
		REGEXFIND('\\bTELEFONO:?',info,NOCASE) => REGEXFIND('\\bTELEFONO:? *([0-9() +-]+)',info,1,NOCASE),
		REGEXFIND('\\bTFNO\\.?:?',info,NOCASE) => REGEXFIND('\\bTFNO\\.?:? *([0-9() +-]+)',info,1,NOCASE),
		REGEXFIND('\\bn\\. o de telefono\\.?:?',info,NOCASE) => REGEXFIND('\\bn\\. o de telefono: *([0-9() +-]+)',info,1,NOCASE),
		REGEXFIND('\\bTel\\.?:?',info,NOCASE) => REGEXFIND('\\bTel\\.?:? *([+]*[0-9() .-]+)',info,1,NOCASE),
		REGEXFIND('\\b(Mobile|Movil):?',info,NOCASE) => REGEXFIND('\\b(Mobile|Movil):? *(\\+? *[0-9(][0-9() -]+)',info,2,NOCASE),
		REGEXFIND('\\bAlt\\.?',info,NOCASE) => REGEXFIND('\\bAlt\\.?:? *([0-9() +-]+)',info,1,NOCASE),
		REGEXFIND('\\bCentralita\\.?',info,NOCASE) => REGEXFIND('\\bCentralita:? *([0-9() +-]+)',info,1,NOCASE),
		REGEXFIND('\\bFax No\\.?:?',info,NOCASE) => REGEXFIND('\\bFax No\\.?:? *([0-9() +-]+)',info,1,NOCASE),
		REGEXFIND('\\bFax at',info,NOCASE) => REGEXFIND('\\bFax at +([0-9() +-]+)',info,1,NOCASE),
		REGEXFIND('\\(Fax\\) [A-Z/.]+ ',info,NOCASE) => REGEXFIND('\\(Fax\\) [A-Z/.]+ ([+]*[0-9() -]+)',info,1,NOCASE),
		REGEXFIND('\\(Fax\\)/[0-9]+',info,NOCASE) => REGEXFIND('\\(Fax\\)/([0-9]+)',info,1,NOCASE),
		REGEXFIND('[0-9-]+ *\\(Fax\\)',info,NOCASE) => REGEXFIND('([0-9-]+) *\\(Fax\\)',info,1,NOCASE),
		REGEXFIND('\\bFax[.)]?:?',info,NOCASE) => REGEXFIND('\\bFax[.)]?:? *([0-9() +-]+)',info,1,NOCASE),
		REGEXFIND('\\b(TELEX|TLX):?',info,NOCASE) => REGEXFIND('\\b(TELEX|TLX):? *([0-9() +-]+)',info,2,NOCASE),
		//rtype in phone_only => info,	// always take the phone
	''));
	
/*Phone Type Enumerations
    Business,
    Cell,
    Fax,
    Home,
    Work,
    Unknown*/
export GetPhoneType(string rtype, string info) := TRIM(
	MAP(
		rtype not in phone_type => '',
		REGEXFIND('^([0-9() +-]+)$',info,NOCASE) => 'Unknown',
		REGEXFIND('^([0-9() +-]+)[,./]* *[0-9A-Z]*',info,NOCASE) => 'Unknown',
		REGEXFIND('\\bPHONE:?',info,NOCASE) => 'Unknown',
		REGEXFIND('\\bTELECOPIEUR:?',info,NOCASE) => 'Unknown',
		REGEXFIND('\\bTELEPHONE:?',info,NOCASE) => 'Unknown',
		REGEXFIND('\\bTFNO\\.?:?',info,NOCASE) => 'Unknown',
		REGEXFIND('\\bTel\\.?:?',info,NOCASE) => 'Unknown',
		REGEXFIND('\\b(Mobile|Movil):?',info,NOCASE) => 'Cell',
		REGEXFIND('\\bAlt\\.?',info,NOCASE) => 'Unknown',
		REGEXFIND('\\bFax\\.?:?',info,NOCASE) => 'Fax',
		REGEXFIND('\\bFax No\\.?:?',info,NOCASE) => 'Fax',
		REGEXFIND('\\(Fax\\) [A-Z/.]+ ',info,NOCASE) => 'Fax',
		REGEXFIND('\\(Fax\\)/[0-9]+',info,NOCASE) => 'Fax',
		REGEXFIND('[0-9-]+ *\\(Fax\\)',info,NOCASE) => 'Fax',
		REGEXFIND('\\b(TELEX|TLX):?',info,NOCASE) => 'Unknown',
	'Unknown'),LEFT,RIGHT);


END;