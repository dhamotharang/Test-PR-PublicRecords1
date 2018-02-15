import ut;
import std;

EXPORT RV_4_BATCH_despray(filename) := functionmacro

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

String Score_file := '~sghatti::out::batch_fcra_rvattributes_v4_' + date_suffix;

string attribute_file := '~sghatti::out::batch_fcra_rvscores_v4_' + date_suffix;


rv_v4_BATCH_scores := dataset(Score_file, Scoring_Project.Scores_layouts.batch_fcra_rvscores_v4, CSV(heading(1), quote('"'), MAXLENGTH(8192)));

rv_v4_BATCH_scores_project := PROJECT(rv_v4_BATCH_scores,TRANSFORM(Scoring_Project.Scores_layouts.batch_fcra_rvscores_v4_project, self := left;));

RV_BATCH_scores_v4 := sghatti.Normalized_code_attributes_Scores(rv_v4_BATCH_scores_project, 'acctno', 'RISK VIEW', 'BATCH', '4.0', 'FCRA', 'CERT', 'FLAGSHIP', datetime);

///////////////////////FUNCTION MACRO CALL to separate reason codes from scores/////////////////////////////////////////////////////////////////
RV_BATCH_v4_SCORES_prj := sghatti.Splitting_Scores_ReasonCodes(RV_BATCH_scores_v4);	

RV_BATCH_v4_SCORES := RV_BATCH_v4_SCORES_prj(flag = 1);
RV_BATCH_v4_REASON_CODES := RV_BATCH_v4_SCORES_prj(flag = 0);


RV_v4_BATCH_attributes := dataset(attribute_file,Scoring_Project.Attributes_Layouts.BATCH_RV_4, CSV(heading(1), quote('"'), MAXLENGTH(8192)));
RV_v4_BATCH_attributes_proj := PROJECT(RV_v4_BATCH_attributes, TRANSFORM(Scoring_Project.Attributes_Layouts.BATCH_RV_4_project, self := left;));

RV_BATCH_attributes_v4 := sghatti.Normalized_code_attributes_Scores(RV_v4_BATCH_attributes_proj, 'accountnumber', 'RISK VIEW', 'BATCH', '4.0', 'FCRA', 'CERT', 'FLAGSHIP', datetime);

ALL_SCORES :=  RV_BATCH_v4_SCORES;

ALL_REASON_CODES := RV_BATCH_v4_REASON_CODES;

ALL_ATTRIBUTES := RV_BATCH_attributes_v4;

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



