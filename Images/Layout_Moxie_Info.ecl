export Layout_Moxie_Info :=
RECORD
	STRING32 file_name;
	STRING32 pointer;
	STRING32 dir;
	STRING14 date_created;
	STRING75 seisint_primary_key;
	STRING32 md5;
	STRING2 st;
	STRING140 url;
	INTEGER1 url_status;
	INTEGER1 status;
	STRING4 ext;
	INTEGER cnter;
	INTEGER dbversion;
END;