import PRTE2_Prof_License_Mari, STD, VersionControl, ut;

EXPORT files := MODULE
	
	EXPORT raw_search		:= DATASET(Constants.in_prefix_name+ 'search', Layouts.search, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));	
  EXPORT raw_discp		:= DATASET(Constants.in_prefix_name+ 'disciplinary_actions', Layouts.disp_action, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));	
	EXPORT raw_indv			:= DATASET(Constants.in_prefix_name+ 'individual_detail', Layouts.indv_detail, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));	
	EXPORT raw_reg			:= DATASET(Constants.in_prefix_name+ 'regulatory_actions', Layouts.reg_action, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));	

	EXPORT base_search     		:= DATASET (Constants.base_prefix_name + 'search', Layouts.search, THOR);
	EXPORT base_disp_actions  := DATASET (Constants.base_prefix_name + 'disciplinary_actions', Layouts.disp_action, THOR);
	EXPORT base_indiv_detail  := DATASET (Constants.base_prefix_name + 'individual_detail', Layouts.indv_detail, THOR);
	EXPORT base_reg_actions   := DATASET (Constants.base_prefix_name + 'regulatory_actions', Layouts.reg_action, THOR);


// AutoKeys Files
EXPORT file_search := project(raw_search, transform(recordof(raw_search),
self.process_date := left.process_date;
Self.ssn_taxid_1:=if(left.Tax_type_1 = 'S',left.link_ssn,if(left.tax_type_1='E',left.link_fein,''));
Self.ssn_taxid_2:=if(left.Tax_type_2 = 'S',left.link_ssn,if(left.tax_type_2='E',left.link_fein,''));
self := left));

EXPORT file_disciplinary := if(count(raw_discp) > 0, project(raw_discp, transform(recordof(raw_discp), self.process_date := (STRING)Std.Date.Today(), self := left)),
																														project(raw_discp, Layouts.disp_action));

EXPORT file_regulatory  :=  if(count(raw_reg) > 0, project(raw_reg, transform(recordof(raw_reg), self.process_date := (STRING)Std.Date.Today(),self := left)),
																												project(raw_reg, Layouts.reg_action));

EXPORT file_individual  :=  if(count(raw_indv) > 0, project(raw_indv, transform(recordof(raw_indv), self.process_date := (STRING)Std.Date.Today(), self := left)),
																													project(raw_indv, Layouts.indv_detail));

Export dsDisciplinary := project(base_disp_actions, layouts.layout_disciplinary);
Export dsDetail 			:= project(base_indiv_detail, {base_indiv_detail} - [cust_name,bug_num]);
Export dsRegulatory 	:= project(base_reg_actions, {base_reg_actions} - [cust_name,bug_num]);
Export dsSearch 			:= project(base_search, {base_search} - [enh_did_src,link_ssn,link_fein,link_inc_date,cust_name,bug_num,link_dob,req]);


layouts.slim_ssn  	xformTIN(recordof(dsSearch) L, integer cnt) := transform
self.tax_type					:= 	choose(cnt,L.tax_type_1,L.tax_type_2);
self.ssn_taxid				:= 	choose(cnt,L.ssn_taxid_1,L.ssn_taxid_2);
self.mari_rid					:= L.mari_rid;
self.mltreckey				:= L.mltreckey;
self.cmc_slpk					:= L.cmc_slpk;		
self.pcmc_slpk				:= L.pcmc_slpk;
self	:=L;
end;
shared NormTIN_SSN := normalize(dsSearch(ssn_taxid_1 != '' or ssn_taxid_2 != ''),2,xformTIN(LEFT,COUNTER));

shared dsSSN4	:=	project(NormTIN_SSN(tax_type = 'S' and ssn_taxid != ''),TRANSFORM(recordof(NormTIN_SSN), 
																																											self.tax_type := 'S4', 
																																											self.ssn_taxid := if(left.ssn_taxid != '' and left.ssn_taxid[6..9] != '0000', left.ssn_taxid[6..9],'');
																																											self := left));
TIN_SSN_comb := NormTIN_SSN(tax_type != 'S') + dsSSN4;
Export dsTaxidSsn_dedup := dedup(TIN_SSN_comb(tax_type != '' and ssn_taxid != ''), record,all);

Export dsPayload := dataset([],layouts.auto_payload);
END;	

