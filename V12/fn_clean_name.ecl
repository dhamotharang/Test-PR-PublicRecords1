import V12, Ut, Lib_FileServices, lib_stringlib;

EXPORT varstring fn_clean_name(string name) := FUNCTION
        string temp_name   := ut.fnTrim2Upper(name);
        string temp_name1  := StringLib.StringFindReplace(temp_name,'*','');
        string temp_name2  := StringLib.StringFindReplace(temp_name1,'%','');
        string temp_name3  := StringLib.StringFindReplace(temp_name2,',',' ');
        string temp_name4  := StringLib.StringFindReplace(temp_name3,'(','');
        string temp_name5  := StringLib.StringFindReplace(temp_name4,')','');
        string temp_name6  := StringLib.StringFindReplace(temp_name5,':','');
        string temp_name7  := StringLib.StringFindReplace(temp_name6,';',' ');
				string temp_name8  := StringLib.StringFindReplace(temp_name7,'#','');
				string temp_name9 := StringLib.StringFindReplace(temp_name8,'"','');
				string temp_name10 := StringLib.StringFindReplace(temp_name9,'~','');
				string temp_name11 := StringLib.StringFindReplace(temp_name10,'}','');
				string temp_name12 := StringLib.StringFindReplace(temp_name11,']','');
				string temp_name13 := StringLib.StringFindReplace(temp_name12,'[','');
				string temp_name14 := StringLib.StringFindReplace(temp_name13,'/','');
				string temp_name15 := StringLib.StringFindReplace(temp_name14,'<FONT COLOR=FF0000>','');
				string temp_name16 := StringLib.StringFindReplace(temp_name15,'<FONT COLOR=666699>','');
				string temp_name17 := StringLib.StringFindReplace(temp_name16,'&','');
				string temp_name18 := StringLib.StringFindReplace(temp_name17,'=','');
				string temp_name19 := StringLib.StringFindReplace(temp_name18,'!','');
				string temp_name20 := StringLib.StringFindReplace(temp_name19,'--','');
				string temp_name21  := regexreplace('\'',temp_name20,'');
				return trim(temp_name21,left,right);
END;



