export layout_OSHAIR_in :=  module

       export Program_rec := record,maxlength(75000)
	      EBCDIC string1  Program_Type;
		  EBCDIC string25 Program_Value;
	   end;

       export Related_Activity_rec := record,maxlength(75000)
          EBCDIC string2       Rel_Activity_item_Number;
          EBCDIC string1       Rel_Activity_Type;
          big_endian unsigned4 Rel_Activity_Number;
          EBCDIC string1       Rel_Activity_Safety_Flag;
          EBCDIC string1       Rel_Activity_Health_Flag;
       end;

       export Optional_Info_rec := record,maxlength(75000)
          EBCDIC string1  Opt_Type;
          EBCDIC string2  Opt_ID;
          EBCDIC string12 Opt_Value;
       end;

       export Debt_rec := record,maxlength(75000)
          EBCDIC string1  Debt_Type;
		  EBCDIC string71 Debt_Payload; // This may be either the Penalty/FTA record or the Miscellaneous record
          /* Penalty or FTA Debt sub-record type */
          /*IfBlock((string1)(ebcdic string1)self.Debt_Type in ['P','F'])
                EBCDIC string1 Debt_Waived;
                EBCDIC string1 Debt_Waived_Reason;
                big_endian unsigned4       Ref_Date;
                decimal9_2      Debt_Interest;
                decimal9_2      Deliquent_Fees;
                big_endian unsigned4       DCA_Send_Date;
                big_endian unsigned4       DCA_Returned_Date;
                EBCDIC string1 DCA_Recommended;
                decimal9_2      DCA_Litigation_Amount;
                decimal9_2      DCA_Fee_Amount;
                EBCDIC string1 Case_Archived;
                decimal9_2      DCA_Interest;
                decimal9_2      DCA_Deliquent_Fees;
                big_endian unsigned4       DFO_Send_Date;
                big_endian unsigned4       DFO_Returned_Date;
                EBCDIC string1 DFO_Recommended;
                big_endian unsigned4       Area_Office_Send_Date;
                big_endian unsigned4       Credit_Bureau_Send_Date;
                big_endian unsigned4       IRS_Send_Date;
                big_endian unsigned4       Credit_Bureau_Returned_Date;
          end;*/
          // /* Miscellaneous Debt sub-record type */
          /*IfBlock((string1)(ebcdic string1)self.Debt_Type = 'M')
                big_endian unsigned4        Next_Installment_Date;
                big_endian unsigned4        Last_Installment_Date;
                big_endian unsigned4        Solicitor_Date;
                EBCDIC string1  Solicitor_Reason;
                EBCDIC string1  Case_Hold_Flag;
                EBCDIC string57 FTA_Debt_Filler;
          end;*/
       end;
 
       export Violations_rec := record,maxlength(75000)
          EBCDIC string1       Delete_Flag;
          big_endian unsigned4 Issuance_Date;
          EBCDIC string2       Citation_Number;
          EBCDIC string3       Item_Number;
          EBCDIC string2       Item_group;
          EBCDIC string1       Emphasis;
          EBCDIC string2       Gravity;
          decimal9_2           Current_Penalty;
          decimal9_2           Initial_Penalty;
          EBCDIC string1       Violation_Type;
          EBCDIC string1       Initial_Violation_Type;
          EBCDIC string22      Fed_State_Standard;
          big_endian unsigned4 Abatement_Date;
          decimal5             Number_Instances;
          EBCDIC string1       Related_Event_Code;
          decimal5             Number_Exposed;
          EBCDIC string1       Abatement_Complete;
          big_endian unsigned4 Earliest_Contest_Date;
          EBCDIC string1       Violation_Contest;
          EBCDIC string1       Penalty_Contest;
          EBCDIC string1       Abatement_Employer_Contest;
          EBCDIC string1       Abatement_Employee_Contest;
          big_endian unsigned4 Final_Order_Date;
          EBCDIC string1       Pet_To_Modify_Abatement;
          EBCDIC string1       Citation_Amended;
          EBCDIC string1       Informal_Settlement_Aggreement;
          EBCDIC string1       Disposition_Event;
          big_endian unsigned4 FTA_Inspection_Number;
          decimal9_2           FTA_Penalty;
          big_endian unsigned4 FTA_Issuance_Date;
          big_endian unsigned4 FTA_Contest_Date;
          EBCDIC string1       FTA_Ammended;
          EBCDIC string1       FTA_ISA;
          EBCDIC string1       FTA_Disposition_Event;
          big_endian unsigned4 FTA_Final_Order_Date;
          EBCDIC string10      Hazard_Category;
          big_endian unsigned4 Abatement_Verify_Date;
       end;
 
       export Penalty_FTA_Event_rec := record,maxlength(75000)
          EBCDIC string1  History_Type;
          EBCDIC string7  History_Cit_ID;
		  EBCDIC string16 Event_Payload; // This may be either the Penalty record or FTA record
          // /* Penalty History sub-record type */
          //IfBlock((string1)(ebcdic string1)self.History_Type = 'P')
                //big_endian unsigned4       Penalty_History_Date;
                //EBCDIC string1 Penalty_History_Event;
                //decimal9_2      Penalty_History_Penalty_Amount;
                //big_endian unsigned4       Penalty_History_Abate_Date;
                //EBCDIC string1 Penalty_History_VType;
                //EBCDIC string1 Penalty_History_Action;
          //end;
          // /* FTA History sub-record type */
          //IfBlock((string1)(ebcdic string1)self.History_Type = 'F')
                //big_endian unsigned4       FTA_History_Insp_Number;
                //big_endian unsigned4       FTA_History_Date;
                //EBCDIC string1 FTA_History_Event;
                //decimal9_2      FTA_History_Penalty;
                //EBCDIC string1 FTA_History_Action;
                //EBCDIC string1 History_Filler;
          //end;
       end;
 
       export Hazardous_Substance_rec := record,maxlength(75000)
          EBCDIC string2 Citation_Number;
          EBCDIC string3 Item_Number;
          EBCDIC string2 Item_group;
          EBCDIC string4 Hazardous_Substance_1;
          EBCDIC string4 Hazardous_Substance_2;
          EBCDIC string4 Hazardous_Substance_3;
          EBCDIC string4 Hazardous_Substance_4;
          EBCDIC string4 Hazardous_Substance_5;
       end;
 
       export Accident_rec := record,maxlength(75000)
          EBCDIC string20      Name;
          big_endian unsigned4 Related_Inspection_Number;
          EBCDIC string1       Sex;
          EBCDIC string2       Age;
          EBCDIC string1       Degree_of_Injury;
          EBCDIC string2       Nature_of_Injury;
          EBCDIC string2       Part_of_Body;
          EBCDIC string2       Source_of_Injury;
          EBCDIC string2       Event_Type;
          EBCDIC string2       Environmental_Factor;
          EBCDIC string2       Human_Factor;
          EBCDIC string1       Task_Assigned;
          EBCDIC string5       Hazardous_Substance;
          EBCDIC string3       Occupation_Code;
       end;
 
       export Administrative_Payment_rec := record,maxlength(75000)
          EBCDIC string1  Admin_Pay_Type;
		  EBCDIC string20 Admin_Pay_Payload; // This may be either the Administrative record or the Payment record
          // /* Administrative sub-record type */
          /*IfBlock((string1)(ebcdic string1)self.Admin_Pay_Type in ['1','2','3','4','5','6','7','8','9',
																   'M','N','I','D','F','G','O'])
			   
                big_endian unsigned4        Admin_Date;
                decimal9_2      Admin_Amount;
                EBCDIC string11 Admin_Filler;
          end;*/
          // /* Payment sub-record type */
          /*IfBlock((string1)(ebcdic string1)self.Admin_Pay_Type in ['P','R','U','C'])
                big_endian unsigned4 Payment_Date;
                decimal9_2 Payment_Penalty_Amount;
                decimal9_2 Payment_FTA_Amount;
                big_endian unsigned4 Payment_163_Number;
                EBCDIC string1 Payment_Origin;
                EBCDIC string1 Payment_Balanced;
          end;*/      
       end;
 
       export Inspection_rec := record,maxlength(75000)
          EBCDIC string1       Continuation_Flag;
          EBCDIC string1       History_Flag;
          big_endian unsigned4 Last_Activity_Date;
          EBCDIC string1       Fed_State_Flag;
          EBCDIC string1       Previous_Activity_Type;
          big_endian unsigned4 Previous_Activity_Number;
          big_endian unsigned4 Activity_Number;
          EBCDIC string2       Region_Code;
          EBCDIC string3       Area_Code;
          EBCDIC string2       Office_Code;
          EBCDIC string5       Compliance_Officer_ID;
          EBCDIC string1       Compliance_Officer_Job_Title;
          EBCDIC string4       Hist_Area;
          EBCDIC string5       Hist_Report_Number;
          EBCDIC string30      Inspected_Site_Name;
          EBCDIC string30      Inspected_Site_Street;
          EBCDIC string2       Inspected_Site_State;
          decimal5             Inspected_Site_Zip;
          big_endian unsigned2 Inspected_Site_City_Code;
          decimal3             Inspected_Site_County_Code;
          big_endian unsigned4 DUNS_Number;
          EBCDIC string17      Host_Establishment_key;
          EBCDIC string1       Owner_Type;
          big_endian unsigned2 Owner_Code;
          EBCDIC string1       Advance_Notice_Flag;
          big_endian unsigned4 Inspection_Opening_Date;
          big_endian unsigned4 Inspection_Close_Date;
          EBCDIC string1       Safety_Health_Flag;
          big_endian unsigned2 SIC_Code;
          big_endian unsigned2 SIC_Guide;
          big_endian unsigned2 SIC_Inspected;
          EBCDIC string6       NAICS_Code;
          EBCDIC string6       NAICS_Secondary_Code;
          EBCDIC string6       NAIC_Inspected;
          EBCDIC string1       Inspection_Type;
          EBCDIC string1       Inspection_Scope;
          decimal5             Number_In_Establishment;
          decimal5             Number_Covered;
          decimal7             Number_Total_Employees;
          EBCDIC string1       Walk_Around_Flag;
          EBCDIC string1       Employees_Interviewed_Flag;
          EBCDIC string1       Union_Flag; 
          EBCDIC string1       Closed_Case_Flag;
          EBCDIC string1       Why_No_Inspection_Code;
          big_endian unsigned4 Close_Case_Date;
          EBCDIC string1       Safety_PG_Manufacturing_Insp_Flag;
          EBCDIC string1       Safety_PG_Construction_Insp_Flag;
          EBCDIC string1       Safety_PG_Maritime_Insp_Flag;
          EBCDIC string1       Health_PG_Manufacturing_Insp_Flag;
          EBCDIC string1       Health_PG_Construction_Insp_Flag;
          EBCDIC string1       Health_PG_Maritime_Insp_Flag;
          EBCDIC string1       Migrant_Farm_Insp_Flag;
          EBCDIC string1       Antic_Served;
          big_endian unsigned4 First_Denial_Date;
          big_endian unsigned4 Last_Reenter_Date;
          decimal5_2           BLS_Loss_Workday_Injury_Rate;
          EBCDIC string1       Informal_SH_Program_Init_Flag;
          EBCDIC string1       Informal_Data_Required;
          big_endian unsigned4 Penalties_Due_Date;
          big_endian unsigned4 FTA_Due_Date;
          EBCDIC string1       Due_Date_Type;
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
          big_endian unsigned2 Number_Program;
          big_endian unsigned2 Number_Rel_Activity;
          big_endian unsigned2 Number_Optional_Info;
          big_endian unsigned2 Number_Debt;
          big_endian unsigned2 Number_Violations;
          big_endian unsigned2 Number_Event;
          big_endian unsigned2 Number_Hazardous_Substance;
          big_endian unsigned2 Number_Accident;
          big_endian unsigned2 Number_Admin_Pay;
          // Program child dataset
          // IfBlock((big_endian unsigned2)self.Number_Program <> 0)
                dataset(Program_rec
                       ,count(self.Number_Program)) Programs;
          // end;
          // Related Activity child dataset
          // IfBlock((big_endian unsigned2)self.Number_Rel_Activity <> 0)
                dataset(Related_Activity_rec
                       ,count(self.Number_Rel_Activity)) Related_Activties;
          // end;
          // Optional Information child dataset
          // IfBlock((big_endian unsigned2)self.Number_Rel_Activity <> 0)
                dataset(Optional_Info_rec
                       ,count(self.Number_Optional_Info)) Optional_Information;
          // end;
          // Debt child dataset
          // IfBlock((big_endian unsigned2)self.Number_Debt <> 0)
                dataset(Debt_rec
                       ,count(self.Number_Debt)) Debts;
          // end;
          // Violations child dataset
          // IfBlock((big_endian unsigned2)self.Number_Violations <> 0)
                dataset(Violations_rec
                       ,count(self.Number_Violations)) Violations;
          // end;
          // Event child dataset
          // IfBlock((big_endian unsigned2)self.Number_Event <> 0)
                dataset(Penalty_FTA_Event_rec
                       ,count(self.Number_Event)) Events;
          // end;
          // Hazardous Substance child dataset
          // IfBlock((big_endian unsigned2)self.Number_Hazardous_Substance <> 0)
                dataset(Hazardous_Substance_rec
                       ,count(self.Number_Hazardous_Substance)) Hazardous_Substances;
          // end;
          // Accident child dataset
          // IfBlock((big_endian unsigned2)self.Number_Accident <> 0)
                dataset(Accident_rec
                       ,count(self.Number_Accident)) Accidents;
          // end;
          // Administrative/Payment child dataset
          // IfBlock((big_endian unsigned2)self.Number_Admin_Pay <> 0)
                dataset(Administrative_Payment_rec
                       ,count(self.Number_Admin_Pay)) Admin_Payment;
          // end;
 
          // Filler at the end of each record
        // EBCDIC string2 Inspection_Filler;  //commented on 20090527 SNARRA
		#warning('Note last field (EBCDIC string2 Inspection_Filler) in OSHAIR.layout_OSHAIR_in is commented out')
       end; // End of the parent record
 
end;  // End of the whole module
