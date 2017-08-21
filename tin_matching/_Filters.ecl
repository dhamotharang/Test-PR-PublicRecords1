import Inquiry_Acclogs;

export _Filters :=
module

	export Input_file(

		dataset(layouts.input.sprayed	)	pInput
	
	) :=
	function
	
		lselectfilter :=		

						pInput.tin_name 					= ''
				or pInput.tin_match_code			not in ['0','6','7','8']	//keep '0','6','7','8'
			;

		lfullfilter		:= not(lselectfilter);
		lfile					:= pInput(lfullfilter);
		
		dfiltered			:= if(_Flags.logs_thor.ShouldFilter, lfile, pInput);
		
		dproject := project(
			 dfiltered
			,transform(
				 layouts.input.sprayed
				,self.jobid						:= left.jobid;
				 self.acctno					:= '';
				 self.account_number 	:= '';
				 self.gcid 						:= left.gcid;
				 self									:= left;
			)
		);

		return dproject;
		
	end;
		
	export asBH(

		dataset(layouts.input.sprayed	)	pInput
	
	) :=
	function
	
		lselectfilter :=		

						pInput.tin_name 					= ''
				or	(			pInput.tin_type						= '2'	//'2' = SSN, which we don't want
							and	pInput.tin_match_code			= '0' //'0' = good match, but don't want good matches that are SSNs to go into BH
						)
				or pInput.tin_match_code			not in ['0','7','8']	//keep '0','7','8'
			;

		lfullfilter		:= not(lselectfilter);
		lfile					:= pInput(lfullfilter);
		
		dfiltered			:= if(_Flags.prod_thor.ShouldFilter, lfile, pInput);
		
		dproject := project(
			 dfiltered
			,transform(
				 layouts.input.sprayed
				,self.jobid						:= left.jobid;
				 self.acctno					:= '';
				 self.account_number 	:= '';
				 self.gcid 						:= left.gcid;
				 self									:= left;
			)
		);

		return dproject;
		
	end;

	export MBS_File(

		 dataset(Inquiry_Acclogs.Layout_MBS	)	pInput 						= Inquiry_AccLogs.File_MBS.File
		,set of string												pFilterCodes			= Inquiry_AccLogs.fnCleanFunctions.FilterCds	//filter out these verticals
		,string 															pTranslationRegex	= 'opt out|disable observation'								//filter out these translations
	
	) :=
	function
	
		lselectfilter :=		

						pInput.vertical							in pFilterCodes 
				or	regexfind(pTranslationRegex,pInput.translation,nocase)
			;

		lfullfilter		:= not(lselectfilter);
		lfile					:= pInput(lfullfilter);
		
		dfiltered			:= if(_Flags.logs_thor.ShouldFilter, lfile, pInput);

		return dfiltered;
		
	end;

end;