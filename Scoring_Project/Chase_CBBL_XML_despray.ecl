import ut;
import std;

EXPORT Chase_CBBL_XML_despray(filename) := functionmacro

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

String Score_file := '~sghatti::out::chase_cbbl_cust_rec_' + date_suffix;

string attribute_file := '~sghatti::out::chase_cbbl_cust_rec_' + date_suffix;


chase_cbbl_xml := dataset(score_file,Scoring_Project.Scores_layouts.chase_cbbl, CSV(heading(1), quote('"'), MAXLENGTH(8192)));


chase_score := record
  string30 acctno;
	  string3 cmpyaddrscore;
	string3 ecovariables;
end;

chase_cbbl_xml_scores_project := PROJECT(chase_cbbl_xml,TRANSFORM(chase_score, self := left;));

chase_cbbl_scores := sghatti.Normalized_code_attributes_Scores(chase_cbbl_xml_scores_project, 'acctno', 'CHASE-CBBL', 'XML', '4.0', 'NON-FCRA', 'CERT', 'CUSTOM', datetime);

chase_attributes := RECORD
  string30 acctno;
  string1 firstcount;
  string1 lastcount;
  string1 addrcount;
  string1 phonecount;
  string1 socscount;
  string2 socsverlevel;
  string1 dobcount;
  string1 cmpycount;
  string1 cmpyaddrcount;
  string1 cmpyphonecount;
  string1 numelever;
  string2 numsource;
  string2 numcmpyelever;
  string2 numcmpysource;
  string3 firstscore;
  string3 lastscore;
  string3 cmpyscore;
  string3 addrscore;
  string3 phonescore;
  string3 socscore;
  string3 dobscore;
  string3 drlcscore;
  string3 cmpyscore2;
  string3 cmpyphonescore;
  string1 idtheftflag;
  string1 phonezipflag;
  string3 socsdob;
  string1 hhriskphoneflag;
  string1 zipclassflag;
  string6 medincome;
  string1 bansflag;
  string1 addrvalflag;
   string1 dwelltypeflag;
  string1 phonedissflag;
   string4 tcifull;
  string4 tcilast;
  string4 tciaddr;
  END;



chase_cbbl_xml_attributes_project := PROJECT(chase_cbbl_xml,TRANSFORM(chase_attributes, self := left;));

chase_cbbl_attributes := sghatti.Normalized_code_attributes_Scores(chase_cbbl_xml_attributes_project, 'acctno', 'CHASE-CBBL', 'XML', '4.0', 'NON-FCRA', 'CERT', 'CUSTOM', datetime);

ALL_SCORES :=  chase_cbbl_scores;

ALL_ATTRIBUTES := chase_cbbl_attributes;

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
