
IMPORT SearchPoint_Services;

EXPORT layouts := MODULE

export Practitioner := MODULE
	     export BatchService := MODULE
		 
		   export layout_in := RECORD
			   unsigned8 seq := 0;
			   string30  acctno;
			   string10  dea_number;						 
				 string4   max_results := ''; 
			 end;
			 
		   export MATCHTYPES := ['PR','FAC','INV','N/A'];  // for matchType below
   
	     // INV - invalid DEA Number
			 // PR - matched CMC or matched DEA
			 // FAC - not used for a match against facilities data
	       // taken care of by the other batch service SearchPoint_Services.Outlet_Batch_Service
       // N/A - not matched the default
				 
			 export layout_out := record
			   string30  acctno;
				 
			   string10  dea_number;
			   unsigned6 did;				 				   
				 string80 Practitioner_Name;
				 string30 Area_of_Practice;
				 string15 Practitioner_sched;
				 string3 Practitioner_zip3;
				 integer Practitioner_DEA_Active_Flg;
				 integer Practitioner_DEA_Expired_Flg;
				 integer Practitioner_Discipline_Flg;
				 integer Practitioner_Discipline_St_Flg;
				 integer Practitioner_St_Lic_Active_Flg;
				 integer Practitioner_St_Expired_Flg;
				 integer Practitioner_BLJ_Flg;
				 integer Practitioner_Crim_Hist_Flg;
				 integer Practitioner_Dead_Flg;
				 string3 MatchType;
				 string5 Practitioner_Zip5;		
				 string10 gennum;
			 end;
			 
			 export layout_out_batch := record		
			   string30 acctno;
			   string10 IMS_DEA;
			   string14 gennum;				 				   
				 string80 Practitioner_Name;
				 string30 Area_of_Practice;
				 string15 Practitioner_sched;
				 string3 Practitioner_zip3;
				 integer Practitioner_DEA_Active_Flg;
				 integer Practitioner_DEA_Expired_Flg;
				 integer Practitioner_Discipline_Flg;
				 integer Practitioner_Discipline_St_Flg;
				 integer Practitioner_St_Lic_Active_Flg;
				 integer Practitioner_St_Expired_Flg;
				 integer Practitioner_BLJ_Flg;
				 integer Practitioner_Crim_Hist_Flg;
				 integer Practitioner_Dead_Flg;
				 string3 MatchType;
				 string5 Practitioner_Zip5;						 							 
			 end;
		 		 
		 export layout_out_matchcodes := RECORD
		   string30  acctno;
			   string10  dea_number;
			   unsigned6 did;				 				   
				 string80 Practitioner_Name;
				 string30 Area_of_Practice;
				 string15 Practitioner_sched;
				 string3 Practitioner_zip3;
				 integer Practitioner_DEA_Active_Flg;
				 integer Practitioner_DEA_Expired_Flg;
				 integer Practitioner_Discipline_Flg;
				 integer Practitioner_Discipline_St_Flg;
				 integer Practitioner_St_Lic_Active_Flg;
				 integer Practitioner_St_Expired_Flg;
				 integer Practitioner_BLJ_Flg;
				 integer Practitioner_Crim_Hist_Flg;
				 integer Practitioner_Dead_Flg;
				 string3 MatchType;
				 string5 Practitioner_Zip5;				 				
			 unsigned6 providerId;
		   boolean ingenixMatch;
			 boolean cnlPracticeMatch;		
			 boolean deaMatch;
			 boolean BankruptcyFlag;
			 boolean LiensFlag;
			 boolean CrimFlag;
			 boolean DeadFlag;
			 boolean isDeaValid;
			 unsigned6 bdid;
			 string10 gennum;
			 string8 address_date;			 		   
		 end;
	 
	 end; // batch service
	 end; // practioner.
   
   EXPORT Outlet := MODULE
		 
		 export BatchService := MODULE
		 
		   export layout_in := RECORD
			   unsigned8 seq := 0;
			   string30  acctno;
			   string10  dea_number;	
				 string10  ncpdp_number;
				 string10  ims_id;
				 string4   max_results := ''; 
			 end;
			 
		   export MATCHTYPES := ['1','2','3','4','5','3b','4b'];  // for matchType below
			 
			  // 1 - Full Match - both NCPDP and DEA match with the same gennum
					// 2 - Split Match - NCPDP and DEA match but with different gennums
					// 3 - NCPDP Only Match- ncpdp matches but dea number does not			 
					// 4 - DEA Only Match - dea number matches fac_denorm but not the ncpdp			 
					// 5 - No Match -
			
			 export layout_out := record
			   string30  acctno;
			   string10  dea_number;	
				 string10  ncpdp_number;
			   string10  gennum; // IMS outlet ID				 				 			 				  				 
				 string2   MatchType;	
				 unsigned6 bdid;
			 end;
     						 
			 export layout_out_batch := RECORD	
			   string30  acctno;
			   string2   MatchType;
				 string10  IMS_ID; //gennum; // IMS outlet ID			
				 string10  IMS_NCPDP; //ncpdp_number;
			   string10  IMS_DEA; //dea_number;		 				 			 				  				 				 	
				 string10  PharmacyId; 
			  end;
		 		 
		 export layout_out_matchcodes := RECORD
		   string30  acctno;
			 string10  dea_number;	
			 string10  ncpdp_number;
			 unsigned6 bdid; 				 				 			 				  				 
			 string2 MatchType;			
			 unsigned6 bdiddea;
			 unsigned6 bdidncpdp;
			 unsigned6 providerId;
		   boolean NCPDPMatch;
			 boolean DeaMatch;		
			 boolean cnlfacilityMatch;  
			 string8 ExpirationDate;
			 string10 gennum; // IMS outlet ID
			 string10 ims_id; // intermediate fields to carry along the ims_id field
       string10  CNLD_PharmacyId; // pharmacy ID #
       string10  NCPDP_PharmacyId;
		 end;
	 end;
   
		 
		 EXPORT SearchService := 
			MODULE
   		// Outlet Summary Layout   
				EXPORT layout_summary := RECORD
            STRING outletID;
            STRING chain;
            STRING outletType;
            STRING hospitalLocation;
            STRING ncpdpNumber;
            STRING npiNumber;
            STRING organizationName;
            STRING ownerName;
        END;

         // Outlet Response Output Layout
	      EXPORT layout_response := RECORD     // Output definition.
            STRING error_code;
            STRING error_message;
            STRING query_date;
            DATASET(layout_summary) outletSummary;
        END;
     END; // End Outlet Search Service Layouts
	

		 EXPORT ReportService :=
				MODULE
					
					//Outlet Report Service Address Layout
					EXPORT layout_outlet_address := RECORD
							STRING address1;
							STRING address2;
							STRING city;
							STRING fax;
							STRING phone;
							STRING state;
							STRING zip;
							STRING status;
							STRING addressType;
							STRING addressRank;
					END;
		
					// Outlet Report Service DEA Number Layout
					EXPORT layout_outlet_DEANumber := RECORD
							STRING expirationDate;
							STRING number;
							STRING schedule;
					END;

					 // Outlet Report Service federalNumber Layout 
					EXPORT layout_federalNumber := RECORD
							STRING number;
							STRING type;
					END;

					// Outlet Report Service Sanctions Layout
					EXPORT layout_Sanction := RECORD
						 STRING amount;
						 STRING sanctionCase;
						 STRING sanctionDate;
						 STRING state;
					END;

					// Outlet Report Service Santions Layout
					EXPORT layout_stateLicense := RECORD
						 STRING expirationDate;
						 STRING number;
						 STRING state;
						 STRING status;
						 STRING type;
					END;

					// Outlet Report Service Survey Layout
					EXPORT layout_survey := RECORD
						 STRING code;
						 STRING rate;
						 STRING status;
						 STRING surveyDate;
						 STRING type;
					END;

					// Outlet Report Service Layout
					EXPORT layout_outlet := RECORD
						 STRING chain;
						 STRING chainID;
						 DATASET(layout_outlet_address) outletAddress;
						 DATASET(layout_outlet_DEANumber) outletDEANumber;
						 STRING outletType;
						 DATASET(layout_federalNumber) federalNumber;
						 STRING hospitalLocation;
						 STRING ncpdpNumber;
						 STRING npiNumber;
						 STRING organizationName;
						 STRING ownerName;
						 DATASET(layout_Sanction) sanction;
						 DATASET(layout_stateLicense) stateLicense;
						 DATASET(layout_survey) survey;
					END;
					
					// Output definition 
					EXPORT layout_outlet_detail_response := RECORD  
						 STRING error_code;
						 STRING error_message;
						 STRING query_date;
						 DATASET(layout_outlet) outlet;
					END;
		 END; 
	 END;// End Oulet Report Service 


   EXPORT practitionerSearch := 
	   MODULE
                    
      // record definition
      EXPORT all_data_needed_for_penalization :=
         RECORD
            STRING3   prefix;
            STRING	  firstName;
            STRING	  middleName;
            STRING	  lastName;
            STRING7	  suffix;
            STRING6	  gender;
            STRING	  address;
            STRING	  address2;
            STRING	  city;
            STRING2	  state;
            STRING5	  zip;
            STRING4 	extZip; 
            STRING8	  birthdate;
            STRING12  practitionerID;
            STRING10	phoneNumber;
            STRING9	  ssn;
            STRING8   dt_last_seen;
            INTEGER   addrPenalt;
            INTEGER   namePenalt;
            INTEGER   phonePenalt;
            INTEGER   ssnPenalt;
            INTEGER   AddrRank;
            INTEGER   source;  // 1=Ingenix (preferred source), 2=NCPDP, 3=CNLD (dead (no longer updating) source
         END;
 
 
         EXPORT layout_summary := 
            RECORD
				   STRING address1;
               STRING address2;
               STRING city;
               STRING dateOfBirth;
               STRING gender;
               STRING pharmacistId;
               STRING firstName;
               STRING middleName;
               STRING lastName;
               STRING nameSuffix; 
               STRING state;
               STRING zip;
            END;

         // Output definition.
			EXPORT layout_response := 
			   RECORD  
               STRING error_code;
               STRING error_message;
               STRING query_date;
               DATASET(layout_summary) 
                   practitionerSummary;
            END;
	      END;  // End Practitioner Search Service
	

   EXPORT practitionerReport := 
	   MODULE
		   
         ///////////////////////////////////
      EXPORT all_data_needed :=
         RECORD
            STRING   BankruptcyLienJudgementHistory;
            STRING60 StreetAddress1;
            STRING60 StreetAddress2;
            STRING25 City;
            STRING2  State;
            STRING5  Zip5;
            STRING4  Zip4;
            STRING18 County;
            STRING14 Fax;
            STRING14 Phone;
            STRING   Status;
            STRING   AddressType;
            STRING1  AddressRank;
            STRING   CriminalHistory;
            STRING8  DateOfBirth;
            STRING8  DateOfDeath;
            STRING12 PractitionerId;
            STRING3  prefix;
            STRING	firstName;
            STRING	middleName;
            STRING	lastName;
            STRING	suffix;
            STRING	gender;
            STRING   t_AdditionalMedTraining_Category;
            STRING   t_AdditionalMedTraining_EndDate;
            STRING   t_AdditionalMedTraining_Institute;
            STRING   t_AdditionalMedTraining_StartDate;
            STRING60 t_DEANumber_AddressStreetAddress1;
            STRING60 t_DEANumber_AddressStreetAddress2;
            STRING25 t_DEANumber_AddressCity;
            STRING2  t_DEANumber_AddressState;
            STRING5  t_DEANumber_AddressZip5;
            STRING4  t_DEANumber_AddressZip4;
            STRING   t_DEANumber_ExpirationDate;
            STRING   t_DEANumber_Number;
            STRING   t_DEANumber_Schedule;
            STRING   t_Education_Degree;
            STRING   t_Education_School;
            STRING   t_Education_YearGraduated;
            STRING   PractitionerSpecialty;
            STRING   t_StateLicense_ExpirationDate;
            STRING   t_StateLicense_Number;
            STRING   t_StateLicense_State;
            STRING   t_StateLicense_Status;
            STRING   t_StateLicense_Type;
            STRING   PractitionerTaxID;
            STRING   PractitionerType;
            STRING   t_Sanction_Action;
            STRING   t_Sanction_Amount;
            STRING   t_Sanction_Complaint;
            STRING   t_Sanction_DocumentumId;
            STRING   t_Sanction_SanctionCase;
            STRING   t_Sanction_SanctionDate;
            STRING   t_Sanction_SanctionSource;
            STRING   t_Sanction_SanctionType;
            STRING   t_Sanction_State;
	         INTEGER  t_Sanction_DocumentPages;
            STRING   PractitionerStatus;
            STRING   SSN;
            STRING   Upin;
            STRING   NpiNumber;
         END;
         ///////////////////////////////////
       
        // Practitioner Report Service Address layout
			EXPORT layout_address := 
			   RECORD
               STRING address1;
               STRING address2;
               STRING city;
               STRING fax;
               STRING phone;
               STRING state;
               STRING zip;
               STRING status;
               STRING addressType;
               STRING addressRank;
            END;

         // Practitioner Report Service ??? layout
			EXPORT layout_addl_med_trng:= 
			   RECORD
               STRING category;
               STRING endDate;
               STRING institute;
               STRING startDate;
            END;

         // Practitioner Report Service DEA Address layout
			EXPORT layout_DEAAddress := 
			   RECORD
               STRING address1;
               STRING address2;
               STRING city;
               STRING state;
               STRING zip;  
            END;

         // Practitioner Report Service DEA Number layout
			EXPORT layout_DEA_number := 
			   RECORD
               DATASET(layout_DEAAddress) deaAddress;
               STRING expirationDate;
               STRING number;
               STRING schedule;
            END;

         // Practitioner Report Service education layout
			EXPORT layout_education := 
			   RECORD
               STRING degree;
               STRING school;
               STRING yearGgraduated;
            END;

         // Practitioner Report Service State License layout
			EXPORT layout_state_license := 
			   RECORD
               STRING expirationDate;
               STRING number;
               STRING state;
               STRING status;
            END;

         // Practitioner Report Service Sanction layout
			EXPORT layout_sanction := 
			   RECORD
               STRING action;
               STRING amount;
               STRING complaint;
               STRING documentumId;
               STRING sanctionCase;
               STRING sanctionDate;
               STRING sanctionSource;
               STRING sanctionType;
               STRING state;
               STRING documentPages;
            END;

         // Practitioner Report Service layout
			EXPORT layout_practitioner := 
			   RECORD
               STRING chain;
               STRING chainID;
               DATASET(layout_address) address;
               STRING dateOfBirth;
               STRING dateOfDeath;
               STRING firstName;
               STRING gender;
               STRING pharmacistId;
               STRING middleName;
               STRING lastName;
               STRING nameSuffix;
               DATASET(layout_addl_med_trng) practitionerAddlMedicalTraining;
               DATASET(layout_DEA_number ) practitionerDEANumber;
               DATASET(layout_education) practitionerEducation;
               STRING practitionerSpecialty;
               DATASET(layout_state_license) practitionerStateLicense;
               STRING practitionerTaxID;
               DATASET(layout_sanction) practitionerSanction;
               STRING practitionerStatus;
               STRING ssn;
               STRING upin;
               STRING npi_number;
            END;

         // Practitioner Report Service Output Definition layout
			EXPORT layout_detail_response := 
			   RECORD 
               STRING error_code;
               STRING error_message;
               STRING query_date;
               DATASET(layout_practitioner) practitioner;
            END;
      
		END; // Pratitioner
	


   END;