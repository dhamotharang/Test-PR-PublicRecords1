import ut;
EXPORT buildreport := module

infile_accidents := FLAccidents_Ecrash.key_EcrashV2_accnbrv1; 

export infile := project(infile_accidents , transform({infile_accidents, string10 source_id }, 
                     self.source_id := map(left.report_code in ['FA','TM','TF'] => left.report_code,
															                      left.report_code[1] ='I' => 'CRU-INQ',
																										left.report_code = 'EA' and left.work_type_id in ['1' ,'0','NULL']=> 'ECRASH', 
																										left.report_code = 'EA' and left.work_type_id in ['2' ,'3'] => 'EA-CRU', 'CRU-NIGHTLY'), self:= left)) : independent;


export infileprev := infile ( dt_last_seen[1..6] = ut.getDateOffset(-15,ut.GetDate)[1..6] ) : independent;
end;
                                                                                                                                                                                                                                                                                                                                   
 