
import address,did_add,ut,header_slimsort,didville;

DateToStandard(String d) := FUNCTION
// Returns date in mm/dd/yyyy format to CCCCMMDD format
datepattern := '^(.*)/(.*)/(.*)$';
yy:=(STRING4)(REGEXFIND(datepattern,d,3));
mm:=(INTEGER)REGEXFIND(datepattern,d,1);
mmstr:=IF(mm<10,'0'+(String1)mm,(string2)(mm));
dd:=(INTEGER)REGEXFIND(datepattern,d,2);
ddstr:=IF(dd<10,'0'+(String1)dd,(string2)(dd));
s:=yy+mmstr+ddstr;
return IF(TRIM(s,left,right) <>'0000',s,'');
END;


layout_in := record,MAXLENGTH(1000)
string firstx;
string middlex;
string lastx;
string orig_dob;
string addr1;
string city;
string st;
string zip;
string ndb_result;
string ln_result;
end;

file_in:= 
	dataset('~thor_200::in::cdl_test::d8testresults',
	layout_in,csv(heading(1),terminator('\n'), separator('\t')));

//output(choosen(file_in,500));


layout_clean := record
string50 firstx;
string50 middlex;
string50 lastx;
string50 orig_dob;
string100 addr1;
string50 city;
string10 st;
string10 zip;
string2000 ndb_result;
string500 ln_result;
string5 title;
string20 fname;
string20 mname;
string20 lname;
string5	name_suffix;
string3 name_score;
string8 dob;
string9 orig_ssn:='';
string10 prim_range:='';
string30 prim_name:='';
string10 sec_range:='';
string5 zip5:='';
string2 state:='';
unsigned6 did_sensitive:=0;
unsigned1 did_senstive_score:=0;
unsigned6 did_regular:=0;
unsigned1 did_regular_score:=0;
unsigned6 did_pipe:=0;
unsigned1 did_pipe_score:=0;
end;


layout_clean tclean(layout_in l) := transform
self := l;
string73 clean_name := address.CleanPersonFML73(l.firstx+' '+l.middlex+' '+l.lastx);
self.title :=	clean_name[1..5];
self.fname :=	clean_name[6..25];
self.mname :=	clean_name[26..45];
self.lname :=	clean_name[46..65];
self.name_suffix :=	clean_name[66..70];
self.name_score :=	clean_name[71..73];
self.dob := datetostandard(l.orig_dob);
end;

presult := project(file_in,tclean(left));
lMatchSet := ['D'];
/*
#stored('did_add_force','thor'); // remove or set to 'thor' to put recs through thor
did_Add.MAC_Match_Flex_Sensitive  // NOTE <- sensitive macro
	(presult, lMatchSet,						
	 orig_ssn, dob, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip5, state, fake_phone_field, 
	 did_sensitive,
	 layout_clean,
	 false, did_sensitive_score,
	 75,						//dids with a score below here will be dropped
	 presult_with_did_sensitive
	)
output(presult_with_did_sensitive,,'~thor_200::temp::cdl_test::d8testresults_did_sensitive');
*/

#stored('did_add_force','thor'); // remove or set to 'thor' to put recs through thor
did_Add.MAC_Match_Flex  // NOTE <- regular
	(presult, lMatchSet,						
	 orig_ssn, dob, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip5, state, fake_phone_field, 
	 did_regular,
	 layout_clean,
	 false, did_regular_score,
	 75,						//dids with a score below here will be dropped
	 presult_with_did_regular
	)
output(presult_with_did_regular,,'~thor_200::temp::cdl_test::d8testresults_did_regular',overwrite);

/*
#stored('did_add_force','roxi'); // remove or set to 'thor' to put recs through thor
did_Add.MAC_Match_Flex  // NOTE <- regular
	(presult, lMatchSet,						
	 orig_ssn, dob, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip5, state, fake_phone_field, 
	 did_pipe,
	 layout_clean,
	 false, did_pipe_score,
	 75,						//dids with a score below here will be dropped
	 presult_with_did_pipe
	)
output(presult_with_did_pipe,,'~thor_200::temp::cdl_test::d8testresults_did_pipe');
*/



