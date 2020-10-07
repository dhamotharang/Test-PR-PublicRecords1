/*2013-05-28T13:35:33Z (Michele Walklin_prod)
code review AML
*/
import AML;
export Layout_BocaShell_Neutral := RECORD
	boolean isrelat;
	STRING20 fname;
	STRING20 lname;
	STRING20 relation;
	Layout_Relatives;

	
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	STRING2 state;
	STRING5 zip5;
	string3 county;
	string7 geo_blk;
	unsigned1 age;
	
	unsigned6 relat_did;
	unsigned dist;
	Layout_Census;
	boolean	census_loose1;
	boolean	census_loose2;
	boolean	census_loose3;
	Risk_Indicators.Layout_Boca_Shell;
	AML.Layouts.LayoutAMLShell;
	unsigned1	errcode;
	Risk_Indicators.Layout_Overrides;
END;
