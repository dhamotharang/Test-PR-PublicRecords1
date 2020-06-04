IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_NH._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT Corporation      	 	:= tools.mod_FilenamesInput(Template('corporation::nh'), pversion);
		EXPORT Address        			:= tools.mod_FilenamesInput(Template('address::nh'), pversion);
		EXPORT Filing  							:= tools.mod_FilenamesInput(Template('filing::nh'), pversion);
		EXPORT RegAgent      				:= tools.mod_FilenamesInput(Template('reg_agent::nh'), pversion);
		EXPORT PrevNames      		  := tools.mod_FilenamesInput(Template('prev_names::nh'), pversion);
		EXPORT Principals        		:= tools.mod_FilenamesInput(Template('principals::nh'), pversion);
		EXPORT PrinPurp         		:= tools.mod_FilenamesInput(Template('prin_purpose::nh'), pversion);
		EXPORT Stock        				:= tools.mod_FilenamesInput(Template('stock::nh'), pversion);

	END;

 // Base files are no longer being used
 /*
	EXPORT Base := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_NH._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT Corporation      	 	:= tools.mod_FilenamesBuild(Template('corporation::nh'), pversion);
		EXPORT Address        			:= tools.mod_FilenamesBuild(Template('address::nh'), pversion);
		EXPORT Filing  							:= tools.mod_FilenamesBuild(Template('filing::nh'), pversion);
		EXPORT Merger       				:= tools.mod_FilenamesBuild(Template('merger::nh'), pversion);
		EXPORT CorporationName   		:= tools.mod_FilenamesBuild(Template('name::nh'), pversion);
		EXPORT Officer        			:= tools.mod_FilenamesBuild(Template('officer::nh'), pversion);
		EXPORT Stock        				:= tools.mod_FilenamesBuild(Template('stock::nh'), pversion);

		EXPORT dAll_Corporation			:= Corporation.dAll_filenames;
		EXPORT dAll_Address					:= Address.dAll_filenames;
		EXPORT dAll_Filing 					:= Filing.dAll_filenames;
		EXPORT dAll_Merger 					:= Merger.dAll_filenames;
		EXPORT dAll_CorporationName	:= CorporationName.dAll_filenames;	
		EXPORT dAll_Office					:= Officer.dAll_filenames;				
		EXPORT dAll_Stock						:= Stock.dAll_filenames;				

	END;
	
	EXPORT dAll_filenames 					:= Base.dAll_Corporation 				+
																		 Base.dAll_Address          	+
																		 Base.dAll_Filing							+
																		 Base.dAll_Merger				 			+
																		 Base.dAll_CorporationName  	+
																		 Base.dAll_Office  						+
																		 Base.dAll_Stock;
	  */
END;