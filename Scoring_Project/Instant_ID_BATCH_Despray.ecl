import ut;
import std;

EXPORT Instant_ID_BATCH_Despray(filename) := functionmacro

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


string attribute_file := '~sghatti::out::fcra_riskprocessing_instant_id_batch_' + date_suffix;

instantId_batch := dataset(attribute_file,  Scoring_Project.Attributes_Layouts.BATCH_Instant_id_layout, CSV(heading(1), quote('"'), MAXLENGTH(8192)));

instantId_batch_project:= PROJECT(instantId_batch, TRANSFORM(Scoring_Project.Attributes_Layouts.BATCH_Instant_id_layout_project,self := left;));


instantId_batch__v2 := sghatti.Normalized_code_attributes_Scores(instantId_batch_project, 'acctno', 'INSTANT ID', 'BATCH', '2.0', 'NON-FCRA', 'CERT', 'FLAGSHIP', datetime);

ALL_ATTRIBUTES := instantId_batch__v2;


distribute_attributes := distribute(all_attributes, hash64( model, mode, version, restriction));
sort_attribute := SORT(distribute_attributes, model, mode, version, restriction, local);

attributes_final := output(sort_attribute,,'~Scoring_Project::ATTRIBUTES_' + datetime ,CSV(heading(single),SEPARATOR('|'), quote('"')), overwrite );

attributes_despray := FileServices.DeSpray('~Scoring_Project::ATTRIBUTES_' + datetime  ,'10.48.72.175', 'G:\\Scoring Project\\common_file_format_landing\\'+ 'ATTRIBUTES_' + datetime + '.csv',,,,TRUE);



result := Sequential(attributes_final, attributes_despray);

return result;

endmacro;
