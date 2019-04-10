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
#UNIQUENAME(layoutin)
#UNIQUENAME(blanksuffix)
#IF(%nosuffix%=true)
	%layoutin% := RECORD
		inFile;
		string5	%blanksuffix% := '';
	END;
	%dsin% := TABLE(inFile, %layoutin%);
#ELSE
	%dsin% := inFile;
#END
  
	outFile := PROJECT(Nid.fn_CleanParsedNames(%dsin%, fname,mname,lname
#IF(%nosuffix%=true)
							,%blanksuffix%),
#ELSE
							,suffix),
#END
							%new_layout%) : DEPRECATED( 'Mac_Is_Business_Parsed is deprecated. Use Nid.fn_CleanParsedNames or Nid.Mac_CleanParsedNames with option V2' );

ENDMACRO;

