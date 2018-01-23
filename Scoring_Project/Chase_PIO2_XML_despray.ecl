import ut;
import std;

EXPORT Chase_PIO2_XML_despray(filename) := functionmacro

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

String Score_file := '~sghatti::out::chase_pi02_cust_rec_' + date_suffix;

string attribute_file := '~sghatti::out::chase_pi02_cust_rec_' + date_suffix;


chase_pio2_XML_scores := dataset(Score_file, Scoring_Project.Scores_layouts.chase_pio2_XML, CSV(heading(1), quote('"'), MAXLENGTH(8192)));

chase_score := record
  string30 acctno;
  // string32 riskwiseid;
	string3 estincome;
end;

chase_pio2_XML_scores_project := PROJECT(chase_pio2_XML_scores,TRANSFORM(chase_score, self := left;));

chase_pio2_scores1 := sghatti.Normalized_code_attributes_Scores(chase_pio2_XML_scores_project, 'acctno', 'CHASE-PIO2', 'XML', '2.0', 'NON-FCRA', 'CERT', 'CUSTOM', datetime);

///////////////////////FUNCTION MACRO CALL to separate reason codes from scores/////////////////////////////////////////////////////////////////
chase_pio2_scores_prj := sghatti.Splitting_Scores_ReasonCodes(chase_pio2_scores1);	

chase_pio2_scores := chase_pio2_scores_prj(flag = 0);


chase_attributes := RECORD
  string30 acctno;
  string32 riskwiseid;
  string1 hriskphoneflag;
  string1 phonevalflag;
  string1 phonezipflag;
  string1 hriskaddrflag;
  string1 decsflag;
  string1 socsdobflag;
  string1 socsvalflag;
  string1 drlcvalflag;
  string1 addrvalflag;
  string1 dwelltypeflag;
   string1 bansflag;
   string1 idtheftflag;
  string1 aptscanflag;
  string1 addrhistoryflag;
  string2 firstcount;
  string2 lastcount;
  string2 addrcount;
  string2 hphonecount;
  string2 wphonecount;
  string2 socscount;
  string2 socsverlevel;
  string2 dobcount;
  string2 numelever;
   string3 firstscore;
  string3 lastscore;
  string3 cmpyscore;
  string3 addrscore;
  string3 hphonescore;
  string3 wphonescore;
  string3 socsscore;
  string3 dobscore;
   string4 disthphoneaddr;
  string4 disthphonewphone;
  string4 distwphoneaddr;
  string2 numfraud;

 END;


chase_pio2_xml_attributes_proj := PROJECT(chase_pio2_XML_scores, TRANSFORM(chase_attributes, self := left;));

chase_pio2_attributes := sghatti.Normalized_code_attributes_Scores(chase_pio2_xml_attributes_proj, 'acctno', 'CHASE-PIO2', 'XML', '2.0', 'NON-FCRA', 'CERT', 'CUSTOM', datetime);

ALL_SCORES :=  chase_pio2_scores;

ALL_ATTRIBUTES := chase_pio2_attributes;

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
