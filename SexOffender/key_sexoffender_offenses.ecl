import doxie, doxie_build, ut, hygenics_search;

export key_sexoffender_offenses (boolean IsFCRA = false) := function

df := sexoffender.file_offenses_2;

addFieldLayout := record
	string60 Seisint_Primary_Key;
	string80 	conviction_jurisdiction;
	string8  	conviction_date;
	string30 	court;
	string25 	court_case_number;
	string8  	offense_date;
	string20 	offense_code_or_statute;
	string320   offense_description;
	string180   offense_description_2;
	unsigned8	offense_category;		//new field added		
	string1  	victim_minor;
	string3  	victim_age;
	string10 	victim_gender;
	string30 	victim_relationship;
	string180   sentence_description;
	string180   sentence_description_2;
	string8		arrest_date;			
	string250	arrest_warrant;	 
	string1	fcra_conviction_flag;
  string1	fcra_traffic_flag;
  string8	fcra_date;
  string1	fcra_date_type;
  string8	conviction_override_date;
  string1	conviction_override_date_type;
  string2	offense_score;
	unsigned8 offense_persistent_id;
end;

unsigned8 GetOffenseCategory (string3 off_cat) := MAP (
	off_cat ='ABD' => Constants.OffenseCategory.ABDUCTION,
	off_cat ='BUR' => Constants.OffenseCategory.BURGLARY, 
	off_cat ='COM' => Constants.OffenseCategory.COMPUTER_CRIME, 
	off_cat ='CON' => Constants.OffenseCategory.CONTRIBUTING, 
	off_cat ='COR' => Constants.OffenseCategory.CORRUPTION, 
	off_cat ='END' => Constants.OffenseCategory.ENDANGER_WELFARE_OF_MINORS, 
	off_cat ='EXP' => Constants.OffenseCategory.EXPLOITATION, 
	off_cat ='EXS' => Constants.OffenseCategory.EXPOSURE, 
	off_cat ='FAI' => Constants.OffenseCategory.FAILURE_TO_COMPLY, 
	off_cat ='FAL' => Constants.OffenseCategory.FALSE_IMPRISONMENT, 
	off_cat ='IMP' => Constants.OffenseCategory.IMPORTUNING, 
	off_cat ='INC' => Constants.OffenseCategory.INCEST, 
	off_cat ='MUR' => Constants.OffenseCategory.MURDER, 
	off_cat ='OTH' => Constants.OffenseCategory.OTHER, 
	off_cat ='POR' => Constants.OffenseCategory.PORNOGRAPHY, 
	off_cat ='PRO' => Constants.OffenseCategory.PROSTITUTION, 
	off_cat ='RAP' => Constants.OffenseCategory.RAPE, 
	off_cat ='REG' => Constants.OffenseCategory.REGISTRATION, 
	off_cat ='RET' => Constants.OffenseCategory.RESTRAINT, 
	off_cat ='ROB' => Constants.OffenseCategory.ROBBERY, 
	off_cat ='SEX' => Constants.OffenseCategory.SEXUAL_ASSAULT, 
	off_cat ='SAM' => Constants.OffenseCategory.SEXUAL_ASSAULT_MINOR, 
	off_cat ='SOL' => Constants.OffenseCategory.SOLICITATION, 
	off_cat ='UNL' => Constants.OffenseCategory.UNLAWFUL_COMMUNICATION_MINOR, 
	0);



addFieldLayout addFieldTran(df l):= transform
	self.offense_category := GetOffenseCategory (l.offense_category[1..3]) +
													GetOffenseCategory (l.offense_category[5..7]);
	self := l;
end;

addField 		:= project(df, addFieldTran(left)); //(~IsFCRA); // disable fcra for now;

add_filter 	:= addField(seisint_primary_key[1..4] not in Hygenics_search.Sex_Offenders_Not_Updating.SO_By_Key);
add_all			:= addField;

//TODO: apply source, date, etc. fcra-filtering
	
//TODO: change names according to a standard
string file_name := if (IsFCRA, 
					 Constants.Cluster+'::key::sexoffender::fcra::offenses_'+doxie_build.buildstate+'_'+doxie.Version_SuperKey,
					 Constants.Cluster+'::key::sexoffender_offenses_' + doxie_build.buildstate+'_' + doxie.Version_SuperKey);

return if (IsFCRA, 
           index (add_filter, {string60 sspk := add_filter.seisint_primary_key}, {add_filter}, file_name, OPT),
           index (add_all, {string60 sspk := add_all.seisint_primary_key}, {add_all}, file_name));
end;