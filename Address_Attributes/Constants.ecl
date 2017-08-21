import ut,std;

export Constants := module
	export todayStr   := (STRING8)Std.Date.Today();
	export today1900  := ut.DaysSince1900( todayStr[1..4], todayStr[5..6], todayStr[7..8] );
	export today      := (unsigned4)todayStr;
	export todayMinus( integer days ) := (unsigned4)ut.DateFrom_DaysSince1900(today1900 - days );
	export oneYrAgo   := (unsigned4)ut.DateFrom_DaysSince1900(today1900 - ut.DaysInNYears(1));
	export twoYrAgo   := (unsigned4)ut.DateFrom_DaysSince1900(today1900 - ut.DaysInNYears(2));
	export threeYrAgo := (unsigned4)ut.DateFrom_DaysSince1900(today1900 - ut.DaysInNYears(3));
	export fourYrAgo  := (unsigned4)ut.DateFrom_DaysSince1900(today1900 - ut.DaysInNYears(4));
	export fiveYrAgo  := (unsigned4)ut.DateFrom_DaysSince1900(today1900 - ut.DaysInNYears(5));
	export sixYrAgo   := (unsigned4)ut.DateFrom_DaysSince1900(today1900 - ut.DaysInNYears(6));
	export sixtyYrAgo := (unsigned4)ut.DateFrom_DaysSince1900(today1900 - ut.DaysInNYears(60));
	export YearsAgo(integer1 y)   := (unsigned4)ut.DateFrom_DaysSince1900(today1900 - ut.DaysInNYears(y));
	export boolean isCurrent( unsigned4 dt_last_seen ) := ut.DaysApart( (string8)dt_last_seen, todayStr ) < 180;
	export boolean isCurrent90( unsigned4 dt_last_seen ) := ut.DaysApart( (string8)dt_last_seen, todayStr ) < 90;
	//PARSE CRITERIA
	EXPORT	STRING NIS_includes 		:= '\\b(?:CORP[ ]SERVICES|CORPORATE[ ]SERVICES|INCORPORATION[ ]SERVICE|INCORPORATION[ ]SYSTEMS|HARVARD[ ]BUSINESS[ ]SERVICES|EXCELSIOR[ ]LEGAL[ ]INC|LEGALZOOM.COM|ALCO[ ]CORP[ ]SERVICES|HARVARD[ ]BUINESS[ ]SERVICES,[ ]INC.|HARVARD[ ]BUSINESS[ ]SERVICE|HARVARD[ ]BUSINESS[ ]SERVICES|HARVARD[ ]BUSINESS[ ]SERVICES[ ]INC)\\b';
	EXPORT	STRING CRDRPR_includes 	:= '\\b(?:CREDIT[ ]REPAIR|SKY[ ]BLUE[ ]SOLUTIONS|LEXINGTON[ ]LAW|OVATION[ ]CREDIT|CREDIT[ ]FIXERS|CREDIT[ ]SOLUTIONS|CREDIT[ ]SERVICES|MY[ ]CREDIT[ ]GROUP)\\b';
	EXPORT	STRING bank_includes 		:= '\\b(?:BANK)\\b';
	EXPORT	STRING virtual_includes := '\\b(?:DAVINCI[ ]VIRTUAL|OFFICE[ ]SPACE|SERVCORP|VIRTUALOFFICE|ALLIED[ ]OFFICES|INTELLIGENT[ ]OFFICES|SYNERGY[ ]BUSINESS[ ]CENTRES|THE[ ]VIRTUAL[ ]OFFICE|PREMIER[ ]BUSINESS[ ]CENTERS|BLUE[ ]SKY[ ]SOLUTIONS|CONTESSA[ ]COURT[ ]VIRTUAL)\\b';
	EXPORT	STRING remail_includes 	:= '\\b(?:EARTH[ ]CLASS[ ]MAIL|ARAMEX|USA2ME|MAILBOX|UPS[ ]STORE|REGUS|TRAVELING[ ]MAILBOX|MAIL[ ]BOXES|MAIL[ ]BOX|MAILBOXES[ ]ETC|ACCESS[ ]USA[ ]SHIPPING|WORLD[ ]ADDRESS|OPAS|USAMAIL1|USA[ ]MAIL1|MYUS.COM|MYUS|ADDRESS[ ]N[ ]MAIL|ADDRESSNMAIL|COASTAL[ ]POSTAL|GLOBAL[ ]MAILING[ ]SERVICE|HOMEBASE[ ]OREGON|USABOX|USABOX.COM|INTERNATIONAL[ ]MAIL[ ]FORWARDING|POSTAL[ ]DEPOT|PRIVATE[ ]BOX|SUPER[ ]POSTAL|BONGOUS|BONGO[ ]INTERNATIONAL|BORDERLINX|PUNTO[ ]MIO|PUNTOMIO|EASTBIZ|SHIPITO|TRANSEXPRESS|VIABOX)\\b';
	EXPORT	aml_sics := ['6099','7011','7993','7999','6082','6081','4731','4731','7389','5932','3151'];
	EXPORT	storage_sic := ['4200','4214','4220','4221','4222','4225','4226','4789','4230','4231','4400','4410','4412','4440','4449','4491','4493'];
	EXPORT	storage_naics := ['484110','484210','484220','493190','531130'];
end;