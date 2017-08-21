import strata, VersionControl;

export Strata_Population_Stats(

	string pversion

) :=
module

	export fPopulationStats(
	
		 dataset(layouts.base) pInput
	
	) := 
	function

		Layout_pInput_stat :=
		record
			unsigned8 CountGroup                                := count(group);
			pInput.Clean_address.st;
			pInput.record_type;
			unsigned8 DotID_CountNonZero												:= sum(group, if(pInput.DotID		       													 <> 0  ,1,0));
			unsigned8	DotScore_CountNonZero											:= sum(group, if(pInput.DotScore	      												 <> 0  ,1,0));
			unsigned8	DotWeight_CountNonZero										:= sum(group, if(pInput.DotWeight	      												 <> 0  ,1,0));
			unsigned8 EmpID_CountNonZero												:= sum(group, if(pInput.EmpID											               <> 0  ,1,0));
			unsigned8	EmpScore_CountNonZero											:= sum(group, if(pInput.EmpScore											           <> 0  ,1,0));
			unsigned8	EmpWeight_CountNonZero										:= sum(group, if(pInput.EmpWeight											           <> 0  ,1,0));
			unsigned8 POWID_CountNonZero												:= sum(group, if(pInput.POWID											               <> 0  ,1,0));
			unsigned8	POWScore_CountNonZero											:= sum(group, if(pInput.POWScore											           <> 0  ,1,0));
			unsigned8	POWWeight_CountNonZero										:= sum(group, if(pInput.POWWeight											           <> 0  ,1,0));
			unsigned8 ProxID_CountNonZero												:= sum(group, if(pInput.ProxID											             <> 0  ,1,0));
			unsigned8	ProxScore_CountNonZero										:= sum(group, if(pInput.ProxScore											           <> 0  ,1,0));
			unsigned8	ProxWeight_CountNonZero										:= sum(group, if(pInput.ProxWeight											         <> 0  ,1,0));
			unsigned8 SELEID_CountNonZero												:= sum(group, if(pInput.SELEID											             <> 0  ,1,0));
			unsigned8	SELEScore_CountNonZero										:= sum(group, if(pInput.SELEScore											           <> 0  ,1,0));
			unsigned8	SELEWeight_CountNonZero										:= sum(group, if(pInput.SELEWeight											         <> 0  ,1,0));
			unsigned8 OrgID_CountNonZero												:= sum(group, if(pInput.OrgID											               <> 0  ,1,0));
			unsigned8	OrgScore_CountNonZero											:= sum(group, if(pInput.OrgScore											           <> 0  ,1,0));
			unsigned8	OrgWeight_CountNonZero										:= sum(group, if(pInput.OrgWeight											           <> 0  ,1,0));
			unsigned8 UltID_CountNonZero												:= sum(group, if(pInput.UltID											               <> 0  ,1,0));
			unsigned8	UltScore_CountNonZero											:= sum(group, if(pInput.UltScore											           <> 0  ,1,0));
			unsigned8	UltWeight_CountNonZero										:= sum(group, if(pInput.UltWeight											           <> 0  ,1,0));
			unsigned8 Did_CountNonZero                   				:= sum(group, if(pInput.Did											                 <> 0  ,1,0));
			unsigned8 did_score_CountNonZero                    := sum(group, if(pInput.did_score								                 <> 0  ,1,0));
			unsigned8 Bdid_CountNonZero                   			:= sum(group, if(pInput.Bdid										                 <> 0  ,1,0));
			unsigned8 bdid_score_CountNonZero                  	:= sum(group, if(pInput.bdid_score							                 <> 0  ,1,0));
			unsigned8 dt_first_seen_CountNonZero                := sum(group, if(pInput.dt_first_seen						                 <> 0  ,1,0));
			unsigned8 dt_last_seen_CountNonZero                 := sum(group, if(pInput.dt_last_seen						                 <> 0  ,1,0));
			unsigned8 dt_vendor_first_reported_CountNonZero     := sum(group, if(pInput.dt_vendor_first_reported                 <> 0  ,1,0));
			unsigned8 dt_vendor_last_reported_CountNonZero      := sum(group, if(pInput.dt_vendor_last_reported	                 <> 0  ,1,0));
                                                                          
			unsigned8 SSN_CountNonBlank                   			:= sum(group, if(pInput.rawfields.SSN																		 <> ''  ,1,0));
			unsigned8 Last_Name_CountNonBlank                   := sum(group, if(pInput.rawfields.Last_Name																   <> ''  ,1,0));
			unsigned8 First_Name_CountNonBlank                  := sum(group, if(pInput.rawfields.First_Name															   <> ''  ,1,0));
			unsigned8 Middle_Name_CountNonBlank                 := sum(group, if(pInput.rawfields.Middle_Name																 <> ''  ,1,0));
			unsigned8 generation_CountNonBlank               		:= sum(group, if(pInput.rawfields.generation															   <> ''  ,1,0));
			
			unsigned8 street_num_CountNonBlank                 	:= sum(group, if(pInput.rawfields.street_num									   <> ''  ,1,0));
			unsigned8 street_name_CountNonBlank                 := sum(group, if(pInput.rawfields.street_name									   <> ''  ,1,0));
			unsigned8 street_type_CountNonBlank                 := sum(group, if(pInput.rawfields.street_type									   <> ''  ,1,0));
			unsigned8 street_direction_CountNonBlank            := sum(group, if(pInput.rawfields.street_direction									   <> ''  ,1,0));
			unsigned8 apartment_CountNonBlank                 	:= sum(group, if(pInput.rawfields.apartment									   <> ''  ,1,0));
			unsigned8 City_CountNonBlank           							:= sum(group, if(pInput.rawfields.City										   <> ''  ,1,0));
			unsigned8 State_CountNonBlank    										:= sum(group, if(pInput.rawfields.State											 <> ''  ,1,0));
			unsigned8 zip_code_CountNonBlank        						:= sum(group, if(pInput.rawfields.zip_code										 <> ''  ,1,0));
			unsigned8 home_phone_CountNonBlank    							:= sum(group, if(pInput.rawfields.home_phone																			 <> ''  ,1,0));
			unsigned8 work_place_CountNonBlank                  := sum(group, if(pInput.rawfields.work_place														 <> ''  ,1,0));
			unsigned8 work_city_CountNonBlank           				:= sum(group, if(pInput.rawfields.work_city					   <> ''  ,1,0));
			unsigned8 work_state_CountNonBlank           				:= sum(group, if(pInput.rawfields.work_state								   <> ''  ,1,0));
			unsigned8 work_phone_CountNonBlank  								:= sum(group, if(pInput.rawfields.work_phone	 <> ''  ,1,0));
      unsigned8 time_stamp_CountNonBlank                  := sum(group, if(pInput.rawfields.time_stamp														 <> ''  ,1,0));
			
			unsigned8 clean_name_title_CountNonBlank      			:= sum(group, if(pInput.clean_name.title			         <> ''  ,1,0));
			unsigned8 clean_name_fname_CountNonBlank      			:= sum(group, if(pInput.clean_name.fname			         <> ''  ,1,0));
			unsigned8 clean_name_mname_CountNonBlank      			:= sum(group, if(pInput.clean_name.mname			         <> ''  ,1,0));
			unsigned8 clean_name_lname_CountNonBlank      			:= sum(group, if(pInput.clean_name.lname			         <> ''  ,1,0));
			unsigned8 clean_name_name_suffix_CountNonBlank			:= sum(group, if(pInput.clean_name.name_suffix        <> ''  ,1,0));
			unsigned8 clean_name_name_score_CountNonBlank 			:= sum(group, if(pInput.clean_name.name_score	       <> ''  ,1,0));
                                                                                   
			unsigned8 prim_range_CountNonBlank                  := sum(group, if(pInput.Clean_address.prim_range	        <> ''  ,1,0));
			unsigned8 predir_CountNonBlank                      := sum(group, if(pInput.Clean_address.predir			        <> ''  ,1,0));
			unsigned8 prim_name_CountNonBlank                   := sum(group, if(pInput.Clean_address.prim_name		        <> ''  ,1,0));
			unsigned8 addr_suffix_CountNonBlank                 := sum(group, if(pInput.Clean_address.addr_suffix	        <> ''  ,1,0));
			unsigned8 postdir_CountNonBlank                     := sum(group, if(pInput.Clean_address.postdir			        <> ''  ,1,0));
			unsigned8 unit_desig_CountNonBlank                  := sum(group, if(pInput.Clean_address.unit_desig	        <> ''  ,1,0));
			unsigned8 sec_range_CountNonBlank                   := sum(group, if(pInput.Clean_address.sec_range		        <> ''  ,1,0));
			unsigned8 p_city_name_CountNonBlank                 := sum(group, if(pInput.Clean_address.p_city_name	        <> ''  ,1,0));
			unsigned8 v_city_name_CountNonBlank                 := sum(group, if(pInput.Clean_address.v_city_name	        <> ''  ,1,0));
			unsigned8 zip_CountNonBlank                        	:= sum(group, if(pInput.Clean_address.zip					        <> ''  ,1,0));
			unsigned8 zip4_CountNonBlank                        := sum(group, if(pInput.Clean_address.zip4				        <> ''  ,1,0));
			unsigned8 cart_CountNonBlank                        := sum(group, if(pInput.Clean_address.cart				        <> ''  ,1,0));
			unsigned8 cr_sort_sz_CountNonBlank                  := sum(group, if(pInput.Clean_address.cr_sort_sz	        <> ''  ,1,0));
			unsigned8 lot_CountNonBlank                        	:= sum(group, if(pInput.Clean_address.lot					        <> ''  ,1,0));
			unsigned8 lot_order_CountNonBlank                   := sum(group, if(pInput.Clean_address.lot_order		        <> ''  ,1,0));
			unsigned8 dbpc_CountNonBlank                        := sum(group, if(pInput.Clean_address.dbpc				        <> ''  ,1,0));
			unsigned8 chk_digit_CountNonBlank                   := sum(group, if(pInput.Clean_address.chk_digit		        <> ''  ,1,0));
			unsigned8 rec_type_CountNonBlank                    := sum(group, if(pInput.Clean_address.rec_type		        <> ''  ,1,0));
			unsigned8 fips_state_CountNonBlank                  := sum(group, if(pInput.Clean_address.fips_state	        <> ''  ,1,0));
			unsigned8 fips_county_CountNonBlank                 := sum(group, if(pInput.Clean_address.fips_county	        <> ''  ,1,0));
			unsigned8 geo_lat_CountNonBlank                     := sum(group, if(pInput.Clean_address.geo_lat			        <> ''  ,1,0));
			unsigned8 geo_long_CountNonBlank                    := sum(group, if(pInput.Clean_address.geo_long		        <> ''  ,1,0));
			unsigned8 msa_CountNonBlank                        	:= sum(group, if(pInput.Clean_address.msa					        <> ''  ,1,0));
			unsigned8 geo_blk_CountNonBlank                     := sum(group, if(pInput.Clean_address.geo_blk			        <> ''  ,1,0));
			unsigned8 geo_match_CountNonBlank                   := sum(group, if(pInput.Clean_address.geo_match		        <> ''  ,1,0));
			unsigned8 err_stat_CountNonBlank                    := sum(group, if(pInput.Clean_address.err_stat		        <> ''  ,1,0));
               
			unsigned8 Clean_hphone_CountNonBlank          			:= sum(group, if(pInput.Clean_hPhone											<> ''  ,1,0));
			unsigned8 Clean_wphones_CountNonBlank								:= sum(group, if(pInput.Clean_wPhone											<> ''  ,1,0));
		end;                                                                           
		                                                                               
		pInput_stat := table(pInput, Layout_pInput_stat, Clean_address.st, record_type, few);                       
		strata.createXMLStats(pInput_stat, _Dataset().Name, 'baseV2', pversion, Email_Notification_Lists.Stats, resultsOut, 'View', 'Population');
		
		return resultsOut;

	end;
	
	
	export all := if(VersionControl.IsValidVersion(pversion),
	sequential(
			fPopulationStats(files().base.qa)
	));

end;