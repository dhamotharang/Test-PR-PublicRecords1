export Layouts := 
module

	export File_Hdr_Biz_Keybuild_Layout := record
		unsigned6  rcid;
		qstring10  prim_range;
		qstring28  prim_name;
		qstring8   sec_range;
		qstring25  city_name;
		unsigned4  city_code;
		qstring2   state;
		integer4   zip;
		qstring40  word;
		qstring40  indic;
		qstring40  sec;
		qstring120 cname;
		unsigned4  fein;
		string7    p7;
		string3    p3;
		unsigned6  bdid;
	end;
	
	export Key_Hdr_Biz_Address_Layout := record
		File_Hdr_Biz_Keybuild_Layout.prim_name;
		File_Hdr_Biz_Keybuild_Layout.prim_range;
		File_Hdr_Biz_Keybuild_Layout.state;
		File_Hdr_Biz_Keybuild_Layout.city_code;
		File_Hdr_Biz_Keybuild_Layout.zip;
		File_Hdr_Biz_Keybuild_Layout.sec_range;
		File_Hdr_Biz_Keybuild_Layout.word;
		File_Hdr_Biz_Keybuild_Layout.indic;
		File_Hdr_Biz_Keybuild_Layout.sec;
		File_Hdr_Biz_Keybuild_Layout.cname;
		File_Hdr_Biz_Keybuild_Layout.bdid;
	end;
	
	export Key_Hdr_Biz_Street_Layout := record
		File_Hdr_Biz_Keybuild_Layout.prim_name;
		File_Hdr_Biz_Keybuild_Layout.zip;
		File_Hdr_Biz_Keybuild_Layout.word;
		File_Hdr_Biz_Keybuild_Layout.prim_range;
		File_Hdr_Biz_Keybuild_Layout.indic;
		File_Hdr_Biz_Keybuild_Layout.sec;
		File_Hdr_Biz_Keybuild_Layout.cname;
		File_Hdr_Biz_Keybuild_Layout.bdid;
	end;
	
	export Key_Hdr_Biz_FEIN_Layout := record
		string1 f1;
		string1 f2;
		string1 f3;
		string1 f4;
		string1 f5;
		string1 f6;
		string1 f7;
		string1 f8;
		string1 f9;
		File_Hdr_Biz_Keybuild_Layout.word;
		File_Hdr_Biz_Keybuild_Layout.indic;
		File_Hdr_Biz_Keybuild_Layout.sec;
		File_Hdr_Biz_Keybuild_Layout.cname;
		File_Hdr_Biz_Keybuild_Layout.bdid;
	end;
	
	export Key_Hdr_Biz_Phone_Layout := record
		File_Hdr_Biz_Keybuild_Layout.p7;
		File_Hdr_Biz_Keybuild_Layout.p3;
		File_Hdr_Biz_Keybuild_Layout.word;
		File_Hdr_Biz_Keybuild_Layout.indic;
		File_Hdr_Biz_Keybuild_Layout.sec;
		File_Hdr_Biz_Keybuild_Layout.cname;
		File_Hdr_Biz_Keybuild_Layout.state;
		File_Hdr_Biz_Keybuild_Layout.bdid;
	end;
	
	export Key_Hdr_Biz_Name_Layout := record
		File_Hdr_Biz_Keybuild_Layout.word;
		File_Hdr_Biz_Keybuild_Layout.indic;
		File_Hdr_Biz_Keybuild_Layout.sec;
		File_Hdr_Biz_Keybuild_Layout.cname;
		File_Hdr_Biz_Keybuild_Layout.fein;
		File_Hdr_Biz_Keybuild_Layout.bdid;
	end;
	
	export Key_Hdr_Biz_StCityName_Layout := record
		File_Hdr_Biz_Keybuild_Layout.city_code;
		File_Hdr_Biz_Keybuild_Layout.state;
		File_Hdr_Biz_Keybuild_Layout.word;
		File_Hdr_Biz_Keybuild_Layout.indic;
		File_Hdr_Biz_Keybuild_Layout.sec;
		File_Hdr_Biz_Keybuild_Layout.cname;
		File_Hdr_Biz_Keybuild_Layout.bdid;
	end;
	
	export Key_Hdr_Biz_StName_Layout := record
		File_Hdr_Biz_Keybuild_Layout.state;
		File_Hdr_Biz_Keybuild_Layout.word;
		File_Hdr_Biz_Keybuild_Layout.indic;
		File_Hdr_Biz_Keybuild_Layout.sec;
		File_Hdr_Biz_Keybuild_Layout.cname;
		File_Hdr_Biz_Keybuild_Layout.fein;
		File_Hdr_Biz_Keybuild_Layout.zip;
		File_Hdr_Biz_Keybuild_Layout.bdid;
	end;
	
	export Key_Hdr_Biz_Zip_Layout := record
		File_Hdr_Biz_Keybuild_Layout.zip;
		File_Hdr_Biz_Keybuild_Layout.word;
		File_Hdr_Biz_Keybuild_Layout.indic;
		File_Hdr_Biz_Keybuild_Layout.sec;
		File_Hdr_Biz_Keybuild_Layout.cname;
		File_Hdr_Biz_Keybuild_Layout.fein;
		File_Hdr_Biz_Keybuild_Layout.bdid;
	end;

end;
