import strata, versioncontrol;
export Strata_Population_Stats(string pversion) :=
module
	
	export fCompaniesPopulationStats(
	
		 dataset(layouts.base.Companies) pInput
	
	) := 
	function

		Layout_pInput_stat :=
		record
			unsigned8 CountGroup                                 	:= count(group);
			pInput.Clean_address.st;
			pInput.record_type;
      unsigned6 DotID_CountNonZero													:= sum(group, if(pInput.DotID																		 <> 0  ,1,0));
			unsigned2	DotScore_CountNonZero												:= sum(group, if(pInput.DotScore																 <> 0  ,1,0));
			unsigned2	DotWeight_CountNonZero											:= sum(group, if(pInput.DotWeight																 <> 0  ,1,0));
			unsigned6 EmpID_CountNonZero													:= sum(group, if(pInput.EmpID																		 <> 0  ,1,0));
			unsigned2	EmpScore_CountNonZero												:= sum(group, if(pInput.EmpScore																 <> 0  ,1,0));
			unsigned2	EmpWeight_CountNonZero											:= sum(group, if(pInput.EmpWeight																 <> 0  ,1,0));
			unsigned6 POWID_CountNonZero													:= sum(group, if(pInput.POWID																		 <> 0  ,1,0));
			unsigned2	POWScore_CountNonZero												:= sum(group, if(pInput.POWScore																 <> 0  ,1,0));
			unsigned2	POWWeight_CountNonZero											:= sum(group, if(pInput.POWWeight																 <> 0  ,1,0));
			unsigned6 ProxID_CountNonZero													:= sum(group, if(pInput.ProxID																	 <> 0  ,1,0));
			unsigned2	ProxScore_CountNonZero											:= sum(group, if(pInput.ProxScore																 <> 0  ,1,0));
			unsigned2	ProxWeight_CountNonZero											:= sum(group, if(pInput.ProxWeight															 <> 0  ,1,0));
			unsigned6 SELEID_CountNonZero													:= sum(group, if(pInput.SELEID																	 <> 0  ,1,0));
			unsigned2	SELEScore_CountNonZero											:= sum(group, if(pInput.SELEScore																 <> 0  ,1,0));
			unsigned2	SELEWeight_CountNonZero											:= sum(group, if(pInput.SELEWeight															 <> 0  ,1,0));
			unsigned6 OrgID_CountNonZero													:= sum(group, if(pInput.OrgID																		 <> 0  ,1,0));
			unsigned2	OrgScore_CountNonZero												:= sum(group, if(pInput.OrgScore																 <> 0  ,1,0));
			unsigned2	OrgWeight_CountNonZero											:= sum(group, if(pInput.OrgWeight																 <> 0  ,1,0));
			unsigned6 UltID_CountNonZero													:= sum(group, if(pInput.UltID																		 <> 0  ,1,0));
			unsigned2	UltScore_CountNonZero												:= sum(group, if(pInput.UltScore																 <> 0  ,1,0));
			unsigned2	UltWeight_CountNonZero											:= sum(group, if(pInput.UltWeight																 <> 0  ,1,0));
			unsigned8 source_rec_id_CountNonZero 									:= sum(group, if(pInput.source_rec_id														 <> 0  ,1,0));
			unsigned8 Bdid_CountNonZero                   				:= sum(group, if(pInput.Bdid										                 <> 0  ,1,0));
			unsigned8 bdid_score_CountNonZero                  		:= sum(group, if(pInput.bdid_score							                 <> 0  ,1,0));
			unsigned8 dt_first_seen_CountNonZero                  := sum(group, if(pInput.dt_first_seen						                 <> 0  ,1,0));
			unsigned8 dt_last_seen_CountNonZero                   := sum(group, if(pInput.dt_last_seen						                 <> 0  ,1,0));
			unsigned8 dt_vendor_first_reported_CountNonZero     	:= sum(group, if(pInput.dt_vendor_first_reported                 <> 0  ,1,0));
			unsigned8 dt_vendor_last_reported_CountNonZero      	:= sum(group, if(pInput.dt_vendor_last_reported	                 <> 0  ,1,0));
                                                                             
			unsigned8 MainCompanyID_CountNonBlank                 := sum(group, if(pInput.rawfields.MainCompanyID  								 <> ''  ,1,0));
			unsigned8 CompanyName_CountNonBlank                   := sum(group, if(pInput.rawfields.CompanyName    							   <> ''  ,1,0));
			unsigned8 Ticker_CountNonBlank                   			:= sum(group, if(pInput.rawfields.Ticker         							   <> ''  ,1,0));
			unsigned8 FortuneRank_CountNonBlank                  	:= sum(group, if(pInput.rawfields.FortuneRank    								 <> ''  ,1,0));
			unsigned8 PrimaryIndustry_CountNonBlank               := sum(group, if(pInput.rawfields.PrimaryIndustry							   <> ''  ,1,0));
			unsigned8 Address1_CountNonBlank        							:= sum(group, if(pInput.rawfields.Address1       								 <> ''  ,1,0));
			unsigned8 Address2_CountNonBlank                  		:= sum(group, if(pInput.rawfields.Address2       								 <> ''  ,1,0));
			unsigned8 City_CountNonBlank                 					:= sum(group, if(pInput.rawfields.City           							   <> ''  ,1,0));
			unsigned8 State_CountNonBlank           							:= sum(group, if(pInput.rawfields.State          							   <> ''  ,1,0));
			unsigned8 Zip_CountNonBlank    												:= sum(group, if(pInput.rawfields.Zip            								 <> ''  ,1,0));
			unsigned8 Country_CountNonBlank        								:= sum(group, if(pInput.rawfields.Country        								 <> ''  ,1,0));
			unsigned8 Region_CountNonBlank  											:= sum(group, if(pInput.rawfields.Region         								 <> ''  ,1,0));
			unsigned8 Phone_CountNonBlank                   			:= sum(group, if(pInput.rawfields.Phone          								 <> ''  ,1,0));
			unsigned8 Extension_CountNonBlank                     := sum(group, if(pInput.rawfields.Extension      							   <> ''  ,1,0));
			unsigned8 WebURL_CountNonBlank                   			:= sum(group, if(pInput.rawfields.WebURL         							   <> ''  ,1,0));
			unsigned8 Sales_CountNonBlank                  				:= sum(group, if(pInput.rawfields.Sales          								 <> ''  ,1,0));
			unsigned8 Employees_CountNonBlank               			:= sum(group, if(pInput.rawfields.Employees      							   <> ''  ,1,0));
			unsigned8 Competitors_CountNonBlank        						:= sum(group, if(pInput.rawfields.Competitors    								 <> ''  ,1,0));
			unsigned8 DivisionName_CountNonBlank                  := sum(group, if(pInput.rawfields.DivisionName   								 <> ''  ,1,0));
			unsigned8 SICCode_CountNonBlank                 			:= sum(group, if(pInput.rawfields.SICCode        							   <> ''  ,1,0));
			unsigned8 Auditor_CountNonBlank           						:= sum(group, if(pInput.rawfields.Auditor        							   <> ''  ,1,0));
			unsigned8 EntryDate_CountNonBlank    									:= sum(group, if(pInput.rawfields.EntryDate      								 <> ''  ,1,0));
			unsigned8 LastUpdate_CountNonBlank        						:= sum(group, if(pInput.rawfields.LastUpdate     								 <> ''  ,1,0));
			unsigned8 EntryStaffID_CountNonBlank  								:= sum(group, if(pInput.rawfields.EntryStaffID   								 <> ''  ,1,0));
			unsigned8 Description_CountNonBlank                  	:= sum(group, if(pInput.rawfields.Description    								 <> ''  ,1,0));
                                                                                             
			unsigned8 prim_range_CountNonBlank                   := sum(group, if(pInput.Clean_address.prim_range	        <> ''  ,1,0));
			unsigned8 predir_CountNonBlank                       := sum(group, if(pInput.Clean_address.predir			        <> ''  ,1,0));
			unsigned8 prim_name_CountNonBlank                    := sum(group, if(pInput.Clean_address.prim_name		      <> ''  ,1,0));
			unsigned8 addr_suffix_CountNonBlank                  := sum(group, if(pInput.Clean_address.addr_suffix	      <> ''  ,1,0));
			unsigned8 postdir_CountNonBlank                      := sum(group, if(pInput.Clean_address.postdir			      <> ''  ,1,0));
			unsigned8 unit_desig_CountNonBlank                   := sum(group, if(pInput.Clean_address.unit_desig	        <> ''  ,1,0));
			unsigned8 sec_range_CountNonBlank                    := sum(group, if(pInput.Clean_address.sec_range		      <> ''  ,1,0));
			unsigned8 p_city_name_CountNonBlank                  := sum(group, if(pInput.Clean_address.p_city_name	      <> ''  ,1,0));
			unsigned8 v_city_name_CountNonBlank                  := sum(group, if(pInput.Clean_address.v_city_name	      <> ''  ,1,0));
			unsigned8 clean_zip_CountNonBlank                    := sum(group, if(pInput.Clean_address.zip					      <> ''  ,1,0));
			unsigned8 zip4_CountNonBlank                         := sum(group, if(pInput.Clean_address.zip4				        <> ''  ,1,0));
			unsigned8 cart_CountNonBlank                         := sum(group, if(pInput.Clean_address.cart				        <> ''  ,1,0));
			unsigned8 cr_sort_sz_CountNonBlank                   := sum(group, if(pInput.Clean_address.cr_sort_sz	        <> ''  ,1,0));
			unsigned8 lot_CountNonBlank                        	 := sum(group, if(pInput.Clean_address.lot					      <> ''  ,1,0));
			unsigned8 lot_order_CountNonBlank                    := sum(group, if(pInput.Clean_address.lot_order		      <> ''  ,1,0));
			unsigned8 dbpc_CountNonBlank                         := sum(group, if(pInput.Clean_address.dbpc				        <> ''  ,1,0));
			unsigned8 chk_digit_CountNonBlank                    := sum(group, if(pInput.Clean_address.chk_digit		      <> ''  ,1,0));
			unsigned8 rec_type_CountNonBlank                     := sum(group, if(pInput.Clean_address.rec_type		        <> ''  ,1,0));
			unsigned8 fips_state_CountNonBlank                   := sum(group, if(pInput.Clean_address.fips_state	        <> ''  ,1,0));
			unsigned8 fips_county_CountNonBlank                  := sum(group, if(pInput.Clean_address.fips_county	      <> ''  ,1,0));
			unsigned8 geo_lat_CountNonBlank                      := sum(group, if(pInput.Clean_address.geo_lat			      <> ''  ,1,0));
			unsigned8 geo_long_CountNonBlank                     := sum(group, if(pInput.Clean_address.geo_long		        <> ''  ,1,0));
			unsigned8 msa_CountNonBlank                        	 := sum(group, if(pInput.Clean_address.msa					      <> ''  ,1,0));
			unsigned8 geo_blk_CountNonBlank                      := sum(group, if(pInput.Clean_address.geo_blk			      <> ''  ,1,0));
			unsigned8 geo_match_CountNonBlank                    := sum(group, if(pInput.Clean_address.geo_match		      <> ''  ,1,0));
			unsigned8 err_stat_CountNonBlank                     := sum(group, if(pInput.Clean_address.err_stat		        <> ''  ,1,0));
               
			unsigned8 Clean_dates_EntryDate_CountNonZero					:= sum(group, if(pInput.Clean_Dates.EntryDate 					<> 0  ,1,0));
			unsigned8 Clean_dates_LastUpdate_CountNonZero					:= sum(group, if(pInput.Clean_Dates.LastUpdate					<> 0  ,1,0));
			unsigned8 Clean_phones_phone_CountNonBlank          	:= sum(group, if(pInput.Clean_Phones.Phone							<> ''  ,1,0));
		end;                                                                           
		                                                                               
		pInput_stat := table(pInput, Layout_pInput_stat, Clean_address.st, record_type, few);                       
		strata.createXMLStats(pInput_stat, _Dataset.Name, 'CompaniesV2', pversion, Email_Notification_Lists().Stats, resultsOut, 'View', 'Population');
		
		return resultsOut;
	end;
	
	export fContactsPopulationStats(
	
		 dataset(layouts.base.Contacts) pInput
	
	) := 
	function

		Layout_pInput_stat :=
		record
			unsigned8 CountGroup                                 	:= count(group);
			pInput.Clean_Contact_address.st;
			pInput.record_type;
			unsigned8 Did_CountNonZero                   					:= sum(group, if(pInput.Did											                 <> 0  ,1,0));
			unsigned8 did_score_CountNonZero                      := sum(group, if(pInput.did_score								                 <> 0  ,1,0));
			unsigned8 Bdid_CountNonZero                   				:= sum(group, if(pInput.Bdid										                 <> 0  ,1,0));
			unsigned8 bdid_score_CountNonZero                  		:= sum(group, if(pInput.bdid_score							                 <> 0  ,1,0));
			unsigned8 dt_first_seen_CountNonZero                  := sum(group, if(pInput.dt_first_seen						                 <> 0  ,1,0));
			unsigned8 dt_last_seen_CountNonZero                   := sum(group, if(pInput.dt_last_seen						                 <> 0  ,1,0));
			unsigned8 dt_vendor_first_reported_CountNonZero     	:= sum(group, if(pInput.dt_vendor_first_reported                 <> 0  ,1,0));
			unsigned8 dt_vendor_last_reported_CountNonZero      	:= sum(group, if(pInput.dt_vendor_last_reported	                 <> 0  ,1,0));
                                                                             
			unsigned8 MainContactID_CountNonBlank                 := sum(group, if(pInput.rawfields.MainContactID 				 	<> ''  ,1,0));
			unsigned8 MainCompanyID_CountNonBlank                 := sum(group, if(pInput.rawfields.MainCompanyID 			   	<> ''  ,1,0));
			unsigned8 Active_CountNonBlank                   			:= sum(group, if(pInput.rawfields.Active  						   	<> ''  ,1,0));
			unsigned8 FirstName_CountNonBlank                  		:= sum(group, if(pInput.rawfields.FirstName  						 	<> ''  ,1,0));
			unsigned8 MidInital_CountNonBlank               			:= sum(group, if(pInput.rawfields.MidInital  				   		<> ''  ,1,0));
			unsigned8 LastName_CountNonBlank        							:= sum(group, if(pInput.rawfields.LastName   					 		<> ''  ,1,0));
			unsigned8 Age_CountNonBlank                  					:= sum(group, if(pInput.rawfields.Age  								 		<> ''  ,1,0));
			unsigned8 Gender_CountNonBlank                 				:= sum(group, if(pInput.rawfields.Gender  						   	<> ''  ,1,0));
			unsigned8 PrimaryTitle_CountNonBlank           				:= sum(group, if(pInput.rawfields.PrimaryTitle  			   	<> ''  ,1,0));
			unsigned8 TitleLevel1_CountNonBlank    								:= sum(group, if(pInput.rawfields.TitleLevel1   				 	<> ''  ,1,0));
			unsigned8 PrimaryDept_CountNonBlank        						:= sum(group, if(pInput.rawfields.PrimaryDept   				 	<> ''  ,1,0));
			unsigned8 SecondTitle_CountNonBlank  									:= sum(group, if(pInput.rawfields.SecondTitle   				 	<> ''  ,1,0));
			unsigned8 TitleLevel2_CountNonBlank                   := sum(group, if(pInput.rawfields.TitleLevel2   				 	<> ''  ,1,0));
			unsigned8 SecondDept_CountNonBlank                    := sum(group, if(pInput.rawfields.SecondDept 				  		<> ''  ,1,0));
			unsigned8 ThirdTitle_CountNonBlank                   	:= sum(group, if(pInput.rawfields.ThirdTitle 				   		<> ''  ,1,0));
			unsigned8 TitleLevel3_CountNonBlank                  	:= sum(group, if(pInput.rawfields.TitleLevel3   				 	<> ''  ,1,0));
			unsigned8 ThirdDept_CountNonBlank               			:= sum(group, if(pInput.rawfields.ThirdDept  				   		<> ''  ,1,0));
			unsigned8 SkillCategory_CountNonBlank        					:= sum(group, if(pInput.rawfields.SkillCategory 				 	<> ''  ,1,0));
			unsigned8 SkillSubCategory_CountNonBlank              := sum(group, if(pInput.rawfields.SkillSubCategory 		 		<> ''  ,1,0));
			unsigned8 ReportTo_CountNonBlank                 			:= sum(group, if(pInput.rawfields.ReportTo   				   		<> ''  ,1,0));
			unsigned8 OfficePhone_CountNonBlank           				:= sum(group, if(pInput.rawfields.OfficePhone   			   	<> ''  ,1,0));
			unsigned8 OfficeExt_CountNonBlank    									:= sum(group, if(pInput.rawfields.OfficeExt  					 		<> ''  ,1,0));
			unsigned8 OfficeFax_CountNonBlank        							:= sum(group, if(pInput.rawfields.OfficeFax  					 		<> ''  ,1,0));
			unsigned8 OfficeEmail_CountNonBlank  									:= sum(group, if(pInput.rawfields.OfficeEmail   				 	<> ''  ,1,0));
			unsigned8 DirectDial_CountNonBlank                  	:= sum(group, if(pInput.rawfields.DirectDial 					 		<> ''  ,1,0));
			unsigned8 MobilePhone_CountNonBlank            				:= sum(group, if(pInput.rawfields.MobilePhone   			   	<> ''  ,1,0));
			unsigned8 OfficeAddress1_CountNonBlank           			:= sum(group, if(pInput.rawfields.OfficeAddress1   	   		<> ''  ,1,0));
			unsigned8 OfficeAddress2_CountNonBlank  							:= sum(group, if(pInput.rawfields.OfficeAddress2   		 		<> ''  ,1,0));
			unsigned8 OfficeCity_CountNonBlank           					:= sum(group, if(pInput.rawfields.OfficeCity 				   		<> ''  ,1,0));
			unsigned8 OfficeState_CountNonBlank    								:= sum(group, if(pInput.rawfields.OfficeState   				 	<> ''  ,1,0));
			unsigned8 OfficeZip_CountNonBlank        							:= sum(group, if(pInput.rawfields.OfficeZip  					 		<> ''  ,1,0));
			unsigned8 OfficeCountry_CountNonBlank  								:= sum(group, if(pInput.rawfields.OfficeCountry 				 	<> ''  ,1,0));
			unsigned8 School_CountNonBlank                   			:= sum(group, if(pInput.rawfields.School  							 	<> ''  ,1,0));
			unsigned8 Degree_CountNonBlank                     		:= sum(group, if(pInput.rawfields.Degree  						   	<> ''  ,1,0));
			unsigned8 GraduationYear_CountNonBlank                := sum(group, if(pInput.rawfields.GraduationYear   	   		<> ''  ,1,0));
			unsigned8 Country_CountNonBlank                  			:= sum(group, if(pInput.rawfields.Country 							 	<> ''  ,1,0));
			unsigned8 Salary_CountNonBlank               					:= sum(group, if(pInput.rawfields.Salary  						   	<> ''  ,1,0));
			unsigned8 Bonus_CountNonBlank        									:= sum(group, if(pInput.rawfields.Bonus   							 	<> ''  ,1,0));
			unsigned8 Compensation_CountNonBlank                  := sum(group, if(pInput.rawfields.Compensation  				 	<> ''  ,1,0));
			unsigned8 Citizenship_CountNonBlank                 	:= sum(group, if(pInput.rawfields.Citizenship   			   	<> ''  ,1,0));
			unsigned8 DiversityCandidate_CountNonBlank           	:= sum(group, if(pInput.rawfields.DiversityCandidate    	<> ''  ,1,0));
			unsigned8 EntryDate_CountNonBlank    									:= sum(group, if(pInput.rawfields.EntryDate  					 		<> ''  ,1,0));
			unsigned8 LastUpdate_CountNonBlank        						:= sum(group, if(pInput.rawfields.LastUpdate 					 		<> ''  ,1,0));
			unsigned8 Biography_CountNonBlank  										:= sum(group, if(pInput.rawfields.Biography  					 		<> ''  ,1,0));
                                                                                             
			unsigned8 clean_contact_name_title_CountNonBlank      := sum(group, if(pInput.clean_contact_name.title			         <> ''  ,1,0));
			unsigned8 clean_contact_name_fname_CountNonBlank      := sum(group, if(pInput.clean_contact_name.fname			         <> ''  ,1,0));
			unsigned8 clean_contact_name_mname_CountNonBlank      := sum(group, if(pInput.clean_contact_name.mname			         <> ''  ,1,0));
			unsigned8 clean_contact_name_lname_CountNonBlank      := sum(group, if(pInput.clean_contact_name.lname			         <> ''  ,1,0));
			unsigned8 clean_contact_name_name_suffix_CountNonBlank:= sum(group, if(pInput.clean_contact_name.name_suffix        <> ''  ,1,0));
			unsigned8 clean_contact_name_name_score_CountNonBlank := sum(group, if(pInput.clean_contact_name.name_score	       <> ''  ,1,0));
                                                                                   
			unsigned8 prim_range_CountNonBlank                   := sum(group, if(pInput.Clean_Contact_address.prim_range	        <> ''  ,1,0));
			unsigned8 predir_CountNonBlank                       := sum(group, if(pInput.Clean_Contact_address.predir			        <> ''  ,1,0));
			unsigned8 prim_name_CountNonBlank                    := sum(group, if(pInput.Clean_Contact_address.prim_name		        <> ''  ,1,0));
			unsigned8 addr_suffix_CountNonBlank                  := sum(group, if(pInput.Clean_Contact_address.addr_suffix	        <> ''  ,1,0));
			unsigned8 postdir_CountNonBlank                      := sum(group, if(pInput.Clean_Contact_address.postdir			        <> ''  ,1,0));
			unsigned8 unit_desig_CountNonBlank                   := sum(group, if(pInput.Clean_Contact_address.unit_desig	        <> ''  ,1,0));
			unsigned8 sec_range_CountNonBlank                    := sum(group, if(pInput.Clean_Contact_address.sec_range		        <> ''  ,1,0));
			unsigned8 p_city_name_CountNonBlank                  := sum(group, if(pInput.Clean_Contact_address.p_city_name	        <> ''  ,1,0));
			unsigned8 v_city_name_CountNonBlank                  := sum(group, if(pInput.Clean_Contact_address.v_city_name	        <> ''  ,1,0));
			unsigned8 zip_CountNonBlank                        	 := sum(group, if(pInput.Clean_Contact_address.zip					        <> ''  ,1,0));
			unsigned8 zip4_CountNonBlank                         := sum(group, if(pInput.Clean_Contact_address.zip4				        <> ''  ,1,0));
			unsigned8 cart_CountNonBlank                         := sum(group, if(pInput.Clean_Contact_address.cart				        <> ''  ,1,0));
			unsigned8 cr_sort_sz_CountNonBlank                   := sum(group, if(pInput.Clean_Contact_address.cr_sort_sz	        <> ''  ,1,0));
			unsigned8 lot_CountNonBlank                        	 := sum(group, if(pInput.Clean_Contact_address.lot					        <> ''  ,1,0));
			unsigned8 lot_order_CountNonBlank                    := sum(group, if(pInput.Clean_Contact_address.lot_order		        <> ''  ,1,0));
			unsigned8 dbpc_CountNonBlank                         := sum(group, if(pInput.Clean_Contact_address.dbpc				        <> ''  ,1,0));
			unsigned8 chk_digit_CountNonBlank                    := sum(group, if(pInput.Clean_Contact_address.chk_digit		        <> ''  ,1,0));
			unsigned8 rec_type_CountNonBlank                     := sum(group, if(pInput.Clean_Contact_address.rec_type		        <> ''  ,1,0));
			unsigned8 fips_state_CountNonBlank                   := sum(group, if(pInput.Clean_Contact_address.fips_state	        <> ''  ,1,0));
			unsigned8 fips_county_CountNonBlank                  := sum(group, if(pInput.Clean_Contact_address.fips_county	        <> ''  ,1,0));
			unsigned8 geo_lat_CountNonBlank                      := sum(group, if(pInput.Clean_Contact_address.geo_lat			        <> ''  ,1,0));
			unsigned8 geo_long_CountNonBlank                     := sum(group, if(pInput.Clean_Contact_address.geo_long		        <> ''  ,1,0));
			unsigned8 msa_CountNonBlank                        	 := sum(group, if(pInput.Clean_Contact_address.msa					        <> ''  ,1,0));
			unsigned8 geo_blk_CountNonBlank                      := sum(group, if(pInput.Clean_Contact_address.geo_blk			        <> ''  ,1,0));
			unsigned8 geo_match_CountNonBlank                    := sum(group, if(pInput.Clean_Contact_address.geo_match		        <> ''  ,1,0));
			unsigned8 err_stat_CountNonBlank                     := sum(group, if(pInput.Clean_Contact_address.err_stat		        <> ''  ,1,0));
               
			unsigned8 Clean_dates_EntryDate_CountNonZero					:= sum(group, if(pInput.Clean_Dates.EntryDate 					<> 0  ,1,0));
			unsigned8 Clean_dates_LastUpdate_CountNonZero					:= sum(group, if(pInput.Clean_Dates.LastUpdate					<> 0  ,1,0));
			unsigned8 Clean_phones_OfficePhone_CountNonBlank      := sum(group, if(pInput.Clean_Phones.OfficePhone				<> ''  ,1,0));
			unsigned8 Clean_phones_DirectDial_CountNonBlank    		:= sum(group, if(pInput.Clean_Phones.DirectDial					<> ''  ,1,0));
			unsigned8 Clean_phones_MobilePhone_CountNonBlank    	:= sum(group, if(pInput.Clean_Phones.MobilePhone				<> ''  ,1,0));
		end;                                                                                        
		                                                                               
		pInput_stat := table(pInput, Layout_pInput_stat, Clean_Contact_address.st, record_type, few);                       
		strata.createXMLStats(pInput_stat, _Dataset.Name, 'Contacts', pversion, Email_Notification_Lists().Stats, resultsOut, 'View', 'Population');
		
		return resultsOut;

	end;
	
	Strata.createAsBusinessStats.Header		(As_Business_Header.fCompanies(files().base.Companies.qa													),_dataset.name,'Companies'	,pversion,Email_Notification_Lists().stats,Business_headers	);
	Strata.createAsBusinessStats.Contacts	(As_Business_Contact.fContacts(files().base.Contacts.qa,files().base.Companies.qa	),_dataset.name,'Contacts'	,pversion,Email_Notification_Lists().stats,Business_Contacts);
	
	export all := if(VersionControl.IsValidVersion(pversion),
	sequential(
		 business_headers
		,business_contacts
		,fCompaniesPopulationStats(files().base.Companies.qa)
		,fContactsPopulationStats(files().base.Contacts.qa)
	));

end;