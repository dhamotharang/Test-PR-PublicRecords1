export Dell_Append_Miscellaneous(

	 dataset(Layouts.Base												)	pSummaryAppends
	,dataset(Layouts.Temporary.PrepAdvo					) pAdvo							= Prep_Advo									()
	,dataset(Layouts.Temporary.PrepForeclosure	) pForeclosure 			= Prep_Foreclosure					()
	,dataset(Layouts.Temporary.PrepPhonesPlus		) pEda							= Prep_Gong									()
	,dataset(Layouts.Temporary.PrepPhonesPlus		)	pPhonesPlus				= Prep_PhonesPlus						()
	,dataset(layouts.temporary.PrepUSPISHotList	) pUSPIS_HotList		= Prep_USPIS_HotList				()
	,string																				pPersistname			= Persistnames().DellAppendMiscellaneous
) := 
function

	////////////////////////////////////////////////////////////////////////////
	// Join to Advo to get stuff
	////////////////////////////////////////////////////////////////////////////
	dGet_Advo_matches1	:= join(
		 distribute(pSummaryAppends	,ace_aid)
		,distribute(pAdvo						,ace_aid)
		,left.ace_aid = right.ace_aid
		,transform(
			 Layouts.Base
			,self.appended_fields.business_residential					:= right.business_residential					;
			 self.appended_fields.vacant_property								:= right.vacant_property							;
			 self.appended_fields.Seasonal_Delivery_Indicator		:= right.Seasonal_Delivery_Indicator	;
			 self.appended_fields.college                    		:= right.college                    	;
			 self.appended_fields.cmra	                    		:= right.cmra		                    	;
			 self.appended_fields.Record_Type_Code           		:= right.Record_Type_Code	          	;
			 self																								:= left																;
		)
		,local
	);
	
	dGet_Advo_nomatches1	:= join(
		 distribute(pSummaryAppends	,ace_aid)
		,distribute(pAdvo						,ace_aid)
		,left.ace_aid = right.ace_aid
		,transform(
			 Layouts.Base
			,self.appended_fields.business_residential					:= right.business_residential					;
			 self.appended_fields.vacant_property								:= right.vacant_property							;
			 self.appended_fields.Seasonal_Delivery_Indicator		:= right.Seasonal_Delivery_Indicator	;
			 self.appended_fields.college                    		:= right.college                    	;
			 self.appended_fields.cmra	                    		:= right.cmra		                    	;
			 self.appended_fields.Record_Type_Code           		:= right.Record_Type_Code	          	;
			 self																								:= left																;
		)
		,left only
		,local
	);

	dGet_Advo_matches2	:= join(
		 distribute(dGet_Advo_nomatches1	,ace_aid_from_bdid)
		,distribute(pAdvo									,ace_aid)
		,left.ace_aid_from_bdid = right.ace_aid
		,transform(
			 Layouts.Base
			,self.appended_fields.business_residential					:= right.business_residential					;
			 self.appended_fields.vacant_property								:= right.vacant_property							;
			 self.appended_fields.Seasonal_Delivery_Indicator		:= right.Seasonal_Delivery_Indicator	;
			 self.appended_fields.college                    		:= right.college                    	;
			 self.appended_fields.cmra	                    		:= right.cmra		                    	;
			 self.appended_fields.Record_Type_Code           		:= right.Record_Type_Code	          	;
			 self																								:= left																;
		)
		,left outer
		,local
	);
	
	dGet_Advo := dGet_Advo_matches1 + dGet_Advo_matches2;

	////////////////////////////////////////////////////////////////////////////
	// Join to Foreclosure to get stuff
	////////////////////////////////////////////////////////////////////////////
	dGet_Foreclosure_matches1	:= join(
		 distribute(dGet_Advo			,ace_aid)
		,distribute(pForeclosure	,ace_aid)
		,left.ace_aid = right.ace_aid
		,transform(
			 Layouts.Base
			,self.appended_fields.recent_foreclosure					:= if(right.ace_aid != 0,'Y','N')	;
			 self.appended_fields.date_of_foreclosure					:= if(right.ace_aid != 0,right.date_of_foreclosure,0)	;
			 self																							:= left					;
		)
		,local
	);

	dGet_Foreclosure_nomatches1	:= join(
		 distribute(dGet_Advo			,ace_aid)
		,distribute(pForeclosure	,ace_aid)
		,left.ace_aid = right.ace_aid
		,transform(
			 Layouts.Base
			,self.appended_fields.recent_foreclosure					:= if(right.ace_aid != 0,'Y','N')	;
			 self.appended_fields.date_of_foreclosure					:= if(right.ace_aid != 0,right.date_of_foreclosure,0)	;
			 self																							:= left					;
		)
		,left only
		,local
	);

	dGet_Foreclosure_matches2	:= join(
		 distribute(dGet_Foreclosure_nomatches1	,ace_aid_from_bdid)
		,distribute(pForeclosure								,ace_aid)
		,left.ace_aid_from_bdid = right.ace_aid
		,transform(
			 Layouts.Base
			,self.appended_fields.recent_foreclosure					:= if(right.ace_aid != 0,'Y','N')	;
			 self.appended_fields.date_of_foreclosure					:= if(right.ace_aid != 0,right.date_of_foreclosure,0)	;
			 self																							:= left					;
		)
		,left outer
		,local
	);

	dGet_Foreclosure := dGet_Foreclosure_matches1 + dGet_Foreclosure_matches2;

	////////////////////////////////////////////////////////////////////////////
	// Join to USPIS to set flag
	////////////////////////////////////////////////////////////////////////////
	dGet_USPIS_matches1	:= join(
		 distribute(dGet_Foreclosure,ace_aid)
		,distribute(pUSPIS_HotList	,ace_aid)
		,left.ace_aid = right.ace_aid
		,transform(
			 Layouts.Base
			,self.appended_fields.usps_hotlist					:= if(right.ace_aid != 0,'Y','N')	;
			 self																				:= left					;
		)
		,local
	);

	dGet_USPIS_nomatches1	:= join(
		 distribute(dGet_Foreclosure,ace_aid)
		,distribute(pUSPIS_HotList	,ace_aid)
		,left.ace_aid = right.ace_aid
		,transform(
			 Layouts.Base
			,self.appended_fields.usps_hotlist					:= if(right.ace_aid != 0,'Y','N')	;
			 self																				:= left					;
		)
		,left only
		,local
	);

	dGet_USPIS_matches2	:= join(
		 distribute(dGet_USPIS_nomatches1	,ace_aid_from_bdid)
		,distribute(pUSPIS_HotList				,ace_aid)
		,left.ace_aid_from_bdid = right.ace_aid
		,transform(
			 Layouts.Base
			,self.appended_fields.usps_hotlist					:= if(right.ace_aid != 0,'Y','N')	;
			 self																				:= left					;
		)
		,left outer
		,local
	);

	dGet_USPIS := dGet_USPIS_matches1 + dGet_USPIS_matches2;
	////////////////////////////////////////////////////////////////////////////
	// Join to EDA to set flag
	////////////////////////////////////////////////////////////////////////////
	dGet_USPIS_with_phone 		:= dGet_USPIS((unsigned8)clean_phones.phone != 0);
	dGet_USPIS_without_phone	:= dGet_USPIS((unsigned8)clean_phones.phone  = 0);
	
	dGet_Eda_Pass1	:= join(
		 distribute(dGet_USPIS_with_phone	,ace_aid)
		,distribute(pEda									,ace_aid)
		,								left.ace_aid						= right.ace_aid
		and (unsigned8)	left.clean_phones.phone = right.phone
		,transform(
			 Layouts.Base
			,self.appended_fields.input_phone_matches_address	:= if(right.ace_aid != 0,'Y','N')	;
			 self.appended_fields.phone_type_match						:= right.phone_type;
			 self																							:= left					;
		)
		,left outer
		,keep(1)
		,local
	);

	////////////////////////////////////////////////////////////////////////////
	// Join Nomatches to Phones Plus to set flag
	////////////////////////////////////////////////////////////////////////////
	dGet_Eda_Pass1_match		:= dGet_Eda_Pass1(appended_fields.input_phone_matches_address = 'Y');
	dGet_Eda_Pass1_nomatch	:= dGet_Eda_Pass1(appended_fields.input_phone_matches_address = 'N');

	pGet_PP_Pass1	:= join(
		 distribute(dGet_Eda_Pass1_nomatch	,ace_aid)
		,distribute(pPhonesPlus							,ace_aid)
		,								left.ace_aid						= right.ace_aid
		and (unsigned8)	left.clean_phones.phone = right.phone
		,transform(
			 Layouts.Base
			,self.appended_fields.input_phone_matches_address	:= if(right.ace_aid != 0,'Y','N')	;
			 self.appended_fields.phone_type_match						:= right.phone_type;
			 self																							:= left					;
		)
		,left outer
		,keep(1)
		,local
	);
	
	pGet_PP_Pass1_match		:= pGet_PP_Pass1(appended_fields.input_phone_matches_address = 'Y' or ace_aid_from_bdid = 0);
	pGet_PP_Pass1_nomatch	:= pGet_PP_Pass1(not(appended_fields.input_phone_matches_address = 'Y' or ace_aid_from_bdid = 0));

	dGet_Eda_Pass_bdid	:= join(
		 distribute(pGet_PP_Pass1_nomatch	,ace_aid_from_bdid)
		,distribute(pEda									,ace_aid)
		,								left.ace_aid_from_bdid	= right.ace_aid
		and (unsigned8)	left.clean_phones.phone = right.phone
		,transform(
			 Layouts.Base
			,self.appended_fields.input_phone_matches_address	:= if(right.ace_aid != 0,'Y','N')	;
			 self.appended_fields.phone_type_match						:= right.phone_type;
			 self																							:= left					;
		)
		,left outer
		,keep(1)
		,local
	);

	dGet_Eda_Pass_bdid_match		:= dGet_Eda_Pass_bdid(appended_fields.input_phone_matches_address = 'Y' or ace_aid_from_bdid = 0);
	dGet_Eda_Pass_bdid_nomatch	:= dGet_Eda_Pass_bdid(not(appended_fields.input_phone_matches_address = 'Y' or ace_aid_from_bdid = 0));

	pGet_PP_Pass_bdid	:= join(
		 distribute(dGet_Eda_Pass_bdid_nomatch	,ace_aid_from_bdid)
		,distribute(pPhonesPlus									,ace_aid)
		,								left.ace_aid_from_bdid	= right.ace_aid
		and (unsigned8)	left.clean_phones.phone = right.phone
		,transform(
			 Layouts.Base
			,self.appended_fields.input_phone_matches_address	:= if(right.ace_aid != 0,'Y','N')	;
			 self.appended_fields.phone_type_match						:= right.phone_type;
			 self																							:= left					;
		)
		,left outer
		,keep(1)
		,local
	);
	
	////////////////////////////////////////////////////////////////////////////
	// Join to EDA to set alternate flags
	////////////////////////////////////////////////////////////////////////////
	dfirst_pass_concat := pGet_PP_Pass1_match + dGet_Eda_Pass1_match + dGet_Eda_Pass_bdid_match + pGet_PP_Pass_bdid;

	dGet_Eda_Pass2	:= join(
		 distribute(dfirst_pass_concat,ace_aid)
		,distribute(pEda							,ace_aid)
		,								left.ace_aid						= right.ace_aid
		and (unsigned8)	left.clean_phones.phone != right.phone
		,transform(
			 Layouts.Base
			,self.appended_fields.alternate_phone_at_address	:= if(right.ace_aid != 0,'Y','N')	;
			 self.appended_fields.alternate_phone_type				:= right.phone_type;
			 self.appended_fields.alternate_phone_listed_name	:= right.listed_name;
			 self																							:= left					;
		)
		,left outer
		,keep(1)
		,local
	);

	////////////////////////////////////////////////////////////////////////////
	// Join nomatches to Phones Plus to set alternate flags
	////////////////////////////////////////////////////////////////////////////
	dGet_Eda_Pass2_match		:= dGet_Eda_Pass2(appended_fields.alternate_phone_at_address = 'Y');
	dGet_Eda_Pass2_nomatch	:= dGet_Eda_Pass2(appended_fields.alternate_phone_at_address = 'N');

	dGet_PP_Pass2	:= join(
		 distribute(dGet_Eda_Pass2_nomatch	,ace_aid)
		,distribute(pPhonesPlus							,ace_aid)
		,								left.ace_aid						= right.ace_aid
		and (unsigned8)	left.clean_phones.phone != right.phone
		,transform(
			 Layouts.Base
			,self.appended_fields.alternate_phone_at_address	:= if(right.ace_aid != 0,'Y','N')	;
			 self.appended_fields.alternate_phone_type				:= right.phone_type;
			 self.appended_fields.alternate_phone_listed_name	:= right.listed_name;
			 self																							:= left					;
		)
		,left outer
		,keep(1)
		,local
	);

	dGet_PP_Pass2_match		:= dGet_PP_Pass2(appended_fields.alternate_phone_at_address = 'Y' or ace_aid_from_bdid = 0);
	dGet_PP_Pass2_nomatch	:= dGet_PP_Pass2(not(appended_fields.alternate_phone_at_address = 'Y' or ace_aid_from_bdid = 0));

	dGet_Eda_Pass2_bdid	:= join(
		 distribute(dGet_PP_Pass2_nomatch	,ace_aid_from_bdid)
		,distribute(pEda									,ace_aid)
		,								left.ace_aid_from_bdid						= right.ace_aid
		and (unsigned8)	left.clean_phones.phone != right.phone
		,transform(
			 Layouts.Base
			,self.appended_fields.alternate_phone_at_address	:= if(right.ace_aid != 0,'Y','N')	;
			 self.appended_fields.alternate_phone_type				:= right.phone_type;
			 self.appended_fields.alternate_phone_listed_name	:= right.listed_name;
			 self																							:= left					;
		)
		,left outer
		,keep(1)
		,local
	);

	dGet_Eda_Pass2_bdid_match		:= dGet_Eda_Pass2_bdid(appended_fields.alternate_phone_at_address = 'Y' or ace_aid_from_bdid = 0);
	dGet_Eda_Pass2_bdid_nomatch	:= dGet_Eda_Pass2_bdid(not(appended_fields.alternate_phone_at_address = 'Y' or ace_aid_from_bdid = 0));

	dGet_PP_Pass2_bdid	:= join(
		 distribute(dGet_Eda_Pass2_bdid_nomatch	,ace_aid_from_bdid)
		,distribute(pPhonesPlus									,ace_aid)
		,								left.ace_aid_from_bdid 	= right.ace_aid
		and (unsigned8)	left.clean_phones.phone != right.phone
		,transform(
			 Layouts.Base
			,self.appended_fields.alternate_phone_at_address	:= if(right.ace_aid != 0,'Y','N')	;
			 self.appended_fields.alternate_phone_type				:= right.phone_type;
			 self.appended_fields.alternate_phone_listed_name	:= right.listed_name;
			 self																							:= left					;
		)
		,left outer
		,keep(1)
		,local
	);

	dall_concat := dGet_PP_Pass2_match + dGet_Eda_Pass2_match + dGet_Eda_Pass2_bdid_match + dGet_PP_Pass2_bdid + dGet_USPIS_without_phone
	: persist(pPersistname);
	
	return dall_concat;
	
end;