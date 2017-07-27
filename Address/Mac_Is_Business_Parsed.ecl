export Mac_Is_Business_Parsed(inFile, 
		outFile, 
		fname='fname',mname='mname',lname='lname',suffix='name_suffix',
		fullname='fullname',
		nameType='nametype', 
		dodedup=true, doclean=false,
		cln_title = 'cln_title',		// cleaned title field
		cln_fname = 'cln_fname',		// cleaned first name field
		cln_mname = 'cln_mname',		// cleaned middle name field
		cln_lname = 'cln_lname',		// cleaned last name field
		cln_suffix = 'cln_suffix',		// cleaned suffix field
		cln_title2 = 'cln_title2',		// cleaned title field
		cln_fname2 = 'cln_fname2',		// cleaned first name field
		cln_mname2 = 'cln_mname2',		// cleaned middle name field
		cln_lname2 = 'cln_lname2',		// cleaned last name field
		cln_suffix2 = 'cln_suffix2',	// cleaned suffix field
		options = '[]'				// 'X' for experimental name cleaner
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

The remaining fields are documented in Address.Mac_Is_Business

******************************************************************/

#UNIQUENAME(nosuffix)
%nosuffix% := IF(#TEXT(suffix) = '\'\'', true, false);

#UNIQUENAME(ind_layout)
// layout for nameType
	%ind_layout% := RECORD
		string80	fullname := '';
		string1 	nameType := '';
	END;
	
	
#UNIQUENAME(cln_layout)
// layout with cleaned name
	%cln_layout% := RECORD
		string80	fullname := '';
		string1		nameType := '';
		string5		cln_title := '';
		string20	cln_fname := '';
		string20	cln_mname := '';
		string20	cln_lname := '';
		string5		cln_suffix := '';
		string5		cln_title2 := '';
		string20	cln_fname2 := '';
		string20	cln_mname2 := '';
		string20	cln_lname2 := '';
		string5		cln_suffix2 := '';
	END;
	
#UNIQUENAME(new_layout)
#IF(doclean=true)
	%new_layout% := {RecordOf(inFile) OR %cln_layout%};
#ELSE
	%new_layout% := {RecordOf(inFile) OR %ind_layout%};
#END
  
#UNIQUENAME(xform)
	%new_layout% %xform%(RECORDOF(inFile) L) := TRANSFORM

		name := Address.Persons.ReconstructName(L.fname,L.mname,L.lname,
#IF(%nosuffix%)
		''
#ELSE
		L.suffix
#END
		);
		nametype := Address.Business.GetNameType(name);
		//self.fullname := name;
		self.fullname := Address.Persons.SuffixToAlpha(Address.Persons.FixupName(name));
		self.nameType := nametype;
#IF(doclean=true)
		hint := IF(nametype='D','D','f');

#uniquename(use_experimental)
%use_experimental% := 'X' in options;
#if(%use_experimental%)
		string140 cln_name := Address.NameCleaner.CleanNameEx(name, hint);
#else
	cln_name := Address.Persons.CleanName(name, hint);
#end
		self.cln_title		:= cln_name[1..5];
		self.cln_fname		:= cln_name[6..25];
		self.cln_mname		:= cln_name[26..45];
		self.cln_lname		:= cln_name[46..65];
		self.cln_suffix	    := cln_name[66..70];
		self.cln_title2		:= cln_name[71..75];
		self.cln_fname2		:= cln_name[76..95];
		self.cln_mname2		:= cln_name[96..115];
		self.cln_lname2		:= cln_name[116..135];
		self.cln_suffix2    := cln_name[136..140];
#END
		self := L;
	END;
	
#UNIQUENAME(dsin)
	%dsin% := IF(dodedup,
					DISTRIBUTE(inFile(TRIM(fname) + TRIM(mname) + TRIM(lname)<>''),
							HASH64(lname,fname,mname
#IF(NOT %nosuffix%)
							,suffix
#END
					)),
					inFile);
					
#UNIQUENAME(ds)
	%ds% := IF(dodedup,DEDUP(
							SORT(DISTRIBUTED(%dsin%,
									HASH64(lname,fname,mname
#IF(NOT %nosuffix%)
							,suffix
#END
							)),
							lname,fname,mname
#IF(NOT %nosuffix%)
							,suffix
#END
							, LOCAL),
						lname,fname,mname
#IF(NOT %nosuffix%)
						,suffix
#END
						, LOCAL),
				inFile);

#UNIQUENAME(dsOut)

	%dsOut% := PROJECT(%ds%,  %xform%(LEFT)) : onwarning(4538,ignore);
	//%dsOut% := DISTRIBUTE(PROJECT(%ds%,  %xform%(LEFT)),HASH64(lname,fname,mname
//#IF(NOT %nosuffix%)
//								,suffix
//#END
//					));
	
#UNIQUENAME(xform2)
	%new_layout% %xform2%(RECORDOF(inFile) L, %new_layout% R) := TRANSFORM
		self.fullname := R.fullname;
		self.nameType := R.nameType;
#IF(doclean=true)
		self.cln_title := R.cln_title;
		self.cln_fname := R.cln_fname;
		self.cln_mname := R.cln_mname;
		self.cln_lname := R.cln_lname;
		self.cln_suffix := R.cln_suffix;
		self.cln_title2 := R.cln_title2;
		self.cln_fname2 := R.cln_fname2;
		self.cln_mname2 := R.cln_mname2;
		self.cln_lname2 := R.cln_lname2;
		self.cln_suffix2 := R.cln_suffix2;
#END
		self := L;
	END;
/*	
	outFile := IF(dodedup,
					JOIN(inFile, %dsOut%, 
					LEFT.fname=RIGHT.fname AND LEFT.mname=RIGHT.mname AND LEFT.lname=RIGHT.lname
#IF(NOT %nosuffix%)
					AND LEFT.suffix=RIGHT.suffix
#END
					,%xform2%(LEFT, RIGHT), LEFT OUTER, KEEP(1)),
					%dsOut%);
*/
	outFile := IF(dodedup,
					JOIN(DISTRIBUTED(%dsin%, HASH64(lname,fname,mname
#IF(NOT %nosuffix%)
							,suffix
#END
					)),
					DISTRIBUTED(%dsOut%, HASH64(lname,fname,mname
#IF(NOT %nosuffix%)
							,suffix
#END
					)),					
					LEFT.fname=RIGHT.fname AND LEFT.mname=RIGHT.mname AND LEFT.lname=RIGHT.lname
#IF(NOT %nosuffix%)
					AND LEFT.suffix=RIGHT.suffix
#END
					,%xform2%(LEFT, RIGHT), LOCAL, LEFT OUTER, KEEP(1))
					+ PROJECT(inFile(TRIM(fname) + TRIM(mname) + TRIM(lname)=''),%new_layout%),
					%dsOut%);


ENDMACRO;

