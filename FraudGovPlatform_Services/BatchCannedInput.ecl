IMPORT FraudShared_Services;

/*
** Complete Record Layout for cut/paste at end of file
*/

FraudShared_Services.Layouts.BatchIn_rec rec0001() := TRANSFORM
	SELF.acctno := 'rec0001';
  SELF.ssn := '594582882';
  SELF.phoneno := '8134170993';
  SELF := [];
END;

FraudShared_Services.Layouts.BatchIn_rec rec0002() := TRANSFORM
	SELF.acctno := 'rec0002';
  SELF.ssn := '766074691';
  SELF := [];
END;

FraudShared_Services.Layouts.BatchIn_rec rec0003() := TRANSFORM
	SELF.acctno := 'rec0003';
  SELF.email_address := 'JOHNSMITH@GMAIL.COM';
  SELF := [];
END;

FraudShared_Services.Layouts.BatchIn_rec rec0004() := TRANSFORM
	SELF.acctno := 'rec0004';
  SELF.ssn := '429702308';
  SELF.did := 214017106;
  SELF.name_first := 'TOLIVER';
  SELF.name_last := 'BLACKMON';
  SELF.addr := 'PO BOX 63 NEW EDINBURG AR';
  SELF.z5 := '71660';
  SELF.phoneno := '4079272391';
	SELF.ip_address := '216.3.128.12';
  SELF.geo_lat := '28.503122';
  SELF.geo_long := '-81.409521';
  SELF := [];
END;

FraudShared_Services.Layouts.BatchIn_rec rec0005() := TRANSFORM
	SELF.acctno := 'rec0005';
  SELF.ssn := '101600931';
  SELF.did := 15000000000013;
  SELF.name_first := 'BARBARA';
  SELF.name_last := 'ALLEN';
  SELF.addr := '121 FOXMOOR CT';
  SELF.st := 'FL';
  SELF.z5 := '33844';
  SELF.phoneno := '4079272391';
	SELF.ip_address := '216.3.128.12';
  SELF.geo_lat := '28.503122';
  SELF.geo_long := '-81.409521';
  SELF := [];
END;

FraudShared_Services.Layouts.BatchIn_rec rec0006() := TRANSFORM
	SELF.acctno := 'rec0006';
  SELF.ssn := '594582882';
  SELF.name_first := 'SERGIO';
  SELF.name_middle := 'A';
  SELF.name_last := 'GUERRA';
  SELF.addr := '8104 NW 100TH WAY';
  SELF.p_city_name := 'MIAMI';
  SELF.st := 'FL';
  SELF.phoneno := '3055252464';
	 SELF.ip_address := '216.3.128.12';
  SELF.geo_lat := '28.503122';
  SELF.geo_long := '-81.409521';
  SELF := [];
END;

FraudShared_Services.Layouts.BatchIn_rec rec0007() := TRANSFORM
	SELF.acctno := 'rec0007';
  SELF.ssn := '594582882';
  SELF.name_first := 'KRISTIE';
  SELF.name_middle := 'DEANN';
  SELF.name_last := 'COLEMANWHITE';
  SELF.addr := '4088 BURNING TREE DRIVE APT 511';
  SELF.p_city_name := 'DORAL';
  SELF.st := 'FL';
  SELF.phoneno := '445825352';
	SELF.ip_address := '216.3.128.12';
  SELF.geo_lat := '28.503122';
  SELF.geo_long := '-81.409521';
  SELF := [];
END;

FraudShared_Services.Layouts.BatchIn_rec rec0008() := TRANSFORM
SELF.acctno := 'rec0008';
  SELF.ssn := '402822218';
  SELF.name_first := 'JUDITH';
  SELF.name_middle := 'ELIZABETH';
  SELF.name_last := 'SALCH';
  SELF.addr := '362 LAKE MONTERAY CIR';
  SELF.p_city_name := 'ORLANDO';
  SELF.st := 'FL';
  SELF.phoneno := '4079272391';
 	SELF.ip_address := '216.3.128.12';
  SELF.geo_lat := '28.503122';
  SELF.geo_long := '-81.409521';
  SELF := [];
END;

FraudShared_Services.Layouts.BatchIn_rec rec0009() := TRANSFORM
SELF.acctno := 'rec0009';
  SELF.name_first := 'ABDUL';
  SELF.name_last := 'BAQI';
  SELF := [];
END;

FraudShared_Services.Layouts.BatchIn_rec rec00010() := TRANSFORM
	SELF.acctno := 'rec00010';
	SELF.name_first := 'Richard';
	SELF.name_last := 'Biroc';
	SELF.did := 19;
  SELF := [];
END;


FraudShared_Services.Layouts.BatchIn_rec rec00011() := TRANSFORM
	SELF.acctno := 'rec00011';
  SELF.ssn := '594582882';
  SELF.name_first := 'magdalena';
  SELF.name_last := 'rivera marsh';
  SELF.addr := '8104 NW 100th WAY';
	SELF.p_city_name := 'miami';
  SELF.st := 'FL';
  SELF.z5 := '33186';
  SELF.phoneno := '3055252464';
	SELF.ip_address := '216.3.128.12';
  SELF.geo_lat := '25.681580';
  SELF.geo_long := '-80.395890';
  SELF := [];
END;

FraudShared_Services.Layouts.BatchIn_rec rec00012() := TRANSFORM
	SELF.acctno := 'rec00012';
  SELF.ssn := '594715761';
	// SELF.did := 102648498593;
  SELF.name_first := 'EDGARDO';
  SELF.name_last := 'BRIGHAM';
  SELF.addr := '813 POPLAR ST';
	SELF.p_city_name := 'MOUNT DORA';
  SELF.st := 'FL';
  SELF.z5 := '32757';
  SELF.phoneno := '3523087852';
	SELF.ip_address := '216.3.128.12';
  SELF := [];
END;

FraudShared_Services.Layouts.BatchIn_rec rec00013() := TRANSFORM
	SELF.acctno := 'rec00013';
  SELF.ssn := '567159036 ';
  SELF := [];
END;

FraudShared_Services.Layouts.BatchIn_rec rec00014() := TRANSFORM
	SELF.acctno := 'rec0014_multiple-KF';
  SELF.ssn := '680183022';
  SELF.name_first := 'WOLFGANG';
  SELF.name_last := 'TREMBLET';
  SELF.addr := '5035 BOWMAN PARK PT';
	SELF.p_city_name := 'NAPLES';
  SELF.st := 'FL';
  SELF.z5 := '34112';
  SELF.phoneno := '3059620758';
	SELF.email_address := 'CHELM17@WALMART.COM';
	SELF.ip_address := '216.3.49.28';	
  SELF := [];
END;

FraudShared_Services.Layouts.BatchIn_rec rec00015() := TRANSFORM
	SELF.acctno := 'rec0015_multiple-KF-Velocity';
  SELF.ssn := '227585650';
  SELF.name_first := 'JORGE';
  SELF.name_last := 'CHARLES';
  SELF.addr := '6608 NEWPORT PALMS CT';
	SELF.p_city_name := 'MIAMI';
  SELF.st := 'FL';
  SELF.z5 := '33185';
  SELF.phoneno := '3059867047';
	SELF.email_address := 'CHELM17@WALMART.COM';
	SELF.ip_address := '216.3.49.28';	
  SELF := [];
END;

FraudShared_Services.Layouts.BatchIn_rec prod_rec0001() := TRANSFORM
	SELF.acctno := 'prod_rec0001';
  SELF.ssn := '714931610';
  SELF.name_first := 'BENN';
  SELF.name_last := 'BURGHER';
  SELF.addr := '8320 JARBOE ST';
	SELF.p_city_name := 'MELBOURNE';
  SELF.st := 'FL';
  SELF.z5 := '32940';
  SELF.phoneno := '9542033011';
	SELF.email_address := 'JCARMAN4@BIZJOURNALS.COM';
	SELF.ip_address := '216.3.128.12';
	SELF.dl_state := 'FL';
	SELF.dl_number := 'K532166588790';
  SELF := [];
END;

FraudShared_Services.Layouts.BatchIn_rec prod_rec0002() := TRANSFORM
	SELF.acctno := 'prod_rec0002';
  SELF.ssn := '595489567';
  SELF.dob := '19870000';
  SELF.name_first := 'NASYA';
  SELF.name_last := 'WAGNER';
  SELF.addr := '5450 SW 156TH PL';
	SELF.p_city_name := 'MIAMI';
  SELF.st := 'FL';
  SELF.z5 := '33185';
  SELF.phoneno := '9542033011';
	SELF.email_address := 'BHALLET0@NBCNEWS.COM';
	SELF.ip_address := '216.3.128.12';
	SELF.dl_state := 'FL';
	SELF.dl_number := 'H400421893380';
  SELF := [];
END;

FraudShared_Services.Layouts.BatchIn_rec prod_rec0003() := TRANSFORM
	SELF.acctno := 'prod_rec0003';
  SELF.ssn := '534563999';
  SELF.name_first := 'AARONS';
  SELF.name_last := 'MARY';
  SELF := [];
END;

FraudShared_Services.Layouts.BatchIn_rec prod_rec0004() := TRANSFORM
	SELF.acctno := 'prod_rec0004';
  SELF.ssn := '600076337';
  SELF.did := 385786;
  SELF.dob := '19230413';
  SELF.name_first := 'MARIA';
  SELF.name_last := 'MORENO';	
  SELF.name_middle := 'H';	
  SELF := [];
END;

FraudShared_Services.Layouts.BatchIn_rec prod_rec0005() := TRANSFORM
	SELF.acctno := 'prod_rec0005';
  SELF.ssn := '511567093';
  SELF.dob := '19501005';
  SELF.name_first := 'MICHAEL';
  SELF.name_last := 'HENDRICKSON';	
  SELF.name_middle := 'W';	
  SELF := [];
END;

FraudShared_Services.Layouts.BatchIn_rec prod_rec0006() := TRANSFORM
	SELF.acctno := 'prod_rec0006';
  SELF.did := 187417114379;
  SELF := [];
END;

FraudShared_Services.Layouts.BatchIn_rec prod_rec0007() := TRANSFORM
	SELF.acctno := 'prod_rec0007';
  SELF.ssn := '313138936';
  SELF := [];
END;

EXPORT BatchCannedInput := dataset([
  /*rec0001(), rec0002(), rec0003(), rec0004(), rec0005(), rec0006(), rec0007(), rec0008(), rec0009(), rec00010(), rec00011(), rec00012(), rec00013(), rec00014() , rec00015()*/
	prod_rec0001(), prod_rec0002(), prod_rec0003(), prod_rec0004(), prod_rec0005(), prod_rec0006(),	prod_rec0007()
]);

/*

FraudShared_Services.Layouts.BatchIn_rec
//*Total # of Fields:	53
  unsigned4	seq := 0;
  string20 	acctno;
  string9  	ssn;
  string8  	dob;
  unsigned6	did;
  string20 	name_first := ' ';
  string20 	name_middle := ' ';
  string20 	name_last := ' ';
  string5  	name_suffix := ' ';
  string100	addr := ' ';
  string10 	prim_range := ' ';
  string2  	predir := ' ';
  string28 	prim_name := ' ';
  string4  	addr_suffix := ' ';
  string2  	postdir := ' ';
  string10 	unit_desig := ' ';
  string8  	sec_range := ' ';
  string25 	p_city_name := ' ';
  string2  	st := ' ';
  string5  	z5 := ' ';
  string4  	zip4 := ' ';
  string18 	county_name := ' ';
  string100	mailing_addr := ' ';
  string10 	mailing_prim_range := ' ';
  string2  	mailing_predir := ' ';
  string28 	mailing_prim_name := ' ';
  string4  	mailing_addr_suffix := ' ';
  string2  	mailing_postdir := ' ';
  string10 	mailing_unit_desig := ' ';
  string8  	mailing_sec_range := ' ';
  string25 	mailing_p_city_name := ' ';
  string2  	mailing_st := ' ';
  string5  	mailing_z5 := ' ';  
  string4  	mailing_zip4 := ' ';  
  string18 	mailing_county_name := ' ';
  string10 	phoneno;
  unsigned6	ultid;
  unsigned6	orgid;
  unsigned6	seleid;
  string10 	tin;
  string50 	email_address;
  unsigned6	appendedproviderid;
  unsigned6	lnpid;
  string10 	npi;
  string25 	ip_address;
  string50 	device_id;
  string12 	professionalid;
  string10 	bank_routing_number;
  string30 	bank_account_number;
  string2  	dl_state;
  string25 	dl_number;
  string10 	geo_lat;
  string11 	geo_long;
  SELF := [];
END;
*/
