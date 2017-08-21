EXPORT Mac_Is_Business_Parsed_new(inFile, 
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
		options = '[]'
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
import nid;

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
  
#UNIQUENAME(dsin)
#UNIQUENAME(ds)
#IF(dodedup=true)
	%dsin% := DISTRIBUTE(inFile(TRIM(fname) + TRIM(mname) + TRIM(lname)<>''),
							Nid.Common.fGetNIDParsed(fname,mname,lname,suffix)
							);
	%ds% := DEDUP(SORT(%dsin%, fname,mname,lname, suffix, LOCAL),fname,mname,lname,suffix, LOCAL);
#ELSE					
	%ds% :=	inFile;
#END					

#UNIQUENAME(dsOut1)

	//%dsOut1% := PROJECT(%ds%,  %new_layout%);
	%dsOut1% := PROJECT(Nid.fn_CleanParsedNames(%ds%, fname, mname, lname, suffix), %new_layout%);

	
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


#IF(dodedup=true)
	outFile := 
					JOIN(%dsin%,
								%dsOut1%,					
					LEFT.fname=RIGHT.fname AND LEFT.mname=RIGHT.mname AND LEFT.lname=RIGHT.lname
					AND LEFT.suffix=RIGHT.suffix
					,%xform2%(LEFT, RIGHT), LOCAL, LEFT OUTER, KEEP(1))
					+ PROJECT(inFile(TRIM(fname) + TRIM(mname) + TRIM(lname)=''),%new_layout%);
#ELSE
		outFile := %dsOut1%;
#END

ENDMACRO;
