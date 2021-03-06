import ut;
import std;

EXPORT LI_3_XML_despray(filename) := functionmacro


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


string attribute_file := '~sghatti::out::nonfcra_liattributes_v30_' + date_suffix;


LI_v3_XML_attributes := dataset(attribute_file, Scoring_Project.Attributes_Layouts.XML_LI_3, CSV(heading(1), quote('"'), MAXLENGTH(8192)));

LI_v3_XML_attributes_project := PROJECT(LI_v3_XML_attributes,TRANSFORM(Scoring_Project.Attributes_Layouts.XML_LI_3_project, self := left;));

LI_XML_attributes_v3 := sghatti.Normalized_code_attributes_Scores(LI_v3_XML_attributes_project, 'accountnumber', 'LEAD INTEGRITY', 'XML', '3.0', 'NON-FCRA', 'CERT', 'FLAGSHIP', datetime);

ALL_ATTRIBUTES := LI_XML_attributes_v3;


distribute_attributes := distribute(all_attributes, hash64( model, mode, version, restriction));
sort_attribute := SORT(distribute_attributes, model, mode, version, restriction, local);

attributes_final := output(sort_attribute,,'~Scoring_Project::ATTRIBUTES_' + datetime ,CSV(heading(single),SEPARATOR('|'), quote('"')), overwrite );

attributes_despray := FileServices.DeSpray('~Scoring_Project::ATTRIBUTES_' + datetime  ,'10.48.72.175', 'G:\\Scoring Project\\common_file_format_landing\\'+ 'ATTRIBUTES_' + datetime + '.csv',,,,TRUE);



result := Sequential(attributes_final, attributes_despray);

return result;

endmacro;
