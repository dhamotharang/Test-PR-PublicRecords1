import STD,PRTE2, _control, PRTE, Data_Services, AlloyMedia_Student_List;  

skipDOPS:=FALSE;
string emailTo:='';
dops_name := 'AlloyKeys';
dops_name_fcra := 'FCRA_ALLoyKeys';

version :=(string8)STD.Date.CurrentDate(True);
pIndexVersion := version + '';


dsFile := dataset([], AlloyMedia_Student_List.layouts.Layout_base);


Key_did       := index(dsFile,{did},{dsFile},prte2.constants.prefix+'key::alloymedia_student_list::'+ pIndexVersion+'::did');
Key_did_fcra  := index(dsFile,{did},{dsFile},prte2.constants.prefix+'key::fcra::alloymedia_student_list::'+ pIndexVersion+'::did');


//---------- making DOPS optional -------------------------------
notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
updatedops					:= PRTE.UpdateVersion(dops_name, pIndexVersion, notifyEmail,'B','N','N');
updatedops_fcra			:= PRTE.UpdateVersion(dops_name_fcra, pIndexVersion, notifyEmail,'B','F','N');

PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

build_keys := sequential(parallel(build(Key_did, update), 
                                  build(Key_did_fcra, update)), 
																	PerformUpdateOrNot
												);

build_keys;                       
output ('successful');