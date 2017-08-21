export Dell_Convert_To_Csv(

	dataset(Layouts.Base)	pInput

) :=
function

	quotewrap	(string			field	) := '"' + trim(field,left,right) + '"';
	cint 			(unsigned8	pfield) := if(pfield = 0		,''		,(string)pfield	);
	cbool 		(boolean		pfield) := if(pfield = true	,'Y'	,'N'						);

	dell_append 	:= dedup(project(pInput
	,transform(layouts.OutAppend
	,
		self.APP_REF_KEY														:= quotewrap(left.rawfields.APP_REF_KEY							)														;
		self.SMB_EDM_APPL_ID												:= quotewrap(left.rawfields.SMB_EDM_APPL_ID					)														;
		self.COMPANY_NUM														:= quotewrap(left.rawfields.COMPANY_NUM							)														;
		self.CREATION_DATE													:= quotewrap(left.rawfields.CREATION_DATE						)														;
		self.LAST_UPDATE_DATE												:= quotewrap(left.rawfields.LAST_UPDATE_DATE				)														;
		self.APPL_LAST_ACTIVITY											:= quotewrap(left.rawfields.APPL_LAST_ACTIVITY			)														;
		self.SMB_BUSINESS_ID												:= quotewrap(left.rawfields.SMB_BUSINESS_ID					)														;
		self.DUNS_NUMBER														:= quotewrap(left.rawfields.DUNS_NUMBER							)														;
		self.LEGAL_NAME															:= quotewrap(left.rawfields.LEGAL_NAME							)														;
		self.BUSINESS_TYPE													:= quotewrap(left.rawfields.BUSINESS_TYPE						)														;
		self.AREA_CD																:= quotewrap(left.rawfields.AREA_CD									)														;
		self.PHONE_NUM															:= quotewrap(left.rawfields.PHONE_NUM								)														;
		self.PHONE_TYPE															:= quotewrap(left.rawfields.PHONE_TYPE							)														;
		self.ADDR_LINE1															:= quotewrap(left.rawfields.ADDR_LINE1							)														;
		self.ADDR_LINE2															:= quotewrap(left.rawfields.ADDR_LINE2							)														;
		self.CITY																		:= quotewrap(left.rawfields.CITY										)													;
		self.STATE																	:= quotewrap(left.rawfields.STATE										)														;
		self.POSTAL_CODE														:= quotewrap(left.rawfields.POSTAL_CODE							)														;
		self.POSTAL_PLUS4														:= quotewrap(left.rawfields.POSTAL_PLUS4						)														;
		self.ADDRESS_TYPE														:= quotewrap(left.rawfields.ADDRESS_TYPE						)														;
		self.CONTACT_FIRST_NAME											:= quotewrap(left.rawfields.CONTACT_FIRST_NAME			)														;
		self.CONTACT_LAST_NAME											:= quotewrap(left.rawfields.CONTACT_LAST_NAME				)														;
		self.CONTACT_MIDDLE_NAME										:= quotewrap(left.rawfields.CONTACT_MIDDLE_NAME			)														;
		self.CONTACT_TITLE													:= quotewrap(left.rawfields.CONTACT_TITLE						)														;
		self.CONTACT_EMAIL_ADDRESS									:= quotewrap(left.rawfields.CONTACT_EMAIL_ADDRESS		)														;
		self.CONTACT_SALUTATION											:= quotewrap(left.rawfields.CONTACT_SALUTATION			)														;
		
		self.filing_match														:= quotewrap(left.appended_fields.filing_match																							)		;
		self.filing_type_match                     	:= quotewrap(left.appended_fields.filing_type_match                     										)		;
		self.match_criteria                        	:= quotewrap(left.appended_fields.match_criteria                        										)		;
		self.latest_status                         	:= quotewrap(left.appended_fields.latest_status                         										)		;
		self.latest_filing_date 										:= quotewrap(cint(left.appended_fields.date_filing_last_seen));
		self.time_since_last_report_date						:= quotewrap(cint(left.appended_fields.time_since_last_report_date	)															)		;
		self.time_between_filings										:= quotewrap(cint(left.appended_fields.time_between_filings			)																)		;
		self.Date_Last_Event 												:= quotewrap(cint(left.appended_fields.Date_Last_Event 					)																)		;
		self.time_between_events										:= quotewrap(cint(left.appended_fields.time_between_events			)																	)		;
		self.current_derogatory_event								:= quotewrap(cbool(left.appended_fields.current_derogatory_event)																	)		;
		self.current_address_change									:= quotewrap(cbool(left.appended_fields.current_address_change		)																)		;
		self.current_contact_change    							:= quotewrap(cbool(left.appended_fields.current_contact_change    )																)		;
		self.Dissolution_exists                    	:= quotewrap(cbool(left.appended_fields.Dissolution_exists        )            										)		;
		self.reinstatement_exists                  	:= quotewrap(cbool(left.appended_fields.reinstatement_exists      )            										)		;
		self.Count_Delinquent_Statuses 							:= quotewrap(cint(left.appended_fields.Count_Delinquent_Statuses 						)										)		;
		self.Count_Derog_Events 										:= quotewrap(cint(left.appended_fields.Count_Derog_Events 									)											)		;
		self.count_address_changes									:= quotewrap(cint(left.appended_fields.count_address_changes								)											)		;
		self.count_contact_changes									:= quotewrap(cint(left.appended_fields.count_contact_changes								)											)		;
		self.Count_Business_At_Address							:= quotewrap(cint(left.appended_fields.Count_Business_At_Address						)											)		;
		self.Count_Delinquent_Business_At_Address		:= quotewrap(cint(left.appended_fields.Count_Delinquent_Business_At_Address	)										)		;
		self.Count_Derogatory_Business_At_Address		:= quotewrap(cint(left.appended_fields.Count_Derogatory_Business_At_Address	)										)		;
		self.count_business_contacts								:= quotewrap(cint(left.appended_fields.count_business_contacts							)											)		;
		self.count_delinquent_business_contacts			:= quotewrap(cint(left.appended_fields.count_delinquent_business_contacts		)										)		;
		self.count_derogatory_business_contacts			:= quotewrap(cint(left.appended_fields.count_derogatory_business_contacts		)										)		;
		self.Count_Bankruptcies_business 						:= quotewrap(cint(left.appended_fields.Count_Bankruptcies_business 					)										)		;
		self.Count_Liens_Judgements_business 				:= quotewrap(cint(left.appended_fields.Count_Liens_Judgements_business 			)										)		;
		self.Count_UCCs_business 										:= quotewrap(cint(left.appended_fields.Count_UCCs_business 									)										)		;
		self.Count_Bankruptcies_contacts 						:= quotewrap(cint(left.appended_fields.Count_Bankruptcies_contacts 					)										)		;
		self.Count_Liens_Judgements_contacts 				:= quotewrap(cint(left.appended_fields.Count_Liens_Judgements_contacts 			)										)		;
		self.Count_UCCs_contacts 										:= quotewrap(cint(left.appended_fields.Count_UCCs_contacts 									)										)		;
		self.business_residential										:= quotewrap(left.appended_fields.business_residential																			)		;
		self.vacant_property												:= quotewrap(left.appended_fields.vacant_property																						)		;
		self.recent_foreclosure              				:= quotewrap(left.appended_fields.recent_foreclosure              													)		;
		self.date_of_foreclosure              			:= quotewrap(cint(left.appended_fields.date_of_foreclosure              		)											)		;
		self.Seasonal_Delivery_Indicator     				:= quotewrap(left.appended_fields.Seasonal_Delivery_Indicator     													)		;
		self.college                         				:= quotewrap(left.appended_fields.college                         													)		;
		self.CMRA 		                        			:= quotewrap(left.appended_fields.CMRA 		                        													)		;
		self.Record_Type_Code												:= quotewrap(left.appended_fields.Record_Type_Code																					)		;
		self.usps_hotlist                    				:= quotewrap(left.appended_fields.usps_hotlist                    													)		;
		self.input_phone_matches_address     				:= quotewrap(left.appended_fields.input_phone_matches_address     													)		;
		self.phone_type_match                				:= quotewrap(left.appended_fields.phone_type_match                													)		;
		self.alternate_phone_at_address      				:= quotewrap(left.appended_fields.alternate_phone_at_address      													)		;
		self.alternate_phone_type            				:= quotewrap(left.appended_fields.alternate_phone_type            													)		;
		self.alternate_phone_listed_name     				:= quotewrap(left.appended_fields.alternate_phone_listed_name     													)		;





	)),APP_REF_KEY,SMB_EDM_APPL_ID,COMPANY_NUM,all);

	return dell_append;
	
end;