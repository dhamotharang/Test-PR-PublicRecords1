IMPORT tools, Corp2_Raw_OH;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
	
		SHARED Template(STRING tag) := Corp2_Raw_OH._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT Business_Address 			:= tools.mod_FilenamesInput(Template('Business_Address::OH'), pversion);		
		EXPORT Agent_Contact 					:= tools.mod_FilenamesInput(Template('Agent_Contact::OH'), pversion);
		EXPORT Business_Associate     := tools.mod_FilenamesInput(Template('Business_Associate::OH'), pversion);
		EXPORT Business         			:= tools.mod_FilenamesInput(Template('Business::OH'), pversion);		
		EXPORT Explanation         		:= tools.mod_FilenamesInput(Template('Explanation::OH'), pversion);		
		EXPORT Old_Name         			:= tools.mod_FilenamesInput(Template('Old_Name::OH'), pversion);	
		EXPORT Authorized_Share       := tools.mod_FilenamesInput(Template('Authorized_Share::OH'), pversion);	
		EXPORT Document_Transaction   := tools.mod_FilenamesInput(Template('Document_Transaction::OH'), pversion);	
		EXPORT Text_Information   		:= tools.mod_FilenamesInput(Template('Text_Information::OH'), pversion);	
		
	END;

	EXPORT Base := MODULE
	
		SHARED Template(STRING tag) := Corp2_Raw_OH._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT Business_Address 			:= tools.mod_FilenamesBuild(Template('Business_Address::OH'), pversion);
		EXPORT Agent_Contact 					:= tools.mod_FilenamesBuild(Template('Agent_Contact::OH'), pversion);
	  EXPORT Business_Associate     := tools.mod_FilenamesBuild(Template('Business_Associate::OH'), pversion);	
		EXPORT Business    						:= tools.mod_FilenamesBuild(Template('Business::OH'), pversion);
		EXPORT Explanation         		:= tools.mod_FilenamesBuild(Template('Explanation::OH'), pversion);			
		EXPORT Old_Name         			:= tools.mod_FilenamesBuild(Template('Old_Name::OH'), pversion);		
		EXPORT Authorized_Share       := tools.mod_FilenamesBuild(Template('Authorized_Share::OH'), pversion);	
		EXPORT Document_Transaction   := tools.mod_FilenamesBuild(Template('Document_Transaction::OH'), pversion);
		EXPORT Text_Information   		:= tools.mod_FilenamesBuild(Template('Text_Information::OH'), pversion);

		EXPORT dAll_Business_Address		:= Business_Address.dAll_filenames;
		EXPORT dAll_Agent_Contact 			:= Agent_Contact.dAll_filenames;
		EXPORT dAll_Business_Associate	:= Business_Associate.dAll_filenames;
		EXPORT dAll_Business 						:= Business.dAll_filenames;
		EXPORT dAll_Explanation 				:= Explanation.dAll_filenames;
		EXPORT dAll_Old_Name 						:= Old_Name.dAll_filenames;
		EXPORT dAll_Authorized_Share 		:= Authorized_Share.dAll_filenames;
		EXPORT dAll_Document_Transaction:= Document_Transaction.dAll_filenames;
		EXPORT dAll_Text_Information		:= Text_Information.dAll_filenames;
		
	END;
	
	EXPORT dAll_filenames := Base.dAll_Business_Address 				+ 
													 Base.dAll_Agent_Contact						+
													 Base.dAll_Business_Associate		 		+
													 Base.dAll_Business 								+
													 Base.dAll_Explanation		 					+
													 Base.dAll_Old_Name		 							+
													 Base.dAll_Authorized_Share         +																	 
													 Base.dAll_Document_Transaction 		+
													 Base.dAll_Text_Information ;
	
END;
