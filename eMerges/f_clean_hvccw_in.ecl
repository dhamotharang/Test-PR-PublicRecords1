import _validate;
export f_clean_hvccw_in (DATASET(layout_hunt_ccw.rHuntCCWCleanAddr_layout) hvccw_in ) := function

	RECORDOF(hvccw_in) clean_input(RECORDOF(hvccw_in) L) := TRANSFORM
		//Clean name fields 
		STRING lname_in := regexreplace('[^[:alpha:]]',L.lname_in,' ');
		SELF.lname_in := IF(regexfind('NULL|NONE',StringLib.StringToUpperCase(lname_in)),'',lname_in);

		STRING fname_in := regexreplace('[^[:alpha:]]',L.fname_in,' ');
		SELF.fname_in := IF(regexfind('NULL|NONE',StringLib.StringToUpperCase(fname_in)),'',fname_in);

		STRING mname_in := regexreplace('[^[:alpha:]]',L.mname_in,' ');
		SELF.mname_in := IF(regexfind('NULL|NONE',StringLib.StringToUpperCase(mname_in)),'',mname_in);

		//Clean addr fields
		// resaddr1 :=  regexreplace('[^[:alnum:] ]',L.resaddr1,' ');
		SELF.resaddr1 := IF(regexfind('NULL|NONE',StringLib.StringToUpperCase(L.resaddr1)),'',L.resaddr1);

		// resaddr2 :=  regexreplace('[^[:alnum:] \043]',L.resaddr2,' ');
		SELF.resaddr2 := IF(regexfind('NULL|NONE',StringLib.StringToUpperCase(L.resaddr2)),'',L.resaddr2);

		res_city :=  regexreplace('[^[:alpha:] ]',L.res_city,' ');
		SELF.res_city := IF(regexfind('NULL|NONE',StringLib.StringToUpperCase(res_city)),'',res_city);

		SELF.res_state := IF(regexfind('NO',StringLib.StringToUpperCase(L.res_state)),'',L.res_state);

		//Clean License Date
		STRING DateLicense_in := _validate.date.fCorrectedDateString(L.DateLicense_in,false);
		SELF.DateLicense_in := IF( NOT _validate.date.fIsValid(DateLicense_in,,true,true),'',regexreplace('[0]{4}$',DateLicense_in,''));

		//Clean ssn
		SELF.best_ssn := IF(regexfind('^00*$',L.best_ssn),'',L.best_ssn);

		//Clean gender
		SELF.gender := IF(L.gender NOT IN ['M','F'],'',L.gender);

		//"Cleaned" Fields
		STRING title := regexreplace('[^[:alpha:]]',L.title,' ');
		SELF.title := IF(regexfind('NULL|NONE',StringLib.StringToUpperCase(title)),'',title);

		STRING fname := regexreplace('[^[:alpha:]]',L.fname,' ');
		SELF.fname := IF(regexfind('NULL|NONE',StringLib.StringToUpperCase(fname)),'',fname);

		STRING mname := regexreplace('[^[:alpha:]]',L.mname,' ');
		SELF.mname := IF(regexfind('NULL|NONE',StringLib.StringToUpperCase(mname)),'',mname);

		STRING lname := regexreplace('[^[:alpha:]]',L.lname,' ');
		SELF.lname := IF(regexfind('NULL|NONE',StringLib.StringToUpperCase(lname)),'',lname);

		STRING name_suffix := regexreplace('[^[:alpha:]]',L.name_suffix,' ');
		SELF.name_suffix := IF(regexfind('NULL|NONE',StringLib.StringToUpperCase(name_suffix)),'',name_suffix);

		SELF.prim_range := IF(regexfind('NULL|NONE',StringLib.StringToUpperCase(L.prim_range)),'',regexreplace('[^[:digit:]]',L.prim_range,' '));

		// STRING prim_name := regexreplace('[^[:alnum:]]',L.prim_name,' ');
		SELF.prim_name := IF(regexfind('NULL|NONE',StringLib.StringToUpperCase(L.prim_name)),'',L.prim_name);

		STRING suffix := regexreplace('[^[:alpha:]]',L.suffix,' ');
		SELF.suffix := IF(regexfind('NULL|NONE',StringLib.StringToUpperCase(suffix)),'',suffix);

		STRING postdir := regexreplace('[^[:alpha:]]',L.postdir,' ');
		SELF.postdir := IF(regexfind('NULL|NONE',StringLib.StringToUpperCase(postdir)),'',postdir);

		STRING unit_desig := regexreplace('[^[:alpha:]]',L.unit_desig,' ');
		SELF.unit_desig := IF(regexfind('NULL|NONE',StringLib.StringToUpperCase(unit_desig)),'',unit_desig);

		SELF.sec_range := IF(regexfind('NULL|NONE',StringLib.StringToUpperCase(L.sec_range)),'',regexreplace('[^[:digit:]]',L.sec_range,' '));

		STRING p_city_name := regexreplace('[^[:alpha:]]',L.p_city_name,' ');
		SELF.p_city_name := IF(regexfind('NULL|NONE',StringLib.StringToUpperCase(p_city_name)),'',p_city_name);

		SELF.st := IF(regexfind('NO',StringLib.StringToUpperCase(L.st)),'',StringLib.StringToUpperCase(L.st));

		STRING city_name := regexreplace('[^[:alpha:]]',L.city_name,' ');
		SELF.city_name := IF(regexfind('NULL|NONE',StringLib.StringToUpperCase(city_name)),'',city_name);

		SELF.zip := IF(regexfind('NULL|NONE',StringLib.StringToUpperCase(L.zip)),'',regexreplace('[^[:digit:]]',L.zip,' '));
		SELF.zip4 := IF(regexfind('NULL|NONE',StringLib.StringToUpperCase(L.zip4)),'',regexreplace('[^[:digit:]]',L.zip4,' '));

		SELF.source_code	:=	stringlib.stringtouppercase(L.source_code);

		SELF := L;
	end;

	return PROJECT(hvccw_in,clean_input(LEFT));

end;