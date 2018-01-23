import ut;
import std;

EXPORT Paro_IT61_XML_despray(filename) := functionmacro

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

String Score_file := '~sghatti::out::paro_it61_' + date_suffix;


Paro_IT61_XML_scores := dataset(Score_file, Scoring_Project.Scores_layouts.Paro_IT61_XML_layout, CSV(heading(1), quote('"'), MAXLENGTH(8192)));

paro_score := RECORD
  string30 acctno;
  string3 score;
  string3 score3;
  END;

Paro_IT61_XML_scores_project := PROJECT(Paro_IT61_XML_scores,TRANSFORM(paro_score, self := left;));

Paro_IT61_scores := sghatti.Normalized_code_attributes_Scores(Paro_IT61_XML_scores_project, 'acctno', 'PARO-IT61', 'XML', '2.0', 'NON-FCRA', 'CERT', 'CUSTOM', datetime);

Paro_attributes := RECORD
  string30 acctno;
  string1 bansmatchflag;
  string1 bansecoaflag;
  string1 decsflag;
  string1 inputaddrcharflag;
  string1 inputsocscharflag;
  string1 phonestatusflag;
   string1 addrstatusflag;
  string1 addrcharflag;
   string1 hownstatusflag;
  string3 estincome;
 END;


Paro_attributes_proj := PROJECT(Paro_IT61_XML_scores, TRANSFORM(Paro_attributes, self := left;));

Paro_IT61_attributes := sghatti.Normalized_code_attributes_Scores(Paro_attributes_proj, 'acctno', 'PARO-IT61', 'XML', '2.0', 'NON-FCRA', 'CERT', 'CUSTOM', datetime);

ALL_SCORES :=  Paro_IT61_scores;

ALL_ATTRIBUTES := Paro_IT61_attributes;

distribute_attributes := distribute(all_attributes, hash64( model, mode, version, restriction));

sort_score := SORT(ALL_SCORES,datetime, model, mode, version, restriction);

sort_attribute := SORT(distribute_attributes, model, mode, version, restriction, local);

scores_final :=  output(sort_score,,'~Scoring_Project::SCORES_' + datetime ,CSV(heading(single), SEPARATOR('|'),quote('"')), overwrite );

attributes_final := output(sort_attribute,,'~Scoring_Project::ATTRIBUTES_' + datetime ,CSV(heading(single),SEPARATOR('|'), quote('"')), overwrite );


scores_despray := FileServices.DeSpray('~Scoring_Project::SCORES_' + datetime  ,'10.48.72.175', 'G:\\Scoring Project\\common_file_format_landing\\'+ 'SCORES_' + datetime + '.csv',,,,TRUE);

attributes_despray := FileServices.DeSpray('~Scoring_Project::ATTRIBUTES_' + datetime  ,'10.48.72.175', 'G:\\Scoring Project\\common_file_format_landing\\'+ 'ATTRIBUTES_' + datetime + '.csv',,,,TRUE);


result := Sequential(scores_final,  scores_despray, attributes_final, attributes_despray);

return result;

endmacro;
