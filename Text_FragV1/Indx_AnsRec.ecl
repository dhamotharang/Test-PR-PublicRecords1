

EXPORT Indx_AnsRec(STRING indxName, 
									 DATASET(Layout_AnswerListData) ans=DATASET([],Layout_AnswerListData))
		:= INDEX(ans, {src, doc}, {ans}, indxName);
