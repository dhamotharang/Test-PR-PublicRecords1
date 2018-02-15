import ut;
import std;

EXPORT BestBuy_ChargeBack_Defender_Score_Despray(filename) := functionmacro

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

String Score_file := '~sghatti::out::best_buy_custom_chargeback_defender_score_' + date_suffix;

bestbuy_custom_chargeback_defender_score := dataset(Score_file, Scoring_Project.Scores_layouts.bestbuy_custom_chargeback_defender_score_layout, CSV(heading(1), quote('"'), MAXLENGTH(8192)));

bestbuy_custom_chargeback_defender_score_project := PROJECT(bestbuy_custom_chargeback_defender_score, TRANSFORM(Scoring_Project.Scores_layouts.best_buy_custom_chargeback_defender_score_project, self := left;));


////////////////////////////BESTBUY CHARGEBACK DEFENDER////////////////////////////////////////////////////////////////////////////////////////
bestbuy_chargeback_defender_score := sghatti.Normalized_code_attributes_Scores(bestbuy_custom_chargeback_defender_score_project, 'account', 'BESTBUY CHARGEBACK DEFENDER', 'XML', 'CDN1109-1', 'NON-FCRA', 'CERT', 'CUSTOM', datetime);

bestbuy_chargeback_defender_score_prj := sghatti.Splitting_Scores_ReasonCodes(bestbuy_chargeback_defender_score);	

bestbuy_chargeback_defender_score_SCORES := bestbuy_chargeback_defender_score_prj(flag = 1);
bestbuy_chargeback_defender_score_REASON_CODES := bestbuy_chargeback_defender_score_prj(flag = 0);

ALL_SCORES :=   bestbuy_chargeback_defender_score_SCORES ;
							
ALL_REASON_CODES := bestbuy_chargeback_defender_score_REASON_CODES;

sort_score := SORT(ALL_SCORES,datetime, model, mode, version, restriction);
sort_reason_code := SORT(ALL_REASON_CODES,datetime, model, mode, version, restriction);


scores_final :=  output(sort_score,,'~Scoring_Project::SCORES_' + datetime ,CSV(heading(single), SEPARATOR('|'),quote('"')), overwrite );

reason_codes_final := output(sort_reason_code,,'~Scoring_Project::REASON_CODES_' + datetime ,CSV(heading(single), SEPARATOR('|'),quote('"')), overwrite );

scores_despray := FileServices.DeSpray('~Scoring_Project::SCORES_' + datetime  ,'10.48.72.175', 'G:\\Scoring Project\\common_file_format_landing\\'+ 'SCORES_' + datetime + '.csv',,,,TRUE);

reason_codes_despray := FileServices.DeSpray('~Scoring_Project::REASON_CODES_' + datetime  ,'10.48.72.175', 'G:\\Scoring Project\\common_file_format_landing\\'+ 'REASON_CODES_'+ datetime + '.csv',,,,TRUE);


result := Sequential(scores_final,  scores_despray, reason_codes_final, reason_codes_despray);

return result;

endmacro;
