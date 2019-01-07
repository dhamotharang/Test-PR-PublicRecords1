IMPORT	tools, ut, std, PRTE2;
EXPORT Files := MODULE

	EXPORT	Input_Raw	:=  DATASET(Filenames().Input.Sprayed, Layout_Infile.Raw, CSV(HEADING(0), SEPARATOR('|'), QUOTE('')));	
	//Clean \, ', and "
	Layout_Infile.Raw fClean1(Layout_Infile.Raw L) := TRANSFORM
		// filter1 := std.str.findreplace(L.MSNAME,'\\\'','');
		filter1 := REGEXREPLACE('O(\\\\)+(\')*(\\\\)*(\')*',TRIM(L.MSNAME,LEFT,RIGHT),'O');
		filter2 := REGEXREPLACE('[\'|"]+',filter1,'');
		//remove trailing backslash
		filter3 := REGEXREPLACE('(\\\\)+$',filter2,'');
		filter4 := REGEXREPLACE('(^|MR |MS |MRS )([A-Z]+)([ ]*)([\\\\]+)([ ]*)([A-Z]+) ',filter3,'$2/$6 ');
		SELF.MSNAME := std.str.findreplace(filter4,'\\',' ');
		SELF := L;
	END;
	ds_raw_clean1 := PROJECT(Input_Raw,fClean1(left));
	PRTE2.CleanFields(ds_raw_clean1, dFieldsCleaned);
	EXPORT Input_FieldsCleaned := dFieldsCleaned;
	EXPORT	Basefile	:=  DATASET(Filenames().Base, Layout_Basefile, THOR, OPT);

END;