/*2015-12-30T22:11:47Z (ddittman)
C:\Users\dittda01\AppData\Roaming\HPCC Systems\eclide\ddittman\Dataland\American_student_list\StudentStats\2015-12-30T22_11_47Z.ecl
*/
IMPORT American_Student_List, WatchDog, ut;

ReportLayout := RECORD
string30 Topic;
unsigned total;
end;


EXPORT StudentStats(dataset(recordof(american_student_list.Extract_Layout)) infile):= function

CollegeSort				:=	sort(distribute(infile(LN_COLLEGE_NAME<>''), hash(LN_COLLEGE_NAME)),LN_COLLEGE_NAME,local);

CInfile:= infile(RECORD_TYPE = 'Current');
HInfile:= infile(RECORD_TYPE = 'Historical');
CInfileSort:=sort(distribute(Cinfile(LN_COLLEGE_NAME<>''), hash(LN_COLLEGE_NAME)),LN_COLLEGE_NAME,local);
HInfileSort:=sort(distribute(Hinfile(LN_COLLEGE_NAME<>''), hash(LN_COLLEGE_NAME)),LN_COLLEGE_NAME,local);
// Current			:=	count(infile(RECORD_TYPE = 'Current'));
// Historical	:=	count(infile(RECORD_TYPE = 'Historical'));

CNumRecords:=	count(CInfile);
CNumColleges	:=	count(dedup(CInfileSort,LN_COLLEGE_NAME,local));
CLexID					:=	count(CInfile(DID<>0));
CName					:=	count(CInfile(FULL_NAME<>''));
CCollege				:=	count(CInfile(LN_COLLEGE_NAME<>''));
CClass_Year		:=	count(CInfile(CLASS_YEAR<>''));
CCollege_Class	:=	count(CInfile(COLLEGE_CLASS<>''));
CMajor					:=	count(CInfile(COLLEGE_MAJOR<>''));
CCollege_Code4Yr	:=	count(CInfile(COLLEGE_CODE='4'));
CCollege_Code2yr	:=	count(CInfile(COLLEGE_CODE='2'));
CCollege_CodeGr	:=	count(CInfile(COLLEGE_CODE='1'));
CCollege_typeSt	:=	count(CInfile(COLLEGE_TYPE='S'));
CCollege_typePr	:=	count(CInfile(COLLEGE_TYPE='P'));
CCollege_typeRe	:=	count(CInfile(COLLEGE_TYPE='R'));
CState					:=	count(CInfile(STATE<>''));

HNumRecords:=	count(HInfile);
HNumColleges	:=	count(dedup(HInfileSort,LN_COLLEGE_NAME,local));
HLexID					:=	count(HInfile(DID<>0));
HName					:=	count(HInfile(FULL_NAME<>''));
HCollege				:=	count(HInfile(LN_COLLEGE_NAME<>''));
HClass_Year		:=	count(HInfile(CLASS_YEAR<>''));
HCollege_Class	:=	count(HInfile(COLLEGE_CLASS<>''));
HMajor					:=	count(HInfile(COLLEGE_MAJOR<>''));
HCollege_Code4Yr	:=	count(HInfile(COLLEGE_CODE='4'));
HCollege_Code2yr	:=	count(HInfile(COLLEGE_CODE='2'));
HCollege_CodeGr	:=	count(HInfile(COLLEGE_CODE='1'));
HCollege_typeSt	:=	count(HInfile(COLLEGE_TYPE='S'));
HCollege_typePr	:=	count(HInfile(COLLEGE_TYPE='P'));
HCollege_typeRe	:=	count(HInfile(COLLEGE_TYPE='R'));
HState					:=	count(HInfile(STATE<>''));


// DeedTable					:=	Output(Table(SortedDeed,{FIPSCountyCode,state,countyname,NumEntries := COUNT(GROUP), MinYear := MIN(group, if((unsigned)RecordingDate = 0, '99999999', RecordingDate)), MaxYear := MAX(GROUP,RecordingDate)},state,strip_countyname, few, local),ALL,named('DeedStats'));

// LexIDTable				:=	OUTPUT(TABLE(LexIDSort,{DID,Number_of_Records := COUNT(GROUP)},DID,few,local),all,named('LexIDTable'));
// NameTable					:=	OUTPUT(TABLE(NameSort,{FULL_NAME,Number_of_Records := COUNT(GROUP)},FULL_NAME,few,local),all,named('NameTable'));
// CollegeTable			:=	OUTPUT(TABLE(CollegeSort,{LN_COLLEGE_NAME,Number_of_Records := COUNT(GROUP)},LN_COLLEGE_NAME,few,local),all,named('CollegeInstitutionTable'));
// YearClassTable		:=	OUTPUT(TABLE(YearClassSort,{CLASS_YEAR,Number_of_Records := COUNT(GROUP)},CLASS_YEAR,few,local),all,named('CollegeYearTable'));
// TitleClassTable		:=	OUTPUT(TABLE(TitleClassSort,{COLLEGE_CLASS,Number_of_Records := COUNT(GROUP)},COLLEGE_CLASS,few,local),all,named('CollegeClassTable'));
// MajorTable				:=	OUTPUT(TABLE(MajorSort,{COLLEGE_MAJOR,Number_of_Records := COUNT(GROUP)},COLLEGE_MAJOR,few,local),all,named('CollegeMajorTable'));
// StateTable				:=	OUTPUT(TABLE(StateSort,{STATE,Number_of_Records := COUNT(GROUP)},STATE,few,local),all,named('StateTable'));

CCalculations	:=	Dataset([
{'Current',CNumRecords},{'Number_of_Colleges',CNumColleges},{'LexID',CLexID},{'Records_with_Full_Name',CName},{'Records_with_College',CCollege},
{'Records_with_Class_Year',CClass_Year},{'Records_with_College_Class',CCollege_Class},{'Records_with_Major',CMajor},{'Records_with_4yr_College',CCollege_Code4yr},
{'Records_with_2yr_College',CCollege_Code2yr},{'Records_with_Graduate_College',CCollege_CodeGr},{'Records_with_State_College',CCollege_TypeSt},
{'Records_with_Private_College',CCollege_TypePr},{'Records_with_Religious_College',CCollege_TypeRe},{'Records_with_State',CState}],
ReportLayout);

HCalculations	:=	Dataset([
{'Historical',HNumRecords},{'Number_of_Colleges',HNumColleges},{'LexID',HLexID},{'Records_with_Full_Name',HName},{'Records_with_College',HCollege},
{'Records_with_Class_Year',HClass_Year},{'Records_with_College_Class',HCollege_Class},{'Records_with_Major',HMajor},{'Records_with_4yr_College',HCollege_Code4yr},
{'Records_with_2yr_College',HCollege_Code2yr},{'Records_with_Graduate_College',HCollege_CodeGr},{'Records_with_State_College',HCollege_TypeSt},
{'Records_with_Private_College',HCollege_TypePr},{'Records_with_Religious_College',HCollege_TypeRe},{'Records_with_State',HState}],
ReportLayout);

IDTableLayout := RECORD
CCalculations.Topic;
CCalculations.total;
end;

IDTableLayout2 := RECORD
HCalculations.Topic;
HCalculations.total;
end;

CStatsTable := TABLE(CCalculations, IDTableLayout);
HStatsTable := TABLE(HCalculations, IDTableLayout2);

MyFile:='~thor_data400::out::ASL::StudentStats::Current::'+workunit;
MyFile2:='~thor_data400::out::ASL::StudentStats::Historical::'+workunit;
COutStats	:=	OUTPUT(CStatsTable,,MyFile,CSV,ALL);
HOutStats	:=	OUTPUT(HStatsTable,,MyFile2,CSV,ALL);



return sequential(COutStats,HOutStats);

end;