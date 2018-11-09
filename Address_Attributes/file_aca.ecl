IMPORT ACA, ADDRESS_ATTRIBUTES, ADVO, BIPV2, lib_stringlib.stringlib, RISK_INDICATORS;

//CONSTANTS
STRING CF_absolute := '\\b(?:CORRECTIONAL[ ]CTR|CORRECTIONAL[ ]CENTER|CORRECTIONAL[ ]FAC|CORRECTIONAL[ ]FACILITY|CORRECTIONAL[ ]INST|CORRECTIONAL[ ]INSTITUTE|CORRECTIONAL[ ]INSTITUTION|CORRECTIONS[ ]DEPT|CORRECTIONS[ ]FACILITY|CNTY[ ]CORRECTIONAL|COUNTY[ ]CORRECTIONAL|COUNTY[ ]DETENTION|COUNTY[ ]JAIL|COUNTY[ ]PRISON|DEPT[ ]CORRECTIONS|DEPARTMENT[ ]CORRECTIONS|DEPARTMENT[ ]CORRECT|DETENTION[ ]CTR|DETENTION[ ]CENTER|DETENTION[ ]FACILITY|FED[ ]CORRECTION[ ]INST|FEDERAL[ ]BUREAU[ ]PRISONS|FEDERAL[ ]CORRECTION|GEO[ ]GROUP[ ]INC|MANAGEMENT[ ]AND[ ]TRAINING|PENITENTIARY|PAROLE[ ]OFFICE|POLICE[ ]DEPARTMENT|STATE[ ]CORRECTIONS|STATE[ ]PENITENTIARY|STATE[ ]PENITENTAIRY|STATE[ ]PRISON|STATE[ ]PROBATION|U[ ]S[ ]GOVT[ ]BUREAU[ ]PRISONS|WACKENHUT[ ]CORRECTION|WHCC[ ]FUNSHINE[ ]COMMITTEE|WORK[ ]RELEASE[ ]CTR)\\b';
STRING CF_abslexcl := '\\b(?:ACCIDENT|ACTIVITIESLEAGUE|ADMIN|ADMINISTRAFI|ADMINISTRATIVE|AIRPORT|ANIMAL|ASSOCIATION|AUTO|AUXILAR|AUXILARY|BAIL|BENEFIT|BENEVOLE|BURNS[ ]PIPING|BUSINESS|CHAPLAIN|CID|CITIZEN|CITIZENS|COLLEGE|COMMUNITY|CONSULTANTS|CREDIT|CRIME[ ]PREVENTION|CRIMINAL[ ]BUREAU|CRIMINAL[ ]INVSTGTN|DATA|DAIRY|DETAIL|DETECTIVE|DISPATCH|DRUG[ ]UNIT|EMERGENCY|EMPLOYEES|EVIDENCE|FINANCE|FISCA|FLYING[ ]CLUB|FOUNDATION|FUND|GYM|HONOR[ ]GUARD|IDENTIFICATION|INDUSTRIES|INTELLIGENCE|INTERNAL|INVESTIGATION|INVESTIGATIONS|LICENSES|LITER|LITERACY|MINIST|MINISTR|MINISTRIES|MINISTRY|MUSEU|MUSEUM|NARCOTICS|NONEMERGENCIES|NONEMERGENCY|OFFIC|OFFICER|OFFICERS|OPERATIONS|OTHER|PARKING|PATROL|PAYABLE|PHARMACY|PRINTING|RECORDS|RELIGIOUS|RENOVATIONS|RESERVATION|RESOURCE|RIDERS|SCHOOL|SPRINKLER|SUPPORT|SUPPORTERS|SWAT|SYSTEMS|TATTOOS|TEST|TOTS|TRAFFIC|TRAIN|TRAININ|TRAINING|TRNG|UNIFORM)\\b';
STRING CF_includes := '\\b(?:CORCRAFT|CORR[ ]COMPLEX|CORR[ ]FAC|CORR[ ]FACILITY|CORR[ ]INST|CORRECTIO|CORRECTION|CORRECTIONAL|CORRECTIONL|CORRECTIONS|CORRECTIONSWORK|CRIMINAL|CRRCTNL|DEPTCORRECT|DETENT|DETENTION|DETNTION|GEO[ ]GROUP|HONOR[ ]FARM|JAIL|JUDICIAL|JUSTICE|JUVENILE|MILITARY[ ]AFFAIRS|PAROLE|PENITENTIARY|PREPAROLE|PRIS|PRISON|PRISONS|PROBATION|PUNISHMENT|REFORMATORY|RELEASE[ ]CENTER|SHERIFF|SHERIFFS|COUNTY[ ]SHERIFF|SVCPROBATION|TRANSITIONAL[ ]CTR|VOC[ ]REH|WOMENS[ ]PRISON|YOUTH[ ]COMMISSION)\\b';
STRING CF_excludes := '\\b(?:OUTREACH|INSTITUTE|RACING|ASSN|FOR[ ]JUDGMENT|FOR[ ]ALL|DOMESTIC|BUILDER|STRATEGIES|ACADEMY|ONLINE|LAWN|FOR[ ]COMMUNITY|BEN[ ]FOR|PRIVATE|MNSTRY|SOCIAL|GOLDEN[ ]KEY|COALITION|PINK[ ]JUSTICE|NETWORK|JUSTICE[ ]VICKY|AUTHENTIC|STREET[ ]JUSTICE|ACQUISITIONS|EXETER[ ]6500|RED[ ]SHERIFF|FRIENDS|FURNITURE|RESEARCH|IMPACT|A[ ]C|AARON|ABSOLUTE|ACTION|ACTS|ADHD|ADMINISTRATORS|ADVANCED|ADVOCATES|AFFAIRS|AFFILIATES|AFTERCARE|ALLCARE|ALLEY|ALLIANCE|ALONG|ALPHA|ANGELS|ANTITRUST|APPRAISAL|ARAMARK|ARTS|ASSESSOR|ASSOCIATES|ASSOCIATION|ATTORNEY|AUDIT|AUDITS|AUTO|AUTOMOTIVE|AVIATION|BAIL|BAILBONDS|BAR|BARBELL|BEAUTY|BENEVOLENCE|BEST|BI|BICENTENNIA|BIG[ ]HOUSE|BIOMED|BLESSING|BLUES|BOARD|BOND|BONDING|BONDS|BOOK|BOOKS|BOW|BREWS|BROTHERS|BUSH[ ]IN[ ]PRISON|BYPASS|CABEL|CABLE|CAMPAIGN|CAR|CARE|CARPET|CASHING|CATCH[ ]A|CERTIFIED|CHAPLAINCY|CHAPLAINS|CHECK|CHICANO|CHIEF|CHIROPRACTIC|CHIROPRATIC|CHPNLCY|CHRISTIAN|CIRCUIT|CITIZENS|CLASSIC|CLASS|CLEANING|CLINIC|CLUB|CLUTTER|COACH|COLOR|COMMISARY|COMMUNICATIONS|COMPLETE|COMPUTER|CONCEPTS|CONCERNED|CONCRETE|CONNECTION|CONNECTIONS|CONSTRUCTION|CONSULT|CONSULTANT|CONSULTANTS|CONSULTING|CONTEMPORARY|COORDINATING|CORRECTION[ ]ACADEMY|CORRECTIONS[ ]MGMT|COUNSELING|COUNSELORS|COURSE|COURT|CRAWLSPACE|CREATIVE|CREDIT|CROSSOVER|CULINARY|CURTS|DATA|DEA|DEANN|DEFENDER|DEFENSE|DENTAL|DESIGN|DEVELOPMENT|DIABETES|DIAGNOSTIC|DIALOG|DIALOG|DIGITAL|DOLLARS|DRAINAGE|DWELLING|DYSLEXIA|ECO|EDUCATION|EDUCATIONAL|ELECTRONICS|EMPLOYEE|EMPLOYEES|EMPLYEES|ENTERTAINMENT|ENVIRONMENTAL|ESCAPES|EXECUTIVES|EXPRESS|EXPRESSION|FAITHBASED|FAMILIES|FAMILY|FINANCE|FITNESS|FOR[ ]JUSTICE|FORECLOSURE|FOUNDATION|FREEDOM|FUND|FULLY|GAP|GOOD[ ]NEWS|GOODS|GRATERFRIENDS|GROUP|HANDYMAN|HEALTH|HEALTHCARE|HEALTHSOUTH|HEROS|HIV|HONORABLE|HUMAN[ ]RIGHTS|HOUSE|I[ ]WAS|IAQ|INDUSTRIES|INDUSTRY|INFORMATION|INITIATIVE|INITIATIVES|INNOVATION|INSIGHT|INSPECTION|INTELLIGENCE|INTERFAITH|INTERNATIONAL|INVASION|INVESTOR|ISLAM|JAIL[ ]BUSTERS|JESUS|JMD|JOBS[ ]WITH|JUDGE|JUST[ ]FOR[ ]GIRLS|JUSTICE[ ]FIRESTONE|JUSTICE[ ]LEAGUE|JUSTICE[ ]PROJECT|K[ ]9|K9|KIKIS|KLUTSEY|KRALA|LAW[ ]OFFICE|LEARNING|LIEUTENANTS|LIFE|LIMITED[ ]PARTNERSHIP|LITIGATION|LOVE|LP|MAIL[ ]FROM[ ]JAIL|MAINTENANCE|MANAGEMENT|MATTHEW[ ]JUSTICE|MAXIMUS|MEDICAL|MEDICINE|MINI|MINIST|MINISTERS|MINISTRI|MINISTRIES|MINISTRY|MINISTRYT|MINSTRIES|MINSTRY|MISSION|MISSIONS|MMINISTRIES|MONICA|MOON|MORTGAGE|MOTHERS|MUSCLE|MUSEUM|NATURAL|NEIGHBORS|NEWS|OFFICER|OFFICER[ ]TEST|OFFICERS|OJP|OMBUDSMAN|OMEGA|PAIN|PAL|PARTNERS|PARTNERSHIP|PASSION|PAULY[ ]JAIL|PEACE|PENPAL|PEOPLE|PEOPLES|PERMA|PEST|PHARMACY|PHYSICAL|PIONEER|PIZZA|PRISON[ ]ART|PRISON[ ]CITY|PRO|PROCARE|PROF|PROTECH|PSIMED|PSYCHIATRIC|PUB|PURPOSE|QUALITY|RAPE|RECORDS|REFORM|RELATIVE|RELIGIOUS|REWORKS|RISK[ ]CONTROL|RODEO|SALON|SALOON|SCUBA|SEARCH|SERGEANTS|SERV|SERVICE|SERVICES|SKIN|SOIL|SOLUTIONS|SOUL|SPINAL|SPINE|STAR|STOP|STORE|STORE|STYLE|SUCKS|SUPPLY|SUPPORT|SURETY|SUSAN|SVCS|TALK|TALKS|TAX|TECH|TECHNOLOGIES|TECHNOLOGY|TELECARE|TELECOM|TELEPHONE|THERAPY|THERAPIES|THREADS|TRAINING|TRANSIT|TRANSITION|TRANSPORTATION|TREASURES|TRUCKING|TSHIRT|TT|TURNKEY|UNCLAIMED|UNDERGROUND|UNION|VEHICLE|VENUE|VENUES|VISION|VISIONS|VOCATIONAL|VOICES|WATER|WATERS|WIZARD|WRITE|WRITES|YEARBOOK|YOU)\\b';
STRING CF_city	 	  := '\\b(?:CITY|POLICE)\\b';
STRING CF_county	  := '\\b(?:COUNTY|SHERIFF|SHERIFFS|COUNTY[ ]SHERIFF)\\b';
STRING CF_state		  := '\\b(?:STATE|AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)\\b';
STRING CF_federal	 := '\\b(?:FEDERAL|US)\\b';
STRING CF_parole	  := '\\b(?:PAROLE|PROBATION)\\b';
STRING CF_correct	 := '\\b(?:CORRECT|CORRECTION|CORRECTIONAL|CORRECTIONS|PRISON|PRISONS|PENITENTIARY)\\b';

//RAW DATA
rScraped := RECORD
	STRING Complex_Name;
	STRING Facility_Name;
	STRING Facility_address_Line_1;
	STRING Facility_Address_Line_2;
	STRING City;
	STRING State;
	STRING Zip;
	STRING Phone;
END;
scraped := DATASET('~thor_data400::in::aca::correctional_facilities_scraped',rScraped,CSV(HEADING(1)));

uslec := Address_Attributes.file_Law_Enforcement;
inBIP := BIPV2.CommonBase.DS_PROD(source IN ['Q3','ER','BR','DF'] AND current = TRUE AND prim_name <> '' AND zip <> ''); 
ADVO_base := PULL(ADVO.key_addr1(prim_name <> '' AND prim_range <> '' AND zip <> ''));

//CLEAN SCRAPED FILE
rDataIn := RECORD
	STRING Complex_Name;
	STRING Facility_Name;
	STRING Phone;
	STRING10 	prim_range;
	STRING2  	predir;
	STRING28 	prim_name;
	STRING4  	addr_suffix;
	STRING2  	postdir;
	STRING10 	unit_desig;
	STRING8  	sec_range;
	STRING25		p_city_name;
	STRING25		v_city_name;
	STRING2  	st;
	STRING5  	zip;
	STRING4  	zip4;
	STRING10 	geo_lat;
	STRING11 	geo_long;
	STRING7		geo_blk;
	STRING5		county;
	STRING4  	msa;
	STRING1		geo_match;
	STRING12	geolink;
	STRING rc;
END;


rDataIn cleanScraped(scraped l) := TRANSFORM
	clean_address := Risk_Indicators.MOD_AddressClean.clean_addr(l.Facility_address_Line_1 + ' ' + l.Facility_Address_Line_2, l.city, l.state, l.zip);
				SELF.prim_range := clean_address [1..10];
				SELF.predir := clean_address [11..12];
				SELF.prim_name := clean_address [13..40];
				SELF.addr_suffix := clean_address [41..44];
				SELF.postdir := clean_address [45..46];
				SELF.unit_desig := clean_address [47..56];
				SELF.sec_range := clean_address [57..64];
				SELF.p_city_name := clean_address [65..89];
				SELF.v_city_name := clean_address [90..114];
				SELF.st := clean_address [115..116];
				SELF.zip := clean_address [117..121];
				SELF.zip4 := clean_address[122..125];
				SELF.county := clean_address[143..145];
				SELF.geo_lat := clean_address[146..155];
				SELF.geo_long := clean_address[156..166];
				SELF.msa := clean_address[167..170];
				SELF.geo_blk := clean_address[171..177];
				SELF.geo_match := clean_address[178];
				SELF.geolink 		:= clean_address[115..116]+clean_address[143..145]+clean_address[171..177];
			SELF.rc := '99';
			SELF := l;
END;
clean_scraped := DEDUP(SORT(PROJECT(scraped, cleanScraped(LEFT)),prim_name, prim_range, zip, sec_range),prim_name, prim_range, zip, sec_range);

//SLIM USLEC
rDataIn slimUSLEC(uslec l) := TRANSFORM
	SELF.Complex_Name := TRIM(stringlib.StringToUpperCase(l.Department_Description));
	SELF.Facility_Name := TRIM(stringlib.StringToUpperCase(l.Department_Name));
	SELF.addr_suffix := l.suffix;
	SELF.v_city_name := l.p_city_name;
	SELF.rc := '98';
	SELF := l;
	SELF := [];
END;

cleaned_uslec := DEDUP(SORT(PROJECT(uslec, slimUSLEC(LEFT)),prim_name, prim_range, zip, sec_range),prim_name, prim_range, zip, sec_range);

types := ['ADULT INSTITUTIONS','ALLENWOOD FEDERAL CORRECTIONAL COMPLEX','BEAUMONT FEDERAL CORRECTIONAL COMPLEX','BUTNER FEDERAL CORRECTIONAL COMPLEX','CITY SHERIFFS ','COLEMAN FEDERAL CORRECTIONAL COMPLEX','COUNTY JAILS','COUNTY JAILS (COVERED BY SHERIFF)','COUNTY POLICE DEPARTMENTS ','FEDERAL BUREAU OF PRISONS ','FEDERAL CORRECTIONAL INSTITUTIONS','FLORENCE FEDERAL CORRECTIONAL COMPLEX','FORREST CITY FEDERAL CORRECTIONAL COMPLEX','HAZELTON FEDERAL CORRECTIONAL COMPLEX','LOMPOC FEDERAL CORRECTIONAL COMPLEX','OAKDALE FEDERAL CORRECTIONAL COMPLEX','PETERSBURG FEDERAL CORRECTIONAL COMPLEX','POLICE DEPARTMENTS','POLLOCK FEDERAL CORRECTIONAL COMPLEX','SHERIFFS DEPARTMENTS','TERRE HAUTE FEDERAL CORRECTIONAL COMPLEX','TUCSON FEDERAL CORRECTIONAL COMPLEX','VICTORVILLE FEDERAL CORRECTIONAL COMPLEX','YAZOO CITY FEDERAL CORRECTIONAL COMPLEX'];
cleaned_internal := clean_scraped + cleaned_uslec(complex_name IN types);

//PROJECT INTERNAL DATA INTO FULL LAYOUT
rFinal := RECORD
		STRING5  zip;
		STRING10 prim_range;
		STRING28 prim_name;
		STRING4  addr_suffix;
		STRING2  predir;
		STRING2  postdir;
		STRING5  unit_desig;
		STRING8  sec_range;
		STRING25		p_city_name;
		STRING25		v_city_name;
		STRING2  st;
		STRING4  zip4;
		UNSIGNED6 aid;
		STRING7	 	geo_blk;
		STRING13	geolink;
		STRING7		streetlink;
		STRING3		county;
		STRING4		msa;
		QSTRING10	geo_lat;
		QSTRING11	geo_long;	
		UNSIGNED4	dt_first_seen;
		UNSIGNED4	dt_last_seen;
		STRING2		source;
		BOOLEAN		current;
		STRING6		cnp_status;
		UNSIGNED6	powid;
		STRING250 cnp_name;
		STRING10  cnp_phone;
		STRING9 	cnp_fein;
		STRING60	company_org_structure_derived;	
		STRING4	rc;
		STRING10	inst_class;
		STRING10	inst_type;
		BOOLEAN prison := FALSE;
		BOOLEAN parole := FALSE;
		BOOLEAN nis := FALSE;
		BOOLEAN inc_srv := FALSE;
		BOOLEAN includes := FALSE;
		BOOLEAN excludes := FALSE;
		BOOLEAN absolute := FALSE;
		BOOLEAN pri_sic := FALSE;
		BOOLEAN pri_naics := FALSE;
		BOOLEAN par_sic := FALSE;
		BOOLEAN par_naics := FALSE;
		BOOLEAN po_box := FALSE;
	//ADVO address attributes
		STRING1  addr_type;
		INTEGER4 biz_use;
		INTEGER4 vacant;
		INTEGER4 dnd;
		INTEGER4 rural;
		INTEGER4 owgm;
		INTEGER4 drop;
		INTEGER4 deliverable;
		INTEGER4 undel_sec;
		STRING6 naics1;
		STRING6 naics2;
		STRING6 naics3;
		STRING6 naics4;
		STRING6 naics5;
		STRING6 sic1;
		STRING6 sic2;
		STRING6 sic3;
		STRING6 sic4;
		STRING6 sic5;
	END;


rFinal xFormInt(cleaned_internal l) := TRANSFORM
	SELF.aid := HASH(l.zip+l.prim_range+l.prim_name+l.predir+l.postdir+l.sec_range+l.zip4);
	SELF.cnp_name := l.facility_name;
	SELF.rc := l.rc;//INDICATES HARD CODED TRUE POSITIVE
	SELF.inst_class := MAP(l.complex_name[1] = 'A' => 'MUNICIPAL',
																								l.complex_name[1] = 'B' => 'COUNTY',
																								REGEXFIND(CF_federal, stringlib.StringToUpperCase(l.complex_name)) => 'FEDERAL','OTHER');
	SELF := l;
	SELF := [];
END;

int_src := PROJECT(cleaned_internal(TRIM(prim_name) <> ''), xFormInt(LEFT));

//ADD ADVO TO BIPV2 AND APPLY ACA FILTERING
rFinal addAdvo(inBIP l, ADVO_base r) := TRANSFORM	
	SELF.zip 				 					:= l.zip;
	SELF.prim_range  		:= l.prim_range;
	SELF.prim_name 	 		:= l.prim_name;
	SELF.addr_suffix 		:= l.addr_suffix;
	SELF.predir 		 				:= l.predir;
	SELF.postdir 		 			:= l.postdir;
	SELF.unit_desig  		:= l.unit_desig;
	SELF.sec_range 	 		:= l.sec_range;
	SELF.streetlink  		:= l.zip + l.zip4[1..2];
	SELF.geolink 		 			:= l.st + l.fips_county + l.geo_blk;
	SELF.st 		 		 					:= l.st;
	SELF.zip4 		   				:= l.zip4;
	SELF.geo_blk 		 			:= l.geo_blk;
	SELF.county 		 				:= l.fips_county;
	SELF.msa 		 		 				:= l.msa;
	SELF.geo_lat 		 			:= l.geo_lat;
	SELF.geo_long 	 			:= l.geo_long;	
	SELF.dt_first_seen := l.dt_first_seen;
	SELF.dt_last_seen  := l.dt_last_seen;
	SELF.current	 	 			:= l.current;
	SELF.cnp_status	 		:= l.company_status_derived;
	SELF.cnp_name		 			:= stringlib.StringToUpperCase(l.cnp_name);
	SELF.cnp_fein		 			:= l.company_fein;
	SELF.cnp_phone	 			:= l.company_phone;
	SELF.POWID 		 	 			:= l.POWID;
	SELF.aid := HASH(l.zip+l.prim_range+l.prim_name+l.predir+l.postdir+l.sec_range+l.zip4);
	SELF.company_org_structure_derived := l.company_org_structure_derived;
	
	SELF.pri_sic 	 := l.company_sic_code1 = '9223';
	SELF.pri_naics := l.company_naics_code1 = '922140';
	
	pris := MAP(l.company_naics_code1 = '922140' OR l.company_sic_code1 = '9223' => TRUE,
													l.company_naics_code2 = '922140' OR l.company_sic_code2 = '9223' => TRUE,
													l.company_naics_code3 = '922140' OR l.company_sic_code3 = '9223' => TRUE,
													l.company_naics_code4 = '922140' OR l.company_sic_code4 = '9223' => TRUE,
													l.company_naics_code5 = '922140' OR l.company_sic_code5 = '9223' => TRUE,FALSE);
	SELF.prison := pris;

	SELF.par_sic 	 := l.company_sic_code1 = '8322';
	SELF.par_naics := l.company_naics_code1 = '922150';	
	
	paro := MAP(l.company_naics_code1 = '922150' OR l.company_sic_code1 = '8322' => TRUE,
													l.company_naics_code2 = '922150' OR l.company_sic_code2 = '8322' => TRUE,
													l.company_naics_code3 = '922150' OR l.company_sic_code3 = '8322' => TRUE,
													l.company_naics_code4 = '922150' OR l.company_sic_code4 = '8322' => TRUE,
													l.company_naics_code5 = '922150' OR l.company_sic_code5 = '8322' => TRUE,
													REGEXFIND(CF_parole, stringlib.StringToUpperCase(l.cnp_name)) 	 	=> TRUE,FALSE);
	SELF.parole := paro;
	
	nis1 := MAP(l.company_naics_code1[1..5] IN ['49111','54111','54119','54199'] OR l.company_sic_code1 IN ['8111','7380','8741','8741','8742','8744'] => TRUE,
													l.company_naics_code2[1..5] IN ['49111','54111','54119','54199'] OR l.company_sic_code2 IN ['8111','7380','8741','8741','8742','8744'] => TRUE,
													l.company_naics_code3[1..5] IN ['49111','54111','54119','54199'] OR l.company_sic_code3 IN ['8111','7380','8741','8741','8742','8744'] => TRUE,
													l.company_naics_code4[1..5] IN ['49111','54111','54119','54199'] OR l.company_sic_code4 IN ['8111','7380','8741','8741','8742','8744'] => TRUE,
													l.company_naics_code5[1..5] IN ['49111','54111','54119','54199'] OR l.company_sic_code5 IN ['8111','7380','8741','8741','8742','8744'] => TRUE,
																																																						REGEXFIND(Address_Attributes.constants.NIS_includes, stringlib.StringToUpperCase(l.cnp_name)) => TRUE,FALSE);
	SELF.nis := nis1;
	
	nis2 := MAP(l.prim_range = '2711' AND l.prim_name = 'CENTERVILLE' AND l.zip = '19808' AND l.sec_range = '400' => TRUE,
													l.prim_range = '1209' AND l.prim_name = 'ORANGE' AND l.predir = 'N' AND l.zip = '19801' 										=> TRUE,
													l.prim_range = '390'  AND l.prim_name = 'ORANGE' AND l.predir = 'N' AND l.zip = '32801' 										=> TRUE,
													l.prim_range = '3500' AND l.prim_name = 'DUPONT' AND l.predir = 'S' AND l.zip = '19901' 										=> TRUE,
													l.prim_range = '1999' AND l.prim_name = 'BRYAN'  AND l.zip = '75201' AND l.sec_range = '900' 		  	=> TRUE,
													l.prim_range = '3411' AND l.prim_name = 'SILVERSIDE' AND l.zip = '19810' AND l.sec_range = '104'  => TRUE,
													l.prim_range = '16192'AND l.prim_name = 'COASTAL' AND l.zip = '19958' 																												=> TRUE,
													l.prim_range = '111'  AND l.prim_name = '8TH' AND l.zip = '10011' 															 																=> TRUE,
													l.prim_range = '900'  AND l.prim_name = 'CHAPEL' AND l.zip = '06510' 														  													=> TRUE,FALSE);  
	SELF.inc_srv := nis2;
	
//RULES
	incl := REGEXFIND(CF_includes, stringlib.StringToUpperCase(l.cnp_name));
	excl := REGEXFIND(CF_excludes, stringlib.StringToUpperCase(l.cnp_name));
	absl := REGEXFIND(CF_absolute, stringlib.StringToUpperCase(l.cnp_name)) AND NOT REGEXFIND(CF_abslexcl, stringlib.StringToUpperCase(l.cnp_name));
	SELF.includes := incl;
	SELF.excludes := excl;
	SELF.absolute := absl;
	namx := TRIM(l.cnp_name) IN ['JUSTICE','JAIL'];
	secr := TRIM(l.sec_range) <> '';
	pobx := l.prim_name[1..6] = 'PO BOX';
	SELF.po_box := pobx;
	smfd := r.address_type IN ['1','2'];
	delv := TRIM(r.address_type) <> '';
	busi := r.residential_or_business_ind IN ['B','C','D'];
	
	 quant_aca := MAP(namx => '10',
										absl AND (l.company_naics_code1 = '922140' OR l.company_sic_code1 = '9223') => '90',
										absl AND pris => '80',
										absl AND NOT nis1 AND NOT nis2 AND busi => '80',
										(l.company_naics_code1 = '922140' OR l.company_sic_code1 = '9223') AND incl AND NOT excl AND NOT nis1 AND NOT nis2 => '70',
										pris AND incl AND NOT excl AND NOT nis1 AND NOT nis2 => '60',
										(l.company_naics_code1 = '922150' OR l.company_sic_code1 = '8322') AND incl AND NOT excl AND NOT nis1 AND NOT nis2 => '50',
										paro AND incl AND NOT excl AND NOT nis1 AND NOT nis2 => '40',
										incl AND NOT excl AND NOT nis1 AND NOT nis2 AND busi => '30',
										incl AND NOT excl AND NOT nis1 AND NOT nis2 AND smfd => '20', '00'); 
	
	SELF.rc := quant_aca;

	SELF.inst_class := MAP(REGEXFIND(CF_city,    stringlib.StringToUpperCase(l.cnp_name)) AND quant_aca NOT IN ['10','00'] => 'MUNICIPAL',
																								REGEXFIND(CF_county,  stringlib.StringToUpperCase(l.cnp_name)) AND quant_aca NOT IN ['10','00'] => 'COUNTY',
																								REGEXFIND(CF_state,   stringlib.StringToUpperCase(l.cnp_name)) AND quant_aca NOT IN ['10','00'] => 'STATE',
																								REGEXFIND(CF_federal, stringlib.StringToUpperCase(l.cnp_name)) AND quant_aca NOT IN ['10','00'] => 'FEDERAL',
																																																																																																																											'OTHER');
												
	SELF.inst_type := MAP(REGEXFIND(CF_correct, stringlib.StringToUpperCase(l.cnp_name)) AND quant_aca IN ['90','80','70','60'] => 'INCARC',
																							REGEXFIND(CF_parole,  stringlib.StringToUpperCase(l.cnp_name)) AND quant_aca IN ['50','40'] 				  				=> 'PAROLE',
																																																																																																																																'OTHER');											
	
	SELF.naics1 := l.company_naics_code1;
	SELF.naics2 := l.company_naics_code2;
	SELF.naics3 := l.company_naics_code3;
	SELF.naics4 := l.company_naics_code4;
	SELF.naics5 := l.company_naics_code5;
	SELF.sic1 := l.company_sic_code1;
	SELF.sic2 := l.company_sic_code2;
	SELF.sic3 := l.company_sic_code3;
	SELF.sic4 := l.company_sic_code4;
	SELF.sic5 := l.company_sic_code5;								
	SELF.addr_type	 := r.address_type;
	SELF.biz_use 		 := IF(r.residential_or_business_ind IN ['B','C','D'], 1, 0);
 SELF.dnd 				  	:= IF(r.dnd_indicator = 'Y', 1, 0);
	SELF.vacant			 	:= IF(r.Address_Vacancy_Indicator = 'Y', 1, 0);
	SELF.rural  				:= IF(r.address_style_flag = 'S', 1, 0);
 SELF.owgm 			  	:= IF(r.owgm_indicator = 'Y', 1, 0);
 SELF.drop			 	  := IF(r.drop_indicator IN ['C','Y'] OR r.address_type = '9', 1, 0);
	SELF.deliverable:= IF(r.address_type <> '', 1, 0);
	SELF.undel_sec	 := IF(l.sec_range <> '' AND r.address_type = '', 1, 0);	

	SELF := l;
	SELF := [];
END;
													
with_ADVO := JOIN(inBIP, ADVO_base,
		LEFT.zip 								= RIGHT.zip AND
		LEFT.prim_range 	= RIGHT.prim_range AND
		LEFT.prim_name 		= RIGHT.prim_name AND
		LEFT.addr_suffix = RIGHT.addr_suffix AND
		LEFT.predir 					= RIGHT.predir AND
		LEFT.postdir					= RIGHT.postdir AND
		LEFT.sec_range 		= RIGHT.sec_range,
	addADVO(LEFT, RIGHT),LEFT OUTER,HASH);

//KEEP THE HIGHEST SCORING POWID	
ACA_poc := DEDUP(SORT(with_ADVO(rc > '60'), powid, -rc, -dt_last_seen), powid);
		
final := DEDUP(SORT(ACA_poc + int_src, aid, -rc, -dt_last_seen), aid);

EXPORT file_aca := final;