export Mac_Is_Business(inFile, Field, outFile, nameType='nametype', dodedup=true, doclean=false,
		title = 'cln_title',		// cleaned title field
		fname = 'cln_fname',		// cleaned first name field
		mname = 'cln_mname',		// cleaned middle name field
		lname = 'cln_lname',		// cleaned last name field
		suffix = 'cln_suffix',		// cleaned suffix field
		title2 = 'cln_title2',		// cleaned title field
		fname2 = 'cln_fname2',		// cleaned first name field
		mname2 = 'cln_mname2',		// cleaned middle name field
		lname2 = 'cln_lname2',		// cleaned last name field
		suffix2 = 'cln_suffix2',	// cleaned suffix field
		options = '[]'				// 'X' for experimental name cleaner (Dataland only)
									// 'F' for force FML name order
									// 'f' for prefer FML name order
									// 'L' for force LFM name order
									// 'l' for prefer LFM name order
									// 'W' for watercraft format
									
) := MACRO
/*****************************************************************

This macro will analyze a dataset to determine if a name is a business name
It will create a dataset, adding a Name Type field, if necessary, of type String1.
The Indicator will have one of the following values:
	B		Business name
	P		Person name
	D		Dual name
	U		Unclassified
	(blank)	"Field" is blank


inFile		Input dataset
Field		input field to analyze
outFile		Output dataset
nameType	The name of the field in the output dataset that holds the result
dodedup		If true, dedup that input dataset on "Field"
doclean		If true, clean the name, if it is determined to be a person name


******************************************************************/

#UNIQUENAME(ind_layout)
// layout for nameType
	%ind_layout% := RECORD
		string1 nameType := '';
	END;
	
	
#UNIQUENAME(cln_layout)
// layout with cleaned name
	%cln_layout% := RECORD
		string1		nameType := '';
		string5		title := '';
		string20	fname := '';
		string20	mname := '';
		string20	lname := '';
		string5		suffix := '';
		string5		title2 := '';
		string20	fname2 := '';
		string20	mname2 := '';
		string20	lname2 := '';
		string5		suffix2 := '';
	END;
	
#UNIQUENAME(new_layout)
#IF(doclean=true)
	%new_layout% := {RecordOf(inFile) OR %cln_layout%};
#ELSE
	%new_layout% := {RecordOf(inFile) OR %ind_layout%};
#END
  
#UNIQUENAME(xform)
	%new_layout% %xform%(RECORDOF(inFile) L) := TRANSFORM
		nametype := Address.Business.GetNameType(L.Field, options);
		self.nameType := nametype;
#IF(doclean=true)
		name := TRIM(L.Field,LEFT,RIGHT);		
		hint := IF(nametype='D','D', MAP(
			'F' in options => 'F',
			'f' in options => 'f',
			'L' in options => 'L',
			'l' in options => 'l',
			'U'));
		
#uniquename(use_experimental)
%use_experimental% := 'X' in options;
#if(%use_experimental%)
		//string140 cln_name := Address.NameCleaner.CleanNameEx(name, hint);
		string140 cln_name := IF(nametype IN ['P','D'],
						Address.NameCleaner.CleanNameEx(name, hint),
						'');
#else
	//cln_name := Address.Persons.CleanName(name, hint);
		string140 cln_name := IF(nametype IN ['P','D'],
						Address.Persons.CleanName(name, hint),
						'');
#end

		self.title		:= cln_name[1..5];
		self.fname		:= cln_name[6..25];
		self.mname		:= cln_name[26..45];
		self.lname		:= cln_name[46..65];
		self.suffix	    := cln_name[66..70];
		self.title2		:= cln_name[71..75];
		self.fname2		:= cln_name[76..95];
		self.mname2		:= cln_name[96..115];
		self.lname2		:= cln_name[116..135];
		self.suffix2    := cln_name[136..140];
#END
		self := L;
	END;

#UNIQUENAME(src)
	%src% := inFile;
#UNIQUENAME(dsin)
	%dsin% := IF(dodedup,
					DISTRIBUTE(%src%(TRIM(Field)<>''),HASH64(Field)),
					inFile);
					
#UNIQUENAME(ds)

	%ds% := IF(dodedup,DEDUP(SORT(DISTRIBUTED(%dsin%,HASH64(Field)), Field, LOCAL),
				 Field, LOCAL),
				inFile);

#UNIQUENAME(dsOut)
	
	%dsOut% := PROJECT(%ds%,  %xform%(LEFT)) : onwarning(4538,ignore);

	
#UNIQUENAME(xform2)
	%new_layout% %xform2%(RECORDOF(inFile) L, %new_layout% R) := TRANSFORM
		self.nameType := R.nameType;
#IF(doclean=true)
		self.title := R.title;
		self.fname := R.fname;
		self.mname := R.mname;
		self.lname := R.lname;
		self.suffix := R.suffix;
		self.title2 := R.title2;
		self.fname2 := R.fname2;
		self.mname2 := R.mname2;
		self.lname2 := R.lname2;
		self.suffix2 := R.suffix2;
#END
		self := L;
	END;
	
	outFile := IF(dodedup,
					JOIN(DISTRIBUTED(%dsin%,HASH64(Field)),
						DISTRIBUTED(%dsOut%,HASH64(Field)),
						LEFT.Field=RIGHT.Field,
							%xform2%(LEFT, RIGHT), LOCAL, LEFT OUTER, KEEP(1))
					+ PROJECT(%src%(TRIM(Field)=''),%new_layout%),
					%dsOut%);

ENDMACRO;