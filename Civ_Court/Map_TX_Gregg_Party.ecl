IMPORT Civ_Court, civil_court, ut, Address, lib_StringLib;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/tx_civil_gregg02_upd.mp

fTXGregg	:= Civ_Court.File_In_TX_Gregg(trim(CaseNumber,left,right) <> 'test');

fmtsin := [
		'%m/%d/%Y',
		'%m/%d/%y'
];
fmtout := '%Y%m%d';

party_pattern := '(.*)VS(.*)';
dba_pattern		:= '(.*)DBA(.*)';
aka_pattern		:= '(.*)AKA(.*)';

Civil_Court.Layout_In_Party tGregg(fTXGregg input, integer1 C) := TRANSFORM
	self.process_date				:= civil_court.Version_Development;
	self.vendor						  := '41';
	self.state_origin				:= 'TX';
	self.source_file				:= 'TX Gregg County Ct';
	self.case_key						:= '41'+ut.CleanSpacesAndUpper(input.CaseNumber);
	self.parent_case_key		:='';
	self.court_code					:='';
	self.court							:= 'GREGG COUNTY COURT';
	self.case_number				:= ut.CleanSpacesAndUpper(input.CaseNumber);
	self.case_type_code			:= '';
	self.case_type					:= ut.CleanSpacesAndUpper(input.CaseType);
	self.case_title					:= ut.CleanSpacesAndUpper(input.CaseTitle);
	ClnParty								:= ut.CleanSpacesAndUpper(IF(REGEXFIND('D/B/A|DOING BUSINESS AS',input.party,nocase)
																								,REGEXREPLACE('D/B/A|DOING BUSINESS AS',input.party,'DBA',nocase),input.party));
	ClnTitle								:= ut.CleanSpacesAndUpper(REGEXREPLACE('VS.',IF(REGEXFIND('D/B/A|DOING BUSINESS AS',input.CaseTitle,nocase)
																																	,REGEXREPLACE('D/B/A|DOING BUSINESS AS',input.CaseTitle,'DBA',nocase),input.CaseTitle)
																													,'VS',NOCASE));
	tmpPlaintiff						:= IF(REGEXFIND(party_pattern,ClnTitle),REGEXFIND(party_pattern,ClnTitle,1),'');

	self.entity_1						:= ut.CleanSpacesAndUpper(CHOOSE(C,ClnParty,tmpPlaintiff));
	self.entity_nm_format_1	:= 'L';  //due to mix of Individual Names and Company Names
	self.entity_type_description_1_orig := CHOOSE(C, 'DEFENDANT', 'PLAINTIFF');
	self.entity_type_code_1_master		  := CHOOSE(C, '30', '10');
	self := [];
END;
	
pGregg	:= normalize(fTXGregg,3,tGregg(left,counter));

//Normalize DBA/AKA name
Civil_Court.Layout_In_Party  NormDBA(pGregg input, integer1 C) := TRANSFORM
	TempName1								:= IF(REGEXFIND(dba_pattern,input.entity_1),REGEXFIND(dba_pattern,input.entity_1,1,NOCASE),
															IF(REGEXFIND(aka_pattern,input.entity_1),REGEXFIND(aka_pattern,input.entity_1,1),trim(input.entity_1,left,right)));
	ClnName1								:= REGEXREPLACE('AND$|,$',IF(REGEXFIND('^EX PARTE|^IN THE',TempName1),'',TempName1),'');
	TempName2								:= REGEXFIND(dba_pattern,input.entity_1,2);
	ClnName2								:= REGEXREPLACE('^,',trim(TempName2,left,right),'');
	TempName3								:= REGEXFIND(aka_pattern,input.entity_1,2);
	self.entity_1						:= ut.CleanSpacesAndUpper(CHOOSE(C,ClnName1,ClnName2,TempName3));
	self.entity_type_description_1_orig := CHOOSE(C, 'PLAINTIFF', 'PLAINTIFF DBA','PLAINTIFF AKA');
	self.entity_type_code_1_master		  := CHOOSE(C, '10','11','11');
	self := input;
END;

NormGregg	:= NORMALIZE(pGregg(entity_1 <> ''),3,NormDBA(left,counter))(entity_1 <> '');

Civ_court.Civ_Court_Cleaner(NormGregg,cleanGregg);

ddGregg 	:= dedup(sort(distribute(cleanGregg,hash(case_key)),
                  process_date,case_key,court, case_number, case_type, entity_1, entity_nm_format_1, 
									entity_type_description_1_orig, entity_type_code_1_master,local),
									case_key,court, case_number, case_type, entity_1, entity_nm_format_1, 
									entity_type_description_1_orig, entity_type_code_1_master,local,left):
									PERSIST('~thor_data400::in::civil_TX_Gregg_party');

EXPORT Map_TX_Gregg_Party := ddGregg(entity_1 <> '');