import American_student_list, D2C_Customers;

/*
FR=Freshman
SO=Sophomore
JR=Junior
SR=Senior    
GR=Graduate
PT=Part Time
UN=Unknown
*/
dsClass := DATASET([
	{'FR', 'FRESHMAN'},{'SO','SOPHOMORE'},{'JR','JUNIOR'},{'SR','SENIOR'},{'GR','GRADUATE'},{'PT','PART TIME'},
		{'UN',''},		//UNKNOWN 
		{'U ',''},
		{' ',''}
	], {string2 abbreviation, string9 class});
dictClass := DICTIONARY(dsClass, {abbreviation => class});


/*
"Field of Study: students current major
A=Biological Science
B=Business/Commerce
C=Education
D=Engineering
E=Health Professions
F=Humanities
G=Law
H=Physical Science
I=Religion
J=Social Science
K=Liberal Arts
L=Nursing
M=Computer
N=Architecture
O=Music
P=Accounting
Q=Biology
R=Marketing
S=Finance
T=Medicine
U=Unclassified
V=Chiropractic
Y=English/Journalism
Z=Management"
*/

dsMajor := DATASET([
{'A','BIOLOGICAL SCIENCE'},
{'B','BUSINESS/COMMERCE'},
{'C','EDUCATION'},
{'D','ENGINEERING'},
{'E','HEALTH PROFESSIONS'},
{'F','HUMANITIES'},
{'G','LAW'},
{'H','PHYSICAL SCIENCE'},
{'I','RELIGION'},
{'J','SOCIAL SCIENCE'},
{'K','LIBERAL ARTS'},
{'L','NURSING'},
{'M','COMPUTER'},
{'N','ARCHITECTURE'},
{'O','MUSIC'},
{'P','ACCOUNTING'},
{'Q','BIOLOGY'},
{'R','MARKETING'},
{'S','FINANCE'},
{'T','MEDICINE'},
{'U',''},		//UNCLASSIFIED
{'V','CHIROPRACTIC'},
{'W','ART'},
{'X',''},
{'Y','ENGLISH/JOURNALISM'},
{'Z','MANAGEMENT'}
], {STRING1 abbreviation, string18 major});
dictMajor := DICTIONARY(dsMajor, {abbreviation => major});

EXPORT fn_add_college(DATASET(reunion.layouts.lMain) src) := FUNCTION

		students := DISTRIBUTE(American_student_list.File_american_student_DID(did<>0, D2C_Customers.SRC_Allowed.Check(22, source)), did);

		main := DISTRIBUTE(src((unsigned6)adl<>0), (unsigned6)adl);

		// this will join with the most recent "current" record, if available
		j := JOIN(main, SORT(students, did, historical_flag, -date_last_seen, local),
					(unsigned6)left.adl = right.did, 
						TRANSFORM(Reunion.layouts.lCollege,
							self.record_type := 'C';
							self.CLASS := IF(REGEXFIND('^\\d\\d$',right.CLASS), right.Class, '');
							//self.COLLEGE_CLASS := dictClass[right.COLLEGE_CLASS].class;
							self.COLLEGE_NAME := right.COLLEGE_NAME;
							self.COLLEGE_MAJOR := dictMajor[right.COLLEGE_MAJOR].major;
							self := left;), INNER, NOSORT(RIGHT), KEEP(1), LOCAL);
						
		return j(COLLEGE_NAME<>'');
END;
