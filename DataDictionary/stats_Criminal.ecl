import crim_common,CrimSrch;
crimoffnd := Crim_Common.File_Crim_Offender2_Plus;

layout_st := record
crimoffnd.state_origin;
total := count(group);
end;

parallel(
output(count(crimoffnd),named('CriminalCombinedTotalRecords')),
output(count(crimoffnd(data_type='2')),named('CriminalCourtTotalRecords')),
//============================================================================
output(count(crimoffnd(data_type='1')),named('DepartmentOfCorrectionsTotalRecords')),
output(sort(table(crimoffnd,layout_st,state_origin,few),state_origin)),
output(count(table(crimoffnd,layout_st,state_origin,few)),named('DepartmentOfCorrectionsCoverageTotal_includesDC')),
//============================================================================
output(count(crimoffnd(data_type='5')),named('ArrestLogsTotalRecords'))
);