IMPORT ut;

EXPORT Rollup_Base(DATASET(Infutor_NARB.Layouts.Base) pDataset) := FUNCTION

	pDataset_Dist := DISTRIBUTE(pDataset, HASH(pid));
	pDataset_sort := SORT( pDataset_Dist 
												,pid								,record_id							,ein								,busname
												,tradename					,house									,predirection				,street
												,strtype						,postdirection					,apttype						,aptnbr
												,city							  ,state									,zip5								,ziplast4
												,dpc								,carrier_route					,address_type_code	,dpv_code
												,mailable						,county_code						,censustract				,censusblockgroup
												,censusblock				,congress_code					,msacode						,timezonecode
												,latitude						,longitude							,url								,telephone
												,toll_free_number		,fax										,sic1								,sic2
												,sic3								,sic4										,sic5								,stdclass
												,heading1						,heading2								,heading3						,heading4
												,heading5						,business_specialty			,sales_code					,employee_code
												,location_type			,parent_company					,parent_address			,parent_city
												,parent_state		  	,parent_zip							,parent_phone				,stock_symbol
												,stock_exchange			,public									,number_of_pcs			,square_footage
												,business_type			,incorporation_state 		,minority						,woman
												,government					,small									,home_office				,soho
												,franchise					,phoneable							,prefix							,first_name
												,middle_name				,surname								,suffix							,birth_year
												,ethnicity					,gender									,email							,contact_title
												,year_started				,date_added							/*,validationdate*/	,internal1
												,dacd								,normCompany_Type		
												,LOCAL );
	
	Infutor_NARB.Layouts.Base RollupUpdate(Infutor_NARB.Layouts.Base L, Infutor_NARB.Layouts.Base R) := TRANSFORM
	  L_validationdate              := (UNSIGNED4)StringLib.StringFilter(L.validationdate, '0123456789')[1..8];
		R_validationdate              := (UNSIGNED4)StringLib.StringFilter(R.validationdate, '0123456789')[1..8];
		
		Earliest_Date                 := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
		
		SELF.dt_first_seen 						:= ut.EarliestDate(ut.EarliestDate(L.dt_first_seen, R.dt_first_seen)
																						        ,ut.EarliestDate(L.dt_last_seen,  R.dt_last_seen));
		SELF.dt_last_seen 						:= max(L.dt_last_seen, R.dt_last_seen);
		SELF.dt_vendor_last_reported 	:= max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported := Earliest_Date;
		SELF.record_type							:= IF(L.record_type = 'C' OR R.record_type = 'C', 'C', 'H');
		SELF.rcid						          := IF(Earliest_Date = L.dt_vendor_first_reported, L.rcid, R.rcid);  //Use the earliest rcid
		SELF.validationdate						:= IF(max(L_validationdate, R_validationdate) = L_validationdate
		                                   ,L.validationdate
																			 ,R.validationdate);
		SELF                          := L;
	END;

	pDataset_rollup := ROLLUP(pDataset_sort
														,RollupUpdate(LEFT, RIGHT)
															,pid								,record_id							,ein								,busname
															,tradename					,house									,predirection				,street
															,strtype						,postdirection					,apttype						,aptnbr
															,city							  ,state									,zip5								,ziplast4
															,dpc								,carrier_route					,address_type_code	,dpv_code
															,mailable						,county_code						,censustract				,censusblockgroup
															,censusblock				,congress_code					,msacode						,timezonecode
															,latitude						,longitude							,url								,telephone
															,toll_free_number		,fax										,sic1								,sic2
															,sic3								,sic4										,sic5								,stdclass
															,heading1						,heading2								,heading3						,heading4
															,heading5						,business_specialty			,sales_code					,employee_code
															,location_type			,parent_company					,parent_address			,parent_city
															,parent_state		  	,parent_zip							,parent_phone				,stock_symbol
															,stock_exchange			,public									,number_of_pcs			,square_footage
															,business_type			,incorporation_state 		,minority						,woman
															,government					,small									,home_office				,soho
															,franchise					,phoneable							,prefix							,first_name
															,middle_name				,surname								,suffix							,birth_year
															,ethnicity					,gender									,email							,contact_title
															,year_started				,date_added							/*,validationdate*/	,internal1
															,dacd								,normCompany_Type		
														,LOCAL );

	RETURN pDataset_rollup;

END;