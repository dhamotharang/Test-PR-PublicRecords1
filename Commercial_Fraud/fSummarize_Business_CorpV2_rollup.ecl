import corp2,BankruptcyV2,LiensV2,UCCV2,Property,Advo,address,mdr,aid,ut;

export fSummarize_Business_CorpV2_rollup(

	 dataset(Corp2.Layout_Corporate_Direct_Corp_Base	) pCorp						= Prep_CorpV2.fCorp()
	,dataset(Corp2.Layout_Corporate_Direct_Cont_Base	) pCorpCont				= Prep_CorpV2.fCont()
	,string																							pPersistname		= Persistnames().fSummarizeBusinessCorpV2Rollup
	,string 																						pDateFilter			= _Dataset().CurrentDate

) :=
function

	dcorp_prep := project(pCorp,transform(layouts.temporary.BusinessSummary
	,
		Date_Filing_First_Seen	:= business_functions.mymin((unsigned8)left.corp_filing_date,if(left.dt_first_seen <= (unsigned8)pDateFilter,left.dt_first_seen	,0));
		Date_Filing_Last_Seen 	:= business_functions.mymax((unsigned8)left.corp_filing_date,if(left.dt_last_seen	 <= (unsigned8)pDateFilter,left.dt_last_seen	,0));
	
		self.bdid 														:= left.bdid;
		self.vendor_id     										:= left.corp_key;
		self.source 													:= mdr.sourceTools.fcorpv2(left.corp_key,left.corp_state_origin);
		self.latest_status     								:= business_functions.fisActiveBusiness(left.corp_status_cd,left.corp_status_desc);

		self.Date_Filing_First_Seen						:= business_functions.mymin(Date_Filing_First_Seen,Date_Filing_Last_Seen);
		self.Date_Filing_Last_Seen 						:= business_functions.mymax(Date_Filing_First_Seen,Date_Filing_Last_Seen);
		self.Date_Current_Status 							:= business_functions.mymin((unsigned8)left.corp_status_date,if(left.dt_first_seen <= (unsigned8)pDateFilter,left.dt_first_seen,0));
		self.Date_prior_status			 					:= self.Date_Current_Status;
		self.Date_Last_Event 									:= 0;
		self.Date_Last_Derog_Event						:= 0;
		self.Date_Most_Recent_Dissolution			:= if(business_functions.fisDissolved	(left.corp_status_cd,left.corp_status_desc),self.Date_Current_Status,0);
		self.Date_Most_Recent_Reinstatement		:= if(business_functions.fisReinstated	(left.corp_status_cd,left.corp_status_desc),self.Date_Current_Status,0);

		self.time_since_last_report_date							:= if(self.Date_Filing_Last_Seen != 0,ut.DaysApart(pDateFilter,(string)self.Date_Filing_Last_Seen) / 30,0);
	  self.time_between_filings											:= if(self.Date_Current_Status != 0 and self.date_prior_status != 0,ut.DaysApart((string)self.Date_Current_Status, (string)self.date_prior_status) / 30,0);
	  self.time_between_dissolution_reinstatement		:= if(self.Date_Most_Recent_Dissolution != 0 and self.Date_Most_Recent_Reinstatement != 0
																														,ut.DaysApart((string)self.Date_Most_Recent_Dissolution, (string)self.Date_Most_Recent_Reinstatement) / 30
																														,0
																												);
		self.time_between_events										 	:= 0;

		self.Count_Delinquent_Statuses 								:= if(business_functions.fisActiveBusiness(left.corp_status_cd,left.corp_status_desc) ='D',1,0);
		self.Count_Derog_Events 											:= 0;
		self.Count_Bankruptcies_Business 							:= 0;
		self.Count_Liens_Judgements_business 					:= 0;
		self.Count_UCCs_business 											:= 0;
		self.count_address_changes									 	:= 0;
		self.count_contact_changes									 	:= 0;
		self.Count_Business_At_Address							 	:= 0;
		self.Count_Delinquent_Business_At_Address	 		:= 0;
		self.Count_Derogatory_Business_At_Address	 		:= 0;
		self.count_business_contacts						 			:= 0;
		self.count_delinquent_business_contacts 			:= 0;
		self.count_derogatory_business_contacts 			:= 0;
		
	));
	
	dcorp_dedup := dedup(dcorp_prep,record,all);

	//rollup on vendor_id cuz each aggregrate join later is uniqued on that
	//to eliminate stuff being counted twice or more
	dcorp_rollup := rollup(sort(distribute(dcorp_dedup, hash64(vendor_id)), source,vendor_id,-Date_Current_Status,local)
		,		left.vendor_id	= right.vendor_id
		and left.source			= right.source
		,transform(
			 layouts.temporary.BusinessSummary
			 ,
				// address changes if 

			 self.bdid 										:= business_functions.mymin(left.bdid,right.bdid);
			 self.vendor_id     					:= left.vendor_id;
			 self.source 									:= left.source;
			 self.latest_status     			:= if(business_functions.mymax(left.Date_Current_Status, right.Date_Current_Status) = left.Date_Current_Status
																					,left.latest_status
																					,right.latest_status
																			);
			 self.Date_Filing_First_Seen	:= business_functions.mymin(left.Date_Filing_First_Seen	,right.Date_Filing_First_Seen	);
			 self.Date_Filing_Last_Seen 	:= business_functions.mymax(left.Date_Filing_last_Seen	,right.Date_Filing_last_Seen	);
			 self.Date_Current_Status 		:= business_functions.mymax(left.Date_Current_Status, right.Date_Current_Status);
			 //so check statuses to make sure it is a different status, only populate if true
			 //also check that it is less than current status date, but 
			 
			 self.date_prior_status			 	:= if(left.latest_status != right.latest_status
																					,if(left.date_prior_status > right.date_prior_status
																					and left.date_prior_status < self.Date_Current_Status
																						,left.date_prior_status
																						,right.date_prior_status
																					)
																					,left.date_prior_status
																			);
//			 self.Date_Last_Event 								:= business_functions.mymax(left.Date_Last_Event								,right.Date_Last_Event								);
//			 self.Date_Last_Derog_Event						:= business_functions.mymax(left.Date_Last_Derog_Event					,right.Date_Last_Derog_Event					);
			 self.Date_Most_Recent_Dissolution		:= business_functions.mymax(left.Date_Most_Recent_Dissolution	,right.Date_Most_Recent_Dissolution		);
			 self.Date_Most_Recent_Reinstatement	:= business_functions.mymax(left.Date_Most_Recent_Reinstatement,right.Date_Most_Recent_Reinstatement	);
			 
			 self.count_address_changes										:= left.count_address_changes									+ right.count_address_changes									;
			 self.Count_Business_At_Address								:= left.Count_Business_At_Address							+ right.Count_Business_At_Address							;
			 self.Count_Delinquent_Business_At_Address		:= left.Count_Delinquent_Business_At_Address	+ right.Count_Delinquent_Business_At_Address	;
			 self.Count_Derogatory_Business_At_Address		:= left.Count_Derogatory_Business_At_Address	+ right.Count_Derogatory_Business_At_Address	;			 
			 self.Count_Delinquent_Statuses 							:= left.Count_Delinquent_Statuses 						+ right.Count_Delinquent_Statuses							;
			 self.Count_Derog_Events 											:= left.Count_Derog_Events 		 								+ right.Count_Derog_Events 										;
			 self.Count_Bankruptcies_Business 						:= left.Count_Bankruptcies_Business 		 			+ right.Count_Bankruptcies_Business 					;
			 self.Count_Liens_Judgements_business 				:= left.Count_Liens_Judgements_business 			+ right.Count_Liens_Judgements_business				;
			 self.Count_UCCs_business 										:= left.Count_UCCs_business 						 			+ right.Count_UCCs_business 									;
			 
			 self.time_since_last_report_date							:= if(self.Date_Filing_Last_Seen != 0,ut.DaysApart(pDateFilter,(string)self.Date_Filing_Last_Seen) / 30,0);
			 self.time_between_filings										:= if(self.Date_Current_Status != 0 and self.date_prior_status != 0,ut.DaysApart((string)self.Date_Current_Status, (string)self.date_prior_status) / 30,0);
			 self.time_between_events											:= if(left.time_between_events != 0, left.time_between_events,right.time_between_events);
			 self.time_between_dissolution_reinstatement	:= if(self.Date_Most_Recent_Dissolution != 0 and self.Date_Most_Recent_Reinstatement != 0
																														,ut.DaysApart((string)self.Date_Most_Recent_Dissolution, (string)self.Date_Most_Recent_Reinstatement) / 30
																														,0
																												);
			 self																					:= left;
		)
		,local
	);

	dcorp_return := dcorp_rollup
			: persist(pPersistname);
	
	return dcorp_return;

end;
