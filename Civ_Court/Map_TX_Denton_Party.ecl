IMPORT Civ_Court, civil_court, ut, lib_StringLib, Address, STD;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/tx_civil_denton02.mp

fTXDenton	:= Civ_Court.File_In_TX_Denton;

fmtsin := [
		'%m/%d/%Y',
		'%m/%d/%Y'
	];
	fmtout:='%Y%m%d';	

dba_pattern		:= '(.*)DBA(.*)';
aka_pattern		:= '(.*)AKA(.*)';

Civil_Court.Layout_In_Party tDenton(fTXDenton input, integer1 C) := TRANSFORM
	self.process_date				:= civil_court.Version_Development;
	self.vendor						  := '39';
	self.state_origin				:= 'TX';
	self.source_file				:= 'TX_DENTON_COUNTY';
	StdFileDate							:= Std.date.ConvertDateFormatMultiple(input.FiledDate,fmtsin,fmtout);
	self.case_key						:= '39'+ut.CleanSpacesAndUpper(input.CaseNumber)+StdFileDate;
	self.parent_case_key		:='';
	self.court_code					:='';
	self.court							:= 'DENTON COUNTY COURT';
	self.case_number				:= ut.CleanSpacesAndUpper(input.CaseNumber);
	self.case_type_code			:= '';
	self.case_type					:= ut.CleanSpacesAndUpper(input.CaseType);
	self.case_title					:= ut.CleanSpacesAndUpper(input.CaseTitle);
	ClnParty								:= ut.CleanSpacesAndUpper(IF(REGEXFIND('D/B/A|DBA=',input.party,NOCASE)
																								,REGEXREPLACE('D/B/A|DBA=',input.party,'DBA',NOCASE),input.party));
	TempPlaint							:= IF(REGEXFIND(dba_pattern,ClnParty),REGEXFIND(dba_pattern,ClnParty,1),
															IF(REGEXFIND(aka_pattern,ClnParty),REGEXFIND(aka_pattern,ClnParty,1),trim(ClnParty,left,right)));
	TempDBA									:= IF(REGEXFIND(dba_pattern,ClnParty),REGEXFIND(dba_pattern,ClnParty,2),'');
	TempAKA									:= IF(REGEXFIND(aka_pattern,ClnParty),REGEXFIND(aka_pattern,ClnParty,2),'');
	self.entity_1						:= ut.CleanSpacesAndUpper(CHOOSE(C,TempPlaint,TempDBA,TempAKA,input.Attorney,input.Judge));
	self.entity_type_description_1_orig := ut.CleanSpacesAndUpper(CHOOSE(C, input.PartyType, 'PLAINTIFF DBA','PLAINTIFF AKA','ATTORNEY','JUDGE'));
	self.entity_type_code_1_master		  := CHOOSE(C, map(input.PartyType = 'Judge' => '60',
																												input.PartyType = 'Plaintiff' => '10',
																												input.PartyType = 'Petitioner' => '10',
																												input.PartyType = 'Defendant' => '30',
																												input.PartyType = 'Plaintiff\'s Agent' => '10',
																												input.PartyType = 'Plaintiff\'s Attorney' => '20',
																												input.PartyType = 'Defendant\'s Attorney' => '40',
																												input.PartyType = 'Attorney' => '50','90'),'11','11','50','60');
	integer WordCount				:= STD.Str.FindCount(input.Address,',');
	tmpStateZip	:= ut.CleanSpacesAndUpper(input.Address[STD.Str.Find(input.Address,',',WordCount)+1..]);
	RemainAddr	:= ut.CleanSpacesAndUpper(REGEXREPLACE(tmpStateZip,input.Address,''));
	StreetOnly	:= IF(REGEXFIND('((THE )[A-Z]+[,])$',RemainAddr),REGEXREPLACE('((THE )[A-Z]+[,])$',RemainAddr,''),
										REGEXREPLACE('([A-Z]+[,])$',RemainAddr,''));
	ClnStreet		:= TRIM(REGEXREPLACE('GMH/GF DENTON ASSC. LLC - LEASING OFFICE',StreetOnly,''),left,right);
	self.entity_1_address_1	:= CHOOSE(C,ClnStreet,ClnStreet,ClnStreet,'','');
	self.entity_1_address_2	:= CHOOSE(C,tmpStateZip,tmpStateZip,tmpStateZip,'','');
	self := [];
END;

NormDenton	:= NORMALIZE(fTXDenton,5,tDenton(left,counter))(entity_1 <> '');

Civ_court.Civ_Court_Cleaner(NormDenton,cleanDenton);

ddDenton 	:= dedup(sort(distribute(cleanDenton,hash(case_key)),
                  process_date,case_key,court, case_number, case_type_code, case_type, entity_1,
									entity_1_address_1, entity_1_address_2, local),
									case_key, court, case_number, case_type_code, case_type, e1_fname1,
									e1_mname1, e1_lname1, e1_suffix1, e1_cname1,
									entity_1_address_1, entity_1_address_2, local,left):
									PERSIST('~thor_data400::in::civil_TX_Denton_party');

EXPORT Map_TX_Denton_Party := ddDenton(entity_1 <> '');