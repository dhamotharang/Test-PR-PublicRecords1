IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_OR._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT EntityDBExtract       	:= tools.mod_FilenamesInput(Template('entity_db_extract::or'), pversion);
		EXPORT NameDBExtract        	:= tools.mod_FilenamesInput(Template('name_db_extract::or'), pversion);
		EXPORT RelAssocNameDBExtract  := tools.mod_FilenamesInput(Template('rel_assoc_name_db_extract::or'), pversion);
		EXPORT CountyDBExtract       	:= tools.mod_FilenamesInput(Template('county_db_extract::or'), pversion);
		EXPORT MergerShareDBExtract   := tools.mod_FilenamesInput(Template('merger_share_db_extract::or'), pversion);
		EXPORT TranDBExtract        	:= tools.mod_FilenamesInput(Template('tran_db_extract::or'), pversion);

	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_OR._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT EntityDBExtract       	:= tools.mod_FilenamesBuild(Template('entity_db_extract::or'), pversion);
		EXPORT NameDBExtract        	:= tools.mod_FilenamesBuild(Template('name_db_extract::or'), pversion);
		EXPORT RelAssocNameDBExtract  := tools.mod_FilenamesBuild(Template('rel_assoc_name_db_extract::or'), pversion);
		EXPORT CountyDBExtract       	:= tools.mod_FilenamesBuild(Template('county_db_extract::or'), pversion);
		EXPORT MergerShareDBExtract   := tools.mod_FilenamesBuild(Template('merger_share_db_extract::or'), pversion);
		EXPORT TranDBExtract        	:= tools.mod_FilenamesBuild(Template('tran_db_extract::or'), pversion);

		EXPORT dAll_Entity 						:= EntityDBExtract.dAll_filenames;
		EXPORT dAll_Name 							:= NameDBExtract.dAll_filenames;
		EXPORT dAll_RelAssocName 			:= RelAssocNameDBExtract.dAll_filenames;
		EXPORT dAll_County 						:= CountyDBExtract.dAll_filenames;
		EXPORT dAll_MergerShare 			:= MergerShareDBExtract.dAll_filenames;	
		EXPORT dAll_Tran 							:= TranDBExtract.dAll_filenames;				

	END;
	
	EXPORT dAll_filenames 					:= Base.dAll_Entity 				+
																		 Base.dAll_Name          	+
																		 Base.dAll_RelAssocName		+
																		 Base.dAll_County				 	+
																		 Base.dAll_MergerShare  	+
																		 Base.dAll_Tran;
	  
END;