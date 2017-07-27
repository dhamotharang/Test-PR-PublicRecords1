/*2013-05-28T13:36:29Z (Michele Walklin_prod)
code review AML
*/
import AML;
export Layout_BocaShell_Neutral_IDs := 
RECORD
	Layout_Boca_Shell_Ids;
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
	AML.Layouts.LayoutAMLShell;
END;
