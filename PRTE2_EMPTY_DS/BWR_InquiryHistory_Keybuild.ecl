import STD,PRTE2, _control, PRTE, Data_Services, dx_InquiryHistory;  

skipDOPS:=FALSE;
string emailTo:='';
dops_name := 'FCRA_InquiryHistoryKeys';

version :=(string8)STD.Date.CurrentDate(True);
pIndexVersion := version + 'a';


dsLexid := dataset([], dx_InquiryHistory.Layouts.i_lexid);
dsGroupId := dataset([], dx_InquiryHistory.Layouts.i_grouprid);


Key_lexid_fcra   := index(dsLexid,{appended_did},{dsLexid}, prte2.constants.prefix+'key::inquiryhistory::fcra::'+ pIndexVersion+'::lexid');
Key_grp_id_fcra  := index(dsGroupId,{group_rid},{dsGroupId},prte2.constants.prefix+'key::inquiryhistory::fcra::'+ pIndexVersion+'::group_rid');


//---------- making DOPS optional -------------------------------
notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
updatedops_fcra			:= PRTE.UpdateVersion(dops_name, pIndexVersion, notifyEmail,'B','F','N');

PerformUpdateOrNot	:= IF(not skipDops,updatedops_fcra,NoUpdate);

build_keys := sequential(parallel(build(Key_lexid_fcra, update), 
                                  build(Key_grp_id_fcra, update)),
																	PerformUpdateOrNot
												);

build_keys;                       
output ('successful');
