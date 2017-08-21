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

df := dataset('~images::in::MI_INFO_20050617',prelayout,csv(SEPARATOR('\t'), TERMINATOR('\n'), QUOTE('"')));

Layout_Moxie_Info goodLayout(preLayout L) :=
TRANSFORM
	SELF.url_status := (INTEGER)L.url_status;
	SELF.status := (INTEGER)L.status;
	SELF.cnter := (INTEGER)L.cnter;
	SELF.dbversion := (INTEGER)L.dbversion;
	SELF := L;
END;



export File_MI_Info := project(df,goodlayout(LEFT)); 

