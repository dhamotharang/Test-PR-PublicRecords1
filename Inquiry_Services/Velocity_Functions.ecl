import iesp, Inquiry_Acclogs, ut;

export	Velocity_Functions(Inquiry_Services.Velocity_Iparam.SearchRecords	inMod)	:=
module
	
	// Check if the vertical is valid
	shared	boolean	fnCheckVertical(string	pVertical)	:=	pVertical NOT IN Inquiry_Services.Velocity_Constants.VERTICAL_FILTER;
	
	// Check if industry is valid
	shared	boolean	fnCheckIndustry(string	pIndustry)	:=	pIndustry NOT IN Inquiry_Services.Velocity_Constants.INDUSTRY_FILTER;
	
	// Check if the filtered industry is valid
	shared	boolean	fnCheckIndustryFilter(string	pVertical,string	pIndustry)	:=	map(	pIndustry	not	in	Inquiry_Services.Velocity_Constants.INDUSTRY_FILTER																																												=>	true,
																																												pVertical	!=	Inquiry_Services.Velocity_Constants.Vertical.Collections	and	pIndustry	in	Inquiry_Services.Velocity_Constants.Industry.BankingVals					=>	true,
																																												pVertical	=		Inquiry_Services.Velocity_Constants.Vertical.Collections	or	pIndustry	in	Inquiry_Services.Velocity_Constants.Industry.SkipLocateVals				=>	true,
																																												pVertical	!=	Inquiry_Services.Velocity_Constants.Vertical.Collections	and	pIndustry	in	Inquiry_Services.Velocity_Constants.Industry.MoneyServiceBusVals	=>	true,
																																												pVertical	!=	Inquiry_Services.Velocity_Constants.Vertical.Collections	and	pIndustry	in	Inquiry_Services.Velocity_Constants.Industry.AltFinServicesVals		=>	true,
																																												pVertical	!=	Inquiry_Services.Velocity_Constants.Vertical.Collections	and	pIndustry	in	Inquiry_Services.Velocity_Constants.Industry.UtilitiesVals				=>	true,
																																												false
																																											);
	
	// Commonize the related industry names into broader industry categories
	shared	string	fnCategorizeIndustry(	string	pVertical,
																				string	pIndustry
																			)	:=	map(	pIndustry	in	Inquiry_Services.Velocity_Constants.Industry.BankingVals																																							=>	Inquiry_Services.Velocity_Constants.Industry.Banking,
																								  inMod.Industry	=	Inquiry_Services.Velocity_Constants.Industry.SkipLocate	and	pvertical	=	Inquiry_Services.Velocity_Constants.Vertical.Collections	=>	Inquiry_Services.Velocity_Constants.Industry.SkipLocate,
																									pIndustry	in	Inquiry_Services.Velocity_Constants.Industry.SkipLocateVals																																						=>	Inquiry_Services.Velocity_Constants.Industry.SkipLocate,
																									pIndustry	in	Inquiry_Services.Velocity_Constants.Industry.MoneyServiceBusVals																																			=>	Inquiry_Services.Velocity_Constants.Industry.MoneyServiceBusiness,
																									pIndustry	in	Inquiry_Services.Velocity_Constants.Industry.AltFinServicesVals																																				=>	Inquiry_Services.Velocity_Constants.Industry.AltFinancialServices,
																									pIndustry	in	Inquiry_Services.Velocity_Constants.Industry.UtilitiesVals																																						=>	Inquiry_Services.Velocity_Constants.Industry.Utility,
																									Inquiry_Services.Velocity_Constants.Industry.Other
																								);
	
	// Commonize the related product names into broader product cactegories
	shared	string	fnCategorizeProduct(string	pProduct)	:=	if(	ut.CleanSpacesAndUpper (pProduct)	in	Inquiry_Services.Velocity_Constants.Product.IDVFPFunctionVals,
																																Inquiry_Services.Velocity_Constants.Product.IdVerificationFraudPrevention,
																																Inquiry_Services.Velocity_Constants.Product.Other
																															);
	
	// Search alert id service
	shared	boolean	fnIncludeVerticals(string	pVertical)	:=	pVertical	in [	Inquiry_Services.Velocity_Constants.Vertical.Auto,
																																						Inquiry_Services.Velocity_Constants.Vertical.Collections,
																																						Inquiry_Services.Velocity_Constants.Vertical.Core,
																																						Inquiry_Services.Velocity_Constants.Vertical.Emblem,
																																						Inquiry_Services.Velocity_Constants.Vertical.Emerging,
																																						Inquiry_Services.Velocity_Constants.Vertical.Financial,
																																						Inquiry_Services.Velocity_Constants.Vertical.Receivable,
																																						Inquiry_Services.Velocity_Constants.Vertical.CorpCore,
																																						Inquiry_Services.Velocity_Constants.Vertical.CorpEnterprise,
																																						Inquiry_Services.Velocity_Constants.Vertical.Abc,
																																						Inquiry_Services.Velocity_Constants.Vertical.Aml,
																																						Inquiry_Services.Velocity_Constants.Vertical.Gaming,
																																						Inquiry_Services.Velocity_Constants.Vertical.Brm,
																																						Inquiry_Services.Velocity_Constants.Vertical.OtherBrm,
																																						Inquiry_Services.Velocity_Constants.Vertical.AutoFinance,
																																						Inquiry_Services.Velocity_Constants.Vertical.ConsumerCredit,
																																						Inquiry_Services.Velocity_Constants.Vertical.Fraud,
																																						Inquiry_Services.Velocity_Constants.Vertical.OtherFraud,
																																						Inquiry_Services.Velocity_Constants.Vertical.CorpMkts,
																																						Inquiry_Services.Velocity_Constants.Vertical.FsLegacy,
																																						Inquiry_Services.Velocity_Constants.Vertical.Infrastructure,																																															
																																						Inquiry_Services.Velocity_Constants.Vertical.OnePC,
																																						Inquiry_Services.Velocity_Constants.Vertical.ThreePC,
																																						Inquiry_Services.Velocity_Constants.Vertical.Communication,
																																						Inquiry_Services.Velocity_Constants.Vertical.D2c,
																																						Inquiry_Services.Velocity_Constants.Vertical.Digital,
																																						Inquiry_Services.Velocity_Constants.Vertical.RealEstate,
																																						Inquiry_Services.Velocity_Constants.Vertical.Cdm,
																																						Inquiry_Services.Velocity_Constants.Vertical.Notassigned
																																						];
	
	// Commonize the industries	
	shared	fn_commonize_industry(string	in_industry)	:=	case(	in_industry,
																																''                         => Inquiry_Services.Velocity_Constants.Industry.Other,
																																'AUTO'                     => Inquiry_Services.Velocity_Constants.Industry.Auto,
																																'AUTO - CAPTIVE'           =>	Inquiry_Services.Velocity_Constants.Industry.Auto,
																																'BANKING'                  =>	Inquiry_Services.Velocity_Constants.Industry.Finance,
																																'CABLE/SATELLITE/INTERNET' =>	Inquiry_Services.Velocity_Constants.Industry.Utility,
																																'CARDS'                    =>	Inquiry_Services.Velocity_Constants.Industry.Credit,
																																'CARDS - SUBPRIME'         =>	Inquiry_Services.Velocity_Constants.Industry.Credit,
																																'COMMUNICATIONS'           => Inquiry_Services.Velocity_Constants.Industry.Communications,
																																'CREDIT BUREAU'            =>	Inquiry_Services.Velocity_Constants.Industry.Credit,
																																'CREDIT DECISIONING'       =>	Inquiry_Services.Velocity_Constants.Industry.Credit,
																																'CREDIT MONITORING'        =>	Inquiry_Services.Velocity_Constants.Industry.Credit,
																																'CREDIT UNION'             => Inquiry_Services.Velocity_Constants.Industry.Credit,
																																'DIRECT TO CONSUMER'       => Inquiry_Services.Velocity_Constants.Industry.DirectToConsumer,
																																'FINANCE COMPANY'          =>	Inquiry_Services.Velocity_Constants.Industry.Finance,
																																'FS SERVICES PROVIDER'     => Inquiry_Services.Velocity_Constants.Industry.Finance,
																																'INVESTMENTS/SECURITIES'   =>	Inquiry_Services.Velocity_Constants.Industry.Finance,
																																'LEASING'                  =>	Inquiry_Services.Velocity_Constants.Industry.Finance,
																																'MORTGAGE/REAL ESTATE'     =>	Inquiry_Services.Velocity_Constants.Industry.Finance,
																																'OTHER'                    =>	Inquiry_Services.Velocity_Constants.Industry.Other,
																																'PROPERTY MANAGEMENT'      => Inquiry_Services.Velocity_Constants.Industry.Finance,
																																'QUIZ PROVIDER'            =>	Inquiry_Services.Velocity_Constants.Industry.Kba,
																																'REFUND ANTICIPATION LOAN' => Inquiry_Services.Velocity_Constants.Industry.Finance,
																																'RENT TO OWN'              =>	Inquiry_Services.Velocity_Constants.Industry.Finance,
																																'RETAIL'                   =>	Inquiry_Services.Velocity_Constants.Industry.Retail,
																																'RETAIL PAYMENTS'          =>	Inquiry_Services.Velocity_Constants.Industry.Retail,
																																'STUDENT LOANS'            => Inquiry_Services.Velocity_Constants.Industry.Finance,
																																'UTILITIES'                => Inquiry_Services.Velocity_Constants.Industry.Utility,
																																''
																															);
	
	
	// Start date for the date range
	shared	string8	vFromDate	:=	if(	inMod.EdataVelocity	and	inMod.RetroDate	!=	'',
																		inMod.RetroDate,
																		ut.Now('%Y%m%d',true)
																	);
	shared	string6	vFromTime	:=	stringlib.stringfilterout(ut.Now('%T',true),':');
	
	// Temp layout for booleans and other temp variables
	shared	layout_	:=	inquiry_services.velocity_layouts.r_add_booleans;
	
	// Combine thor and sybase records
	export	fnCombineRecords(	dataset(recordof(Inquiry_AccLogs.Key_Inquiry_DID))			dThorInquiry,
														dataset(Inquiry_Services.Velocity_Layouts.Gateway.Out)	dSybaseInquiry
													)	:=
	function		
		// Transform thor inquiry records to the temporary layout
		layout_	x1(dThorInquiry	le)	:=
		transform
			string8	vInquiryDate						:=	if(	le.search_info.datetime[1..8]	<=	vFromDate,
																							le.search_info.datetime[1..8],
																							skip
																						);
			integer	vDaysApart							:=	ut.DaysApart(vFromDate,vInquiryDate);
			// Per requirements a true 24 hour check is not required it is ok to round to days instead of checking hours
			// boolean vTrueLast24Check				:=  map(vDaysApart=0 => true,
																							// vDaysApart=1 and (le.search_info.datetime[10..18] >= vFromTime) => true,
																							// false); 
			string	vVertical								:=	ut.CleanSpacesAndUpper(le.bus_intel.vertical);
			string	vIndustry								:=	ut.CleanSpacesAndUpper(le.bus_intel.industry);
			string	vFunctionDesc						:=	ut.CleanSpacesAndUpper(le.search_info.function_description);
			
			
			self.bus_intel.vertical					:=	vVertical;
			self.bus_intel.industry					:=	vIndustry;
			self.InquiryDate								:=	vInquiryDate;
			self.InquiryTime								:=	le.search_info.datetime[10..18];
			self.DaysApart									:=	vDaysApart;
			self.WithinDateRange						:=	vDaysApart	<=	inMod.DateRange;
			self.InVerticalSet							:=	if(	~inMod.EDataVelocity,
																							fnIncludeVerticals(vVertical),
																							fnCheckVertical(vVertical)
																						);
			self.InFunctionSet							:=	vFunctionDesc	in	Inquiry_Services.Velocity_Constants.functions_to_include;
			self.InAnyIndustry							:=	fn_commonize_industry(vIndustry)	<>	'';
			self.InIndustryKba							:=	fn_commonize_industry(vIndustry)	=	Inquiry_Services.Velocity_Constants.Industry.Kba;
			// All the below boolean flags set aren't being used now - for future enhancements only
			self.InIndustryAuto							:=	fn_commonize_industry(vIndustry)	=	Inquiry_Services.Velocity_Constants.Industry.Auto;
			self.InIndustryCommunications		:=	fn_commonize_industry(vIndustry)	=	Inquiry_Services.Velocity_Constants.Industry.Communications;
			self.InIndustryCredit						:=	fn_commonize_industry(vIndustry)	=	Inquiry_Services.Velocity_Constants.Industry.Credit;
			self.InIndustryDirectToConsumer	:=	fn_commonize_industry(vIndustry)	=	Inquiry_Services.Velocity_Constants.Industry.Directtoconsumer;
			self.InIndustryFinance					:=	fn_commonize_industry(vIndustry)	=	Inquiry_Services.Velocity_Constants.Industry.Finance;
			self.InIndustryOther						:=	fn_commonize_industry(vIndustry)	=	Inquiry_Services.Velocity_Constants.Industry.Other;
			self.InIndustryRetail						:=	fn_commonize_industry(vIndustry)	=	Inquiry_Services.Velocity_Constants.Industry.Retail;
			self.InIndustryUtility					:=	fn_commonize_industry(vIndustry)	=	Inquiry_Services.Velocity_Constants.Industry.Utility;
			// New values for Velocity Identity ID
			self.Within24Hours							:=	vDaysApart	<	1;//VDaysApart is 0 based so 1-1=0
			self.Within7Days								:=	vDaysApart	<=	6;//VDaysApart is 0 based so 7-1=6
			self.Within30Days								:=	vDaysApart	<=	29;//VDaysApart is 0 based so 30-1=29
			self.Within90Days								:=	vDaysApart	<=	89;//VDaysApart is 0 based so 90-1=89
			self.Within12Months							:=	vDaysApart	<=	364;//VDaysApart is 0 based so 365-1=364
			self.isValidIndustry						:=	if(	inMod.Industry	in	['','ALL'],
																							fnCheckIndustry(vIndustry),
																							fnCheckIndustryFilter(vVertical,vIndustry)
																						);
			self														:=	le;
			self														:=	[];
		end;
		
		thor_recs	:=	project(dThorInquiry,x1(left));
		
		// Transform sybase records to the temporary layout
		layout_	x1b(dSybaseInquiry	le)	:=
		transform
			integer	vDaysApart										:=	ut.DaysApart(vFromDate,le.search_date);
			//If the days apart is 0 then transaction occured the day of the search
			//If the days apart is 1 then transaction occured on the previous day and we need to check the hours
			// 			to see if it really occurred within the last 24 hours (i.e. previous day, but having an 
			//			time greater than or equal to the current time) 
			boolean vTrueLast24Check							:=  map(vDaysApart=0 => true,
																										vDaysApart=1 and (le.search_time >= vFromTime) => true,
																										false); 
			string	vVertical											:=	ut.CleanSpacesAndUpper(le.vertical);
			string	vIndustry											:=	ut.CleanSpacesAndUpper(le.industry);
			string	vFunctionDesc									:=	ut.CleanSpacesAndUpper(le.description);
			
			self.search_info.transaction_id				:=	le.transaction_id;
			self.person_q.Appended_ADL						:=	inMod.uniqueid;
			self.bus_intel.vertical								:=	vVertical;
			self.bus_intel.industry								:=	vIndustry;
			self.search_info.function_description	:=	vFunctionDesc;
			self.InquiryDate											:=	if(	le.search_date	<=	vFromDate,
																										le.search_date,
																										skip
																									);
			self.InquiryTime											:=	le.search_time;
			self.DaysApart												:=	if(vTrueLast24Check,0,vDaysApart);//Override set to 0 so it falls within the last 24 hours
			self.WithinDateRange									:=	vDaysApart	<=	inMod.daterange;
			self.InVerticalSet										:=	if(	~inMod.EDataVelocity,
																										fnIncludeVerticals(vVertical),
																										fnCheckVertical(vVertical)
																									);
			self.InFunctionSet										:=	vFunctionDesc	in	Inquiry_Services.Velocity_Constants.functions_to_include;
			self.InAnyIndustry										:=	fn_commonize_industry(vIndustry)	<>	'';
			self.InIndustryKba										:=	fn_commonize_industry(vIndustry)	=	Inquiry_Services.Velocity_Constants.Industry.Kba;
			// All the below boolean flags set aren't being used now - for future enhancements only
			self.InIndustryAuto										:=	fn_commonize_industry(vIndustry)	=	Inquiry_Services.Velocity_Constants.Industry.Auto;
			self.InIndustryCommunications					:=	fn_commonize_industry(vIndustry)	=	Inquiry_Services.Velocity_Constants.Industry.Communications;
			self.InIndustryCredit									:=	fn_commonize_industry(vIndustry)	=	Inquiry_Services.Velocity_Constants.Industry.Credit;
			self.InIndustryDirectToConsumer				:=	fn_commonize_industry(vIndustry)	=	Inquiry_Services.Velocity_Constants.Industry.Directtoconsumer;
			self.InIndustryFinance								:=	fn_commonize_industry(vIndustry)	=	Inquiry_Services.Velocity_Constants.Industry.Finance;
			self.InIndustryOther									:=	fn_commonize_industry(vIndustry)	=	Inquiry_Services.Velocity_Constants.Industry.Other;
			self.InIndustryRetail									:=	fn_commonize_industry(vIndustry)	=	Inquiry_Services.Velocity_Constants.Industry.Retail;
			self.InIndustryUtility								:=	fn_commonize_industry(vIndustry)	=	Inquiry_Services.Velocity_Constants.Industry.Utility;
			// New values for Velocity Identity ID
			self.Within24Hours										:=	if(vTrueLast24Check,0,vDaysApart)	<	1;//VDaysApart is 0 based so 1-1=0
			self.Within7Days											:=	vDaysApart	<=	6;//VDaysApart is 0 based so 7-1=6
			self.Within30Days											:=	vDaysApart	<=	29;//VDaysApart is 0 based so 30-1=29
			self.Within90Days											:=	vDaysApart	<=	89;//VDaysApart is 0 based so 90-1=89
			self.Within12Months										:=	vDaysApart	<=	364;//VDaysApart is 0 based so 365-1=364
			self.isValidIndustry									:=	if(	inMod.Industry	in	['','ALL'],
																										fnCheckIndustry(vIndustry),
																										fnCheckIndustryFilter(vVertical,vIndustry)
																									);
			self																	:=	le;
			self																	:=	[];
		end;
		
		sybase_recs	:=	project(dSybaseInquiry,x1b(left));
		
		// Apply filter condition for Alert ID thor records
		dThorAlertIDFilter		:=	thor_recs(			InVerticalSet
																					and	InFunctionSet
																					and	((inMod.IndustryKBA	and	InIndustryKBA)	or	InAnyIndustry)
																					and	WithinDateRange
																				);
		
		// Filter condition for Identity Velocity ID thor records
		dThorFilter						:=	thor_recs(inVerticalSet	and	isValidIndustry);
		dThorVelocityIDFilter	:=	map(	inMod.Industry	in			['','ALL']	and	inMod.Product	in			['','ALL']	=>	dThorFilter,
																		inMod.Industry	not	in	['','ALL']	and	inMod.Product	in			['','ALL']	=>	dThorFilter(isValidIndustry	and	fnCategorizeIndustry(bus_intel.vertical,bus_intel.industry)	=	inMod.Industry),
																		inMod.Industry	in			['','ALL']	and	inMod.Product	not	in	['','ALL']	=>	dThorFilter(fnCategorizeProduct(search_info.function_description)	=	inMod.Product),
																		dThorFilter(isValidIndustry	and	fnCategorizeIndustry(bus_intel.vertical,bus_intel.industry)	=	inMod.Industry	and	fnCategorizeProduct(search_info.function_description)	=	inMod.Product)
																	);
		
		// Filter thor records depending on type of service
		thor_recs_after_filter	:=	if(	~inMod.EDataVelocity,
																		dThorAlertIDFilter,
																		dThorVelocityIDFilter
																	);
		
		// Apply filter condition for Alert ID sybase records - sybase procedure already has the vertical filter applied
		dSybaseAlertIDFilter		:=	sybase_recs(			InFunctionSet
																							and	((inMod.IndustryKBA	and	InIndustryKBA)	or	InAnyIndustry)
																							and	WithinDateRange
																						);
		
		// Filter condition for Identity Velocity ID sybase records
		dSybaseFilter						:=	sybase_recs(inVerticalSet	and	isValidIndustry);
		dSybaseVelocityIDFilter	:=	map(	inMod.Industry	in			['','ALL']	and	inMod.Product	in				['','ALL']	=>	dSybaseFilter,
																			inMod.Industry	not	in	['','ALL']	and	inMod.Product	in				['','ALL']	=>	dSybaseFilter(fnCategorizeIndustry(bus_intel.vertical,bus_intel.industry)	=	inMod.Industry),
																			inMod.Industry	in			['','ALL']	and	inMod.Product	not	in		['','ALL']	=>	dSybaseFilter(fnCategorizeProduct(search_info.function_description)	=	inMod.Product),
																			dSybaseFilter(fnCategorizeIndustry(bus_intel.vertical,bus_intel.industry)	=	inMod.Industry	and	fnCategorizeProduct(search_info.function_description)	=	inMod.Product)
																		);
		
		// Filter sybase records depending on type of service
		sybase_recs_after_filter	:=	if(	~inMod.EdataVelocity,
																			dSybaseAlertIDFilter,
																			dSybaseVelocityIDFilter
																		);
		
		// Remove dups between thor and sybase
		// Alert service
		dAlertUniqueSybaseRecs		:=	join(	sybase_recs_after_filter,
																				thor_recs_after_filter,
																				left.search_info.transaction_id = right.search_info.transaction_id,
																				// left.InquiryDate											=	right.InquiryDate	and
																				// left.search_info.function_description	=	right.search_info.function_description,
																				transform(layout_,self	:=	left),
																				left only
																			);
		
		// Velocity service
		dVelocityUniqueSybaseRecs	:=	join(	sybase_recs_after_filter,
																				thor_recs_after_filter,
																				left.search_info.transaction_id = right.search_info.transaction_id,
																				// left.InquiryDate				=	right.InquiryDate	and
																				// left.bus_intel.industry	=	right.bus_intel.industry,
																				transform(layout_,self	:=	left),
																				left only
																			);
		
		unique_to_sybase_recs	:=	if(	~inMod.EdataVelocity,
																	dAlertUniqueSybaseRecs,
																	dVelocityUniqueSybaseRecs
																);
	 
		inquiry_recs	:=	thor_recs_after_filter	+	unique_to_sybase_recs;
/*
		// Debugging outputs
		output(thor_recs,named('thor_recs'));
		output(sybase_recs,named('sybase_recs'));
		output(thor_recs_after_filter,named('thor_recs_after_filter'));
		output(sybase_recs_after_filter,named('sybase_recs_after_filter'));
		output(unique_to_sybase_recs,named('unique_to_sybase_recs'));
*/		
		return	inquiry_recs;
	end;
	
	// Macro to calculate the counts by industry or function
	export	Mac_Calculate_Counts(dIn,dOut,pField1,pField2,pField3	=	'?')	:=
	macro
		#UNIQUENAME(rAppendCounts_Layout)
		%rAppendCounts_Layout%	:=
		record
			dIn.pField1;
			dIn.pField2;
			#IF(#TEXT(pField3)	!=	'?')
				dIn.pField3;
			#END
			unsigned	cntGroup	:=	count(group);
		end;
		
		dOut	:=	table(	dIn
											,%rAppendCounts_Layout%
											,dIn.pField1
											,dIn.pField2
											#IF(#TEXT(pField3)	!=	'?')
												,dIn.pField3
											#END
											,few
										);
	endmacro;
	
	// Function for creating the necessary counts for search alert service
	export	fnFunctionNameCounts(dataset(layout_)	dInquiry)	:=
	function
		// Macro to calculate the total counts (per industry or function name)
		Mac_Calculate_Counts(dInquiry,dCntFunction,person_q.appended_adl,search_info.function_description);
		Mac_Calculate_Counts(dInquiry,dCntFunctionSearchDate,person_q.appended_adl,search_info.function_description,inquirydate);
		
		// Append counts back to the main records
		// Function count
		layout_	tFunctionCnt(dInquiry	le,dCntFunction	ri)	:=
		transform
			self.FunctionCnt	:=	ri.cntGroup;
			self							:=	le;
		end;
		
		dAppendFunctionCnt	:=	join(	dInquiry,
																	dCntFunction,
																	left.person_q.appended_adl						=	right.appended_adl	and
																	left.search_info.function_description	=	right.function_description,
																	tFunctionCnt(left,right),
																	limit(Inquiry_Services.Velocity_Constants.MAX_COUNT_RECORDS)
																);
		
		// Append function search date count
		layout_	tFunctionDateCnt(dAppendFunctionCnt	le,dCntFunctionSearchDate	ri)	:=
		transform
			self.FunctionDateCnt	:=	ri.cntGroup;
			self									:=	le;
		end; 
		
		dAppendFunctionSearchDateCnt	:=	join(	dAppendFunctionCnt,
																						dCntFunctionSearchDate,
																						left.person_q.appended_adl						=	right.appended_adl					and
																						left.search_info.function_description	=	right.function_description	and
																						left.InquiryDate											=	right.InquiryDate,
																						tFunctionDateCnt(left,right),
																						limit(Inquiry_Services.Velocity_Constants.MAX_COUNT_RECORDS)
																					);
		
		// Dedup the records based on function name and date
		dInquiryFunctionDedup	:=	dedup(	dAppendFunctionSearchDateCnt,
																			person_q.appended_adl,
																			search_info.function_description,
																			InquiryDate,
																			FunctionCnt,
																			FunctionDateCnt,
																			all
																		);
		
		// Group by function names
		dFunctionGroup	:=	group(	sort(dInquiryFunctionDedup,search_info.function_description),
																search_info.function_description
															);
		
		// Rollup by function name to get the counts
		iesp.SearchAlert.t_SearchDateCountRecord	SetCounts(layout_	le)	:=
		transform
			self.SearchDate		:=	iesp.ECL2ESP.toDateString8(le.InquiryDate);
			self.SearchCount	:=	le.FunctionDateCnt;
			self							:=	[];
		end;
		
		iesp.SearchAlert.t_SearchAlertRecord	GetAlertResults(layout_ le,dataset(layout_)	ri)	:=
		transform
			self.FunctionName			:=	le.search_info.function_description;
			self.TotalSearchCount	:=	le.FunctionCnt;
			self.SearchDateCounts	:=	project(choosen(ri,iesp.constants.VC.MAX_SRCHDATE_RECS),SetCounts(left));
			self									:=	[];
		end;
		
		dFunctionRollup	:=	rollup(dFunctionGroup,group,GetAlertResults(left,rows(left)));
/* 		
   		// Debugging outputs
   		output(dCntFunction,named('dCntFunction'));
   		output(dCntFunctionSearchDate,named('dCntFunctionSearchDate'));
   		output(dAppendFunctionCnt,named('dAppendFunctionCnt'));
   		output(dAppendFunctionSearchDateCnt,named('dAppendFunctionSearchDateCnt'));
   		output(dInquiryFunctionDedup,named('dInquiryFunctionDedup'));
   		output(dFunctionRollup,named('dFunctionRollup'));
*/
		
		return	dFunctionRollup;
	end;
	
	// Function for creating the necessary counts for velocity edata service
	export	fnIndustryCounts(dataset(layout_)	dInquiry)	:=
	function
		// Table to calculate the total counts per industry
		rAppendIndustryCounts_Layout	:=
		record
			dInquiry.person_q.appended_adl;
			// dInquiry.bus_intel.industry;
			unsigned	cntIndustry	:=	count(group);
			unsigned	cnt24Hours	:=	sum(group,if(dInquiry.Within24Hours,1,0));
			unsigned	cnt7Days		:=	sum(group,if(dInquiry.Within7Days,1,0));
			unsigned	cnt30Days		:=	sum(group,if(dInquiry.Within30Days,1,0));
			unsigned	cnt90Days		:=	sum(group,if(dInquiry.Within90Days,1,0));
			unsigned	cnt12Months	:=	sum(group,if(dInquiry.Within12Months,1,0));
		end;
		
		tblIndustryCnt	:=	if(	exists(dInquiry),
														table(dInquiry,rAppendIndustryCounts_Layout,dInquiry.person_q.appended_adl,few),
														dataset([{0,0,0,0,0,0,0}],rAppendIndustryCounts_Layout)
													);
		
		// Reformat to iesp layout
		iesp.SearchAlert.t_SearchDateCountRecord	SetCounts(tblIndustryCnt	le,integer	cnt)	:=
		transform
			self.SearchPeriod	:=	choose(	cnt,
																		Inquiry_Services.Velocity_Constants.DS_TIME_FRAME(Days	=	1)[1].desc,
																		Inquiry_Services.Velocity_Constants.DS_TIME_FRAME(Days	=	7)[1].desc,
																		Inquiry_Services.Velocity_Constants.DS_TIME_FRAME(Days	=	30)[1].desc,
																		Inquiry_Services.Velocity_Constants.DS_TIME_FRAME(Days	=	90)[1].desc,
																		Inquiry_Services.Velocity_Constants.DS_TIME_FRAME(Days	=	365)[1].desc,
																		Inquiry_Services.Velocity_Constants.DS_TIME_FRAME(Days	=	0)[1].desc
																	);
			self.SearchCount	:=	choose(cnt,le.cnt24Hours,le.cnt7Days,le.cnt30Days,le.cnt90Days,le.cnt12Months,le.cntIndustry);
			self							:=	[];
		end;
		
		iesp.SearchAlert.t_SearchAlertRecord	tVelocityResults(tblIndustryCnt le)	:=
		transform
			self.IndustryClass		:=	if(	inMod.Industry	=	'',
																		'ALL',
																		inMod.industry
																	);
			self.TotalSearchCount	:=	le.cntIndustry;
			self.SearchDateCounts	:=	normalize(dataset(le),6,SetCounts(left,counter));
			self									:=	[];
		end;
		
		dIndustryCounts	:=	project(tblIndustryCnt,tVelocityResults(left));

/*
 		// Debugging outputs
   	output(tblIndustryCnt,named('tblIndustryCnt'));
   	output(dIndustryCounts,named('dIndustryCounts'));
*/
		
		return	dIndustryCounts;
	end;
	
end;