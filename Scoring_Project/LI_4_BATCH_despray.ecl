import ut;
import std;

EXPORT LI_4_BATCH_despray(filename) := functionmacro

import ut;

string filename_indicator := MAP(STD.STr.EndsWith(filename,'_2') => '2',
																				STD.STr.EndsWith(filename,'_1') => '1',
																				'0');	

STring filename_remove := MAP(filename_indicator = '2' => STD.str.removesuffix(filename, '_2'),
														  filename_indicator = '1' => STD.str.removesuffix(filename, '_1'),
															filename);
															
															
len := length(filename_remove);
String date := filename_remove[len-7..len];
String datetime := date + '-' + ut.getTime(): INDEPENDENT;

STring date_suffix := MAP(filename_indicator = '2' => filename[length(filename)-9.. length(filename)],
														  filename_indicator = '1' => filename[length(filename)-9.. length(filename)],
															filename[length(filename)-7.. length(filename)]);
															

string score_file := 	'~sghatti::out::nonfcra_liscores_batch_v40_' + date_suffix;													
string attribute_file := '~sghatti::out::nonfcra_liattributes_batch_v40_' +  date_suffix;

LI_v4_BATCH_scores := dataset('~sghatti::out::' + filename, sghatti.Scores_layouts.nonfcra_liscores_v4_msn1106_0,CSV(heading(1), quote('"'), MAXLENGTH(8192)));


LI_v4_BATCH_scores_project := PROJECT(LI_v4_BATCH_scores, TRANSFORM(sghatti.Scores_layouts.nonfcra_liscores_v4_msn1106_0_project,self.LI_score := left.score;
																					self := left;));
																					
////////////////////////////LEAD INTEGRITY version-4 Mode-BATCH////////////////////////////////////////////////////////////////////////////////////////
LI_scores_v4 := sghatti.Normalized_code_attributes_Scores(LI_v4_BATCH_scores_project, 'accountnumber', 'LEAD INTEGRITY', 'BATCH', '4.0', 'NON-FCRA', 'CERT', 'FLAGSHIP', datetime);

LI_v4_SCORES_prj := sghatti.Splitting_Scores_ReasonCodes(LI_scores_v4);	

LI_v4_SCORES := LI_v4_SCORES_prj(flag = 1);
LI_v4_REASON_CODES := LI_v4_SCORES_prj(flag = 0);


LI_v4_BATCH_attributes := dataset(attribute_file, Scoring_Project.Attributes_Layouts.XML_LI_4, CSV(heading(1), quote('"'), MAXLENGTH(8192)));

LI_v4_BATCH_attributes_project := PROJECT(LI_v4_BATCH_attributes,TRANSFORM(Scoring_Project.Attributes_Layouts.XML_LI_4_project, self := left;));

LI_BATCH_attributes_v4 := sghatti.Normalized_code_attributes_Scores(LI_v4_BATCH_attributes_project, 'accountnumber', 'LEAD INTEGRITY', 'BATCH', '4.0', 'NON-FCRA', 'CERT', 'FLAGSHIP', datetime);

ALL_SCORES :=  LI_v4_SCORES;

ALL_REASON_CODES := LI_v4_REASON_CODES;

ALL_ATTRIBUTES := LI_BATCH_attributes_v4;

distribute_attributes := distribute(all_attributes, hash64( model, mode, version, restriction));
sort_score := SORT(ALL_SCORES,datetime, model, mode, version, restriction);
sort_reason_code := SORT(ALL_REASON_CODES,datetime, model, mode, version, restriction);
sort_attribute := SORT(distribute_attributes, model, mode, version, restriction, local);

scores_final :=  output(sort_score,,'~Scoring_Project::SCORES_' + datetime ,CSV(heading(single), SEPARATOR('|'),quote('"')), overwrite );

reason_codes_final := output(sort_reason_code,,'~Scoring_Project::REASON_CODES_' + datetime ,CSV(heading(single), SEPARATOR('|'),quote('"')), overwrite );

attributes_final := output(sort_attribute,,'~Scoring_Project::ATTRIBUTES_' + datetime ,CSV(heading(single),SEPARATOR('|'), quote('"')), overwrite );


scores_despray := FileServices.DeSpray('~Scoring_Project::SCORES_' + datetime  ,'10.48.72.175', 'G:\\Scoring Project\\common_file_format_landing\\'+ 'SCORES_' + datetime + '.csv',,,,TRUE);

reason_codes_despray := FileServices.DeSpray('~Scoring_Project::REASON_CODES_' + datetime  ,'10.48.72.175', 'G:\\Scoring Project\\common_file_format_landing\\'+ 'REASON_CODES_'+ datetime + '.csv',,,,TRUE);

attributes_despray := FileServices.DeSpray('~Scoring_Project::ATTRIBUTES_' + datetime  ,'10.48.72.175', 'G:\\Scoring Project\\common_file_format_landing\\'+ 'ATTRIBUTES_' + datetime + '.csv',,,,TRUE);


result := Sequential(scores_final,  scores_despray, reason_codes_final, reason_codes_despray, attributes_final, attributes_despray);

return result;

endmacro;
