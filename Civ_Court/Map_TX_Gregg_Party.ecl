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

Civil_Court.Layout_In_Party tGreggD(fTXGregg input, integer1 C) := TRANSFORM
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

		ClnParty								:= ut.CleanSpacesAndUpper(IF(REGEXFIND('D/B/A|DOING BUSINESS AS|ALSO KNOWN AS|AKA',input.party,nocase)
																								,REGEXREPLACE('D/B/A|DOING BUSINESS AS|ALSO KNOWN AS|AKA',input.party,'DBA',nocase),input.party));
																								
		valDBA             := stringlib.StringFind(ClnParty, 'DBA', 1);
		
		ClnParty1     := IF(valDBA = 0, ClnParty, ClnParty[1..valDBA - 1]);
		ClnParty2     := IF(valDBA > 0, trim(ClnParty[valDBA + 4.. ]), '');

		
	self.entity_1						:= CHOOSE(C,ClnParty1,ClnParty2);
	self.entity_nm_format_1	:= 'U';  //due to mix of Individual Names and Company Names
	self.entity_type_description_1_orig := 'DEFENDANT';
	self.entity_type_code_1_master		  := '30';
	self := [];
END;
	
dGregg	:= normalize(fTXGregg,3,tGreggD(left,counter));

Civil_Court.Layout_In_Party tGreggP(fTXGregg input, integer1 C) := TRANSFORM
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
      ClnTitle								:= ut.CleanSpacesAndUpper(REGEXREPLACE('VS.',IF(REGEXFIND('D/B/A|DOING BUSINESS AS',input.CaseTitle,nocase)
																																	,REGEXREPLACE('D/B/A|DOING BUSINESS AS',input.CaseTitle,'DBA',nocase),input.CaseTitle)
																													,'VS',NOCASE));
      tmpPlaintiff						:= IF(REGEXFIND(party_pattern,ClnTitle),REGEXFIND(party_pattern,ClnTitle,1),'');

	self.entity_1						:= tmpPlaintiff;
	self.entity_nm_format_1	:= 'U';  //due to mix of Individual Names and Company Names
	self.entity_type_description_1_orig := 'PLAINTIFF';
	self.entity_type_code_1_master		  := '10';
	self := [];
END;
	
pGregg	:= normalize(fTXGregg,3,tGreggP(left,counter));

greggAll := pGregg(entity_1 <> '') + dgregg(entity_1 <> '');

Civ_court.Civ_Court_Cleaner(greggAll,cleanGregg);

ddGregg 	:= dedup(sort(distribute(cleanGregg,hash(case_key)),
                  process_date,case_key,court, case_number, case_type, entity_1, entity_nm_format_1, 
									entity_type_description_1_orig, entity_type_code_1_master,local),
									case_key,court, case_number, case_type, entity_1, entity_nm_format_1, 
									entity_type_description_1_orig, entity_type_code_1_master,local,left):
									PERSIST('~thor_data400::in::civil_TX_Gregg_party');

EXPORT Map_TX_Gregg_Party := ddGregg(entity_1 <> '');