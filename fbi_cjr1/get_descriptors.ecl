import fbi_cjr1, DriversV2,codes,corrections,sexoffender, lib_date;
import lib_stringlib, Address;

file_dl_searchv2 := dataset('~thor_data400::base::DL2::DLSearch_PUBLIC', DriversV2.Layout_Drivers, flat);
file_offenders := dataset('~thor_Data400::base::Corrections_Offenders_' + 'public' + '_BUILT',corrections.layout_Offender,flat);
file_so_main		:= sexoffender.file_Main;
codelookup := codes.File_Codes_V3_In;

fn_height_to_inches(string3 ft_inches):=FUNCTION
return INTFORMAT((integer)ft_inches[1..1]*12+(integer)ft_inches[2..3],3,1);
END;
//
layout_best_descriptors tSlimDL(Driversv2.Layout_Drivers L) := TRANSFORM
 // self.did:='';
  self.source                   :='DriverLic';
  self.dt_first_seen			:=L.dt_first_seen;
  self.dt_last_seen				:=L.dt_last_seen;
  self.height					:=fn_height_to_inches(L.height);
  self.weight					:=L.weight;
  self.race_code				:=L.race;
  self.race_desc				:='';
  self.gender_code				:=L.sex_flag;
  self.gender_desc				:=CASE(L.sex_flag,
                                     'M'=>'Male',
									 'F'=>'Female',
									 '');
  self.eye_color_code			:=L.eye_color;
  self.eye_color_desc			:='';
  self.hair_color_code			:=l.hair_color;
  self.hair_color_desc			:='';
  //------------------------------------
  self.best_score_height		:=0;
  self.best_score_weight		:=0;
  self.best_score_race			:=0;
  self.best_score_gender		:=0;
  self.best_score_eye_color		:=0;
  self.best_score_hair_color	:=0;
  self:=L;
END;
DL_Slim := PROJECT(file_dl_searchv2(did<>0), tSlimDL(LEFT));

// OFFENDER SLIM

Layout_best_descriptors tSlimOffenders(corrections.layout_Offender L) := TRANSFORM
    self.source                   :='Offender';
  self.did						:=(integer)L.DID;
  self.source_code              :=L.VENDOR;
  self.dt_first_seen			:=(unsigned6)L.process_date[1..6];
  self.dt_last_seen				:=0;//L.dt_last_seen;
  self.height					:=L.height;
  self.weight					:=L.weight;
  self.race_code				:=L.race;
  self.race_desc				:=L.race_desc;
  self.gender_code				:=L.sex;
  self.gender_desc				:=CASE(L.sex,
                                     'M'=>'Male',
									 'F'=>'Female',
									 '');
  self.eye_color_code			:=L.eye_color;
  self.eye_color_desc			:=L.eye_color_desc;
  self.hair_color_code			:=l.hair_color;
  self.hair_color_desc			:=L.hair_color_desc;
  //------------------------------------
  self.best_score_height		:=0;
  self.best_score_weight		:=0;
  self.best_score_race			:=0;
  self.best_score_gender		:=0;
  self.best_score_eye_color		:=0;
  self.best_score_hair_color	:=0;
  self:=L;
END;

Offender_Slim := PROJECT(file_offenders(did<>''), tSlimOffenders(LEFT));

//SEX OFFENDER SLIM

Layout_best_descriptors tSlimSOR(file_so_main L) := TRANSFORM
  self.source                   :='SexOffender';
  self.did						:=L.DID;
  self.source_code              :=L.VENDOR_code;
  self.dt_first_seen			:=(unsigned6)L.dt_last_reported[1..6];
  self.dt_last_seen				:=(unsigned6)L.dt_first_reported[1..6];
  self.height					:=L.height;
  self.weight					:=L.weight;
  self.race_code				:='';//L.race;
  self.race_desc				:=L.race;
  self.gender_code				:=L.sex;
  self.gender_desc				:= L.sex;//CASE(L.sex,
                                   //  'M'=>'Male',
									// 'F'=>'Female',
									// '');
  self.eye_color_code			:='';//L.eye_color;
  self.eye_color_desc			:=L.eye_color;
  self.hair_color_code			:='';//l.hair_color;
  self.hair_color_desc			:=L.hair_color;
  //------------------------------------
  self.best_score_height		:=0;
  self.best_score_weight		:=0;
  self.best_score_race			:=0;
  self.best_score_gender		:=0;
  self.best_score_eye_color		:=0;
  self.best_score_hair_color	:=0;
  self:=L;
END;

SexOffender_Slim := PROJECT(file_so_main(did<>0), tSlimSOR(LEFT));


//DL_slim := DL_Slim;// +Offender_slim+SexOffender_Slim;
// plug in the descriptions
//eye color
Layout_best_descriptors doEyeColor(DL_slim L, codelookup R) := TRANSFORM
self.eye_color_desc:= R.long_desc;
self:=L;
END;
//
DL_slim_plus_eyecolor:= JOIN(DL_slim,codelookup, 
                             right.file_name   = 'DRIVERS_LICENSE2' and
							 right.field_name   = 'EYE_COLOR' and
                             left.orig_state    = right.field_name2 and 
                             left.eye_color_code = right.code,
							 doEyeColor(left,right), LOOKUP, FEW);
							 
//eye color
Layout_best_descriptors doHairColor(DL_slim_plus_eyecolor L, codelookup R) := TRANSFORM
self.hair_color_desc:= R.long_desc;
self:=L;
END;
//
DL_slim_plus_haircolor:= JOIN(DL_slim_plus_eyecolor,codelookup, 
                             right.file_name   = 'DRIVERS_LICENSE2' and
							 right.field_name   = 'HAIR_COLOR' and
                             left.orig_state    = right.field_name2 and 
                             left.hair_color_code = right.code,
							 doHairColor(left,right), LOOKUP, FEW);
							 
// DO the scoring NOW
// ------------------------------- SCORING FUNCTIONS AND WEIGHTS --------------------
blanks:= ['', '   '];
fn_nonblank (string fld):=FUNCTION
return IF(fld in blanks ,0,1000000);
END;

fn_firstseen(unsigned4 datein, string fld):=FUNCTION
date:=INTFORMAT(datein,6,1);
year:=(integer)date[1..4];
month:=(integer)date[5..6];
day:= 01;//(integer)date[7..8];
return if(datein <>0 and fld not in blanks ,LIB_Date.DaysSince1900( year, month, day ),0);
END;

fn_coded(string fld):= FUNCTION
return IF(fld in blanks ,0,100000);
END;
//


set of string junk_data := [
		'NOT AVAILABLE',
		'UNAVAILABLE',
		'BLANK',
		'JUNK',
		'TO BE DETERMINED',
		'INVALID',
		'TBD',
		'UNK',
		'UNKNOWN',
		'MISSING',
		'R000',
		'-0-',
		'0',
		'00',
		'000',
		'0000',
		'00000',
		'000000',
		'0000000',
		'00000000',
		'000000000',
		'0000000000',
		'00000000000',
		'000000000000',
		'0000000000000'
		];


fnUpper(string s):=function
     return stringlib.StringToUpperCase(trim(s,left,right));
end;

DS_all_slimmed:=DL_slim_plus_haircolor+Offender_slim+SexOffender_Slim;

layout_best_descriptors to_cleanup(DS_all_slimmed l) := transform
self.height				:= if(l.height			not in junk_data, l.height,'');
self.weight				:= if(l.weight			not in junk_data, l.weight,'');
self.race_code			:= if(l.race_code  		not in junk_data, fnUpper(l.race_code),'');
self.race_desc			:= if(l.race_desc  		not in junk_data, fnUpper(l.race_desc),'');
self.gender_code		:= if(l.gender_code   	not in junk_data, fnUpper(l.gender_code),'');
self.gender_desc		:= if(l.gender_desc  	not in junk_data, fnUpper(l.gender_desc),'');
self.eye_color_code		:= if(l.eye_color_code  not in junk_data, fnUpper(l.eye_color_code),'');
self.eye_color_desc		:= if(l.eye_color_desc  not in junk_data, fnUpper(l.eye_color_desc),'');
self.hair_color_code	:= if(l.hair_color_code	not in junk_data, fnUpper(l.hair_color_code),'');
self.hair_color_desc	:= if(l.hair_color_desc not in junk_data, fnUpper(l.hair_color_desc),'');
self := l;
end;
DS_all_cleaned := project(DS_all_slimmed,to_cleanup(left));

//
Layout_best_descriptors tScoreDL(DS_all_cleaned L) := TRANSFORM
  /*-----------------------------------------------------------------------------
   Higher score will be used in the final SORT to 'float', the best value to
   the top in the final ROLLUP. Rules can be changed 
   Score Function = nonblank*w1+coded?*w2+firstseen_age*w3
   i.e bonblank ranks higher
       coded ranks higher
	   later firstseen date ranks higher
	   
  -------------------------------------------------------------------------- */
  self.best_score_height		:= fn_nonblank(l.height)+fn_nonblank(l.height)/10+fn_firstseen(L.dt_first_seen,l.height);
  self.best_score_weight		:= fn_nonblank(l.weight)+fn_nonblank(l.height)/10+fn_firstseen(L.dt_first_seen,l.weight);
  self.best_score_race			:= fn_nonblank(l.race_code)+fn_coded(l.race_desc)+fn_firstseen(L.dt_first_seen,TRIM(l.race_code) + TRIM(l.race_desc));
  self.best_score_gender		:= fn_nonblank(l.gender_code)+fn_coded(l.gender_desc)+fn_firstseen(L.dt_first_seen,TRIM(l.gender_code) + TRIM(l.gender_desc));
  self.best_score_eye_color		:= fn_nonblank(l.eye_color_code)+fn_coded(l.eye_color_desc)+fn_firstseen(L.dt_first_seen,TRIM(l.eye_color_code) + TRIM(l.eye_color_desc));
  self.best_score_hair_color	:= fn_nonblank(l.hair_color_code)+fn_coded(l.hair_color_desc)+fn_firstseen(L.dt_first_seen,TRIM(l.hair_color_code) + TRIM(l.hair_color_desc));
  self:=L;
END;

DS_scored := PROJECT(DS_all_cleaned, tScoreDL(LEFT));

DS_scored_Dist := DISTRIBUTE(DS_Scored, HASH(did));
DS_scored_Dist_Sort := SORT(DS_scored_Dist,did,LOCAL);

export get_descriptors := DS_scored_Dist_Sort	: persist('thor::persist::fbi_cjr1:get_descriptors');
