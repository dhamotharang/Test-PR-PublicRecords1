import irs_dummy, corp2;
export Filters :=
module

	// these high bdid and did number filters are for the dummy records
	export As_Business :=
	module
		export Corp_Base	:=	File_Corp_Base.bdid 		< IRS_Dummy.Bdid_cutoff;
		export Corp_Cont	:=	File_Corp_Cont_Base.did		< IRS_Dummy.did_cutoff and 
								File_Corp_Cont_Base.bdid	< IRS_Dummy.Bdid_cutoff;	
	end;
	
	export Base :=
	module
		export Corp_Base	:= As_Business.Corp_Base;
		export Corp_Cont	:= As_Business.Corp_Cont;	
		export Corp_Event	:= true;
		export Corp_Supp	:= true;
	end;

	export V2 :=
	module
		
		shared Layout_CorpV1_IN		:= corp.Layout_Corporate_Direct_Corp_in;
		shared Layout_ContV1_IN		:= corp.Layout_Corporate_Direct_Cont_in;
		shared Layout_EventsV1_IN	:= corp.Layout_Corporate_Direct_Event_in;

		shared Layout_CorpV2_IN		:= Corp2.Layout_Corporate_Direct_Corp_In;
		shared Layout_ContV2_IN		:= Corp2.Layout_Corporate_Direct_Cont_In;
		shared Layout_EventsV2_IN	:= Corp2.Layout_Corporate_Direct_Event_In;
		
		shared set_phase_I_V2_states	:= ['CA','FL','HI','NC'];
		shared set_phase_II_V2_states	:= ['TX','NV','NY'];
		
		shared set_all_V2_states 			:= set_phase_I_V2_states + set_phase_II_V2_states;
		
		export Events(dataset(Layout_EventsV2_IN) pInput) :=
		function
			//should be good for events
			Layout_EventsV1_IN tEventsV2toEventsV1(Layout_EventsV2_IN pInput) :=
			transform
				self	:= pInput;
			end;

			lselectfilter := pInput.corp_state_origin in set_all_V2_states;
			lfullfilter		:= true;	// probably don't need state filter since if the 
															//state is in corpv2 input, it has been rewritten

			lfile					:= project(pInput(lfullfilter), tEventsV2toEventsV1(left));
			
			return				lfile;
		
		end;
		
		export Cont(dataset(Layout_ContV2_IN) pInput) :=
		function

			Layout_ContV1_IN tContV2toContV1(Layout_ContV2_IN pInput) :=
			transform
				self	:= pInput;
			end;

			lselectfilter := pInput.corp_state_origin in set_all_V2_states;
//			lfullfilter		:= lselectfilter;
			lfullfilter		:= true;

			lfile					:= project(pInput(lfullfilter), tContV2toContV1(left));
			
			return				lfile;
		
		end;

		export Corp(dataset(Layout_CorpV2_IN) pInput) :=
		function
			
			Layout_CorpV1_IN tCorpV2toCorpV1(Layout_CorpV2_IN pInput) :=
			transform
				self	:= pInput;
			end;

			lselectfilter := pInput.corp_state_origin in set_all_V2_states;
			lfullfilter		:= true;
			lfile					:= project(pInput(lfullfilter), tCorpV2toCorpV1(left));
			
			return				lfile;
		
		end;
	
	end;
	
	
end;