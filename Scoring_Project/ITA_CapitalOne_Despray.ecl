import ut;
import std;

EXPORT ITA_CapitalOne_Despray(filename) := functionmacro

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


string attribute_file := '~sghatti::out::nonfcra_ita_capitalone_batch_v30_' + date_suffix;

ita_capitalone_batch_v30 := dataset(attribute_file, Scoring_Project.Attributes_Layouts.ITA_CapitalOne_Batch_layout, CSV(heading(1), quote('"'), MAXLENGTH(8192)));

ita_capitalone_batch_v30_project := PROJECT(ita_capitalone_batch_v30,TRANSFORM(Scoring_Project.Attributes_Layouts.ITA_CapitalOne_Batch_layout_project, self := left;));

ita_capitalone_attributes_v3 := sghatti.Normalized_code_attributes_Scores(ita_capitalone_batch_v30_project, 'accountnumber', 'ITA CAPITAL ONE', 'BATCH', '3.0', 'NON-FCRA', 'CERT', 'FLAGSHIP', datetime);

ALL_ATTRIBUTES := ita_capitalone_attributes_v3;


distribute_attributes := distribute(all_attributes, hash64( model, mode, version, restriction));
sort_attribute := SORT(distribute_attributes, model, mode, version, restriction, local);

attributes_final := output(sort_attribute,,'~Scoring_Project::ATTRIBUTES_' + datetime ,CSV(heading(single),SEPARATOR('|'), quote('"')), overwrite );

attributes_despray := FileServices.DeSpray('~Scoring_Project::ATTRIBUTES_' + datetime  ,'10.48.72.175', 'G:\\Scoring Project\\common_file_format_landing\\'+ 'ATTRIBUTES_' + datetime + '.csv',,,,TRUE);



result := Sequential(attributes_final, attributes_despray);

return result;

endmacro;
