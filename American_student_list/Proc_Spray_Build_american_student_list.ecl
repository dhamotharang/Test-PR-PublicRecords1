import _Control, VersionControl;

export Proc_Spray_Build_american_student_list(string filedate, string filename) := function 

GroupName	:=	VersionControl.GroupName('88');

American_student_list.Mac_spray_american_student(_control.IPAddress.bctlpedata11
   																				,'/data/data_build_1/american_student/data/'+filedate[1..8]+'/'
   																				,filedate
   																				,filename
																					,GroupName
   																				,'Y'
																					,doClean);

doBuild := American_student_list.Proc_Build_American_Student_List(filedate);

retval := sequential(doClean
									 , doBuild
									 , SampleRecs)
									 : success(Send_Email(filedate).Build_Success)
									 , failure(Send_Email(filedate).Build_Failure);

return retval;
end;