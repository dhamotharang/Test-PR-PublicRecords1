import Crim_Common, Crim, ut, Address;

export fCleanCVExpunctions(string filedate) := function 


old_layout := 
record
string cau_nbr;
string pty_nm;
string source_file;
string dob;
string orig_ssn;
string DateReceived;
string SourceTable;
string SourceID;
end;

old:= dataset('~thor_data400::in::crim_court::court_ventures::20091202::expunctions',old_layout,csv(terminator('\r\n'), separator(','), quote('\"')));

//redefine new layout to old 
new_layout := record
string DateAdded;
string CaseNo;
string Source;
string LastName;
string FirstName;
string Middlename;
string Suffix;
string DateofBirth;
string SSN;
string CVsourcetable;
string CVsourceid;
string Note;
end;

new:= dataset('~thor_data400::in::crim_court::court_ventures::'+filedate+'::expunctions',new_layout,csv(terminator('\r\n'), separator(','), quote('\"')));

old_layout redefine(new L) := transform
self.cau_nbr := L.CaseNo;
self.pty_nm := regexreplace(' +',L.FirstName + ' '+ L.MiddleName + ' '+ L.LastName+ ' '+ L.Suffix,' ');
self.source_file := L.Source;
self.dob := L.DateofBirth;
self.orig_ssn:= L.SSN;
self.DateReceived := L.DateAdded;
self.SourceTable := L.CVsourcetable;
self.SourceID := L.CVsourceid;
end;

redrecs := project(new,redefine(left));

////////////Clean Combined Files
cmbnd := old + redrecs;

cleanLayout := record
old_layout;
    string5        title;
    string20       fname;
    string20       mname;
    string20       lname;
    string5        name_suffix;
    string3        cleaning_score;
	string1		   blank := '';
	unsigned6 	   did := 0;
	unsigned 	   did_score := 0;
end;

cleanLayout trecs(cmbnd L) := transform

///////////////////format dob
string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

string8     getReasonableRange(string newDateIn) 
:=    map((newDateIn[1..2] between '19' and '20') and 
			(newDateIn < ut.GetDate) => newDateIn,'');

//////////////////clean name			
preCleanName		:= StringLib.StringFilter(StringLib.StringToUpperCase(L.pty_nm),
					   ' -\'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 

CleanName			:= Address.CleanPersonFMl73(preCleanName);
self.dob			:= getReasonableRange(fSlashedMDYtoCYMD(L.dob));					  
self.title 			:= CleanName[1..5];
self.fname 			:= CleanName[6..25];
self.mname 			:= CleanName[26..45];
self.lname 			:= CleanName[46..65];
self.name_suffix 	:= CleanName[66..70];
self.cleaning_score := CleanName[71..73];
self := L;
end;

precs := project(cmbnd,trecs(left));

return

sequential(
output(precs,,'~thor_data400::in::crim_court::court_ventures::'+filedate+'::expunctions_clean',csv(terminator('\r\n'), separator('\t')),overwrite),
fileservices.clearsuperfile('~thor_data400::in::crim_court::court_ventures::expunctions'),
fileservices.addsuperfile('~thor_data400::in::crim_court::court_ventures::expunctions','~thor_data400::in::crim_court::court_ventures::'+filedate+'::expunctions_clean'));
end;


