

EXPORT Indx_AnsRec(STRING indxName, 
									 DATASET(Layout_AnswerListData) ans=DATASET([],Layout_AnswerListData))
		:= INDEX(ans, {record_id}, {ans}, indxName);
