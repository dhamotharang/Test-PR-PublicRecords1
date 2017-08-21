EXPORT BuildReport(string select_dataset) := function

Loadfile := dataset('~thor_data400::' + select_dataset + '::buildlog',BuildLogger.Layouts.layout_log,thor);




SortedList	:=	sort(Loadfile,wuid);
GroupedList	:=	group(SortedList,wuid);

BuildLogger.Layouts.Report_Record tCombine(BuildLogger.Layouts.layout_log L,Dataset(BuildLogger.Layouts.layout_log) R) := transform
																			Self.Build_Start	:=	if(count(R(tag='Build_Start'))<>0,R(tag='Build_Start')[1].date_time,'');
																			Self.Build_End		:=	if(count(R(tag='Build_End'))<>0,R(tag='Build_End')[1].date_time,'');
																			Self.Prep_Start		:=	if(count(R(tag='Prep_Start'))<>0,R(tag='Prep_Start')[1].date_time,'');
																			Self.Prep_End			:=	if(count(R(tag='Prep_End'))<>0,R(tag='Prep_End')[1].date_time,'');
																			Self.Base_Start		:=	if(count(R(tag='Base_Start'))<>0,R(tag='Base_Start')[1].date_time,'');
																			Self.Base_End			:=	if(count(R(tag='Base_End'))<>0,R(tag='Base_End')[1].date_time,'');
																			Self.Key_Start		:=	if(count(R(tag='Key_Start'))<>0,R(tag='Key_Start')[1].date_time,'');
																			Self.Key_End			:=	if(count(R(tag='Key_End'))<>0,R(tag='Key_End')[1].date_time,'');
																			Self.Post_Start		:=	if(count(R(tag='Post_Start'))<>0,R(tag='Post_Start')[1].date_time,'');
																			Self.Post_End			:=	if(count(R(tag='Post_End'))<>0,R(tag='Post_End')[1].date_time,'');
																			Self.Build_Status	:=	if(Self.Build_End = '','Build_Incomplete','Build_Completed');
																			Self:=L;
																			end;

CombinedRecords := rollup(GroupedList,GROUP,tCombine(left,ROWS(left)));


return CombinedRecords;

end;