/*2013-05-28T13:34:48Z (Michele Walklin_prod)
code review AML
*/
export Layout_Boca_Shell_ids := 
RECORD
			unsigned4 seq;
			unsigned3 historydate;
			unsigned6 did;
			boolean isrelat;
			STRING20 fname;
			STRING20 lname;
			STRING20 relation;
			Layout_Overrides;

END;