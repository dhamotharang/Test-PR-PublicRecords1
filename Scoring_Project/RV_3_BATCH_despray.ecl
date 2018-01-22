import ut;
import std;

EXPORT RV_3_BATCH_despray(filename) := functionmacro

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

String Score_file := '~sghatti::out::batch_fcra_rvattributes_v3_' + date_suffix;

string attribute_file := '~sghatti::out::batch_fcra_rvscores_v3_' + date_suffix;

rv_v3_BATCH_scores := dataset(score_file, Scoring_Project.Scores_layouts.batch_fcra_rvscores_v3, CSV(heading(1), quote('"'), MAXLENGTH(8192)));

rv_v3_BATCH_scores_project := PROJECT(rv_v3_BATCH_scores,TRANSFORM(Scoring_Project.Scores_layouts.batch_fcra_rvscores_v3_project, self := left;));

RV_BATCH_scores_v3 := sghatti.Normalized_code_attributes_Scores(rv_v3_BATCH_scores_project, 'acctno', 'RISK VIEW', 'BATCH', '3.0', 'FCRA', 'CERT', 'FLAGSHIP', datetime);

///////////////////////FUNCTION MACRO CALL to separate reason codes from scores/////////////////////////////////////////////////////////////////
RV_BATCH_v3_SCORES_prj := sghatti.Splitting_Scores_ReasonCodes(RV_BATCH_scores_v3);	

RV_BATCH_v3_SCORES := RV_BATCH_v3_SCORES_prj(flag = 1);
RV_BATCH_v3_REASON_CODES := RV_BATCH_v3_SCORES_prj(flag = 0);


ALL_SCORES :=  RV_BATCH_v3_SCORES;

ALL_REASON_CODES := RV_BATCH_v3_REASON_CODES;

scores_final :=  output(ALL_SCORES,,'~Scoring_Project::SCORES_' + datetime ,CSV(heading(single), SEPARATOR('|'),quote('"')), overwrite );

reason_codes_final := output(ALL_REASON_CODES,,'~Scoring_Project::REASON_CODES_' + datetime ,CSV(heading(single), SEPARATOR('|'),quote('"')), overwrite );


scores_despray := FileServices.DeSpray('~Scoring_Project::SCORES_' + datetime  ,'10.48.72.175', 'G:\\Scoring Project\\common_file_format_landing\\'+ 'SCORES_' + datetime + '.csv',,,,TRUE);

reason_codes_despray := FileServices.DeSpray('~Scoring_Project::REASON_CODES_' + datetime  ,'10.48.72.175', 'G:\\Scoring Project\\common_file_format_landing\\'+ 'REASON_CODES_'+ datetime + '.csv',,,,TRUE);


result := Sequential(scores_final,  scores_despray, reason_codes_final, reason_codes_despray);

return result;

endmacro;
