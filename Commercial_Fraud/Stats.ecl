import versioncontrol, paw, corp2, Business_Header_BDL2;

export Stats(

	 string												pversion
	,dataset(Layouts.OutAppend	) pOutAppend	= files().Dell_out_Append.built

) :=
function
/*
Description of Stat
% applications with filing match
% applications where most recent filing >24 months of process date
% applications where time between filings >24 months
% applications with current derogatory status
% applications with current derogatory event
% applications with current address change
% applications with current contact change
% applications with dissolution and reinstatement
% applications with current derogatory status and event (a)
% applications with recent address and contact change (b)
% applications both (a) and (b) above
% delinquent business at address >1 (c)
% business with derogatory events >1 (d)
% business with both (c) and (d) > 1
% contacts associated with other delinquent business >1 (e)
% contacts associated with other derogatory event business >1 (f)
% both (e) and (f) above
% with a bankruptcy associated (business or contact)
% with a l&j associated (business or contact)
% bk, lj & ucc associated
% vacant
% recent foreclosure
% seasonal
% college
% hotlist
% input phone / address match eda
% alternate phone / address match 
% match in all sections
*/
	dstat_prep := project(pOutAppend	,transform({Layouts.OutAppend,string stuff},self.stuff := 'A';self := left));
	
		Layout_dstat_prep_stat :=
		record
			unsigned8 CountGroup                                 				:= count(group);
			dstat_prep.stuff;
			unsigned8 filing_match_countY																:= sum(group, if(dstat_prep.filing_match														  = 'Y' 	,1,0));
			unsigned8 filing_type_matchSOS                  						:= sum(group, if(dstat_prep.filing_type_match                     	  = 'SOS'	,1,0));
			unsigned8 filing_type_matchOther                  					:= sum(group, if(dstat_prep.filing_type_match                     	  = 'Other'	,1,0));
			unsigned8 filing_type_matchNone                  						:= sum(group, if(dstat_prep.filing_type_match                     	  = 'None'	,1,0));
			unsigned8 match_criteria                        						:= sum(group, if(dstat_prep.match_criteria                        	 != ''  	,1,0));
			unsigned8 match_criteria_LinkID               							:= sum(group, if(dstat_prep.match_criteria                        	 = 'LinkID'  	,1,0));
			unsigned8 match_criteria_NCS           											:= sum(group, if(dstat_prep.match_criteria                        	 = 'NCS'  	,1,0));
			unsigned8 latest_status_good		                   					:= sum(group, if(dstat_prep.latest_status                         	 = 'G'  	,1,0));
			unsigned8 latest_status_Delinquent                 					:= sum(group, if(dstat_prep.latest_status                         	 = 'D'  	,1,0));
			unsigned8 latest_filing_date_nonzero 												:= sum(group, if(dstat_prep.latest_filing_date 									 		!= ''  		,1,0));
			unsigned8 time_since_last_report_date_nonzero								:= sum(group, if(dstat_prep.time_since_last_report_date							 != ''  		,1,0));
			unsigned8 time_between_filings_nonzero											:= sum(group, if(dstat_prep.time_between_filings										 != ''  		,1,0));
			unsigned8 Date_Last_Event_nonzero 													:= sum(group, if(dstat_prep.Date_Last_Event 												 != ''  		,1,0));
      unsigned8 time_between_events_nonzero										    := sum(group, if(dstat_prep.time_between_events											 != ''  		,1,0));         
			unsigned8 current_derogatory_event_true											:= sum(group, if(dstat_prep.current_derogatory_event								 = 'Y' 	,1,0));
			unsigned8 current_address_change_true												:= sum(group, if(dstat_prep.current_address_change								   = 'Y' 	,1,0));
			unsigned8 current_contact_change_true    										:= sum(group, if(dstat_prep.current_contact_change    						   = 'Y' 	,1,0));
			unsigned8 Dissolution_exists_true                    				:= sum(group, if(dstat_prep.Dissolution_exists                    	 = 'Y' 	,1,0));
			unsigned8 reinstatement_exists_true                  				:= sum(group, if(dstat_prep.reinstatement_exists                     = 'Y' 	,1,0));
//			unsigned8 time_between_dissolution_reinstatement_nonzero		:= sum(group, if(dstat_prep.time_between_dissolution_reinstatement	 != ''  		,1,0));
			unsigned8 Count_Delinquent_Statuses_nonzero 								:= sum(group, if(dstat_prep.Count_Delinquent_Statuses 							 != ''  		,1,0));
			unsigned8 Count_Derog_Events_nonzero 										    := sum(group, if(dstat_prep.Count_Derog_Events 										   != ''  		,1,0));
			unsigned8 count_address_changes_nonzero									  	:= sum(group, if(dstat_prep.count_address_changes									   != ''  		,1,0));
			unsigned8 count_contact_changes_nonzero											:= sum(group, if(dstat_prep.count_contact_changes										 != ''  		,1,0));
			unsigned8 Count_Business_At_Address_nonzero									:= sum(group, if(dstat_prep.Count_Business_At_Address								 != ''  		,1,0));
			unsigned8 Count_Delinquent_Business_At_Address_nonzero			:= sum(group, if(dstat_prep.Count_Delinquent_Business_At_Address		 != ''  		,1,0));
			unsigned8 Count_Derogatory_Business_At_Address_nonzero	    := sum(group, if(dstat_prep.Count_Derogatory_Business_At_Address		 != ''  		,1,0));
			unsigned8 count_business_contacts_nonzero								    := sum(group, if(dstat_prep.count_business_contacts								   != ''  		,1,0));
			unsigned8 count_delinquent_business_contacts_nonzero		    := sum(group, if(dstat_prep.count_delinquent_business_contacts		   != ''  		,1,0));
			unsigned8 count_derogatory_business_contacts_nonzero		    := sum(group, if(dstat_prep.count_derogatory_business_contacts			 != ''  		,1,0));
			unsigned8 Count_Bankruptcies_business_nonzero 							:= sum(group, if(dstat_prep.Count_Bankruptcies_business 					   != ''  		,1,0));
			unsigned8 Count_Liens_Judgements_business_nonzero 					:= sum(group, if(dstat_prep.Count_Liens_Judgements_business 				 != ''  		,1,0));
			unsigned8 Count_UCCs_business_nonzero 									 		:= sum(group, if(dstat_prep.Count_UCCs_business 										 != ''  		,1,0));
			unsigned8 Count_Bankruptcies_contacts_nonzero 					    := sum(group, if(dstat_prep.Count_Bankruptcies_contacts 					   != ''  		,1,0));
			unsigned8 Count_Liens_Judgements_contacts_nonzero 			 		:= sum(group, if(dstat_prep.Count_Liens_Judgements_contacts 			   != ''  		,1,0));
			unsigned8 Count_UCCs_contacts_nonzero 											:= sum(group, if(dstat_prep.Count_UCCs_contacts 										 != ''  		,1,0));
			unsigned8	residential_Y																			:= sum(group, if(dstat_prep.business_residential										 = 'R'  	,1,0));
			unsigned8 business_Y																				:= sum(group, if(dstat_prep.business_residential										 = 'B'  	,1,0));
			unsigned8 vacant_property_Y																	:= sum(group, if(dstat_prep.vacant_property													 = 'Y'  	,1,0));
			unsigned8 recent_foreclosure_Y	              			  			:= sum(group, if(dstat_prep.recent_foreclosure              				 = 'Y'  	,1,0));
			unsigned8 Seasonal_Delivery_Indicator_Y	     			        	:= sum(group, if(dstat_prep.Seasonal_Delivery_Indicator     			   = 'Y'  	,1,0));
			unsigned8 college_Y	                         			     			:= sum(group, if(dstat_prep.college                         			   = 'Y'  	,1,0));
			unsigned8 CMRA_Y	                         			     				:= sum(group, if(dstat_prep.CMRA                         			   		 = 'Y'  	,1,0));
			unsigned8 Record_Type_Code_NonBlank                    			:= sum(group, if(dstat_prep.Record_Type_Code             			   		 != ''  	,1,0));
			unsigned8 Record_Type_Code_H	                         			:= sum(group, if(dstat_prep.Record_Type_Code             			   		 = 'H'  	,1,0));
			unsigned8 usps_hotlist_Y	                    			  			:= sum(group, if(dstat_prep.usps_hotlist                    				 = 'Y'  	,1,0));
      unsigned8 input_phone_matches_address_Y	     			     			:= sum(group, if(dstat_prep.input_phone_matches_address     				 = 'Y'  	,1,0));                   
			unsigned8 phone_type_match_nonblank                					:= sum(group, if(dstat_prep.phone_type_match                				 <> ''  	,1,0));
			unsigned8 alternate_phone_at_address_Y	      							:= sum(group, if(dstat_prep.alternate_phone_at_address      				 = 'Y'  	,1,0));
			unsigned8 alternate_phone_type_nonblank            					:= sum(group, if(dstat_prep.alternate_phone_type            				 <> ''  	,1,0));
			unsigned8 alternate_phone_listed_name_nonblank     					:= sum(group, if(dstat_prep.alternate_phone_listed_name     				 <> ''  	,1,0));
	end;                                                                                                                                                        	
		                                                                                                                                                          	
	dstat_prep_stat := table(dstat_prep, Layout_dstat_prep_stat, stuff, few);                                                                                   	
	dstat_ref := project(dstat_prep_stat	,transform(recordof(dstat_prep_stat) - stuff, self := left));                                                         	
	                                                                                                                                                            	
	return output(dstat_ref	,named('Commercial_Fraud_Stats'));


end;