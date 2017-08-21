export fSummarize_Address(

	 dataset(layouts.temporary.addresssummary		)	pAddrSummary			= fSummarize_Address_CorpV2	()
	,dataset(Layouts.Temporary.PrepAdvo					) pAdvo							= Prep_Advo									()
	,dataset(Layouts.Temporary.PrepForeclosure	) pForeclosure 			= Prep_Foreclosure					()
	,dataset(Layouts.Temporary.PrepPhonesPlus		) pEda							= Prep_Gong									()
	,dataset(Layouts.Temporary.PrepPhonesPlus		)	pPhonesPlus				= Prep_PhonesPlus						()
	,dataset(layouts.temporary.PrepUSPISHotList	) pUSPIS_HotList		= Prep_USPIS_HotList				()

) := 
function

	// Join to Advo to get stuff
	dGet_Advo	:= join(
		 distribute(pAddrSummary		,address_id)
		,distribute(pAdvo						,ace_aid)
		,left.address_id = right.ace_aid
		,transform(
			 layouts.temporary.addresssummary
			,self.business_residential					:= right.business_residential					;
			 self.vacant_property								:= right.vacant_property							;
			 self.Seasonal_Delivery_Indicator		:= right.Seasonal_Delivery_Indicator	;
			 self.college                    		:= right.college                    	;
			 self.cmra	                    		:= right.cmra		                    	;
			 self																:= left																;
		)
		,left outer
		,local
		,keep(1)
	);
	
	// Join to Foreclosure to get stuff
	dGet_Foreclosure	:= join(
		 distribute(dGet_Advo			,address_id)
		,distribute(pForeclosure	,ace_aid)
		,left.address_id = right.ace_aid
		,transform(
			 layouts.temporary.addresssummary
			,self.recent_foreclosure					:= if(right.ace_aid != 0,'Y','N')	;
			 self.date_of_foreclosure					:= if(right.ace_aid != 0,right.date_of_foreclosure,0)	;
			 self															:= left					;
		)
		,left outer
		,local
		,keep(1)
	);

	// Join to USPIS to set flag
	dGet_USPIS	:= join(
		 distribute(dGet_Foreclosure,address_id)
		,distribute(pUSPIS_HotList	,ace_aid)
		,left.address_id = right.ace_aid
		,transform(
			 layouts.temporary.addresssummary
			,self.usps_hotlist					:= if(right.ace_aid != 0,'Y','N')	;
			 self												:= left					;
		)
		,left outer
		,local
		,keep(1)
	);

	////////////////////////////////////////////////////////////////////////////
	// Join to EDA to set flag
	////////////////////////////////////////////////////////////////////////////
	dGet_USPIS_with_phone 		:= dGet_USPIS(phone != 0);
	dGet_USPIS_without_phone	:= dGet_USPIS(phone  = 0);
	
	dGet_Eda_Pass1	:= join(
		 distribute(dGet_USPIS_with_phone	,address_id)
		,distribute(pEda									,ace_aid)
		,		left.address_id						= right.ace_aid
		and left.phone								= right.phone
		,transform(
			 layouts.temporary.addresssummary
			,self.input_phone_matches_address	:= if(right.ace_aid != 0,'Y','N')	;
			 self.phone_type_match						:= right.phone_type;
			 self																							:= left					;
		)
		,left outer
		,local
		,keep(1)
	);

	////////////////////////////////////////////////////////////////////////////
	// Join Nomatches to Phones Plus to set flag
	////////////////////////////////////////////////////////////////////////////
	dGet_Eda_Pass1_match		:= dGet_Eda_Pass1(input_phone_matches_address = 'Y');
	dGet_Eda_Pass1_nomatch	:= dGet_Eda_Pass1(input_phone_matches_address = 'N');

	pGet_PP_Pass1	:= join(
		 distribute(dGet_Eda_Pass1_nomatch	,address_id)
		,distribute(pPhonesPlus							,ace_aid)
		,		left.address_id		= right.ace_aid
		and left.phone				= right.phone
		,transform(
			 layouts.temporary.addresssummary
			,self.input_phone_matches_address	:= if(right.ace_aid != 0,'Y','N')	;
			 self.phone_type_match						:= right.phone_type;
			 self															:= left					;
		)
		,left outer
		,local
		,keep(1)
	);
	
	////////////////////////////////////////////////////////////////////////////
	// Join to EDA to set alternate flags
	////////////////////////////////////////////////////////////////////////////
	dfirst_pass_concat := pGet_PP_Pass1 + dGet_Eda_Pass1_match;

	dGet_Eda_Pass2	:= join(
		 distribute(dfirst_pass_concat,address_id)
		,distribute(pEda							,ace_aid)
		,		left.address_id		= right.ace_aid
		and left.phone 				!= right.phone
		,transform(
			 layouts.temporary.addresssummary
			,self.alternate_phone_at_address	:= if(right.ace_aid != 0,'Y','N')	;
			 self.alternate_phone_type				:= right.phone_type;
			 self.alternate_phone_listed_name	:= right.listed_name;
			 self															:= left					;
		)
		,left outer
		,local
		,keep(1)
	);

	////////////////////////////////////////////////////////////////////////////
	// Join nomatches to Phones Plus to set alternate flags
	////////////////////////////////////////////////////////////////////////////
	dGet_Eda_Pass2_match		:= dGet_Eda_Pass2(alternate_phone_at_address = 'Y');
	dGet_Eda_Pass2_nomatch	:= dGet_Eda_Pass2(alternate_phone_at_address = 'N');

	dGet_PP_Pass2	:= join(
		 distribute(dGet_Eda_Pass2_nomatch	,address_id)
		,distribute(pPhonesPlus							,ace_aid)
		,		left.address_id	= right.ace_aid
		and left.phone 			!= right.phone
		,transform(
			 layouts.temporary.addresssummary
			,self.alternate_phone_at_address	:= if(right.ace_aid != 0,'Y','N')	;
			 self.alternate_phone_type				:= right.phone_type;
			 self.alternate_phone_listed_name	:= right.listed_name;
			 self															:= left					;
		)
		,left outer
		,local
		,keep(1)
	);
	
	dcorp_concat := dGet_PP_Pass2 + dGet_Eda_Pass2_match + dGet_USPIS_without_phone;
	
	dcorp_sort := sort(dcorp_concat(bdid != 0),-bDid)
							+ dcorp_concat(bdid = 0)
							;

	dcorpreturn_debug := dcorp_sort;
	
	dcorpreturn_prod := project(dcorpreturn_debug,transform(layouts.address_summary, self := left));

	#if(_Dataset().IsDebugging = true)
		dcorp_return := dcorpreturn_debug
		: persist(persistnames().fSummarizeAddress);
	#else
		dcorp_return := dcorpreturn_prod
		: persist(persistnames().fSummarizeAddress);
	#end

	
	return dcorp_return;
	
end;