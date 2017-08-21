IMPORT American_Student_List, WatchDog, lib_date, ut;




EXPORT Extract_Student_List_Product(string filedate = ut.GetDate):= function

Over18:=ut.DaysInNYears(18);

LoadFile:= American_student_list.File_American_Student_DID_v2;

InvalidDayFixed :=  project(LoadFile,transform(American_student_list.layout_american_student_base_v2,
													self.DOB_FORMATTED := American_student_list.InvalidDayTest(Left.DOB_FORMATTED);
													self := left;));

ValidDOB:=sort(distribute(InvalidDayFixed(ut.ValidDate(DOB_FORMATTED)=TRUE AND ut.DaysApart(filedate,DOB_FORMATTED)>= Over18 AND DID<>0),hash(DID)),DID,Local);

MinorDIDList:=sort(distribute(project(InvalidDayFixed(ut.ValidDate(DOB_FORMATTED)=TRUE AND ut.DaysApart(filedate,DOB_FORMATTED)< Over18 AND DID<>0),
									Transform({unsigned6 DID}, self.DID	:=	left.DID)),hash(DID)),DID,Local);

InvalidDOB:=sort(distribute(InvalidDayFixed(ut.ValidDate(DOB_FORMATTED)=FALSE AND DID<>0),hash(DID)),DID,Local);

InvalidASLMinorRemoved	:=	join(InvalidDOB,MinorDIDList,Left.DID=Right.DID,Transform(Left),Left Only,LOCAL);

ValidASLMinorRemoved	:=	join(ValidDOB,MinorDIDList,Left.DID=Right.DID,Transform(Left),Left Only,LOCAL);

LegalWatchDogDOB:=sort(distribute(WatchDog.File_Best(ut.ValidDate((string)DOB)=TRUE AND ut.DaysApart(filedate,(string)DOB)>=Over18 AND DID<>0),hash(DID)),DID,Local);

WatchDogValidated:= join(InvalidASLMinorRemoved,LegalWatchDogDOB,Left.DID=Right.DID,Transform(Left),LOCAL);

Full_Final_List:=ValidASLMinorRemoved+WatchDogValidated;



ValidList:=Project(Full_Final_List,Transform(american_student_list.Extract_Layout,
self.CLASS_YEAR				:=	stringlib.StringFilter(left.CLASS,'0123456789');
// self.COLLEGE_CLASS		:=	stringlib.StringFilter(left.CLASS,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz');
self.RECORD_TYPE			:=	if(left.HISTORICAL_FLAG = 'C','Current','Historical');
self.DATE_FIRST_SEEN	:=	(UNSIGNED4)Left.DATE_FIRST_SEEN;
self.DATE_LAST_SEEN		:=	(UNSIGNED4)Left.DATE_LAST_SEEN;
self									:=	left;));

american_student_list.Extract_Layout tFillDates (american_student_list.Extract_Layout L, american_student_list.Extract_Layout R)	:= transform
self.DATE_FIRST_SEEN	:=	lib_date.earliestdate(L.DATE_FIRST_SEEN,R.DATE_FIRST_SEEN);
self.DATE_LAST_SEEN		:=	lib_date.latestdate(L.DATE_LAST_SEEN,R.DATE_LAST_SEEN);
// self.PROCESS_DATE			:=	lib_date.earliestdatestring(L.PROCESS_DATE,R.PROCESS_DATE);
self.PROCESS_DATE			:=	if(L.PROCESS_DATE='' or (R.PROCESS_DATE<>'' and R.PROCESS_DATE>L.PROCESS_DATE),R.PROCESS_DATE,L.PROCESS_DATE);
//self.RECORD_TYPE			:=	if(L.RECORD_TYPE = 'Historical' OR R.RECORD_TYPE = 'Current',R.RECORD_TYPE,L.RECORD_TYPE);
self									:=	L;
end;


ValidListDist	:=	sort(distribute(ValidList,
										hash(DID,FULL_NAME,fname,mname,lname,name_suffix,
													LN_COLLEGE_NAME,CLASS_YEAR,COLLEGE_CLASS,COLLEGE_MAJOR,
													STATE,COLLEGE_CODE_EXPLODED,COLLEGE_TYPE_EXPLODED)),
													//sort
													DID,FULL_NAME,fname,mname,lname,name_suffix,
													LN_COLLEGE_NAME,CLASS_YEAR,COLLEGE_CLASS,COLLEGE_MAJOR,
													STATE,COLLEGE_CODE_EXPLODED,COLLEGE_TYPE_EXPLODED,Record_Type, LOCAL);

Final_List	:=	Rollup(ValidListDist,
 Left.DID	=	Right.DID	AND
 Left.FULL_NAME	=	Right.FULL_NAME	AND
 Left.fname	=	Right.fname	AND
 Left.mname	=	Right.mname	AND
 Left.lname	=	Right.lname	AND
 Left.name_suffix	=	Right.name_suffix	AND
 Left.LN_COLLEGE_NAME	=	Right.LN_COLLEGE_NAME	AND
 Left.CLASS_YEAR	=	Right.CLASS_YEAR	AND
 Left.COLLEGE_CLASS	=	Right.COLLEGE_CLASS	AND
 Left.COLLEGE_MAJOR	=	Right.COLLEGE_MAJOR	AND
 Left.STATE	=	Right.STATE	AND
 Left.COLLEGE_CODE_EXPLODED	=	Right.COLLEGE_CODE_EXPLODED	AND
 Left.COLLEGE_TYPE_EXPLODED	=	Right.COLLEGE_TYPE_EXPLODED,
tFillDates(LEFT,RIGHT),
Local);

Final_Layout := RECORD
string10					RECORD_TYPE	:=	Final_List.RECORD_TYPE;
unsigned6       	DID	:=	Final_List.DID;
string40        	FULL_NAME	:=	Final_List.FULL_NAME;
string20 					fname	:=	Final_List.fname;
string20 					mname	:=	Final_List.mname;
string20 					lname	:=	Final_List.lname;
string5 					name_suffix	:=	Final_List.name_suffix;
string50        	LN_COLLEGE_NAME	:=	Final_List.LN_COLLEGE_NAME;
string2         	CLASS_YEAR	:=	Final_List.CLASS_YEAR;
string2						COLLEGE_CLASS	:=	Final_List.COLLEGE_CLASS;
string1						COLLEGE_MAJOR	:=	Final_List.COLLEGE_MAJOR;
string2         	STATE	:=	Final_List.STATE;
UNSIGNED4         DATE_FIRST_SEEN	:=	Final_List.DATE_FIRST_SEEN;
UNSIGNED4         DATE_LAST_SEEN	:=	Final_List.DATE_LAST_SEEN;
string8         	PROCESS_DATE	:=	Final_List.PROCESS_DATE;
string20  				COLLEGE_CODE_EXPLODED	:=	Final_List.COLLEGE_CODE_EXPLODED;
string25					COLLEGE_TYPE_EXPLODED	:=	Final_List.COLLEGE_TYPE_EXPLODED;
end;


Table_Creation:=TABLE(Final_List,Final_Layout);
StatsOutput:=American_student_list.StudentStats(Final_List);
MyFile:='~thor_data400::out::ASL::StudentList::'+workunit;
Final_Product:=OUTPUT(Table_Creation,,MyFile,CSV,ALL);

return sequential(Final_Product,StatsOutput);
// return 1;
end;

