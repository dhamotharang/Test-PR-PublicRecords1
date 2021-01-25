import doxie, tools, dx_InquiryHistory;

export Keys(
   	        boolean  isFCRA   = true
) :=

module

	shared data_env := if(isFCRA,1,0);
	
	// Pay Load - indexed by group_rid (hash of all data)  
  export Group_RID := dx_InquiryHistory.Key_Group_RID(data_env);
	
	// Main key - indexed by lexid
	export Lexid     := dx_InquiryHistory.Key_Lexid(data_env);
	
  // Pay Load - indexed by group_rid (hash of encrypted data)  
  export Group_RID_Encrypted := dx_InquiryHistory.Key_Group_RID_Encrypted(data_env);	
	
end;
