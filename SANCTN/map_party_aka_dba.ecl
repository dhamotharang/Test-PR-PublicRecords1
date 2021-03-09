IMPORT SANCTN,std,ut;

EXPORT map_party_aka_dba(string filedate) := function

// Get the datasets
SANCTN_aka_dba := SANCTN.file_in_aka_dba;


//Remove nonprintable characters
else_filter_find := '[Ã¢]';
//else_filter_find := '[^[:print:]]';
else_filter := '[^[:print:]]';

SANCTN.layout_SANCTN_aka_dba_in clean_SANCTN_aka_dba(SANCTN_aka_dba input) := TRANSFORM
		self.LAST_NAME					:= ut.CleanSpacesAndUpper(input.LAST_NAME);
		self.FIRST_NAME					:= ut.CleanSpacesAndUpper(input.FIRST_NAME);
		self.MIDDLE_NAME				:= ut.CleanSpacesAndUpper(input.MIDDLE_NAME);
	  self.AKA_DBA_TEXT       := if(input.COMPANY != '', ut.CleanSpacesAndUpper(input.COMPANY),
																			STD.Str.CleanSpaces(TRIM(self.FIRST_NAME +' '+ self.MIDDLE_NAME+' '+self.LAST_NAME)));
		self                     := input;
		self:=[];
   
end;

clean_aka_dba_data := sort(PROJECT(SANCTN_aka_dba,clean_SANCTN_aka_dba(LEFT)),batch_number,incident_number, party_number);

clean_data_suppress := clean_aka_dba_data((trim(batch_number,left,right)+trim(incident_number,left,right) not in SANCTN.SuppressBatchIncident));

output('AKA/DBA NAME data: ' + count(clean_aka_dba_data));

clean_data_deduped := output(dedup(clean_data_suppress,all),,SANCTN.cluster_name +'out::SANCTN::'+filedate+'::aka_dba_cleaned',overwrite);
		
add_super := sequential(STD.File.StartSuperFileTransaction()
											 ,STD.File.ClearSuperFile(SANCTN.cluster_name + 'out::sanctn::aka_dba_cleaned',true)
											 ,STD.File.AddSuperFile(SANCTN.cluster_name + 'out::sanctn::aka_dba_cleaned'
							                             ,SANCTN.cluster_name + 'out::sanctn::' + filedate + '::aka_dba_cleaned')
										   ,STD.File.FinishSuperFileTransaction()
													);

return sequential(clean_data_deduped,add_super);

end;