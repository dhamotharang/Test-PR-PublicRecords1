//mapping verid to common
export fn_mapping_question_old(dataset(avenger.layout_in.question) pInFile) := function
 
avenger.layout_common.old tmap_verid_question(pInFile le) := transform

fixDate_CREATIONTIME := avenger.fncleanfunctions.tDateAdded(le.CREATIONTIME);
fixTime_CREATIONTIME := avenger.fncleanfunctions.tTimeAdded(fixDate_CREATIONTIME);
fixDate_STARTTIME := avenger.fncleanfunctions.tDateAdded(le.STARTTIME);
fixTime_STARTTIME:= avenger.fncleanfunctions.tTimeAdded(fixDate_STARTTIME);
fixDate_ENDTIME := avenger.fncleanfunctions.tDateAdded(le.ENDTIME);
fixTime_ENDTIME:= avenger.fncleanfunctions.tTimeAdded(fixDate_ENDTIME);

self.Tran_Conversation_ID	:=	if(le.TRANSACTIONID <> '', trim(le.TRANSACTIONID,left,right), '-2')	;
self.Tran_ID	:= 	if(le.TRANSACTIONID <> '', trim(le.TRANSACTIONID, left,right), '-2');
self.Tran_type       := '2';

self.Cust_Account  := if(le.accountname <> '', le.accountname, '-1');
//self.Auth_Score	:= 	if(le.QUESTIONGRADEOUTCOMETYPEFIELD = '1', le.SCOREWEIGHT,'');

self.Question_Set_ID	:=	le.QUESTIONSETID	;
self.Question_ID	:=	le.QUESTIONID	;
self.Question_Time_Creation	:=	fixTime_CREATIONTIME;
self.Question_Time_Start	:=	fixTime_STARTTIME	;
self.Question_Time_End	:=	fixTime_ENDTIME	;
self.Question_Time_Total := (string)((unsigned)fixTime_ENDTIME - (unsigned)fixTime_STARTTIME);
self.Question_Subset_Number	:=	le.SUBSETNUMBER	;
self.Question_Category_Numeric	:=	le.QUESTIONTYPEFIELD	;
self.Question_Set_Type	:=	avenger.getcode_old.questionsettype(le.QUESTIONSETTYPEFIELD);
self.Question_Tier_Type	:=	le.QUESTIONTIERTYPEFIELD	;
self.Question_Style_Type	:=	avenger.getcode_old.questionstyletype(le.QUESTIONINGSTYLETYPEFIELD);
self.Question_Category_String	:=	le.STRINGCODE	;
self.Question_Presentation_Position	:=	le.PRESENTATIONPOSITION	;
self.Question_Presentation_Weight	:=	le.SHUFFLEWEIGHT	;
self.Question_Contribution_Weight	:=	le.SCOREWEIGHT	;
self.Question_Data_Source	:=	avenger.getcode_old.questiondatasource(le.DATASOURCETYPEFIELD);
self.Question_Language_Type	:=	le.LANGUAGETYPEFIELD	;
self.Question_Answer_Grade  	:=	le.GRADE	;
self.Question_Answer_Grade_OutcomeType	:=	avenger.getcode_old.QuestionGradeOutcome(le.QUESTIONGRADEOUTCOMETYPEFIELD)	;
self.Question_Answers_NoneOfAboveSelected	:=	le.WASNONEOFTHEABOVESELECTED	;
self.Question_Raw_Question	:=	le.QUESTIONSTATEMENT	;
self.Question_Raw_CorrectAnswer	:=	le.CORRECTANSWER	;
self.Question_Raw_UserAnswer	:=	le.SELECTEDANSWER  	;
self.Quiz_Outcome   := le.SUBSETGRADEOUTCOMETYPEFIELD;
self.Quiz_Outcome_1 := if(trim(le.SUBSETNUMBER,left,right) = '1',le.SUBSETGRADEOUTCOMETYPEFIELD, '');
self.Quiz_Outcome_2  := if(trim(le.SUBSETNUMBER,left,right) = '2',le.SUBSETGRADEOUTCOMETYPEFIELD, '');
self.Quiz_Outcome_Code	:=	le.SUBSETGRADEOUTCOMETYPEFIELD;
self.Selected_LexID  := if(Avenger.fncleanfunctions.clean_ADL(le.VERITEID) <> '',Avenger.fncleanfunctions.clean_ADL(le.VERITEID), '-3') ;
//SUBSETGRADEOUTCOMETYPEFIELD including '1'passed, '0' not.graded, '2' failed, '4' continue 
//self.Quiz_Status_Passfail  := if(le.SUBSETGRADEOUTCOMETYPEFIELD in ['1', '2'], '1', '0');
//self.Quiz_Outcome_TimeOut  := if(le.SUBSETGRADEOUTCOMETYPEFIELD = '4', '1', '0');//need confirm???
//self.Question_Type_Diversionary := if(regexfind('None of the above', le.CORRECTANSWER),'1', '0'); // need confirm if need map from VERID question
self.Question_Answers_AOASelected  :=  if(regexfind('All of the above', le.SELECTEDANSWER),'1', '0');
//self.source := 'VER';


self := [];
end;

common_verid_question := project(pInFile, tmap_verid_question(left));
common_verid_question_dedup := dedup(sort(distribute(common_verid_question(tran_id <> ''), hash(Tran_ID)), record, local), record, local);

//rollup on the last transaction -- not all can determine which is the last transaction, need correction after join with transaction table?
verid_question_dist := distribute(pInFile, hash(TRANSACTIONID));

verid_question_sort := sort(verid_question_dist,TRANSACTIONID, QuestionSetID, -SUBSETNUMBER, -endtime,local);

verid_question_dedup := dedup(verid_question_sort,TRANSACTIONID, local);

//append SUBSETGRADEOUTCOMETYPEFIELD -- auth fields only mapping from IDM 
/*common_verid_question_dedup tjoin_GRADEOUTCOME(common_verid_question_dedup le,verid_question_dedup ri) := transform

//QUESTIONGRADEOUTCOMETYPEFIELD including '1'passed, '0' not.graded, '2' failed, '3' error, '5' undecide
//self.Auth_Outcome := ri.SUBSETGRADEOUTCOMETYPEFIELD;
//self.Auth_Pass	:= 	if(ri.QUESTIONGRADEOUTCOMETYPEFIELD	= '1', '1', '0');
//self.Auth_Fail	:= 	if(ri.QUESTIONGRADEOUTCOMETYPEFIELD	= '2', '1', '0');
//self.Auth_OptOut	:= 	if(ri.QUESTIONGRADEOUTCOMETYPEFIELD	= '5', '1', '0')	;
//self.Auth_UnableToGengerate	:= if(ri.QUESTIONGRADEOUTCOMETYPEFIELD	= '0', '1', '0')	;
//self.Auth_Error	:= 	if(ri.QUESTIONGRADEOUTCOMETYPEFIELD	= '3', '1', '0');
//self.Auth_Quiz_Expired	:= 	'0'	; //need confirm with VERID
self := le;
 
 end;
 
common_verid_question_outcome := join(common_verid_question_dedup,verid_question_dedup,
left.tran_id = trim(right.TRANSACTIONID,left,right), tjoin_GRADEOUTCOME(left,right), left outer,local);*/


return common_verid_question_dedup; 

end;