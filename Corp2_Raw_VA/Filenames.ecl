IMPORT tools;
	
EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
						 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_VA._Dataset(pUseOtherEnvironment).InputTemplate + tag;
			
		EXPORT Corps	   		:= tools.mod_FilenamesInput(Template('corps::va'), pversion);			
		//EXPORT Tables	    	:= tools.mod_FilenamesInput(Template('tables::va'), pversion);
		EXPORT LLC	   			:= tools.mod_FilenamesInput(Template('llc::va'), pversion);			
		EXPORT LP	    			:= tools.mod_FilenamesInput(Template('lp::va'), pversion);
		EXPORT Officer	  	:= tools.mod_FilenamesInput(Template('officer::va'), pversion);			
		EXPORT Merger	    	:= tools.mod_FilenamesInput(Template('merger::va'), pversion);
		EXPORT ResrvdName	  := tools.mod_FilenamesInput(Template('resrvdname::va'), pversion);			
		EXPORT Amendment		:= tools.mod_FilenamesInput(Template('amendment::va'), pversion);
		EXPORT NamesHist	 	:= tools.mod_FilenamesInput(Template('nameshist::va'), pversion);

	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_VA._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT Corps   					:= tools.mod_FilenamesBuild(Template('corps::va'), pversion);
		//EXPORT Tables	    			:= tools.mod_FilenamesBuild(Template('tables::va'), pversion);
		EXPORT LLC	    				:= tools.mod_FilenamesBuild(Template('llc::va'), pversion);
		EXPORT LP	    					:= tools.mod_FilenamesBuild(Template('lp::va'), pversion);
		EXPORT Officer	    		:= tools.mod_FilenamesBuild(Template('officer::va'), pversion);
		EXPORT Merger	    	  	:= tools.mod_FilenamesBuild(Template('merger::va'), pversion);
		EXPORT ResrvdName    		:= tools.mod_FilenamesBuild(Template('resrvdname::va'), pversion);
		EXPORT Amendment   			:= tools.mod_FilenamesBuild(Template('amendment::va'), pversion);
		EXPORT NamesHist	    	:= tools.mod_FilenamesBuild(Template('nameshist::va'), pversion);


		EXPORT dAll_Corps 			:= Corps.dAll_filenames;
		//EXPORT dAll_Tables 			:= Tables.dAll_filenames;
		EXPORT dAll_LLC 				:= LLC.dAll_filenames;
		EXPORT dAll_LP 					:= LP.dAll_filenames;
		EXPORT dAll_Officer 		:= Officer.dAll_filenames;
		EXPORT dAll_Merger 	  	:= Merger.dAll_filenames;
		EXPORT dAll_ResrvdName  := ResrvdName.dAll_filenames;
		EXPORT dAll_Amendment		:= Amendment.dAll_filenames;
		EXPORT dAll_NamesHist 	:= NamesHist.dAll_filenames;
	END;
	
	EXPORT dAll_filenames 				:= Base.dAll_Corps  	  +
																	 //Base.dAll_Tables     +
																	 Base.dAll_LLC  		  +
																	 Base.dAll_LP				  +
																	 Base.dAll_Officer	  +
																	 Base.dAll_Merger	    +
																	 Base.dAll_ResrvdName +
																	 Base.dAll_Amendment  +
																	 Base.dAll_NamesHist
																	 ;
  
END;