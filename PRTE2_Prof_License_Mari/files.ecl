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


//------------------------------------------------------------------------------------------------------
// AutoKeys Files
EXPORT file_search := project(raw_search, transform(recordof(raw_search),	self.process_date := (STRING)Std.Date.Today(), self := left));
EXPORT file_disciplinary := if(count(raw_discp) > 0, project(raw_discp, transform(recordof(raw_discp), self.process_date := (STRING)Std.Date.Today(), self := left)),
																														project(raw_discp, Layouts.disp_action));

EXPORT file_regulatory  :=  if(count(raw_reg) > 0, project(raw_reg, transform(recordof(raw_reg), self.process_date := (STRING)Std.Date.Today(),self := left)),
																												project(raw_reg, Layouts.reg_action));

EXPORT file_individual  :=  if(count(raw_indv) > 0, project(raw_indv, transform(recordof(raw_indv), self.process_date := (STRING)Std.Date.Today(), self := left)),
																													project(raw_indv, Layouts.indv_detail));

END;	