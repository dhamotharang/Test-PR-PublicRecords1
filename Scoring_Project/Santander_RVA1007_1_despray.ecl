import ut;
import std;

EXPORT Santander_RVA1007_1_despray(filename) := functionmacro

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

String Score_file := '~sghatti::out::santander_rva1007_1_' + date_suffix;


Santander_rva1007_1_XML := dataset(Score_file,Scoring_Project.Scores_layouts.Santander_RVA1007, CSV(heading(1), quote('"'), MAXLENGTH(8192)));

////////////////////////////T MOBILE rvt1210 Mode-XML////////////////////////////////////////////////////////////////////////////////////////
Santander_rva1007_1 := sghatti.Normalized_code_attributes_Scores(Santander_rva1007_1_XML, 'acctno', 'SANTANDER RVA1007-1', 'XML', '4.0', 'FCRA', 'CERT', 'CUSTOM', datetime);

Santander_rva1007_1_prj := sghatti.Splitting_Scores_ReasonCodes(Santander_rva1007_1);	

Santander_rva1007_1_SCORES := Santander_rva1007_1_prj(flag = 1);
Santander_rva1007_1_REASON_CODES := Santander_rva1007_1_prj(flag = 0);

ALL_SCORES :=   Santander_rva1007_1_SCORES ;
							
ALL_REASON_CODES := Santander_rva1007_1_REASON_CODES;

sort_score := SORT(ALL_SCORES,datetime, model, mode, version, restriction);
sort_reason_code := SORT(ALL_REASON_CODES,datetime, model, mode, version, restriction);


scores_final :=  output(sort_score,,'~Scoring_Project::SCORES_' + datetime ,CSV(heading(single), SEPARATOR('|'),quote('"')), overwrite );

reason_codes_final := output(sort_reason_code,,'~Scoring_Project::REASON_CODES_' + datetime ,CSV(heading(single), SEPARATOR('|'),quote('"')), overwrite );

scores_despray := FileServices.DeSpray('~Scoring_Project::SCORES_' + datetime  ,'10.48.72.175', 'G:\\Scoring Project\\common_file_format_landing\\'+ 'SCORES_' + datetime + '.csv',,,,TRUE);

reason_codes_despray := FileServices.DeSpray('~Scoring_Project::REASON_CODES_' + datetime  ,'10.48.72.175', 'G:\\Scoring Project\\common_file_format_landing\\'+ 'REASON_CODES_'+ datetime + '.csv',,,,TRUE);


result := Sequential(scores_final,  scores_despray, reason_codes_final, reason_codes_despray);

return result;

endmacro;
