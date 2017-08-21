import Std;

export _Filters :=
module

	export Input(dataset(Layouts.Input.Sprayed) pInput) :=
	function
		
		lselectfilter :=		

						pInput.company_name 					= ''
			;

		lfullfilter		:= not(lselectfilter);
		lfile					:= pInput(lfullfilter);
		
		return				if(_Flags.ShouldFilter, lfile, pInput);
	
	end;


	export Base(dataset(Layouts.Base) pInput) :=
	function
		
		lselectfilter :=		

				(		pInput.rawfields.zoomid 					= '382516491'
				and	pInput.rawfields.Zoom_Company_ID	= '37961766'
				)
				or	pInput.rawfields.company_name 		= ''

			;

		lfullfilter		:= not(lselectfilter);
		lfile					:= pInput(lfullfilter);
		
		return				if(_Flags.ShouldFilter, lfile, pInput);
	
	end;
	
	export BaseXML(dataset(Layouts.BaseXML) pInput) :=
	function
		
		lselectfilter :=		

						pInput.rawfields.zoomid 					  = '382516491'
				and	pInput.rawfields.resume_company_iD	= '37961766'
			;

		lfullfilter		:= not(lselectfilter);
		lfile					:= pInput(lfullfilter);
		
		return				if(_Flags.ShouldFilter, lfile, pInput);
	
	end;

	export keybuild(
		 dataset(Layouts.Base)	pInput
		,boolean								pFilterOut	= true
	) :=
	function
		
		dproj := project(pInput,transform(Layouts.keybuild
			,self.rawfields.company_name := if(			regexfind('^(.*?)(\\1)$',left.rawfields.company_name									,nocase)
																					and regexfind(' '						,trim(left.rawfields.company_name,left,right)	,nocase)
																				,regexreplace('^(.*?)(\\1)$',left.rawfields.company_name,'\\1',nocase)
																				,left.rawfields.company_name
																			);
			 self.rawfields.Company_Address_Street := map(
				 regexfind('&Nbsp',left.rawfields.Company_Address_Street									,nocase)
						=> regexreplace('&Nbsp',left.rawfields.Company_Address_Street,'',nocase)
				,regexfind('^1558 Sandpiper Drive   Corolla NC 27927605.*$',left.rawfields.Company_Address_Street,nocase)
						=> '1558 Sandpiper Drive Corolla NC 27927'
				,regexfind('^No Part Of This Publication May Be Reproduced, Stored In A Retrieval System, Or Transmitted In Any Form Or By Any Means, Electronic, Mechanical, Photocopying, Recording Or Otherwise Without The Written Permission Of Richard Burbidge Ltd. Richard Burbidge Ltd , Whittington Road$',left.rawfields.Company_Address_Street,nocase)
						=> regexreplace('No Part Of This Publication May Be Reproduced, Stored In A Retrieval System, Or Transmitted In Any Form Or By Any Means, Electronic, Mechanical, Photocopying, Recording Or Otherwise Without The Written Permission Of Richard Burbidge Ltd. Richard Burbidge Ltd , Whittington Road',left.rawfields.Company_Address_Street,'',nocase)
				,regexfind('If You Are Interested In Or Wish To Be Considered',left.rawfields.Company_Address_Street,nocase)
						=> ''
							,left.rawfields.Company_Address_Street
			);
																			
			 self := left;
		));

		lfilter := 
				 (not regexfind('^[[:digit:]-]+$',trim(dproj.rawfields.zoomid,left,right),nocase))
			or (length(trim(dproj.rawfields.name_last								,left,right)) > 50)
			or (length(trim(dproj.rawfields.Job_Title_Hierarchy_Level,left,right)) > 4	)
			or (length(trim(dproj.rawfields.source_count							,left,right)) > 5	)
			or (length(trim(dproj.rawfields.Last_Updated_Date				,left,right)) > 10)
			or (length(trim(dproj.rawfields.ZoomID										,left,right)) > 10	)
			or (length(trim(dproj.rawfields.Zoom_Company_ID					,left,right)) > 10	)
			or (length(trim(dproj.rawfields.Acquiring_Company_ID			,left,right)) > 10	)
			or (length(trim(dproj.rawfields.Parent_Company_ID				,left,right)) > 10	)
			or (dproj.rawfields.company_name	= '')
		;

		lfull_filter := if(pFilterOut	, not lfilter
																	,			lfilter
										);

		dproj_filt	:= dproj(lfull_filter);

		return		if(_Flags.ShouldFilter, dproj_filt, dproj);

	end;
	
	shared getTodaysdate := (string8)Std.Date.Today();
	shared one_year_ago := (unsigned4)((unsigned)getTodaysdate[1..4] - 1 + getTodaysdate[5..]);

	export fAs_POE(
	
		 dataset(layouts.Base)	pInput
		,boolean								pFilterOut	= true
		
	) := 
	function

		boolean lStandardFilter 	:= 		
					pInput.record_type			!= 'C'	
			or 	pInput.dt_last_seen			< one_year_ago	
			;
		boolean lAdditionalFilter	:=	 
			false
			;

		boolean lFullFilter 		:= if(pFilterOut
																	,not(lStandardFilter or lAdditionalFilter)	//negate it 
																	,(lStandardFilter or lAdditionalFilter)
																);

		return pInput(lFullFilter);
	
	end;

end;