import Standard;

export layout_OSHAIR_clean := module

       export oshair_program_rec := record,maxlength(75000)
          string1  Program_Type;
          string25 Program_Value;
       end;

       export oshair_Related_Activity_rec := record,maxlength(75000)
          string2              Rel_Activity_item_Number;
          string1              Rel_Activity_Type;
          big_endian unsigned4 Rel_Activity_Number;
          string1              Rel_Activity_Safety_Flag;
          string1              Rel_Activity_Health_Flag;
		  // Derived values from OSHA specifications document
          string20             Rel_Activity_Desc := ''; // Derived
       end;

       export oshair_Optional_Info_rec := record,maxlength(75000)
          string1  Opt_Type;
          string2  Opt_ID;
          string12 Opt_Value;
		  // Derived values from OSHA specifications document
          string10 Opt_Desc := ''; // Derived
       end;
 
       export oshair_Violations_rec := record,maxlength(75000)
          string1              Delete_Flag;
          big_endian unsigned4 Issuance_Date;
          string2              Citation_Number;
          string3              Item_Number;
          string2              Item_group;
          string1              Emphasis;
          string2              Gravity; // Values: b, 1-10
          decimal9_2           Current_Penalty;
          decimal9_2           Initial_Penalty;
          string1              Violation_Type;
          string1              Initial_Violation_Type;
          string22             Fed_State_Standard;
          big_endian unsigned4 Abatement_Date;
          decimal5             Number_Instances;
          string1              Related_Event_Code;
          decimal5             Number_Exposed;
          string1              Abatement_Complete;
          big_endian unsigned4 Earliest_Contest_Date;
          string1              Violation_Contest;
          string1              Penalty_Contest;
          string1              Abatement_Employer_Contest;
          string1              Abatement_Employee_Contest;
          big_endian unsigned4 Final_Order_Date;
          string1              Pet_To_Modify_Abatement;
          string1              Citation_Amended;
          string1              Informal_Settlement_Aggreement;
          string1              Disposition_Event;
          big_endian unsigned4 FTA_Inspection_Number;
          decimal9_2           FTA_Penalty;
          big_endian unsigned4 FTA_Issuance_Date;
          big_endian unsigned4 FTA_Contest_Date;
          string1              FTA_Ammended;
          string1              FTA_ISA;
          string1              FTA_Disposition_Event;
          big_endian unsigned4 FTA_Final_Order_Date;
          string10             Hazard_Category;
          big_endian unsigned4 Abatement_Verify_Date;
          string15             Violation_Desc             := ''; // Derived
          string20             Related_Event_Desc         := ''; // Derived
          string68             Abatement_Comp_Desc        := ''; // Derived
          string33             Disposition_Event_Desc     := ''; // Derived
          string40             FTA_Disposition_Event_Desc := ''; // Derived
       end;
  
       export oshair_Hazardous_Substance_rec := record,maxlength(75000)
          string2  Citation_Number;
          string3  Item_Number;
          string2  Item_group;
          string4  Hazardous_Substance_1;
          string4  Hazardous_Substance_2;
          string4  Hazardous_Substance_3;
          string4  Hazardous_Substance_4;
          string4  Hazardous_Substance_5;
		  // Derived values from OSHA specifications documents
          string50 Hazardous_Sub_Desc_1 := ''; // Derived
		  string50 Hazardous_Sub_Desc_2 := ''; // Derived
          string50 Hazardous_Sub_Desc_3 := ''; // Derived
          string50 Hazardous_Sub_Desc_4 := ''; // Derived
          string50 Hazardous_Sub_Desc_5 := ''; // Derived
       end;
 
       export oshair_Accident_rec := record,maxlength(75000)
          string20             Name;
          big_endian unsigned4 Related_Inspection_Number;
          string1              Sex;
          unsigned1            Age;
          string1              Degree_of_Injury;
          string2              Nature_of_Injury;    
          string2              Part_of_Body;        
          string2              Source_of_Injury;    
          string2              Event_Type;          
          string2              Environmental_Factor; 
          string2              Human_Factor;        
          string1              Task_Assigned; 
          string5              Hazardous_Substance; 
          string3              Occupation_Code;     
          // Cleaned accident victim name
		  Standard.Name        victim;
	      // string5        	   title       := '';   // Derived
	      // string20       	   fname       := '';   // Derived
	      // string20       	   mname       := '';   // Derived
	      // string20       	   lname       := '';   // Derived
	      // string5              name_suffix := '';   // Derived
		  // string3              name_score  := '';   // Derived

  	      // Derived values from OSHA specifications document
          string22             Deg_of_Injury_Desc := ''; // Derived
		  string20             Nat_of_Inj_Desc    := ''; // Derived
          string10             Part_of_Body_Desc  := ''; // Derived
          string20             Src_of_Inj_Desc    := ''; // Derived
          string20             Event_Desc         := ''; // Derived
          string30             Env_Factor_Desc    := ''; // Derived
          string33             Human_Factor_Desc  := ''; // Derived
          string39             Task_Assigned_Desc := ''; // Derived
          string50             Hazardous_Sub_Desc := ''; // Derived
          string50             Occupation_Desc    := ''; // Derived
       end;
  
       export oshair_Inspection_rec := record,maxlength(75000)
          string1              Continuation_Flag;
          string1              History_Flag;
          string20             History_Desc := ''; // Derived
          big_endian unsigned4 Last_Activity_Date;
          string1              Fed_State_Flag;
          string1              Previous_Activity_Type;
          string31             Prev_Activity_Type_Desc := ''; // Derived
          big_endian unsigned4 Previous_Activity_Number;
          big_endian unsigned4 Activity_Number;
          string2              Region_Code;
          string3              Area_Code;
          string2              Office_Code;
          string5              Compliance_Officer_ID;
          string1              Compliance_Officer_Job_Title;
          string20             Compl_Officer_Job_Title_Desc := ''; // Derived
          string4              Hist_Area;
          string5              Hist_Report_Number;
          string30             Inspected_Site_Name; // Searchable
          string30             Inspected_Site_Street;
          string2              Inspected_Site_State;
          decimal5             Inspected_Site_Zip;
          big_endian unsigned2 Inspected_Site_City_Code;
		  string30             Inspected_Site_City_Name := ''; // Derived
          decimal3             Inspected_Site_County_Code;
		  // string20             Inspected_Site_County_Name := ''; // Derived
          big_endian unsigned4 DUNS_Number;
          string17             Host_Establishment_key;
          string1              Owner_Type;
          string18             Own_Type_Desc := ''; // Derived
          big_endian unsigned2 Owner_Code;
          string1              Advance_Notice_Flag;
          big_endian unsigned4 Inspection_Opening_Date;
          big_endian unsigned4 Inspection_Close_Date;
          string1              Safety_Health_Flag;
		  // string6              Safety_Health_Desc := ''; // Derived
          big_endian unsigned2 SIC_Code;
          big_endian unsigned2 SIC_Guide;
          big_endian unsigned2 SIC_Inspected;
          string6              NAICS_Code;
          string6              NAICS_Secondary_Code;
          string6              NAIC_Inspected;
          string1              Inspection_Type;
          string27             Insp_Type_Desc := ''; // Derived
          string1              Inspection_Scope;
          string13             Insp_Scope_Desc := ''; // Derived
          decimal5             Number_In_Establishment;
          decimal5             Number_Covered;
          decimal7             Number_Total_Employees;
          string1              Walk_Around_Flag;
          string1              Employees_Interviewed_Flag;
          string1              Union_Flag; 
          string1              Closed_Case_Flag;
          string1              Why_No_Inspection_Code;
          // string42             Why_No_Insp_Desc := ''; // Derived
          big_endian unsigned4 Close_Case_Date;
          string1              Safety_PG_Manufacturing_Insp_Flag;
          string1              Safety_PG_Construction_Insp_Flag;
          string1              Safety_PG_Maritime_Insp_Flag;
          string1              Health_PG_Manufacturing_Insp_Flag;
          string1              Health_PG_Construction_Insp_Flag;
          string1              Health_PG_Maritime_Insp_Flag;
          string1              Migrant_Farm_Insp_Flag;
          string1              Antic_Served;
          big_endian unsigned4 First_Denial_Date;
          big_endian unsigned4 Last_Reenter_Date;
          decimal5_2           bls_Loss_Workday_Injury_Rate;
          string1              Informal_SH_Program_Init_Flag;
          string1              Informal_Data_Required;
          big_endian unsigned4 Penalties_Due_Date;
          big_endian unsigned4 FTA_Due_Date;
          string1              Due_Date_Type;
          // string60             Due_Date_Desc := ''; // Derived
          big_endian unsigned2 PA_Prep_Time;
          big_endian unsigned2 PA_Travel_Time;
          big_endian unsigned2 PA_On_site_Time;
          big_endian unsigned2 PA_Tech_supp_Time;
          big_endian unsigned2 PA_Report_prep_Time;
          big_endian unsigned2 PA_Other_conf_Time;
          big_endian unsigned2 PA_Litigation_Time;
          big_endian unsigned2 PA_Denial_Time;
          big_endian unsigned4 PA_Sum_hours;
          big_endian unsigned4 Earliest_Contest_Date;
          decimal11_2          Remitted_Penalty_Amount;
          decimal11_2          Remitted_FTA_Amount;
          decimal11_2          Total_Penalties;
          decimal11_2          Total_FTA;
          decimal5             Total_Violations;
          decimal5             Total_Serious_Violations;
          // Counts for child records
          unsigned2            Number_Program;
          unsigned2            Number_Rel_Activity;
          unsigned2            Number_Optional_Info;
          unsigned2            Number_Debt;
          unsigned2            Number_Violations;
          unsigned2            Number_Event;
          unsigned2            Number_Hazardous_Substance;
          unsigned2            Number_Accident;
          unsigned2            Number_Admin_Pay;
          // Cleaned/Appended site name/address
          string30             cname;
		  unsigned6	           bdid	:= 0;
		  // unsigned6	           new_bdid	:= 0;
		  unsigned2            BDID_score := 0;
		  string9              FEIN_append  := '';
          Standard.L_Address.detailed;
		  // string10       	  prim_range := '';
          // string2        	  predir := '';
          // string28             prim_name := '';
          // string4              addr_suffix := '';
          // string2              postdir := '';
          // string10             unit_desig := '';
          // string8              sec_range := '';
          // string25             p_city_name := '';
          // string25       	  v_city_name := '';
          // string2        	  state := '';
          // string5        	  zip5 := '';
          // string4        	  zip4 := '';
          // string4        	  cart := '';
          // string1        	  cr_sort_sz := '';
          // string4        	  lot := '';
          // string1        	  lot_order := '';
          // string2        	  dpbc := '';
          // string1        	  chk_digit := '';
          // string2        	  rec_type := '';
          // string2        	  ace_fips_st := '';
          // string3        	  ace_fips_county := '';
          // string10       	  geo_lat := '';
          // string11       	  geo_long := '';
          // string4        	  msa := '';
          // string7        	  geo_blk := '';
          // string1        	  geo_match := '';
          // string4        	  err_stat := '';
       end; // End of the parent record
 
end;  // End of the whole module

