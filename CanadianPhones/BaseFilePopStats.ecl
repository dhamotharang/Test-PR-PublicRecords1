

allCanadianPhone_ds := file_CanadianWhitePagesBase;
						

//pop stats

CanadianPhone_pop_stats := record
   count_ 																					:= count(group);
	 integer             listing_type								:= ave(group, if(allCanadianPhone_ds.listing_type <> '',100,0));
	 integer 					   lastname    	  							:= ave(group, if(allCanadianPhone_ds.lastname <> '',100,0));							
   integer             firstname    								:= ave(group, if(allCanadianPhone_ds.firstname <> '',100,0));
   integer             middlename    								:= ave(group, if(allCanadianPhone_ds.middlename <> '',100,0));
   integer             Name         								:= ave(group, if(allCanadianPhone_ds.Name <> '',100,0));
   integer             nickname    	  							:= ave(group, if(allCanadianPhone_ds.nickname <> '',100,0));
   integer             generational   							:= ave(group, if(allCanadianPhone_ds.generational <> '',100,0));
   integer             title    	            			:= ave(group, if(allCanadianPhone_ds.title <> '',100,0));
   integer             professionalsuffix    				:= ave(group, if(allCanadianPhone_ds.professionalsuffix <> '',100,0));
   integer             housenumber    							:= ave(group, if(allCanadianPhone_ds.housenumber <> '',100,0));
   integer             directional    							:= ave(group, if(allCanadianPhone_ds.directional <> '',100,0));
   integer             streetname    								:= ave(group, if(allCanadianPhone_ds.streetname <> '',100,0));
   integer             streetsuffix    							:= ave(group, if(allCanadianPhone_ds.streetsuffix <> '',100,0));
   integer             suitenumber    							:= ave(group, if(allCanadianPhone_ds.suitenumber <> '',100,0));
   integer             suburbancity    							:= ave(group, if(allCanadianPhone_ds.suburbancity <> '',100,0));
   integer             postalcity    								:= ave(group, if(allCanadianPhone_ds.postalcity <> '',100,0));
   integer             province    									:= ave(group, if(allCanadianPhone_ds.province <> '',100,0));
   integer             postalcode    								:= ave(group, if(allCanadianPhone_ds.postalcode <> '',100,0));
   integer             provincecode    							:= ave(group, if(allCanadianPhone_ds.provincecode <> '',100,0));
   integer             County_Code    							:= ave(group, if(allCanadianPhone_ds.County_Code <> '',100,0));
   integer             phonenumber    							:= ave(group, if(allCanadianPhone_ds.phonenumber <> '',100,0));
   integer             phonetypeflag    						:= ave(group, if(allCanadianPhone_ds.phonetypeflag <> '',100,0));
   integer             nosolicitation    						:= ave(group, if(allCanadianPhone_ds.nosolicitation <> '',100,0));
   integer             cmacode    									:= ave(group, if(allCanadianPhone_ds.cmacode <> '',100,0));
   integer             company_name    							:= ave(group, if(allCanadianPhone_ds.company_name <> '',100,0)); //instead of busines
   integer             Record_ID    								:= ave(group, if(allCanadianPhone_ds.Record_ID <> '',100,0));
   integer             Record_Use_Indicator   			:= ave(group, if(allCanadianPhone_ds.Record_Use_Indicator <> '',100,0));
   integer             Pub_Date    									:= ave(group, if(allCanadianPhone_ds.Pub_Date <> '',100,0));
   integer             Latitude 			      				:= ave(group, if(allCanadianPhone_ds.Latitude <> '',100,0));
   integer             Longitude    				  			:= ave(group, if(allCanadianPhone_ds.Longitude <> '',100,0));
   integer             Lat_Long_Level_Applied 			:= ave(group, if(allCanadianPhone_ds.Lat_Long_Level_Applied <> '',100,0));
   integer             Book_Number    							:= ave(group, if(allCanadianPhone_ds.Book_Number <> '',100,0));
   integer             Secondary_Name    						:= ave(group, if(allCanadianPhone_ds.Secondary_Name <> '',100,0));
   integer             Room_Number    							:= ave(group, if(allCanadianPhone_ds.Room_Number <> '',100,0));
   integer             Room_Code    								:= ave(group, if(allCanadianPhone_ds.Room_Code <> '',100,0));
   integer             Record_Type    							:= ave(group, if(allCanadianPhone_ds.Record_Type <> '',100,0));
   integer             YPHC_1    	   								:= ave(group, if(allCanadianPhone_ds.YPHC_1 <> '',100,0));
   integer             YPHC_2    	   								:= ave(group, if(allCanadianPhone_ds.YPHC_2 <> '',100,0));
   integer             YPHC_3    	   								:= ave(group, if(allCanadianPhone_ds.YPHC_3 <> '',100,0));
   integer             YPHC_4    	   								:= ave(group, if(allCanadianPhone_ds.YPHC_4 <> '',100,0));
   integer             YPHC_5    	   								:= ave(group, if(allCanadianPhone_ds.YPHC_5 <> '',100,0));
   integer             YPHC_6    	   								:= ave(group, if(allCanadianPhone_ds.YPHC_6 <> '',100,0));
   integer             SIC_1    	   								:= ave(group, if(allCanadianPhone_ds.SIC_1 <> '',100,0));
   integer             SIC_2    	   								:= ave(group, if(allCanadianPhone_ds.SIC_2 <> '',100,0));
   integer             SIC_3    	   								:= ave(group, if(allCanadianPhone_ds.SIC_3 <> '',100,0));
   integer             SIC_4    	   								:= ave(group, if(allCanadianPhone_ds.SIC_4 <> '',100,0));
   integer             Bus_Govt_Indicator   				:= ave(group, if(allCanadianPhone_ds.Bus_Govt_Indicator <> '',100,0));
   integer             status_indicator    					:= ave(group, if(allCanadianPhone_ds.status_indicator <> '',100,0));
   integer             Selected_SIC    	   					:= ave(group, if(allCanadianPhone_ds.Selected_SIC <> '',100,0));
   integer             Franchise_Codes    					:= ave(group, if(allCanadianPhone_ds.Franchise_Codes <> '',100,0));
   integer             Ad_Size    	   							:= ave(group, if(allCanadianPhone_ds.Ad_Size <> '',100,0));
   integer             French_Flag    	   				  := ave(group, if(allCanadianPhone_ds.French_Flag <> '',100,0));
   integer             Population_Code    	  			:= ave(group, if(allCanadianPhone_ds.Population_Code <> '',100,0));
   integer             Individual_Firm_Code   			:= ave(group, if(allCanadianPhone_ds.Individual_Firm_Code <> '',100,0));
   integer             Year_of_1st_Appearance_CCYY	:= ave(group, if(allCanadianPhone_ds.Year_of_1st_Appearance_CCYY <> '',100,0));
   integer             Date_Added_to_DB_CCYYMM 			:= ave(group, if(allCanadianPhone_ds.Date_Added_to_DB_CCYYMM <> '',100,0));
   integer             Title_Code    	   						:= ave(group, if(allCanadianPhone_ds.Title_Code <> '',100,0));
   integer             Contact_Gender_Code    			:= ave(group, if(allCanadianPhone_ds.Contact_Gender_Code <> '',100,0));
   integer             Employee_Size_Code    				:= ave(group, if(allCanadianPhone_ds.Employee_Size_Code <> '',100,0));
   integer             Sales_Volume_Code    				:= ave(group, if(allCanadianPhone_ds.Sales_Volume_Code <> '',100,0));
   integer             Industry_Specific_Code  			:= ave(group, if(allCanadianPhone_ds.Industry_Specific_Code <> '',100,0));
   integer             Business_Status_Code    			:= ave(group, if(allCanadianPhone_ds.Business_Status_Code <> '',100,0));
   integer             Key_Code    									:= ave(group, if(allCanadianPhone_ds.Key_Code <> '',100,0));
   integer             Fax_Phone    								:= ave(group, if(allCanadianPhone_ds.Fax_Phone <> '',100,0));
   integer             Office_Size_Code    					:= ave(group, if(allCanadianPhone_ds.Office_Size_Code <> '',100,0));
   integer             Production_Date_MMDDCCYY 		:= ave(group, if(allCanadianPhone_ds.Production_Date_MMDDCCYY <> '',100,0));
   integer             ABI_Number    								:= ave(group, if(allCanadianPhone_ds.ABI_Number <> '',100,0));
   integer             Subsidiary_Parent_Number 		:= ave(group, if(allCanadianPhone_ds.Subsidiary_Parent_Number <> '',100,0));
   integer             Ultimate_Parent_Number   		:= ave(group, if(allCanadianPhone_ds.Ultimate_Parent_Number <> '',100,0));
   integer             Primary_Sic    							:= ave(group, if(allCanadianPhone_ds.Primary_Sic <> '',100,0));
   integer             Secondary_SIC_Code_1    			:= ave(group, if(allCanadianPhone_ds.Secondary_SIC_Code_1 <> '',100,0));
   integer             Secondary_SIC_Code_2    			:= ave(group, if(allCanadianPhone_ds.Secondary_SIC_Code_2 <> '',100,0));
   integer             Secondary_SIC_Code_3    			:= ave(group, if(allCanadianPhone_ds.Secondary_SIC_Code_3 <> '',100,0));
   integer             Secondary_SIC_Code_4    			:= ave(group, if(allCanadianPhone_ds.Secondary_SIC_Code_4 <> '',100,0));
   integer             Total_Employee_Size_Code 		:= ave(group, if(allCanadianPhone_ds.Total_Employee_Size_Code <> '',100,0));
   integer             Total_Output_Sales_Code  		:= ave(group, if(allCanadianPhone_ds.Total_Output_Sales_Code <> '',100,0));
   integer             Number_of_Employees_Actual 	:= ave(group, if(allCanadianPhone_ds.Number_of_Employees_Actual <> '',100,0));
   integer             Total_No_Employees_Actual  	:= ave(group, if(allCanadianPhone_ds.Total_No_Employees_Actual <> '',100,0));	
   integer             Postal_Mode    							:= ave(group, if(allCanadianPhone_ds.Postal_Mode <> '',100,0));
   integer             Postal_Bag_Bundle    				:= ave(group, if(allCanadianPhone_ds.Postal_Bag_Bundle <> '',100,0));	
   integer             Transaction_Code    					:= ave(group, if(allCanadianPhone_ds.Transaction_Code <> '',100,0));						
                  
	 end;
CanPhone_pop_stats := table(allCanadianPhone_ds,CanadianPhone_pop_stats,few);
output(CanPhone_pop_stats,all,named('CanadianPhone_pop_stats'));								
									