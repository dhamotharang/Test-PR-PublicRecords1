import prte_csv, header,ut,AutoKey,NID,autokeyb2,Census_data,codes;

EXPORT files := module

EXPORT dl2_drvlic_in := DATASET(Constants.file_in, Layouts.Layout_in, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );

EXPORT Base_Conviction := DATASET([], Layouts.Layout_Convictions);

EXPORT Base_Suspension := DATASET([], Layouts.Layout_Suspensions);

EXPORT Base_DR_Info := DATASET([], Layouts.Layout_Driver_Record_info);

EXPORT Base_Accident := DATASET([], Layouts.Layout_Accident);

EXPORT dl2_base := DATASET('~PRTE::BASE::DL2::DRVLIC', Layouts.Layout_Base, FLAT);

EXPORT dl2_fra_insur := DATASET([], Layouts.Layout_FRA_insurance);

EXPORT autokey_file := PROJECT(dl2_base, Layouts.Layout_DL_AutoKeys  );

//////////////dl2_dl_number////////////

EXPORT dl_header := PROJECT(dl2_base, TRANSFORM(Layouts.Layout_As_Header, SELF := LEFT, SELF:= []));

dl4key := PROJECT(dl2_base(dl_number <> ''), Layouts.ExtendedLayout);

Layouts.ExtendedLayout getCountyName(Layouts.ExtendedLayout le, Census_data.File_Fips2County ri) := TRANSFORM
	SELF.county_name := ri.county_name;
	SELF := le;
END;
o0 := JOIN(dl4key, Census_data.File_Fips2County, 
				LEFT.county = RIGHT.county_fips AND LEFT.st = RIGHT.state_code, 
				getCountyName(LEFT, RIGHT), lookup, LEFT OUTER);

Layouts.ExtendedLayout getHist(Layouts.ExtendedLayout L, codes.File_Codes_V3_In R):= transform
	self.history_name := stringlib.StringToUpperCase(R.long_desc);
	self := L;
end;
o1 := join(o0,
		 codes.File_Codes_V3_In(file_name = 'DRIVERS_LICENSE',field_name = 'HISTORY'),
		 (string15)left.history = right.code,getHist(LEFT,RIGHT),left outer, lookup);


Layouts.ExtendedLayout getAttention(Layouts.ExtendedLayout L, codes.File_Codes_V3_In R) := transform
	self.attention_name:= IF(R.long_desc != '', stringlib.StringToUpperCase(R.long_desc), L.attention_flag);
	self := L;
end;
o2 := join(o1,
		 codes.File_Codes_V3_In(file_name = 'DRIVERS_LICENSE',field_name = 'ATTENTION_FLAG'),
		 (String15)left.attention_flag = right.code and left.orig_state = right.field_name2,
		 getAttention(LEFT,RIGHT),left outer, lookup);


Layouts.ExtendedLayout GetSexAndRace(Layouts.ExtendedLayout L, codes.File_Codes_V3_In R) := transform
	self.sex_name := if (R.long_desc = '', 'UNKNOWN', stringlib.StringToUpperCase(R.long_desc)); 
	self.race_name := map(L.race = 'W' => 'WHITE',
					  L.race = 'B' => 'BLACK',
					  L.race = 'H' => 'HISPANIC',
					  L.race = 'A' => 'ASIAN',
					  L.race = 'I' => 'NATIVE AMERICAN',
					  L.race = 'O' => 'OTHER',
					  L.race);
	self := L;
end;
o3 := join(o2,codes.File_Codes_V3_In(file_name = 'GENERAL',field_name = 'GENDER'),
		 (string15)left.sex_flag = right.code, getSexAndRace(LEFT,RIGHT),left outer, lookup);


Layouts.ExtendedLayout getHairColor(Layouts.ExtendedLayout L, codes.File_Codes_V3_In R) := transform
	self.hair_color_name := stringlib.StringToUpperCase(R.long_desc);
	self := L;
end;
o4 := join(o3,
		 codes.File_Codes_V3_In(file_name = 'DRIVERS_LICENSE',field_name = 'HAIR_COLOR'),
		 left.orig_state = right.field_name2 and left.hair_color = right.code,
		 getHairColor(LEFT,RIGHT),left outer, lookup);


Layouts.ExtendedLayout getEyeColor(Layouts.ExtendedLayout L, codes.File_Codes_V3_In R) := transform
	self.eye_Color_name := stringlib.StringToUpperCase(R.long_desc);
	self := L;
end;
o5 := join(o4,
		 codes.File_Codes_V3_In(file_name = 'DRIVERS_LICENSE',field_name= 'EYE_COLOR'), 
		 left.orig_state = right.field_name2 and left.eye_color = right.code, 
		 getEyeColor(LEFT,RIGHT),left outer, lookup);

Layouts.ExtendedLayout getState(Layouts.ExtendedLayout L, codes.File_Codes_V3_In R) := transform
	self.orig_state_name := stringlib.StringToUpperCase(R.long_desc);
	self := L;
end;
o6 := join(o5,
		 codes.File_Codes_V3_In(file_name = 'GENERAL', field_name= 'STATE_LONG'),
		 left.orig_state = right.code,
		 getState(LEFT,RIGHT),left outer, lookup);

EXPORT dl2_dl_number			  := o6;


file_search_prep := PROJECT(dl2_base, Layouts.Layout_Base - cust_name - bug_num);

export File_DL_Search 			  := Header.fn_dlamxtnd(file_search_prep);

Layouts.Layout_DL_Wildcard tMap(Layouts.Layout_Drivers l) :=	transform
	self.dl_number				:= l.dl_number;
	self.dl_seq						:= l.dl_seq;
	self.orig_state				:= ut.St2Code(l.orig_state);
	self.gender 					:= l.sex_flag;
	self.years_since_1900	:= (integer)l.dob div 10000 - 1900;
end;
	
dsWildcard := project(File_DL_Search, tMap(left));
		
EXPORT DS_Wildcard	:= dedup(dsWildcard, record);
		
only_with := dl2_base(race IN ['W','H','A','I','B'],
									sex_flag IN ['M','F'],(INTEGER)age<>0);


Layouts.Layout_indic_rec proj(only_with le) := TRANSFORM
	SELF.age := (INTEGER)le.age;
	SELF := le;
END;

P := project(only_with, proj(LEFT));

dl4key := dedup(SORT(p, race, sex_flag, age, orig_state, dl_number), race, sex_flag, age, orig_state, dl_number);

Layouts.Layout_indic_rec iter(Layouts.Layout_indic_rec le, Layouts.Layout_indic_rec ri) := TRANSFORM
	SELF.randomizer := IF(le.randomizer=0 OR le.randomizer=10000, 1, le.randomizer+1);
	SELF := ri;
END;

EXPORT DS_Indicative := ITERATE(dl4key,iter(LEFT,RIGHT));

	
SHARED fakepf := dataset([],Layouts.Layout_DL_AutoKeys);

	

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,zero,Constants.ak_qa_name +'Payload',plk,'')

Key_DL_AutoKey_Payload := plk;




mod_PL := PROJECT(Key_DL_AutoKey_Payload
	,TRANSFORM(Layouts.Layouts_DL_uber_Layout_Base
	,SELF.pfname := NID.PreferredFirstVersionedStr(LEFT.fname, NID.version)
	,SELF.dph_lname := metaphonelib.DMetaPhone1(LEFT.lname)[1..6]
	,SELF := LEFT));
	 
infile :=mod_PL;

fld_cnst(string fld) := Autokey.UBER_Constants.Uber_FieldData(FieldName=fld)[1].FieldID;	
	
Layouts.Layouts_DL_uber_Layout_Plus IntoInversion(infile le,unsigned2 c) := transform
	 self.word := choose(c,(string)le.FNAME,(string)le.PFNAME,(string)le.MNAME
	,(string)le.LNAME,(string)le.DPH_LNAME,(string)le.PRIM_RANGE,(string)le.PREDIR
	,(string)le.PRIM_NAME,(string)le.SUFFIX,(string)le.POSTDIR
	,(string)le.UNIT_DESIG,(string)le.SEC_RANGE,(string)le.P_CITY_NAME
	,(string)le.ST,(string)le.ZIP5,(string)le.DOB,SKIP);

	 self.field := choose(c,fld_cnst('FNAME'),fld_cnst('PFNAME'),fld_cnst('MNAME')
	,fld_cnst('LNAME'),fld_cnst('DPH_LNAME'),fld_cnst('PRANGE'),fld_cnst('PREDIR')
	,fld_cnst('PNAME'),fld_cnst('SUFFIX'),fld_cnst('POSTDIR')
	,fld_cnst('UNIT_DESIG'),fld_cnst('SEC_RANGE'),fld_cnst('CITY')
	,fld_cnst('STATE'),fld_cnst('ZIP'),fld_cnst('DOB'),SKIP);
	 self.uid := le.FAKEID;
end;
   
nfields_r := normalize(infile,16,IntoInversion(left,counter),local);
   
//NORMALIZING ADDR
Layouts.Layouts_DL_uber_Layout_Plus tr(infile le,unsigned c,unsigned typ,unsigned fld) := transform
	new_word := MAP(typ =1=>le.prim_range
				   ,typ =2=>le.predir
				   ,typ =3=>le.prim_name
				   ,typ =4=>le.suffix
				   ,typ =5=>le.postdir
				   ,typ =6=>le.unit_desig
				   ,typ =7=>le.sec_range
								 ,'');
	self.word := ut.Word((string)new_word,c);
	self.uid := le.fakeid;
	self.field := fld;
end;

cnt_flds := 	normalize(infile,ut.NoWords((string)left.prim_range),tr(left,counter,1,fld_cnst('ADDR')),local)
				+normalize(infile,ut.NoWords((string)left.predir),tr(left,counter,2,fld_cnst('ADDR')),local)
				+normalize(infile,ut.NoWords((string)left.prim_name),tr(left,counter,3,fld_cnst('ADDR')),local)
				+normalize(infile,ut.NoWords((string)left.suffix),tr(left,counter,4,fld_cnst('ADDR')),local)
				+normalize(infile,ut.NoWords((string)left.postdir),tr(left,counter,5,fld_cnst('ADDR')),local)
				+normalize(infile,ut.NoWords((string)left.unit_desig),tr(left,counter,6,fld_cnst('ADDR')),local)
				+normalize(infile,ut.NoWords((string)left.sec_range),tr(left,counter,7,fld_cnst('ADDR')),local);

//WORD TABLE
invert_records := (nfields_r + cnt_flds)(word<>'');

File_uber_in := dedup(sort(invert_records,uid,word,field,local),uid,word,field,local);

shared tab:= File_uber_in;


word_values := UNGROUP(TABLE(GROUP(SORT(
	TABLE(GROUP(sort(tab,word,local),word),{word,unsigned8 cnt1:=COUNT(GROUP)},local)
	,word),word),{word,unsigned8 cnt:=SUM(GROUP,cnt1),id:=0})); 
   
words := PROJECT(word_values
	,TRANSFORM(AutoKey.Layout_uber.word_rec
	,SELF := LEFT,SELF := []));
   
typeof(words) tra(words lef,words ref) := transform
	 self.id := if(lef.id=0,thorlib.node()+1,lef.id+thorlib.nodes());
	 self := ref;
end;

EXPORT UBER_WORD_IN :=iterate(words,tra(left,right),local);

 //INVERSION TABLE 
AutoKey.Layout_uber.ref_rec add_id(tab le, UBER_WORD_IN ri) := transform
	self.word_id := ri.id;
	self := le;
end;
   
EXPORT  UBER_INV_TAB := JOIN(tab, UBER_WORD_IN,LEFT.word =RIGHT.word,add_id(LEFt,RIGHT),local);
 
END;