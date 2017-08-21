import ut, tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
	
		tools.mac_FilesInput(Corp2_Raw_KY.Filenames(pversion,pUseOtherEnvironment).Input.Companies ,Corp2_Raw_KY.Layouts.CompanyLayoutIn, RawCompanies,
		                     'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t');															
		tools.mac_FilesInput(Corp2_Raw_KY.Filenames(pversion, pUseOtherEnvironment).Input.Officer,	Corp2_Raw_KY.Layouts.OfficerLayoutIn, RawOfficer,
		                     'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t');														
		tools.mac_FilesInput(Corp2_Raw_KY.Filenames(pversion, pUseOtherEnvironment).Input.InitialOfficers,	Corp2_Raw_KY.Layouts.InitialOfficersLayoutIn, RawInitialOfficers,
		                     'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t');															

		//Due to missing enclosed double-quotes, multiple records are appearing within the name field for the
		//Companies file.  As shown above for "RawCompanies", the pQuote parameter is set to blank, and the 
		//transform below is eliminating the double-quotes in each of the fields (if they exist).   
		EXPORT Companies				:=	PROJECT(RawCompanies.Logical,
																				TRANSFORM(Corp2_Raw_KY.Layouts.CompanyLayoutIn,
																									SELF.id	     						:=	Stringlib.StringFilterOut(LEFT.id, '"');
																									SELF.comptype	 		   	 	:=	Stringlib.StringFilterOut(LEFT.comptype, '"');
																									SELF.compseq			     	:=	Stringlib.StringFilterOut(LEFT.compseq, '"');
																									SELF.name	     					:=	Stringlib.StringFilterOut(LEFT.name, '"');
																									SELF.standing	  	  	 	:=	Stringlib.StringFilterOut(LEFT.standing, '"');
																									SELF.status	   	  			:=	Stringlib.StringFilterOut(LEFT.status, '"');
																									SELF.country			     	:=	Stringlib.StringFilterOut(LEFT.country, '"');
																									SELF.state	   	 	 			:=	Stringlib.StringFilterOut(LEFT.state, '"');
																									SELF.type1	   	  			:=	Stringlib.StringFilterOut(LEFT.type1, '"');
																									SELF.raname	   	  			:=	Stringlib.StringFilterOut(LEFT.raname, '"');
																									SELF.raaddr1			     	:=	Stringlib.StringFilterOut(LEFT.raaddr1, '"');
																									SELF.raaddr2	 	 		   	:=	Stringlib.StringFilterOut(LEFT.raaddr2, '"');
																									SELF.raaddr3	 	   		 	:=	Stringlib.StringFilterOut(LEFT.raaddr3, '"');
																									SELF.raaddr4			     	:=	Stringlib.StringFilterOut(LEFT.raaddr4, '"');
																									SELF.racity	   		  		:=	Stringlib.StringFilterOut(LEFT.racity, '"');
																									SELF.rastate		 	    	:=	Stringlib.StringFilterOut(LEFT.rastate, '"');
																									SELF.razip	   		  		:=	Stringlib.StringFilterOut(LEFT.razip, '"');
																									SELF.poaddr1	 		    	:=	Stringlib.StringFilterOut(LEFT.poaddr1, '"');
																									SELF.poaddr2	 		 	   	:=	Stringlib.StringFilterOut(LEFT.poaddr2, '"');
																									SELF.poaddr3	  			 	:=	Stringlib.StringFilterOut(LEFT.poaddr3, '"');
																									SELF.poaddr4	   		  	:=	Stringlib.StringFilterOut(LEFT.poaddr4, '"');
																									SELF.pocity	     				:=	Stringlib.StringFilterOut(LEFT.pocity, '"');
																									SELF.postate	   	  		:=	Stringlib.StringFilterOut(LEFT.postate, '"');
																									SELF.pozip		     			:=	Stringlib.StringFilterOut(LEFT.pozip, '"');
																									SELF.filedate		    	 	:=	Stringlib.StringFilterOut(LEFT.filedate, '"');
																									SELF.orgdate	  	 	  	:=	Stringlib.StringFilterOut(LEFT.orgdate, '"');
																									SELF.authdate	   		  	:=	Stringlib.StringFilterOut(LEFT.authdate, '"');
																									SELF.recorddate	 	  		:=	Stringlib.StringFilterOut(LEFT.recorddate, '"');
																									SELF.raresdte		    	 	:=	Stringlib.StringFilterOut(LEFT.raresdte, '"');
																									SELF.expdte	    	 			:=	Stringlib.StringFilterOut(LEFT.expdte, '"');
																									SELF.rendte	   				  :=	Stringlib.StringFilterOut(LEFT.rendte, '"');
																									SELF.numofcr	     			:=	Stringlib.StringFilterOut(LEFT.numofcr, '"');
																									SELF.numofshr	    	 		:=	Stringlib.StringFilterOut(LEFT.numofshr, '"');
																									SELF.mangnum	  	  	 	:=	Stringlib.StringFilterOut(LEFT.mangnum, '"');
																									SELF.applname	    	 		:=	Stringlib.StringFilterOut(LEFT.applname, '"');
																									SELF.appltitl	  	  		:=	Stringlib.StringFilterOut(LEFT.appltitl, '"');
																									SELF.parpre	    		 		:=	Stringlib.StringFilterOut(LEFT.parpre, '"');
																									SELF.parcomno	   	  		:=	Stringlib.StringFilterOut(LEFT.parcomno, '"');
																									SELF.parcom	     				:=	Stringlib.StringFilterOut(LEFT.parcom, '"');
																									SELF.parpreno	    		 	:=	Stringlib.StringFilterOut(LEFT.parpreno, '"');
																									SELF.profit	     				:=	Stringlib.StringFilterOut(LEFT.profit, '"');
																									SELF.recordnumber				:=	Stringlib.StringFilterOut(LEFT.recordnumber, '"');
																								 )
																				);

		//Due to missing enclosed double-quotes, multiple records are appearing within the name field for the
		//Companies file.  As shown above for "RawOfficer", the pQuote parameter is set to blank, and the 
		//transform below is eliminating the double-quotes in each of the fields (if they exist).
		EXPORT Officer					:=	PROJECT(RawOfficer.Logical,
																				TRANSFORM(Corp2_Raw_KY.Layouts.OfficerLayoutIn,		
																									SELF.id	     						:=	Stringlib.StringFilterOut(LEFT.id, '"');
																									SELF.comptype	  		   	:=	Stringlib.StringFilterOut(LEFT.comptype, '"');
																									SELF.compseq			     	:=	Stringlib.StringFilterOut(LEFT.compseq, '"');
																									SELF.type1	  		   		:=	Stringlib.StringFilterOut(LEFT.type1, '"');
																									SELF.fname	     				:=	Stringlib.StringFilterOut(LEFT.fname, '"');
																									SELF.mname	  		   		:=	Stringlib.StringFilterOut(LEFT.mname, '"');
																									SELF.lname	     				:=	Stringlib.StringFilterOut(LEFT.lname, '"');
																									SELF.chgdate	   		  	:=	Stringlib.StringFilterOut(LEFT.chgdate, '"');
																									SELF.recordnumber	 			:=	Stringlib.StringFilterOut(LEFT.recordnumber, '"');
																								 )
																				);

		//Due to missing enclosed double-quotes, multiple records are appearing within the name field for the
		//Companies file.  As shown above for "RawInitialOfficers", the pQuote parameter is set to blank, and the 
		//transform below is eliminating the double-quotes in each of the fields (if they exist).
		EXPORT InitialOfficers	:=	PROJECT(RawInitialOfficers.Logical,
																				TRANSFORM(Corp2_Raw_KY.Layouts.InitialOfficersLayoutIn,
																									SELF.id	     						:=	Stringlib.StringFilterOut(LEFT.id, '"');
																									SELF.type1	     				:=	Stringlib.StringFilterOut(LEFT.type1, '"');
																									SELF.initialofficername	:=	Stringlib.StringFilterOut(LEFT.initialofficername, '"');
																									SELF.dateadded	     		:=	Stringlib.StringFilterOut(LEFT.dateadded, '"');
																									SELF.recordnumber	 			:=	Stringlib.StringFilterOut(LEFT.recordnumber, '"');
																								 )
																				);

	END;
	
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
	
		tools.mac_FilesBase(Corp2_Raw_KY.Filenames(pversion, pUseOtherEnvironment).Base.Companies, 	Corp2_Raw_KY.Layouts.CompanyLayoutBase, Companies);
		tools.mac_FilesBase(Corp2_Raw_KY.Filenames(pversion, pUseOtherEnvironment).Base.Officer, 		Corp2_Raw_KY.Layouts.OfficerLayoutBase, Officer);
		tools.mac_FilesBase(Corp2_Raw_KY.Filenames(pversion, pUseOtherEnvironment).Base.InitialOfficers, 		Corp2_Raw_KY.Layouts.InitialOfficersLayoutBase, InitialOfficers);

	END;

END;