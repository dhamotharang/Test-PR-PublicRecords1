import ut;
import std;

EXPORT LI_3_BATCH_despray(filename) := functionmacro

import ut;
string filename_remove := STD.str.removesuffix(filename, '_1');

len := length(filename_remove);
String datetime := filename_remove[len-7..len] + '-' + ut.getTime(): INDEPENDENT;


LI_v3_BATCH_attributes := dataset('~sghatti::out::' + filename, Scoring_Project.Attributes_Layouts.BATCH_LI_3, CSV(heading(1), quote('"'), MAXLENGTH(8192)));

LI_v3_BATCH_attributes_project := PROJECT(LI_v3_BATCH_attributes,TRANSFORM(Scoring_Project.Attributes_Layouts.BATCH_LI_3_project, self := left;));

LI_BATCH_attributes_v3 := sghatti.Normalized_code_attributes_Scores(LI_v3_BATCH_attributes_project, 'accountnumber', 'LEAD INTEGRITY', 'BATCH', '3.0', 'NON-FCRA', 'CERT', 'FLAGSHIP', datetime);

ALL_ATTRIBUTES := LI_BATCH_attributes_v3;


distribute_attributes := distribute(all_attributes, hash64( model, mode, version, restriction));
sort_attribute := SORT(distribute_attributes, model, mode, version, restriction, local);

attributes_final := output(sort_attribute,,'~Scoring_Project::ATTRIBUTES_' + datetime ,CSV(heading(single),SEPARATOR('|'), quote('"')), overwrite );

attributes_despray := FileServices.DeSpray('~Scoring_Project::ATTRIBUTES_' + datetime  ,'10.48.72.175', 'G:\\Scoring Project\\common_file_format_landing\\'+ 'ATTRIBUTES_' + datetime + '.csv',,,,TRUE);



result := Sequential(attributes_final, attributes_despray);

return result;

endmacro;

