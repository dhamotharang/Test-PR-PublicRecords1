IMPORT tools;
	
EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
						 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_VA._Dataset(pUseOtherEnvironment).InputTemplate + tag;
			
		EXPORT Corps	   		:= tools.mod_FilenamesInput(Template('corps::va'), pversion);
		EXPORT BT	   		    := tools.mod_FilenamesInput(Template('bt::va'), pversion);
		EXPORT LLC	   			:= tools.mod_FilenamesInput(Template('llc::va'), pversion);	
		EXPORT PSA	   			:= tools.mod_FilenamesInput(Template('psa::va'), pversion);
		EXPORT LP	    			:= tools.mod_FilenamesInput(Template('lp::va'), pversion);
		EXPORT GP	    			:= tools.mod_FilenamesInput(Template('gp::va'), pversion);
		EXPORT Officer	  	:= tools.mod_FilenamesInput(Template('officer::va'), pversion);			
		EXPORT Merger	    	:= tools.mod_FilenamesInput(Template('merger::va'), pversion);
		EXPORT ResrvdName	  := tools.mod_FilenamesInput(Template('resrvdname::va'), pversion);			
		EXPORT Amendment		:= tools.mod_FilenamesInput(Template('amendment::va'), pversion);
		EXPORT NamesHist	 	:= tools.mod_FilenamesInput(Template('nameshist::va'), pversion);

	END;
	
END;