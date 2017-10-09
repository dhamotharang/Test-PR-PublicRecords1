import Business_header, tools;

export Filenames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lversiondate	:= pversion;
	shared lthor				:= _Dataset(pUseOtherEnvironment).thor_cluster_Files;
/*	
	export Input := 
	module
		//////////////////////////////////////////////////////////////////
		// -- Root names
		//////////////////////////////////////////////////////////////////
		shared linputroot		:= lthor + 'in::business_header::@version@::';
		
		export lInputBusHdr			:= linputroot + 'Bus_header'					;
		export lInputBusCont		:= linputroot + 'Bus_Contact'					;
		
		//////////////////////////////////////////////////////////////////
		// -- Filename Versions
		//////////////////////////////////////////////////////////////////
		export InBusHdr		:= tools.mod_FilenamesInput(lInputBusHdr,lversiondate);
		export InBusCont	:= tools.mod_FilenamesInput(lInputBusCont,lversiondate);
		
		//////////////////////////////////////////////////////////////////
		// -- Dataset of all Base Filename Versions
		//////////////////////////////////////////////////////////////////		
		export dAll_filenames := 
					InBusHdr.dAll_filenames
				+	InBusCont.dAll_filenames			
			; 

	end;
*/
	
	export Base :=
	module
		//////////////////////////////////////////////////////////////////
		// -- Root names
		//////////////////////////////////////////////////////////////////
		shared lNewroot		:= lthor + 'base::Bipv2_Business_Header::@version@::';

		export lNewBHILroot				:= lNewroot + 'internal_linking'					;
		export lNewBHIroot				:= lNewroot + 'industry_linkids'					;
		export lNewBHLroot				:= lNewroot + 'license_linkids'						;
		export lNewControot				:= lNewroot + 'contacts'									;
		export lNewBestroot				:= lNewroot + 'best'											;
		

		//////////////////////////////////////////////////////////////////
		// -- Filename Versions
		//////////////////////////////////////////////////////////////////
		export LinkingBase				:= tools.mod_FilenamesBuild(lNewBHILroot				,lversiondate	,'',1	);
		export IndustryBase				:= tools.mod_FilenamesBuild(lNewBHIroot					,lversiondate	,'',1	);
		export LicenseBase				:= tools.mod_FilenamesBuild(lNewBHLroot					,lversiondate	,'',1	);
		export ContactBase				:= tools.mod_FilenamesBuild(lNewControot				,lversiondate	,'',1	);
		export Bestbase 					:= tools.mod_FilenamesBuild(lNewBestroot				,lversiondate	,'',1	);
		//export Relatives								:= tools.mod_FilenamesBuild(lNewBRroot				,lversiondate	,'',1	);
		
		
		
		//////////////////////////////////////////////////////////////////
		// -- Dataset of all Base Filename Versions
		//////////////////////////////////////////////////////////////////
		export dAll_filenames :=
				LinkingBase.dAll_filenames
			+ IndustryBase.dAll_filenames
			+ LicenseBase.dAll_filenames
			+ ContactBase.dAll_filenames
			+ BestBase.dAll_filenames
	
			;
	end;

end;