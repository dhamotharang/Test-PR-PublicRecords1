import AID;

EXPORT Layouts := MODULE

	EXPORT DEA	:=	record
		string10	gennum;              				// Unique provider identification number
		string9		deanbr;             	
		string8		deanbr_exp;
		string7		deanbr_sch;
		string1		deanbr_code;
	end;		

	EXPORT ADDR	:=	record		
		string10	gennum;					// Unique provider identification number
		string6		upin_num;				// HCFA Provider Number
		string1 	provstat;				// Prescriber Status (D=Deceased, R=Retired)
		string10  provStatDesc;	
		string1 	gender;					// Gender
		string25	lastName;				// Last Name
		string20	firstName;			// First Name
		string20	middleName;			// Middle Name
		string6		suffix;					// Name Suffix
		string3		generation;			// Name suffix generation
		string8		dob;						// Date Of Birth
		string4		prescriberType;	// Type of prescriber
		string10	address_addrid;
		string55	address_line1;
		string55	address_line2;	
		string30	address_city;   
		string2 	address_st; 		
		string5		address_zip;        	
		string5		address_zip4; 		
		string25	address_country;			
		string10	address_phone;
		string10	address_fax;        	
		string8		address_date;        
		string1		address_status;  
		string5		address_source;			
		string1		address_type;	
		string1		address_rank;   
		string10	SSN;									
		string10	NPI;					
		string8		ABMSID;	
		string1		profstat;				// Provider Status (A=Active, I = Inactive)
		string10	profStatDesc;
	end;	
	
	EXPORT TAX	:=	record
	  string10	gennum;					// Unique provider identification number	
		string10	Tax_ID;
	end;
	
	EXPORT LIC	:=	record
		string10	gennum; 
		string2		st_lic_in;      // State License Number State
    string15	st_lic_num;     // State License Number 
    string8		st_lic_num_exp;	// State License Number Date Expire, fmt YYYYMMDD
    string3		st_lic_stat;    // State License Status (A=Active)
		string10	licStatDesc;				
    string10	st_lic_type;    // State License Type
    string10	st_lic_issue;   // State License Issue Date
    string8		st_lic_source;  // State License Source
	end;
	
	EXPORT Specialty	:=	record
		string10	gennum; 
		string3		specialty_code;
	end;
	
	EXPORT Sanction	:=	record
		string10	gennum; 
		string8		sanction_date; 		// Date Sanction
		string2		sanction_state;		// State Sanction Occurred
		string30	sanction_case;		// Sanction Case Number
		string11	sanction_id;			// Sanction ID
		string10	sanction_docid;		// Sanction Document ID
		string5		sanction_source;	// Sanction Source
		string5		sanction_type;		// Sanction Type
	end;	
	
	EXPORT School	:=	record
		string10	gennum;            // Unique provider identification number
		string10	degree;             	
		string5		schoolCode;
		string4		schoolyear;
	end;	
	
	EXPORT Training	:=	record
		string10	gennum;           // Unique provider identification number
		string1		train_category;   // Training (I=Intern, R= Resident, F=Fellow)
		string10	trainCatDesc;
		string10	train_startdate;	// Start Date of Training Info
		string10	train_enddate;		// End Date of Training Info
		string5		train_institute;	// Training Institution
	end;		
			
	EXPORT Input := record
	  string10	gennum;              	// Unique provider identification number
		string9		deanbr1;             	// DEA Number 1
		string9		deanbr2;             	// DEA Number 2
		string9		deanbr3;             	// DEA Number 3
		string9		deanbr4;             	// DEA Number 4
		string9		deanbr5;             	// DEA Number 5
		string9		deanbr6;             	// DEA Number 6
		string9		deanbr7;             	// DEA Number 7
		string9		deanbr8;             	// DEA Number 8
		string9		deanbr9;             	// DEA Number 9
		string9		deanbr10;            	// DEA Number 10
		string8		deanbr_exp1;         	// DEA Number 1 Date Expire, fmt YYYYMMDD
		string8		deanbr_exp2;         	// DEA Number 2 Date Expire, fmt YYYYMMDD
		string8		deanbr_exp3;         	// DEA Number 3 Date Expire, fmt YYYYMMDD
		string8		deanbr_exp4;         	// DEA Number 4 Date Expire, fmt YYYYMMDD
		string8		deanbr_exp5;         	// DEA Number 5 Date Expire, fmt YYYYMMDD
		string8		deanbr_exp6;         	// DEA Number 6 Date Expire, fmt YYYYMMDD
		string8		deanbr_exp7;         	// DEA Number 7 Date Expire, fmt YYYYMMDD
		string8		deanbr_exp8;         	// DEA Number 8 Date Expire, fmt YYYYMMDD
		string8		deanbr_exp9;         	// DEA Number 9 Date Expire, fmt YYYYMMDD
		string8		deanbr_exp10;        	// DEA Number 10 Date Expire , fmt YYYYMMDD
		string7		deanbr_sch1;         	// DEA Number 1 Sched 1 2 2n 3 3n 4 5
		string7		deanbr_sch2;         	// DEA Number 2 Sched 1 2 2n 3 3n 4 5
		string7		deanbr_sch3;         	// DEA Number 3 Sched 1 2 2n 3 3n 4 5
		string7		deanbr_sch4;         	// DEA Number 4 Sched 1 2 2n 3 3n 4 5
		string7		deanbr_sch5;         	// DEA Number 5 Sched 1 2 2n 3 3n 4 5
		string7		deanbr_sch6;         	// DEA Number 6 Sched 1 2 2n 3 3n 4 5
		string7		deanbr_sch7;         	// DEA Number 7 Sched 1 2 2n 3 3n 4 5
		string7		deanbr_sch8;         	// DEA Number 8 Sched 1 2 2n 3 3n 4 5
		string7		deanbr_sch9;         	// DEA Number 9 Sched 1 2 2n 3 3n 4 5
		string7		deanbr_sch10;        	// DEA Number 10 Sched 1 2 2n 3 3n 4 5
		string1		deanbr_code1;        	// DEA Number 1 Business Activity Code
		string1		deanbr_code2;        	// DEA Number 2 Business Activity Code
		string1		deanbr_code3;        	// DEA Number 3 Business Activity Code
		string1		deanbr_code4;        	// DEA Number 4 Business Activity Code
		string1		deanbr_code5;        	// DEA Number 5 Business Activity Code
		string1		deanbr_code6;        	// DEA Number 6 Business Activity Code
		string1		deanbr_code7;        	// DEA Number 7 Business Activity Code
		string1		deanbr_code8;        	// DEA Number 8 Business Activity Code
		string1		deanbr_code9;        	// DEA Number 9 Business Activity Code
		string1		deanbr_code10;       	// DEA Number 10 Business Activity Code
		string6		upin_num;						 	// HCFA Provider Number
		string1 	provstat;							// Prescriber Status (D=Deceased, R=Retired)
		string1 	gender;								// Gender
		string25	lastName;							// Last Name
		string20	firstName;						// First Name
		string20	middleName;						// Middle Name
		string6		suffix;								// Name Suffix
		string3		generation;						// Name suffix generation
		string8		dob;									// Date Of Birth
		string4		prescriberType;				// Type of prescriber
		string10	address1_addrid;     	// Top Address 1 Address ID
		string10	address2_addrid;     	// Top Address 2 Address ID
		string10	address3_addrid;     	// Top Address 3 Address ID
		string10	address4_addrid;     	// Top Address 4 Address ID
		string10	address5_addrid;     	// Top Address 5 Address ID
		string10	address6_addrid;     	// Top Address 6 Address ID
		string55	address1_line1;      	// Top Address 1 Line 1
		string55	address2_line1;      	// Top Address 2 Line 1
		string55	address3_line1;      	// Top Address 3 Line 1
		string55	address4_line1;      	// Top Address 4 Line 1
		string55	address5_line1;      	// Top Address 5 Line 1
		string55	address6_line1;      	// Top Address 6 Line 1		
		string55	address1_line2;       // Top Address 1 Line 2
		string55	address2_line2;       // Top Address 2 Line 2
		string55	address3_line2;       // Top Address 3 Line 2
		string55	address4_line2;       // Top Address 4 Line 2		
		string55	address5_line2;       // Top Address 5 Line 2
		string55	address6_line2;       // Top Address 6 Line 2		
		string30	address1_city;        // Top Address 1 City
		string30	address2_city;        // Top Address 2 City
		string30	address3_city;        // Top Address 3 City
		string30	address4_city;        // Top Address 4 City
		string30	address5_city;        // Top Address 5 City
		string30	address6_city;        // Top Address 6 City
		string2 	address1_st;          // Top Address 1 State
		string2 	address2_st;          // Top Address 2 State
		string2 	address3_st;          // Top Address 3 State
		string2 	address4_st;          // Top Address 4 State
		string2 	address5_st;          // Top Address 5 State
		string2 	address6_st;          // Top Address 6 State
		string5		address1_zip;        	// Top Address 1 Zip
		string5		address2_zip;        	// Top Address 2 Zip
		string5		address3_zip;        	// Top Address 3 Zip
		string5		address4_zip;        	// Top Address 4 Zip
		string5		address5_zip;        	// Top Address 5 Zip
		string5		address6_zip;        	// Top Address 6 Zip
		string5		address1_zip4;       	// Top Address 1 Zip4
		string5		address2_zip4;       	// Top Address 2 Zip4
		string5		address3_zip4;       	// Top Address 3 Zip4
		string5		address4_zip4;       	// Top Address 4 Zip4
		string5		address5_zip4;       	// Top Address 5 Zip4
		string5		address6_zip4;       	// Top Address 6 Zip4	
		string25	address1_country;			// Top Address 1 Country
		string25	address2_country;			// Top Address 2 Country
		string25	address3_country;			// Top Address 3 Country
		string25	address4_country;			// Top Address 4 Country
		string25	address5_country;			// Top Address 5 Country
		string25	address6_country;			// Top Address 6 Country
		string10	address1_phone;      	// Top Address 1 Phone
		string10	address2_phone;      	// Top Address 2 Phone
		string10	address3_phone;      	// Top Address 3 Phone
		string10	address4_phone;      	// Top Address 4 Phone
		string10	address5_phone;      	// Top Address 5 Phone
		string10	address6_phone;      	// Top Address 6 Phone
		string10	address1_fax;        	// Top Address 1 Fax
		string10	address2_fax;        	// Top Address 2 Fax
		string10	address3_fax;        	// Top Address 3 Fax
		string10	address4_fax;        	// Top Address 4 Fax
		string10	address5_fax;        	// Top Address 5 Fax
		string10	address6_fax;        	// Top Address 6 Fax
		string8		address1_date;        // Top Address 1 Date Record, fmt YYYYMMDD 
		string8		address2_date;        // Top Address 2 Date Record, fmt YYYYMMDD
		string8		address3_date;        // Top Address 3 Date Record, fmt YYYYMMDD
		string8		address4_date;        // Top Address 4 Date Record, fmt YYYYMMDD
		string8		address5_date;        // Top Address 5 Date Record, fmt YYYYMMDD
		string8		address6_date;        // Top Address 6 Date Record, fmt YYYYMMDD
		string1		address1_status;     	// Top Address 1 Status (A=Active)
		string1		address2_status;     	// Top Address 2 Status (A=Active)
		string1		address3_status;     	// Top Address 3 Status (A=Active)
		string1		address4_status;     	// Top Address 4 Status (A=Active)
		string1		address5_status;     	// Top Address 5 Status (A=Active)
		string1		address6_status;     	// Top Address 6 Status (A=Active)
		string30	address1_orgname;			// Top Addresss 1 Organization
		string30	address2_orgname;			// Top Addresss 2 Organization
		string30	address3_orgname;			// Top Addresss 3 Organization
		string30	address4_orgname;			// Top Addresss 4 Organization
		string30	address5_orgname;			// Top Addresss 5 Organization
		string30	address6_orgname;			// Top Addresss 6 Organization
		string5		address1_source;			// Top Addresss 1 Source
		string5		address2_source;			// Top Addresss 2 Source
		string5		address3_source;			// Top Addresss 3 Source
		string5		address4_source;			// Top Addresss 4 Source
		string5		address5_source;			// Top Addresss 5 Source
		string5		address6_source;			// Top Addresss 6 Source
		string1		address1_type;				// Top Addresss 1 Type (P=Prac, B=Bill, U=Unkn)
		string1		address2_type;				// Top Addresss 2 Type (P=Prac, B=Bill, U=Unkn)
		string1		address3_type;				// Top Addresss 3 Type (P=Prac, B=Bill, U=Unkn)
		string1		address4_type;				// Top Addresss 4 Type (P=Prac, B=Bill, U=Unkn)
		string1		address5_type;				// Top Addresss 5 Type (P=Prac, B=Bill, U=Unkn)
		string1		address6_type;				// Top Addresss 6 Type (P=Prac, B=Bill, U=Unkn)	
		string1		address1_rank;       	// Top Address Rank 1
		string1		address2_rank;       	// Top Address Rank 2
		string1		address3_rank;       	// Top Address Rank 3
		string1		address4_rank;       	// Top Address Rank 4
		string1		address5_rank;       	// Top Address Rank 5
		string1		address6_rank;       	// Top Address Rank 6
		string10	SSN;									// Social Security Number
		string10	NPI;									// NPI Number
		string10	Tax_ID_1;							// Federal Tax ID 1
		string10	Tax_ID_2;							// Federal Tax ID 2
		string10	Tax_ID_3;							// Federal Tax ID 3
		string2		st_lic_in1;          	// State License Number 1 State
		string2		st_lic_in2;          	// State License Number 2 State
		string2		st_lic_in3;          	// State License Number 3 State
		string2		st_lic_in4;          	// State License Number 4 State
		string2		st_lic_in5;          	// State License Number 5 State
		string2		st_lic_in6;          	// State License Number 6 State
		string2		st_lic_in7;          	// State License Number 7 State
		string2		st_lic_in8;          	// State License Number 8 State
		string2		st_lic_in9;          	// State License Number 9 State
		string2		st_lic_in10;         	// State License Number 10 State
    string15	st_lic_num1;         	// State License Number 1
    string15	st_lic_num2;         	// State License Number 2
    string15	st_lic_num3;         	// State License Number 3
    string15	st_lic_num4;         	// State License Number 4
    string15	st_lic_num5;         	// State License Number 5
    string15	st_lic_num6;         	// State License Number 6
    string15	st_lic_num7;         	// State License Number 7
    string15	st_lic_num8;         	// State License Number 8
    string15	st_lic_num9;         	// State License Number 9
    string15	st_lic_num10;        	// State License Number 10
    string8		st_lic_num_exp1;     	// State License Number 1 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp2;     	// State License Number 2 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp3;     	// State License Number 3 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp4;     	// State License Number 4 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp5;     	// State License Number 5 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp6;     	// State License Number 6 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp7;     	// State License Number 7 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp8;     	// State License Number 8 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp9;     	// State License Number 9 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp10;    	// State License Number 10 Date Expire, fmt YYYYMMDD
    string3		st_lic_stat1;        	// State License 1 Status (A=Active)
    string3		st_lic_stat2;        	// State License 2 Status (A=Active)
    string3		st_lic_stat3;        	// State License 3 Status (A=Active)
    string3		st_lic_stat4;        	// State License 4 Status (A=Active)
    string3		st_lic_stat5;        	// State License 5 Status (A=Active)
    string3		st_lic_stat6;        	// State License 6 Status (A=Active)
    string3		st_lic_stat7;        	// State License 7 Status (A=Active)
    string3		st_lic_stat8;        	// State License 8 Status (A=Active)
    string3		st_lic_stat9;        	// State License 9 Status (A=Active)
    string3		st_lic_stat10;       	// State License 10 Status (A=Active)
    string10	st_lic_type1;        	// State License 1 Type
    string10	st_lic_type2;        	// State License 2 Type
    string10	st_lic_type3;        	// State License 3 Type
    string10	st_lic_type4;        	// State License 4 Type
    string10	st_lic_type5;        	// State License 5 Type
    string10	st_lic_type6;        	// State License 6 Type
    string10	st_lic_type7;        	// State License 7 Type
    string10	st_lic_type8;        	// State License 8 Type                                        
    string10	st_lic_type9;        	// State License 9 Type
    string10	st_lic_type10;       	// State License 10 Type
    string10	st_lic_issue1;       	// State License 1 Issue Date
    string10	st_lic_issue2;       	// State License 2 Issue Date
    string10	st_lic_issue3;       	// State License 3 Issue Date
    string10	st_lic_issue4;       	// State License 4 Issue Date
    string10	st_lic_issue5;       	// State License 5 Issue Date
    string10	st_lic_issue6;       	// State License 6 Issue Date
    string10	st_lic_issue7;       	// State License 7 Issue Date
    string10	st_lic_issue8;       	// State License 8 Issue Date                                        
    string10	st_lic_issue9;       	// State License 9 Issue Date
    string10	st_lic_issue10;      	// State License 10 Issue Date		
    string8		st_lic_source1;      	// State License 1 Source
    string8		st_lic_source2;      	// State License 2 Source
    string8		st_lic_source3;      	// State License 3 Source
    string8		st_lic_source4;      	// State License 4 Source
    string8		st_lic_source5;      	// State License 5 Source
    string8		st_lic_source6;      	// State License 6 Source
    string8		st_lic_source7;      	// State License 7 Source
    string8		st_lic_source8;      	// State License 8 Source                                        
    string8		st_lic_source9;      	// State License 9 Source
    string8		st_lic_source10;     	// State License 10 Source		
		string3		specialty_code1;			// Specialty Code 1 from ABMS
		string3		specialty_code2;			// Specialty Code 2 from ABMS
		string3		specialty_code3;			// Specialty Code 3 from ABMS
		string3		specialty_code4;			// Specialty Code 4 from ABMS
		string3		specialty_code5;			// Specialty Code 5 from ABMS
		string8		ABMSID;								// ABMS Provider Number
		string2		certcode_abms1;				// ABMS Certification 1 Code
		string2		certcode_abms2;				// ABMS Certification 2 Code
		string2		certcode_abms3;				// ABMS Certification 3 Code
		string2		certcode_abms4;				// ABMS Certification 4 Code
		string2		certcode_abms5;				// ABMS Certification 5 Code
		string2		cert_start_abms1;			// ABMS Certification 1 Date 
		string2		cert_start_abms2;			// ABMS Certification 2 Date
		string2		cert_start_abms3;			// ABMS Certification 3 Date
		string2		cert_start_abms4;			// ABMS Certification 4 Date
		string2		cert_start_abms5;			// ABMS Certification 5 Date
		string2		cert_end_abms1;				// ABMS Certification 1 Expiration 
		string2		cert_end_abms2;				// ABMS Certification 2 Expiration
		string2		cert_end_abms3;				// ABMS Certification 3 Expiration
		string2		cert_end_abms4;				// ABMS Certification 4 Expiration
		string2		cert_end_abms5;				// ABMS Certification 5 Expiration		
		string1		cert_type_abms1;			// ABMS Initial or Re-certification
		string1		cert_type_abms2;			// ABMS Initial or Re-certification
		string1		cert_type_abms3;			// ABMS Initial or Re-certification
		string1		cert_type_abms4;			// ABMS Initial or Re-certification
		string1		cert_type_abms5;			// ABMS Initial or Re-certification
		string8		sanction_date1; 			// Date Sanction 1
		string8		sanction_date2;				// Date Sanction 2	
		string8		sanction_date3;				// Date Sanction 3	
		string8		sanction_date4;				// Date Sanction 4	
		string8		sanction_date5;				// Date Sanction 5	
		string8		sanction_date6;				// Date Sanction 6	
		string8		sanction_date7;				// Date Sanction 7	
		string8		sanction_date8;				// Date Sanction 8	
		string8		sanction_date9;				// Date Sanction 9	
		string8		sanction_date10;			// Date Sanction 10	
		string2		sanction_state1;			// State Sanction Occurred 1
		string2		sanction_state2;			// State Sanction Occurred 2	
		string2		sanction_state3;			// State Sanction Occurred 3	
		string2		sanction_state4;			// State Sanction Occurred 4	
		string2		sanction_state5;			// State Sanction Occurred 5	
		string2		sanction_state6;			// State Sanction Occurred 6	
		string2		sanction_state7;			// State Sanction Occurred 7	
		string2		sanction_state8;			// State Sanction Occurred 8	
		string2		sanction_state9;			// State Sanction Occurred 9	
		string2		sanction_state10;		  // State Sanction Occurred 10	
		string30	sanction_case1;				// Sanction 1 Case Number
		string30	sanction_case2;				// Sanction 2 Case Number	
		string30	sanction_case3;				// Sanction 3 Case Number	
		string30	sanction_case4;				// Sanction 4 Case Number	
		string30	sanction_case5;				// Sanction 5 Case Number	
		string30	sanction_case6;				// Sanction 6 Case Number	
		string30	sanction_case7;				// Sanction 7 Case Number	
		string30	sanction_case8;				// Sanction 8 Case Number	
		string30	sanction_case9;				// Sanction 9 Case Number	
		string30	sanction_case10;			// Sanction 10 Case Number	
		string11	sanction_id1;					// Sanction 1 ID
		string11	sanction_id2;					// Sanction 2 ID
		string11	sanction_id3;					// Sanction 3 ID
		string11	sanction_id4;					// Sanction 4 ID	
		string11	sanction_id5;					// Sanction 5 ID	
		string11	sanction_id6;					// Sanction 6 ID	
		string11	sanction_id7;					// Sanction 7 ID	
		string11	sanction_id8;					// Sanction 8 ID	
		string11	sanction_id9;					// Sanction 9 ID	
		string11	sanction_id10;				// Sanction 10 ID	
		string10	sanction_docid1;			// Sanction 1 Document ID
		string10	sanction_docid2;			// Sanction 2 Document ID	
		string10	sanction_docid3;			// Sanction 3 Document ID	
		string10	sanction_docid4;			// Sanction 4 Document ID	
		string10	sanction_docid5;			// Sanction 5 Document ID	
		string10	sanction_docid6;			// Sanction 6 Document ID	
		string10	sanction_docid7;			// Sanction 7 Document ID	
		string10	sanction_docid8;			// Sanction 8 Document ID	
		string10	sanction_docid9;			// Sanction 9 Document ID	
		string10	sanction_docid10;			// Sanction 10 Document ID
		string5		sanction_source1;			// Sanction 1 Source
		string5		sanction_source2;			// Sanction 2 Source	
		string5		sanction_source3;			// Sanction 3 Source	
		string5		sanction_source4;			// Sanction 4 Source	
		string5		sanction_source5;			// Sanction 5 Source	
		string5		sanction_source6;			// Sanction 6 Source	
		string5		sanction_source7;			// Sanction 7 Source	
		string5		sanction_source8;			// Sanction 8 Source	
		string5		sanction_source9;			// Sanction 9 Source	
		string5		sanction_source10;		// Sanction 10 Source	
		string5		sanction_type1;				// Sanction 1 Type
		string5		sanction_type2;				// Sanction 2 Type	
		string5		sanction_type3;				// Sanction 3 Type	
		string5		sanction_type4;				// Sanction 4 Type	
		string5		sanction_type5;				// Sanction 5 Type	
		string5		sanction_type6;				// Sanction 6 Type	
		string5		sanction_type7;				// Sanction 7 Type	
		string5		sanction_type8;				// Sanction 8 Type	
		string5		sanction_type9;				// Sanction 9 Type	
		string5		sanction_type10;			// Sanction 10 Type	
		string10	degree1;							// Graduation degree 1
		string10	degree2;							// Graduation degree 2	
		string10	degree3;							// Graduation degree 3
		string5		schoolcode1;					// Medical School Code 1
		string5		schoolcode2;					// Medical School Code 1	
		string5		schoolcode3;					// Medical School Code 1	
		string4		schoolyear1;					// Year Graduated 1
		string4		schoolyear2;					// Year Graduated 2	
		string4		schoolyear3;					// Year Graduated 3	
		string1		train_category1;			// Training 1 (I=Intern, R= Resident, F=Fellow)
		string1		train_category2;			// Training 2 (I=Intern, R= Resident, F=Fellow)	
		string1		train_category3;			// Training 3 (I=Intern, R= Resident, F=Fellow)	
		string1		train_category4;			// Training 4 (I=Intern, R= Resident, F=Fellow)	
		string1		train_category5;			// Training 5 (I=Intern, R= Resident, F=Fellow)	
		string10	train_startdate1;			// Start Date of Training 1 Info
		string10	train_startdate2;			// Start Date of Training 2 Info	
		string10	train_startdate3;			// Start Date of Training 3 Info	
		string10	train_startdate4;			// Start Date of Training 4 Info	
		string10	train_startdate5;			// Start Date of Training 5 Info	
		string10	train_enddate1;				// End Date of Training 1 Info
		string10	train_enddate2;				// End Date of Training 2 Info	
		string10	train_enddate3;				// End Date of Training 3 Info	
		string10	train_enddate4;				// End Date of Training 4 Info	
		string10	train_enddate5;				// End Date of Training 5 Info	
		string5		train_institute1;			// Training Institution 1
		string5		train_institute2;			// Training Institution 2	
		string5		train_institute3;			// Training Institution 3	
		string5		train_institute4;			// Training Institution 4	
		string5		train_institute5;			// Training Institution 5	
		string1		profstat;							// Provider Status (A=Active, I = Inactive)
		string3 	profcode1;						// Profession Code 1
		string3 	profcode2;						// Profession Code 2	
		string3 	profcode3;						// Profession Code 3	
	end;

	EXPORT Temp1	:=	record
		DEA;
		ADDR - [gennum];
	end;
	
	EXPORT Temp2	:=	record
		temp1;
		TAX - [gennum];
	end;
	
	EXPORT Temp3	:=	record
		temp2;
		LIC - [gennum];
	end;
	
	EXPORT Temp4	:=	record
		temp3;	
		Specialty - [gennum];
	end;
	
	EXPORT Temp5	:=	record
		temp4;
		sanction - [gennum];
	end;
	
	EXPORT Temp6	:=	record
		temp5;
		School - [gennum];
	end;
	
	EXPORT Temp7	:=	record
		temp6;
		Training - [gennum];	
	end;
	
	EXPORT Temp	:=	record
		DEA;
		ADDR - [gennum];
		TAX - [gennum];
		LIC - [gennum];
		Specialty - [gennum];
		sanction - [gennum];
		School - [gennum];
		Training - [gennum];
		STRING100					Append_AddrLine1		:=	'';
		STRING50					Append_AddrLineLast	:=	'';
		AID.Common.xAID		Append_RawAID				:=	0;
		AID.Common.xAID		Append_AceAID				:=	0;		
	end;
	
	EXPORT Base	:=	record
		UNSIGNED8 Date_FirstSeen;
		UNSIGNED8 Date_LastSeen;
		UNSIGNED6 did 	:= 0;
		Temp;	
		string5   title;
		string20  fname;
		string20  mname;
		string20  lname;
		string5   name_suffix;
	end;	
	
	EXPORT	KeyBuild := RECORD
		Base;
		STRING10	prim_range; 
		STRING2		predir;	
		STRING28	prim_name;	
		STRING4		addr_suffix; 
		STRING2		postdir;	
		STRING10	unit_desig;	
		STRING8		sec_range;	
		STRING25	p_city_name;	
		STRING25	v_city_name; 
		STRING2		st;	
		STRING5		zip;	
		STRING4		zip4;	
		STRING4		cart;	
		STRING1		cr_sort_sz;	
		STRING4		lot;	
		STRING1		lot_order;	
		STRING2		dbpc;	
		STRING1		chk_digit;	
		STRING2		rec_type;	
		STRING2		fips_state;	
		STRING3		fips_county;	
		STRING10	geo_lat;	
		STRING11	geo_long;	
		STRING4		msa;	
		STRING7		geo_blk;	
		STRING1		geo_match;	
		STRING4		err_stat;		
	end;	
	
end;		