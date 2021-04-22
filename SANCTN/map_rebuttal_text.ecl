IMPORT SANCTN, lib_stringlib,ut,std;

EXPORT map_rebuttal_text(string filedate) := function

// Get the datasets
SANCTN_rebuttal_text := SANCTN.file_in_rebuttal;


//Remove nonprintable characters
else_filter_find := '[Ã¢]';
//else_filter_find := '[^[:print:]]';
else_filter := '[^[:print:]]';

SANCTN.layout_SANCTN_rebuttal_base clean_SANCTN_rebuttal(SANCTN_rebuttal_text input) := TRANSFORM

	  self.PARTY_TEXT       := IF(regexfind(else_filter_find,input.party_text) = false,input.party_text,
		                            regexreplace(else_filter,input.party_text,'',NOCASE));

   self                     := input;
   self:=[];
   
end;

clean_rebuttal_data := sort(PROJECT(SANCTN_rebuttal_text,clean_SANCTN_rebuttal(LEFT)),batch_number,incident_number, party_number,order_number);

clean_data_suppress := clean_rebuttal_data((trim(batch_number,left,right)+trim(incident_number,left,right) not in SANCTN.SuppressBatchIncident));

output('Rebuttal data: ' + count(clean_rebuttal_data));

clean_data_deduped := output(dedup(clean_data_suppress,all),,SANCTN.cluster_name +'out::SANCTN::'+filedate+'::rebuttal_cleaned');
		
add_super := sequential(STD.File.StartSuperFileTransaction()
											 ,STD.File.ClearSuperFile(SANCTN.cluster_name + 'out::sanctn::rebuttal_cleaned',true)
											 ,STD.File.AddSuperFile(SANCTN.cluster_name + 'out::sanctn::rebuttal_cleaned'
							                             ,SANCTN.cluster_name + 'out::sanctn::' + filedate + '::rebuttal_cleaned')
										  	,STD.File.FinishSuperFileTransaction()
													);


return sequential(clean_data_deduped,add_super);

end;