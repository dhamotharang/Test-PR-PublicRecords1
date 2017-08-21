import corp,Std;
export Filters :=
module

	shared Layout_CorpV2_Base		:= Corp2.Layout_Corporate_Direct_Corp_AID		;
	shared Layout_ContV2_Base		:= Corp2.Layout_Corporate_Direct_Cont_AID		;
	shared Layout_EventsV2_Base	:= Corp2.Layout_Corporate_Direct_Event_Base	;
	shared Layout_StockV2_Base	:= Corp2.Layout_Corporate_Direct_Stock_Base	;
	shared Layout_ARV2_Base			:= Corp2.Layout_Corporate_Direct_AR_Base		;

	export Base :=
	module
	
		export Events(dataset(Layout_EventsV2_Base) pInput) :=
		function
			lselectfilter :=		
				///////////////////////////////////////////////////////////////////////////////		
				// -- Bug 23137 -- remove HI temporary records(charter number with a "T" in it)
				///////////////////////////////////////////////////////////////////////////////
				(			pInput.corp_state_origin = 'HI'
				 and (		regexfind('T',pInput.corp_key)
							or	regexfind('T',pInput.corp_sos_charter_nbr)
				))
				;

			lfullfilter		:= not(lselectfilter);
			lfile					:= pInput(lfullfilter);
			
			return				lfile;
		
		end;

		export Cont(dataset(Layout_ContV2_Base) pInput) :=
		function
			
			lselectfilter :=		
				///////////////////////////////////////////////////////////////////////////////		
				// -- Bug 23137 -- remove HI temporary records(charter number with a "T" in it)
				///////////////////////////////////////////////////////////////////////////////
				(			pInput.corp_state_origin = 'HI'
				 and (		regexfind('T',pInput.corp_key)
							or	regexfind('T',pInput.corp_orig_sos_charter_nbr)
				))
				;

			lfullfilter		:= not(lselectfilter);
			lfile					:= pInput(lfullfilter);
			
			return				lfile;
		
		end;

		export Corp(dataset(Layout_CorpV2_Base) pInput) :=
		function

			lselectfilter :=	
				///////////////////////////////////////////////////////////////////////////////		
				// -- Bug 23137 -- remove HI temporary records(charter number with a "T" in it)
				///////////////////////////////////////////////////////////////////////////////
				(			pInput.corp_state_origin = 'HI'
				 and (		regexfind('T',pInput.corp_key)
							or	regexfind('T',pInput.corp_orig_sos_charter_nbr)
				))
				;

			lfullfilter		:= not(lselectfilter);
			lfile					:= pInput(lfullfilter);

			return				lfile;
			
		end;

		export Stock(dataset(Layout_StockV2_Base) pInput) :=
		function
			
			lselectfilter :=		
				///////////////////////////////////////////////////////////////////////////////		
				// -- Bug 23137 -- remove HI temporary records(charter number with a "T" in it)
				///////////////////////////////////////////////////////////////////////////////
				(			pInput.corp_state_origin = 'HI'
				 and (		regexfind('T',pInput.corp_key)
							or	regexfind('T',pInput.corp_sos_charter_nbr)
				))
				;

			lfullfilter		:= not(lselectfilter);
			lfile					:= pInput(lfullfilter);
			
			return				lfile;
		
		end;

		export AR(dataset(Layout_ARV2_Base) pInput) :=
		function
			
			lselectfilter :=		
				///////////////////////////////////////////////////////////////////////////////		
				// -- Bug 23137 -- remove HI temporary records(charter number with a "T" in it)
				///////////////////////////////////////////////////////////////////////////////
				(			pInput.corp_state_origin = 'HI'
				 and (		regexfind('T',pInput.corp_key)
							or	regexfind('T',pInput.corp_sos_charter_nbr)
				))
				;

			lfullfilter		:= not(lselectfilter);
			lfile					:= pInput(lfullfilter);
			
			return				lfile;
		
		end;

		export StockFromEvents(dataset(Layout_EventsV2_Base) pInputfunction) :=
		function
			//different types of stock
			//cwp -- common with par value
			//cnp -- common without par value
			//pwp -- preferred with par value
			//pnp -- preferred without par value
			
			nodata := '(?:NO DATA FROM CONVERSION)';
			
			Stock_class_RegEx						:= '^(.*?)(?:STOCK|SHARES|STK)?[ ]?(?:CLASS|type|typ)[ ]*[:]?[ ]*('+ nodata +'|[[:alpha:]]+[ ]?(?:[(][[:alpha:]]+[)])?)[;]?[ ]*((NUMBER)?.*?)$'		;
			issued_shares_RegEx 				:= '^(.*?)(?:iss shrs|ISSUED SHARES|number of shares|no of shares|shr vol|share vol|share total)[ ]*[:]?[ ]*('+ nodata +'|[[:digit:]]+)[ ]*[;]?[ ]*(.*)$'		;
			authorized_shares_RegEx 		:= '^(.*?)(?:auth shrs|AUTHORIZED SHARES|AUTH SHARES)[ ]*[:]?[ ]*('+ nodata +'|[[:digit:]]+)[ ]*[;]?[ ]*(.*)$'								;
			par_value_RegEx 						:= '^(.*?)(?:par value amount|par val|par value)[ ]*[:]?[ ]*('+ nodata +'|[$]?[ ]*[[:digit:].,]+)[ ]*[;]?[ ]*(.*)$'								;
			voting_rights_RegEx					:= '^(.*?)(?:voting rts|voting rights)[ ]*[:]?[ ]*('+ nodata +'|[[:alpha:]]+)[ ]*[;]?[ ]*(.*)$'									;
			stock_capital_filing_RegEx	:= '^(.*?)(?:capital)[ ]*[:@]?[ ]*('+ nodata +'|[$]?[ ]*[[:digit:].,]+)[ ]*[;]?[ ]*(.*)$'												;
			stock_total_capitol_RegEx1	:= '^capital|capital amount$'																																				;
			stock_total_capitol_RegEx2	:= '^(?:authorized)?[ ]*[:]?[ ]*('+ nodata +'|[[:digit:]$,.]+)[ ]*[;]?[ ]*(.*)$'																	;
			
			getData(string pRegex, string pfield) :=
				if(regexfind(		pRegex	, pfield				,nocase)
					,trim(regexreplace(pRegex	, pfield	,'$2'	,nocase),left,right)
					,''
				);
			
			Layout_StockV2_Base tEventsV2toStockV2(Layout_EventsV2_Base pInput) :=
			transform
			
				event_filing_desc	:= trim(pInput.event_filing_desc							,left,right);
				event_desc				:= trim(pInput.event_desc											,left,right);
				both							:= trim(event_filing_desc + '; ' + event_desc	,left,right);
				
				stock_class 					:= getData(Stock_class_RegEx					,both				);
				issued_shares 				:= getData(issued_shares_RegEx				,event_desc	);
				authorized_shares 		:= getData(authorized_shares_RegEx		,event_desc	);
				par_value 						:= getData(par_value_RegEx						,both				);
				voting_rights					:= getData(voting_rights_RegEx				,both				);
				stock_capital_filing	:= getData(stock_capital_filing_RegEx	,both				);
				
				stock_total_capitol 	:= if(		regexfind(	stock_total_capitol_RegEx1, event_filing_desc	, nocase) 
																		and regexfind(	stock_total_capitol_RegEx2, event_desc				, nocase)
																			,trim(regexreplace(stock_total_capitol_RegEx2, event_desc, '$2'	, nocase),left,right)
																			,trim(stock_capital_filing,left,right)
																);
				// Remove stuff that I took out of the event_desc field
				stock_addl_info1			:= regexreplace(stock_total_capitol_RegEx2	, event_desc				,'$2'			,nocase);
				stock_addl_info2			:= regexreplace(Stock_class_RegEx						, stock_addl_info1	,'$1 $3'	,nocase);
				stock_addl_info3			:= regexreplace(issued_shares_RegEx 				, stock_addl_info2	,'$1 $3'	,nocase);
				stock_addl_info4			:= regexreplace(authorized_shares_RegEx 		, stock_addl_info3	,'$1 $3'	,nocase);
				stock_addl_info5			:= regexreplace(par_value_RegEx 						, stock_addl_info4	,'$1 $3'	,nocase);
				stock_addl_info6			:= regexreplace(voting_rights_RegEx					, stock_addl_info5	,'$1 $3'	,nocase);
				stock_addl_info7			:= regexreplace(stock_capital_filing_RegEx	, stock_addl_info6	,'$1 $3'	,nocase);
				                                                                                             
				
				self.corp_key									:= pInput.corp_key;
				self.corp_vendor							:= pInput.corp_vendor;
				self.corp_vendor_county				:= '';
				self.corp_vendor_subcode			:= '';
				self.corp_state_origin				:= pInput.corp_state_origin;
				self.corp_process_date				:= pInput.corp_process_date;
				self.corp_sos_charter_nbr			:= pInput.corp_sos_charter_nbr;
				self.stock_ticker_symbol			:= '';
				self.stock_exchange						:= '';
				self.stock_type								:= '';
				self.stock_class							:= if(stringlib.stringtouppercase(stock_class) 				= 'NO DATA FROM CONVERSION','',stock_class);
				self.stock_shares_issued			:= if(stringlib.stringtouppercase(issued_shares)			= 'NO DATA FROM CONVERSION','',issued_shares);
				self.stock_authorized_nbr			:= if(stringlib.stringtouppercase(authorized_shares)	= 'NO DATA FROM CONVERSION','',authorized_shares);
				self.stock_par_value					:= if(stringlib.stringtouppercase(par_value)					= 'NO DATA FROM CONVERSION','',par_value);
				self.stock_nbr_par_shares			:= '';
				self.stock_change_ind					:= '';
				self.stock_change_date				:= pInput.event_filing_date;
				self.stock_voting_rights_ind	:= map(regexfind('Y',voting_rights,nocase) =>'Y'
																						,regexfind('N',voting_rights,nocase) =>'N'
																						,''
																				);
				self.stock_convert_ind				:= '';
				self.stock_convert_date				:= '';
				self.stock_change_in_cap			:= '';
				self.stock_tax_capital				:= '';
				self.stock_total_capital			:= if(stringlib.stringtouppercase(stock_total_capitol)	= 'NO DATA FROM CONVERSION','',stock_total_capitol);
				self.stock_addl_info					:= if(stringlib.stringtouppercase(stock_addl_info7)			= 'NO DATA FROM CONVERSION','',trim(stock_addl_info7,left,right));
				self													:= pInput;

			end;

			stock_exp := 'STOCK|stk|SHARE|ISSUED|shrs|voting|par val';

			lselectfilter := regexfind(stock_exp, pInputfunction.event_filing_desc,nocase);
			lfullfilter		:= lselectfilter;

			lfile					:= project(pInputfunction(lfullfilter), tEventsV2toStockV2(left));
			
			return				lfile;
		
		end;

		export ARFromEvents(dataset(Layout_EventsV2_Base) pInputfunction) :=
		function

			dt_filed_RegEx							:= '^(.*?)(?:date|dt)[ ]*(?:filed)[ ]*[:]?[ ]*([[:digit:]]+)[ ]*[;]?[ ]*(.*?)$';
			report_year_RegEx						:= '^(.*?)(?:report|rept)[ ]*(?:year|yr)[ ]*[:]?[ ]*([[:digit:]]+)[ ]*[;]?[ ]*(.*?)$';
			mailed_dt_RegEx							:= '^(.*?)(?:MAIL(?:ED)?)[ ](?:Date|DT)[ ]*[:]?[ ]*([[:digit:]]+)[;]?[ ]*(.*?)$'																																;		
			due_dt_RegEx								:= 'annual report due'																																																													;
			delinquent_dt_RegEx					:= '^(.*?)(?:delinquency|deliquency|delq)[ ]*(?:run)?[ ]*(?:date|dt)[:]?[ ]*([[:digit:]]+)[ ]*[;]?[ ]*(.*?)$';
			ar_franchise_tax_paid_dt_REgex := '^(.*?)(?:paid)[ ]*(?:date)[ ]*[:]?[ ]*([[:digit:]]+)[ ]*[;]?[ ]*(.*?)$';
			tax_factor_RegEx						:= '^(.*?)(?:tax)[ ]*(?:factor)[ ]*[:]?[ ]*([[:digit:].,]+)[ ]*[;]?[ ]*(.*?)$'																																	;
			tax_amount_paid_RegEx				:= '^(.*?)(?:(?:(?:tax)?[ ]*(?:amt|amount)[ ]*(?:paid|pd))|(?:[[:digit:]]*[ ]*(?:license[ ]+tax))|(?:(?:filing)[ ]+(?:fee)[ ]+(?:collected|clcted)))[ ]*[:]?[ ]*([$]?[ ]*[[:digit:].,]+)[ ]*[;]?[ ]*(.*?)$'		;
			annual_report_cap_RegEx			:= '^(.*?)(?:annual)[ ]*(?:report|rpt)[ ]*(?:cap|capital)[ ]*[:]?[ ]*([[:digit:].,]+)[ ]*[;]?[ ]*(.*?)$'																				;
			illinois_capital_RegEx			:= '^(.*?)(?:illinois)[ ]*(?:cap|capital)[ ]*[:]?[ ]*([[:digit:].,]+)[ ]*[;]?[ ]*(.*?)$'																												;
			roll_RegEx									:= '^(.*?)(?:[1-2][[:digit:]]{3} )?(?:roll)[ ]*[:]?[ ]*([[:digit:].,]+)[ ]*[;]?[ ]*(.*?)$'																											;
			frame_RegEx									:= '^(.*?)(?:frame)[ ]*[:]?[ ]*([[:digit:].,]+)[ ]*[;]?[ ]*(.*?)$'																																							;
			extension_RegEx							:= '^(.*?)(?:no)[ ]*(?:extension|ext)[ ]*[:]?[ ]*([[:digit:].,]+)[ ]*[;]?[ ]*(.*?)$'																														;
		//microfilm_nbr_RegEx					:= can't find any events records with microfilm 
		//ar_type_RegEx								:= 

			getData(string pRegex, string pfield) :=
			if(regexfind(		pRegex	, pfield				,nocase)
				,trim(regexreplace(pRegex	, pfield	,'$2'	,nocase),left,right)
				,''
			);


			
			Layout_ARV2_Base tEventsV2toARV2(Layout_EventsV2_Base pInput) :=
			transform

				event_filing_desc	:= trim(pInput.event_filing_desc							,left,right);
				event_desc				:= trim(pInput.event_desc											,left,right);
				both							:= trim(event_filing_desc + '; ' + event_desc	,left,right);

				ar_comment1		:= regexreplace(mailed_dt_RegEx								,event_desc		,'$1 $3'	,nocase);
				ar_comment2		:= regexreplace(tax_factor_RegEx							,ar_comment1	,'$1 $3'	,nocase);
				ar_comment3		:= regexreplace(tax_amount_paid_RegEx 				,ar_comment2	,'$1 $3'	,nocase);
				ar_comment4		:= regexreplace(annual_report_cap_RegEx 			,ar_comment3	,'$1 $3'	,nocase);
				ar_comment5		:= regexreplace(illinois_capital_RegEx 				,ar_comment4	,'$1 $3'	,nocase);
				ar_comment6		:= regexreplace(roll_RegEx										,ar_comment5	,'$1 $3'	,nocase);
				ar_comment7		:= regexreplace(frame_RegEx										,ar_comment6	,'$1 $3'	,nocase);
				ar_comment8		:= regexreplace(extension_RegEx								,ar_comment7	,'$1 $3'	,nocase);
				ar_comment9		:= regexreplace(ar_franchise_tax_paid_dt_REgex,ar_comment8	,'$1 $3'	,nocase);
				ar_comment10	:= regexreplace(delinquent_dt_RegEx						,ar_comment9	,'$1 $3'	,nocase);
				ar_comment11	:= regexreplace(report_year_RegEx							,ar_comment10	,'$1 $3'	,nocase);
				ar_comment12	:= regexreplace(dt_filed_RegEx								,ar_comment11	,'$1 $3'	,nocase);

				self.corp_key									:= pInput.corp_key;
				self.corp_vendor							:= pInput.corp_vendor;
				self.corp_vendor_county				:= pInput.corp_vendor_county	;
				self.corp_vendor_subcode			:= pInput.corp_vendor_subcode;
				self.corp_state_origin				:= pInput.corp_state_origin;
				self.corp_process_date				:= pInput.corp_process_date;
				self.corp_sos_charter_nbr			:= pInput.corp_sos_charter_nbr;
				self.ar_year									:= if(getData(report_year_RegEx, pInput.event_desc) = ''
																						,trim(pInput.event_filing_date,left,right)[1..4]
																						,getData(report_year_RegEx, pInput.event_desc)[1..4]
																					);
				self.ar_mailed_dt							:= getData(mailed_dt_RegEx, pInput.event_desc);
				self.ar_due_dt								:= if(regexfind(due_dt_RegEx,trim(pInput.event_filing_desc,left,right), nocase), pInput.event_filing_date,'');
				self.ar_filed_dt							:= if(getData(dt_filed_RegEx, pInput.event_desc) != ''
																					and pInput.event_filing_date = ''
																						,getData(dt_filed_RegEx, pInput.event_desc)
																						,pInput.event_filing_date
																					);
																						
				self.ar_report_dt							:= ''; //don't understand difference between this one and filing date
				self.ar_report_nbr						:= pInput.event_filing_reference_nbr;
				self.ar_franchise_tax_paid_dt	:= getData(ar_franchise_tax_paid_dt_REgex	, pInput.event_desc);
				self.ar_delinquent_dt					:= getData(delinquent_dt_RegEx		, pInput.event_desc);
				self.ar_tax_factor						:= getData(tax_factor_RegEx				, pInput.event_desc);
				self.ar_tax_amount_paid				:= getData(tax_amount_paid_RegEx	, pInput.event_desc);
				self.ar_annual_report_cap			:= getData(annual_report_cap_RegEx, pInput.event_desc);
				self.ar_illinois_capital			:= getData(illinois_capital_RegEx	, pInput.event_desc);
				self.ar_roll									:= if(pInput.event_roll	= '', getData(roll_RegEx	, pInput.event_desc), pInput.event_roll	);
				self.ar_frame									:= if(pInput.event_frame = '', getData(frame_RegEx	, pInput.event_desc), pInput.event_frame	);
				self.ar_extension							:= getData(extension_RegEx, pInput.event_desc);//looks like there are not extensions
				self.ar_microfilm_nbr					:= pInput.event_microfilm_nbr;
				self.ar_comment								:= if(stringlib.stringtouppercase(ar_comment12) = 'NO DATA FROM CONVERSION','',trim(ar_comment12,left,right));
				self.ar_type									:= '';
				self													:= pInput;
						
			end;

			ar_exp := 'ANNUAL REPORT';

			lselectfilter := regexfind(ar_exp, pInputfunction.event_filing_desc,nocase);
			lfullfilter		:= lselectfilter;

			lfile					:= project(pInputfunction(lfullfilter), tEventsV2toARV2(left));
			
			return				lfile;

		end;
	end;
	
	export Input :=
	module
		export Events	:= true;
		export Cont		:= true;
		export Corp		:= true;
		export Stock	:= true;
		export AR			:= true;
	end;

	export Out :=
	module
		export Events	:= true;
		export Cont		:= true;
		export Corp		:= true;
		export Stock	:= true;
		export AR			:= true;
	end;
	
	export V1 :=
	module
		
		shared Layout_CorpV1_Base		:= Corp.Layout_Corp_Base;
		shared Layout_ContV1_Base		:= Corp.Layout_Corp_Cont_Base;
		shared Layout_EventsV1_Base	:= Corp.Layout_Corp_Event_Base;

		shared set_all_V2_states 			:= 	Corp2.SetsofStates.V2_states
																		;

		shared stock_exp				:= 'STOCK|stk|SHARE|ISSUED|shrs|voting|par val';		
		shared ar_exp						:= 'ANNUAL REPORT';
		shared stock_and_ar_exp := stock_exp + '|' + ar_exp;
		
		export Events(dataset(Layout_EventsV1_Base) pInput) :=
		function
			//should be good for events
			Layout_EventsV2_Base tEventsV1toEventsV2(Layout_EventsV1_Base pInput) :=
			transform
				self	:= pInput;
				self	:= [];
			end;

			lselectfilter := regexfind(stock_and_ar_exp, pInput.event_filing_desc,nocase);
			lfullfilter		:= not(lselectfilter);

			lfile					:= project(pInput(lfullfilter), tEventsV1toEventsV2(left));
			
			return				lfile;
		
		end;
		
		export Cont(dataset(Layout_ContV1_Base) pInput) :=
		function

			Layout_ContV2_Base tContV1toContV2(Layout_ContV1_Base pInput) :=
			transform
				self	:= pInput;
				self	:= [];
			end;

			lselectfilter := false;
			lfullfilter		:= not(lselectfilter);

			lfile					:= project(pInput(lfullfilter), tContV1toContV2(left));
			
			return				lfile;
		
		end;

		export Corp(dataset(Layout_CorpV1_Base) pInput) :=
		function
			
			Layout_CorpV2_Base tCorpV1toCorpV2(Layout_CorpV1_Base pInput) :=
			transform
				self	:= pInput;
				self	:= [];
			end;

			lselectfilter := false;
			lfullfilter		:= not(lselectfilter);
			lfile					:= project(pInput(lfullfilter), tCorpV1toCorpV2(left));
			
			return				lfile;
		
		end;
	
		export StockFromEvents(dataset(Layout_EventsV1_Base) pInputfunction) :=
		function
			//different types of stock
			//cwp -- common with par value
			//cnp -- common without par value
			//pwp -- preferred with par value
			//pnp -- preferred without par value
			
			nodata := '(?:NO DATA FROM CONVERSION)';
			
			Stock_class_RegEx						:= '^(.*?)(?:STOCK|SHARES|STK)?[ ]?(?:CLASS|type|typ)[ ]*[:]?[ ]*('+ nodata +'|[[:alpha:]]+[ ]?(?:[(][[:alpha:]]+[)])?)[;]?[ ]*((NUMBER)?.*?)$'		;
			issued_shares_RegEx 				:= '^(.*?)(?:iss shrs|ISSUED SHARES|number of shares|no of shares|shr vol|share vol|share total)[ ]*[:]?[ ]*('+ nodata +'|[[:digit:]]+)[ ]*[;]?[ ]*(.*)$'		;
			authorized_shares_RegEx 		:= '^(.*?)(?:auth shrs|AUTHORIZED SHARES|AUTH SHARES)[ ]*[:]?[ ]*('+ nodata +'|[[:digit:]]+)[ ]*[;]?[ ]*(.*)$'								;
			par_value_RegEx 						:= '^(.*?)(?:par value amount|par val|par value)[ ]*[:]?[ ]*('+ nodata +'|[$]?[ ]*[[:digit:].,]+)[ ]*[;]?[ ]*(.*)$'								;
			voting_rights_RegEx					:= '^(.*?)(?:voting rts|voting rights)[ ]*[:]?[ ]*('+ nodata +'|[[:alpha:]]+)[ ]*[;]?[ ]*(.*)$'									;
			stock_capital_filing_RegEx	:= '^(.*?)(?:capital)[ ]*[:@]?[ ]*('+ nodata +'|[$]?[ ]*[[:digit:].,]+)[ ]*[;]?[ ]*(.*)$'												;
			stock_total_capitol_RegEx1	:= '^capital|capital amount$'																																				;
			stock_total_capitol_RegEx2	:= '^(?:authorized)?[ ]*[:]?[ ]*('+ nodata +'|[[:digit:]$,.]+)[ ]*[;]?[ ]*(.*)$'																	;
			
			getData(string pRegex, string pfield) :=
				if(regexfind(		pRegex	, pfield				,nocase)
					,trim(regexreplace(pRegex	, pfield	,'$2'	,nocase),left,right)
					,''
				);
			
			Layout_StockV2_Base tEventsV1toStockV2(Layout_EventsV1_Base pInput) :=
			transform
			
				event_filing_desc	:= trim(pInput.event_filing_desc							,left,right);
				event_desc				:= trim(pInput.event_desc											,left,right);
				both							:= trim(event_filing_desc + '; ' + event_desc	,left,right);
				
				stock_class 					:= getData(Stock_class_RegEx					,both				);
				issued_shares 				:= getData(issued_shares_RegEx				,event_desc	);
				authorized_shares 		:= getData(authorized_shares_RegEx		,event_desc	);
				par_value 						:= getData(par_value_RegEx						,both				);
				voting_rights					:= getData(voting_rights_RegEx				,both				);
				stock_capital_filing	:= getData(stock_capital_filing_RegEx	,both				);
				
				stock_total_capitol 	:= if(		regexfind(	stock_total_capitol_RegEx1, event_filing_desc	, nocase) 
																		and regexfind(	stock_total_capitol_RegEx2, event_desc				, nocase)
																			,trim(regexreplace(stock_total_capitol_RegEx2, event_desc, '$2'	, nocase),left,right)
																			,trim(stock_capital_filing,left,right)
																);
				// Remove stuff that I took out of the event_desc field
				stock_addl_info1			:= regexreplace(stock_total_capitol_RegEx2	, event_desc				,'$2'			,nocase);
				stock_addl_info2			:= regexreplace(Stock_class_RegEx						, stock_addl_info1	,'$1 $3'	,nocase);
				stock_addl_info3			:= regexreplace(issued_shares_RegEx 				, stock_addl_info2	,'$1 $3'	,nocase);
				stock_addl_info4			:= regexreplace(authorized_shares_RegEx 		, stock_addl_info3	,'$1 $3'	,nocase);
				stock_addl_info5			:= regexreplace(par_value_RegEx 						, stock_addl_info4	,'$1 $3'	,nocase);
				stock_addl_info6			:= regexreplace(voting_rights_RegEx					, stock_addl_info5	,'$1 $3'	,nocase);
				stock_addl_info7			:= regexreplace(stock_capital_filing_RegEx	, stock_addl_info6	,'$1 $3'	,nocase);
				                                                                                             
				
				self.corp_key									:= pInput.corp_key;
				self.corp_vendor							:= pInput.corp_vendor;
				self.corp_vendor_county				:= '';
				self.corp_vendor_subcode			:= '';
				self.corp_state_origin				:= pInput.corp_state_origin;
				self.corp_process_date				:= pInput.corp_process_date;
				self.corp_sos_charter_nbr			:= pInput.corp_sos_charter_nbr;
				self.stock_ticker_symbol			:= '';
				self.stock_exchange						:= '';
				self.stock_type								:= '';
				self.stock_class							:= if(stringlib.stringtouppercase(stock_class) 				= 'NO DATA FROM CONVERSION','',stock_class);
				self.stock_shares_issued			:= if(stringlib.stringtouppercase(issued_shares)			= 'NO DATA FROM CONVERSION','',issued_shares);
				self.stock_authorized_nbr			:= if(stringlib.stringtouppercase(authorized_shares)	= 'NO DATA FROM CONVERSION','',authorized_shares);
				self.stock_par_value					:= if(stringlib.stringtouppercase(par_value)					= 'NO DATA FROM CONVERSION','',par_value);
				self.stock_nbr_par_shares			:= '';
				self.stock_change_ind					:= '';
				self.stock_change_date				:= pInput.event_filing_date;
				self.stock_voting_rights_ind	:= map(regexfind('Y',voting_rights,nocase) =>'Y'
																						,regexfind('N',voting_rights,nocase) =>'N'
																						,''
																				);
				self.stock_convert_ind				:= '';
				self.stock_convert_date				:= '';
				self.stock_change_in_cap			:= '';
				self.stock_tax_capital				:= '';
				self.stock_total_capital			:= if(stringlib.stringtouppercase(stock_total_capitol)	= 'NO DATA FROM CONVERSION','',stock_total_capitol);
				self.stock_addl_info					:= if(stringlib.stringtouppercase(stock_addl_info7)			= 'NO DATA FROM CONVERSION','',trim(stock_addl_info7,left,right));
				self													:= pInput;

			end;

			lselectfilter := regexfind(stock_exp, pInputfunction.event_filing_desc,nocase);
			lfullfilter		:= lselectfilter;
;

			lfile					:= project(pInputfunction(lfullfilter), tEventsV1toStockV2(left));
			
			return				lfile;
		
		end;

		export ARFromEvents(dataset(Layout_EventsV1_Base) pInputfunction) :=
		function

			dt_filed_RegEx							:= '^(.*?)(?:date|dt)[ ]*(?:filed)[ ]*[:]?[ ]*([[:digit:]]+)[ ]*[;]?[ ]*(.*?)$';
			report_year_RegEx						:= '^(.*?)(?:report|rept)[ ]*(?:year|yr)[ ]*[:]?[ ]*([[:digit:]]+)[ ]*[;]?[ ]*(.*?)$';
			mailed_dt_RegEx							:= '^(.*?)(?:MAIL(?:ED)?)[ ](?:Date|DT)[ ]*[:]?[ ]*([[:digit:]]+)[;]?[ ]*(.*?)$'																																;		
			due_dt_RegEx								:= 'annual report due'																																																													;
			delinquent_dt_RegEx					:= '^(.*?)(?:delinquency|deliquency|delq)[ ]*(?:run)?[ ]*(?:date|dt)[:]?[ ]*([[:digit:]]+)[ ]*[;]?[ ]*(.*?)$';
			ar_franchise_tax_paid_dt_REgex := '^(.*?)(?:paid)[ ]*(?:date)[ ]*[:]?[ ]*([[:digit:]]+)[ ]*[;]?[ ]*(.*?)$';
			tax_factor_RegEx						:= '^(.*?)(?:tax)[ ]*(?:factor)[ ]*[:]?[ ]*([[:digit:].,]+)[ ]*[;]?[ ]*(.*?)$'																																	;
			tax_amount_paid_RegEx				:= '^(.*?)(?:(?:(?:tax)?[ ]*(?:amt|amount)[ ]*(?:paid|pd))|(?:[[:digit:]]*[ ]*(?:license[ ]+tax))|(?:(?:filing)[ ]+(?:fee)[ ]+(?:collected|clcted)))[ ]*[:]?[ ]*([$]?[ ]*[[:digit:].,]+)[ ]*[;]?[ ]*(.*?)$'		;
			annual_report_cap_RegEx			:= '^(.*?)(?:annual)[ ]*(?:report|rpt)[ ]*(?:cap|capital)[ ]*[:]?[ ]*([[:digit:].,]+)[ ]*[;]?[ ]*(.*?)$'																				;
			illinois_capital_RegEx			:= '^(.*?)(?:illinois)[ ]*(?:cap|capital)[ ]*[:]?[ ]*([[:digit:].,]+)[ ]*[;]?[ ]*(.*?)$'																												;
			roll_RegEx									:= '^(.*?)(?:[1-2][[:digit:]]{3} )?(?:roll)[ ]*[:]?[ ]*([[:digit:].,]+)[ ]*[;]?[ ]*(.*?)$'																											;
			frame_RegEx									:= '^(.*?)(?:frame)[ ]*[:]?[ ]*([[:digit:].,]+)[ ]*[;]?[ ]*(.*?)$'																																							;
			extension_RegEx							:= '^(.*?)(?:no)[ ]*(?:extension|ext)[ ]*[:]?[ ]*([[:digit:].,]+)[ ]*[;]?[ ]*(.*?)$'																														;
		//microfilm_nbr_RegEx					:= can't find any events records with microfilm 
		//ar_type_RegEx								:= 

			getData(string pRegex, string pfield) :=
			if(regexfind(		pRegex	, pfield				,nocase)
				,trim(regexreplace(pRegex	, pfield	,'$2'	,nocase),left,right)
				,''
			);


			
			Layout_ARV2_Base tEventsV2toARV2(Layout_EventsV1_Base pInput) :=
			transform

				event_filing_desc	:= trim(pInput.event_filing_desc							,left,right);
				event_desc				:= trim(pInput.event_desc											,left,right);
				both							:= trim(event_filing_desc + '; ' + event_desc	,left,right);

				ar_comment1		:= regexreplace(mailed_dt_RegEx								,event_desc		,'$1 $3'	,nocase);
				ar_comment2		:= regexreplace(tax_factor_RegEx							,ar_comment1	,'$1 $3'	,nocase);
				ar_comment3		:= regexreplace(tax_amount_paid_RegEx 				,ar_comment2	,'$1 $3'	,nocase);
				ar_comment4		:= regexreplace(annual_report_cap_RegEx 			,ar_comment3	,'$1 $3'	,nocase);
				ar_comment5		:= regexreplace(illinois_capital_RegEx 				,ar_comment4	,'$1 $3'	,nocase);
				ar_comment6		:= regexreplace(roll_RegEx										,ar_comment5	,'$1 $3'	,nocase);
				ar_comment7		:= regexreplace(frame_RegEx										,ar_comment6	,'$1 $3'	,nocase);
				ar_comment8		:= regexreplace(extension_RegEx								,ar_comment7	,'$1 $3'	,nocase);
				ar_comment9		:= regexreplace(ar_franchise_tax_paid_dt_REgex,ar_comment8	,'$1 $3'	,nocase);
				ar_comment10	:= regexreplace(delinquent_dt_RegEx						,ar_comment9	,'$1 $3'	,nocase);
				ar_comment11	:= regexreplace(report_year_RegEx							,ar_comment10	,'$1 $3'	,nocase);
				ar_comment12	:= regexreplace(dt_filed_RegEx								,ar_comment11	,'$1 $3'	,nocase);

				self.corp_key									:= pInput.corp_key;
				self.corp_vendor							:= pInput.corp_vendor;
				self.corp_vendor_county				:= ''	;
				self.corp_vendor_subcode			:= '';
				self.corp_state_origin				:= pInput.corp_state_origin;
				self.corp_process_date				:= pInput.corp_process_date;
				self.corp_sos_charter_nbr			:= pInput.corp_sos_charter_nbr;
				self.ar_year									:= if(getData(report_year_RegEx, pInput.event_desc) = ''
																						,trim(pInput.event_filing_date,left,right)[1..4]
																						,getData(report_year_RegEx, pInput.event_desc)[1..4]
																					);
				self.ar_mailed_dt							:= getData(mailed_dt_RegEx, pInput.event_desc);
				self.ar_due_dt								:= if(regexfind(due_dt_RegEx,trim(pInput.event_filing_desc,left,right), nocase), pInput.event_filing_date,'');
				self.ar_filed_dt							:= if(getData(dt_filed_RegEx, pInput.event_desc) != ''
																					and pInput.event_filing_date = ''
																						,getData(dt_filed_RegEx, pInput.event_desc)
																						,pInput.event_filing_date
																					);
																						
				self.ar_report_dt							:= ''; //don't understand difference between this one and filing date
				self.ar_report_nbr						:= pInput.event_filing_reference_nbr;
				self.ar_franchise_tax_paid_dt	:= getData(ar_franchise_tax_paid_dt_REgex	, pInput.event_desc);
				self.ar_delinquent_dt					:= getData(delinquent_dt_RegEx		, pInput.event_desc);
				self.ar_tax_factor						:= getData(tax_factor_RegEx				, pInput.event_desc);
				self.ar_tax_amount_paid				:= getData(tax_amount_paid_RegEx	, pInput.event_desc);
				self.ar_annual_report_cap			:= getData(annual_report_cap_RegEx, pInput.event_desc);
				self.ar_illinois_capital			:= getData(illinois_capital_RegEx	, pInput.event_desc);
				self.ar_roll									:= getData(roll_RegEx	, pInput.event_desc);
				self.ar_frame									:= getData(frame_RegEx	, pInput.event_desc);
				self.ar_extension							:= getData(extension_RegEx, pInput.event_desc);//looks like there are not extensions
				self.ar_microfilm_nbr					:= '';
				self.ar_comment								:= if(stringlib.stringtouppercase(ar_comment12) = 'NO DATA FROM CONVERSION','',trim(ar_comment12,left,right));
				self.ar_type									:= '';
				self													:= pInput;
						
			end;

			lselectfilter := regexfind(ar_exp, pInputfunction.event_filing_desc,nocase);
			lfullfilter		:= lselectfilter;

			lfile					:= project(pInputfunction(lfullfilter), tEventsV2toARV2(left));
			
			return				lfile;

		end;

	end;

	getTodaysdate := (string8)Std.Date.Today();
	one_year_ago  := (unsigned4)((unsigned)getTodaysdate[1..4] - 1 + getTodaysdate[5..]);

	export fAs_POE(
	
		 dataset(Layout_ContV2_Base)	pContBase		= Files().AID.cont.qa
		,dataset(Layout_CorpV2_Base) 	pCorpBase		= Files().AID.corp.qa
		,boolean											pFilterOut	= true
		
	) := 
	function

		boolean lCorpFilter 	:=
 		
			pCorpBase.corp_status_desc[1..6] not in  
			['ACTIVE','CONSOL','CONVER','CURREN','EFFECT','EXISTS','EXISTI','FOR PR',
			 'GOOD S','INCORP','IN EXI','IN GOO','IN USE','MERGED','MERGER','NEW CO',
			 'NAME C','ORGANI','PRIOR ','QUALIF','REDOME','RE-INS','REINST','RESTOR'
			 ,'REVIVE']
			or pCorpBase.corp_status_desc[8..10] in ['(OU','OUT',' OU']
			or pCorpBase.corp_status_desc[11..17] in 
				['E RESER','ED - NO','ED -- N','ED INAC'
				,'NON-SUR','- DELIN','ON-SURV','ESS PRE']
			or trim(pCorpBase.corp_status_desc,left,right) = 'CONVERTED OUT'
			or pCorpBase.record_type != 'C'
			;
			
		boolean lContFilter	:=	 
					pContBase.cont_lname	 = ''
			or	pContBase.record_type != 'C'
			or	regexfind('REGISTERED AGENT', pContBase.cont_title_desc, nocase)		
			or 	pContBase.dt_last_seen			> one_year_ago	
			;

		boolean lFullCorpFilter 		:= if(pFilterOut
																	,not(lCorpFilter)	//negate it 
																	,lCorpFilter
																);

		boolean lFullContFilter 		:= if(pFilterOut
																	,not(lContFilter)	//negate it 
																	,lContFilter
																);

		dCorpBase_filt  := pCorpBase(lFullCorpFilter,bdid != 0);	//move bdid != 0 filter here so it doesn't get negated
		dContBase_filt  := pContBase(lFullContFilter,bdid != 0);
		dCorpBase_dedup := table(dCorpBase_filt, {bdid},bdid);
		
		djoin := join(
			 distribute(dContBase_filt	,bdid)
			,distribute(dCorpBase_dedup	,bdid)
			,left.bdid = right.bdid
			,transform(
				 Layout_ContV2_Base
				,self := left
			)
			,local
		);
		
		return djoin;

	end;
	
end;