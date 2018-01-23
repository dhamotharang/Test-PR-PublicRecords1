import ut;
import std;

EXPORT FP_2_XML_despray(filename) := functionmacro

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
															

string score_file := 	'~sghatti::out::nonfcra_fpscores_v2_' + date_suffix;													
string attribute_file := '~sghatti::out::nonfcra_fpscoresattributes_v2_' +  date_suffix;


fp_v2_XML_scores := dataset(score_file, sghatti.Scores_layouts.nonfcra_fpscores_v2, CSV(heading(1), quote('"'), MAXLENGTH(8192)));

////////////////////////////FRAUD POINT version-2 Mode-XML////////////////////////////////////////////////////////////////////////////////////////
FP_scores_v2 := sghatti.Normalized_code_attributes_Scores(fp_v2_XML_scores, 'accountnumber', 'FRAUD POINT', 'XML', '2.0', 'NON-FCRA', 'CERT', 'FLAGSHIP', datetime);

FP_scores_v2_prj := sghatti.Splitting_Scores_ReasonCodes(FP_scores_v2);	

FP_v2_SCORES := FP_scores_v2_prj(flag = 1);
FP_v2_REASON_CODES := FP_scores_v2_prj(flag = 0);


FP_2_XML_attributes := dataset(attribute_file,Scoring_Project.Attributes_Layouts.XML_FP_2,CSV(heading(1), quote('"'), MAXLENGTH(8192)));

FP_2_XML_attributes_project := PROJECT(FP_2_XML_attributes,TRANSFORM(Scoring_Project.Attributes_Layouts.XML_FP_2_project, self := left;));

FP_XML_attributes_v2 := sghatti.Normalized_code_attributes_Scores(FP_2_XML_attributes_project, 'accountnumber', 'FRAUD POINT', 'XML', '2.0', 'NON-FCRA', 'CERT', 'FLAGSHIP', datetime);

ALL_SCORES :=  FP_v2_SCORES;

ALL_REASON_CODES := FP_v2_REASON_CODES;

ALL_ATTRIBUTES := FP_XML_attributes_v2;

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