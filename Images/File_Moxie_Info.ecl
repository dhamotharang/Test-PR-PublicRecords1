import crim_common, hygenics_crim, ut;

preLayout :=
RECORD
	STRING file_name;
	STRING pointer;
	STRING dir;
	STRING date_created;
	STRING seisint_primary_key;
	STRING md5;
	STRING st;
	STRING url;
	STRING url_status;
	STRING status;
	STRING ext;
	STRING cnter;
	STRING dbversion;
END;

preFile := dataset('~thor_data400::in::MoxieImagesInfo_fixKY', preLayout, 
							csv(SEPARATOR('\t'), TERMINATOR('\n'), QUOTE('"')));

Layout_Moxie_Info goodLayout(preLayout L) := TRANSFORM
	SELF.url_status := (INTEGER)L.url_status;
	SELF.status := (INTEGER)L.status;
	SELF.cnter := (INTEGER)L.cnter;
	SELF.dbversion := (INTEGER)L.dbversion;
	SELF := L;
END;
		
jpgPos(STRING nm) := IF(StringLib.StringFind(StringLib.StringToUpperCase(nm), '.JPG', 1) > 0,
						StringLib.StringFind(StringLib.StringToUpperCase(nm), '.JPG', 1)-1, 
						LENGTH(TRIM(nm)));

p := PROJECT(preFile, goodLayout(LEFT));
		
//f := crim_common.File_Crim_Offender2_Plus;

DOCpublicFiles 			:= hygenics_crim.File_Moxie_Crim_Offender2_Dev;
dFile								:= DOCpublicFiles(data_type='1');

	oldLayout	:= record
		string60 offender_key;
		string2  state_origin;
		string10 doc_num;
	end;

	oldLayout fixLayout(dFile l):= transform
		SELF.state_origin	 		:= ut.st2abbrev(stringlib.stringtouppercase(l.orig_state));
		self 									:= l;
	end;
	
f := project(dFile, fixLayout(left));

crims := TABLE(f, {f.state_origin, f.offender_key, f.doc_num});
crim 	:= DEDUP(crims, state_origin, offender_key, all);		
		
Layout_Moxie_Info getdoc(Layout_Moxie_Info L, crim R) :=
TRANSFORM
	SELF.seisint_primary_key := IF(TRIM(R.doc_num) != '', R.doc_num, L.seisint_primary_key);
	SELF := L;
END;

j1 := JOIN(p, crim, 
		  LEFT.st = RIGHT.state_origin AND LEFT.seisint_primary_key = RIGHT.offender_key, 
		  getdoc(LEFT, RIGHT), hash);
		  
j2 := JOIN(p, crim, 
		  LEFT.st = RIGHT.state_origin AND LEFT.seisint_primary_key = RIGHT.offender_key, 
		  getdoc(LEFT, RIGHT), LEFT ONLY, hash);


export File_Moxie_Info := DISTRIBUTE(j1+j2, HASH(file_name[1..jpgPos(file_name)])) : persist('persist::moxie_info');