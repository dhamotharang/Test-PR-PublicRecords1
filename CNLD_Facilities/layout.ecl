export layout := RECORD
  	string10	gennum;              // Unique provider identification number
		string80  org_name;            // Organization or group name
		string10	storeno;             // Identifying number assigned to a facility within a chain
		string9		deanbr1;             // DEA Number 1
		string9		deanbr2;             // DEA Number 2
		string9		deanbr3;             // DEA Number 3
		string9		deanbr4;             // DEA Number 4
		string9		deanbr5;             // DEA Number 5
		string9		deanbr6;             // DEA Number 6
		string9		deanbr7;             // DEA Number 7
		string9		deanbr8;             // DEA Number 8
		string9		deanbr9;             // DEA Number 9
		string9		deanbr10;            // DEA Number 10
		string8		deanbr_exp1;         // DEA Number 1 Date Expire, fmt YYYYMMDD
		string8		deanbr_exp2;         // DEA Number 2 Date Expire, fmt YYYYMMDD
		string8		deanbr_exp3;         // DEA Number 3 Date Expire, fmt YYYYMMDD
		string8		deanbr_exp4;         // DEA Number 4 Date Expire, fmt YYYYMMDD
		string8		deanbr_exp5;         // DEA Number 5 Date Expire, fmt YYYYMMDD
		string8		deanbr_exp6;         // DEA Number 6 Date Expire, fmt YYYYMMDD
		string8		deanbr_exp7;         // DEA Number 7 Date Expire, fmt YYYYMMDD
		string8		deanbr_exp8;         // DEA Number 8 Date Expire, fmt YYYYMMDD
		string8		deanbr_exp9;         // DEA Number 9 Date Expire, fmt YYYYMMDD
		string8		deanbr_exp10;        // DEA Number 10 Date Expire , fmt YYYYMMDD
		string7		deanbr_sch1;         // DEA Number 1 Sched 1 2 2n 3 3n 4 5
		string7		deanbr_sch2;         // DEA Number 2 Sched 1 2 2n 3 3n 4 5
		string7		deanbr_sch3;         // DEA Number 3 Sched 1 2 2n 3 3n 4 5
		string7		deanbr_sch4;         // DEA Number 4 Sched 1 2 2n 3 3n 4 5
		string7		deanbr_sch5;         // DEA Number 5 Sched 1 2 2n 3 3n 4 5
		string7		deanbr_sch6;         // DEA Number 6 Sched 1 2 2n 3 3n 4 5
		string7		deanbr_sch7;         // DEA Number 7 Sched 1 2 2n 3 3n 4 5
		string7		deanbr_sch8;         // DEA Number 8 Sched 1 2 2n 3 3n 4 5
		string7		deanbr_sch9;         // DEA Number 9 Sched 1 2 2n 3 3n 4 5
		string7		deanbr_sch10;        // DEA Number 10 Sched 1 2 2n 3 3n 4 5
		string55	addr1_id;            // Address 1 ID
		string55	addr2_id;            // Address 2 ID
		string55	addr3_id;            // Address 3 ID
		string55	addr1_line1;         // Address 1 Line 1
		string55	addr2_line1;         // Address 2 Line 1
		string55	addr3_line1;         // Address 3 Line 1
		string55	addr1_line2;         // Address 1 Line 2
		string55	addr2_line2;         // Address 2 Line 2
		string55	addr3_line2;         // Address 3 Line 2
		string30	addr1_city;          // Address 1 City
		string30	addr2_city;          // Address 2 City
		string30	addr3_city;          // Address 3 City
		string2 	addr1_st;            // Address 1 State
		string2		addr2_st;            // Address 2 State
		string2		addr3_st;            // Address 3 State
		string5		addr1_zip;           // Address 1 Zip
		string5		addr2_zip;           // Address 2 Zip
		string5		addr3_zip;           // Address 3 Zip
		string10	addr1_phone;         // Address 1 Phone
		string10	addr2_phone;         // Address 2 Phone
		string10	addr3_phone;         // Address 3 Phone
		string10	addr1_fax;           // Address 1 Fax
		string10	addr2_fax;           // Address 2 Fax
		string10	addr3_fax;           // Address 3 Fax
		string8		addr1_date;          // Address 1 Date Record, fmt YYYYMMDD 
		string8		addr2_date;          // Address 2 Date Record, fmt YYYYMMDD
		string8		addr3_date;          // Address 3 Date Record, fmt YYYYMMDD
		string1		addr1_status;        // Address 1 Status (A=Active)
		string1		addr2_status;        // Address 2 Status (A=Active)
		string1		addr3_status;        // Address 3 Status (A=Active)
		string1		addr1_rank;          // Top Address Rank 1
		string1		addr2_rank;          // Top Address Rank 2
		string1		addr3_rank;          // Top Address Rank 3
		string2		st_lic_in1;          // State License Number 1 State
		string2		st_lic_in2;          // State License Number 2 State
		string2		st_lic_in3;          // State License Number 3 State
		string2		st_lic_in4;          // State License Number 4 State
		string2		st_lic_in5;          // State License Number 5 State
		string2		st_lic_in6;          // State License Number 6 State
		string2		st_lic_in7;          // State License Number 7 State
		string2		st_lic_in8;          // State License Number 8 State
		string2		st_lic_in9;          // State License Number 9 State
		string2		st_lic_in10;         // State License Number 10 State
		string2		st_lic_in11;         // State License Number 11 State
		string2		st_lic_in12;         // State License Number 12 State
		string2		st_lic_in13;         // State License Number 13 State
		string2		st_lic_in14;         // State License Number 14 State
		string2		st_lic_in15;         // State License Number 15 State
		string2		st_lic_in16;         // State License Number 16 State
		string2		st_lic_in17;         // State License Number 17 State
		string2		st_lic_in18;         // State License Number 18 State
		string2		st_lic_in19;         // State License Number 19 State
		string2		st_lic_in20;         // State License Number 20 State
		string2		st_lic_in21;         // State License Number 21 State
		string2		st_lic_in22;         // State License Number 22 State
		string2		st_lic_in23;         // State License Number 23 State
		string2		st_lic_in24;         // State License Number 24 State
		string2		st_lic_in25;         // State License Number 25 State
		string2		st_lic_in26;         // State License Number 26 State
		string2		st_lic_in27;         // State License Number 27 State
		string2		st_lic_in28;         // State License Number 28 State
		string2		st_lic_in29;         // State License Number 29 State
		string2		st_lic_in30;         // State License Number 30 State
		string2		st_lic_in31;         // State License Number 31 State
		string2		st_lic_in32;         // State License Number 32 State
		string2		st_lic_in33;         // State License Number 33 State
    string2		st_lic_in34;         // State License Number 34 State
    string2		st_lic_in35;         // State License Number 35 State
    string2		st_lic_in36;         // State License Number 36 State
    string2		st_lic_in37;         // State License Number 37 State
    string2		st_lic_in38;         // State License Number 38 State
    string2		st_lic_in39;         // State License Number 39 State
    string2		st_lic_in40;         // State License Number 40 State
    string2		st_lic_in41;         // State License Number 41 State
    string2		st_lic_in42;         // State License Number 42 State
    string2		st_lic_in43;         // State License Number 43 State
    string2		st_lic_in44;         // State License Number 44 State
    string2		st_lic_in45;         // State License Number 45 State
    string2		st_lic_in46;         // State License Number 46 State
    string2		st_lic_in47;         // State License Number 47 State
    string2		st_lic_in48;         // State License Number 48 State
    string2		st_lic_in49;         // State License Number 49 State
    string2		st_lic_in50;         // State License Number 50 State
    string15	st_lic_num1;         // State License Number 1
    string15	st_lic_num2;         // State License Number 2
    string15	st_lic_num3;         // State License Number 3
    string15	st_lic_num4;         // State License Number 4
    string15	st_lic_num5;         // State License Number 5
    string15	st_lic_num6;         // State License Number 6
    string15	st_lic_num7;         // State License Number 7
    string15	st_lic_num8;         // State License Number 8
    string15	st_lic_num9;         // State License Number 9
    string15	st_lic_num10;        // State License Number 10
    string15	st_lic_num11;        // State License Number 11
    string15	st_lic_num12;        // State License Number 12
    string15	st_lic_num13;        // State License Number 13
    string15	st_lic_num14;        // State License Number 14
    string15	st_lic_num15;        // State License Number 15
    string15	st_lic_num16;        // State License Number 16
    string15	st_lic_num17;        // State License Number 17
    string15	st_lic_num18;        // State License Number 18
    string15	st_lic_num19;        // State License Number 19
    string15	st_lic_num20;        // State License Number 20
    string15	st_lic_num21;        // State License Number 21
    string15	st_lic_num22;        // State License Number 22
    string15	st_lic_num23;        // State License Number 23
    string15	st_lic_num24;        // State License Number 24
    string15	st_lic_num25;        // State License Number 25
		string15	st_lic_num26;        // State License Number 26
    string15	st_lic_num27;        // State License Number 27
    string15	st_lic_num28;        // State License Number 28
    string15	st_lic_num29;        // State License Number 29
    string15	st_lic_num30;        // State License Number 30
    string15	st_lic_num31;        // State License Number 31
    string15	st_lic_num32;        // State License Number 32
    string15	st_lic_num33;        // State License Number 33
    string15	st_lic_num34;        // State License Number 34
    string15	st_lic_num35;        // State License Number 35
    string15	st_lic_num36;        // State License Number 36
    string15	st_lic_num37;        // State License Number 37
    string15	st_lic_num38;        // State License Number 38
    string15	st_lic_num39;        // State License Number 39
    string15	st_lic_num40;        // State License Number 40
    string15	st_lic_num41;        // State License Number 41
    string15	st_lic_num42;        // State License Number 42
    string15	st_lic_num43;        // State License Number 43
    string15	st_lic_num44;        // State License Number 44
    string15	st_lic_num45;        // State License Number 45
    string15	st_lic_num46;        // State License Number 46
    string15	st_lic_num47;        // State License Number 47
    string15	st_lic_num48;        // State License Number 48
    string15	st_lic_num49;        // State License Number 49
    string15	st_lic_num50;        // State License Number 50
    string8		st_lic_num_exp1;     // State License Number 1 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp2;     // State License Number 2 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp3;     // State License Number 3 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp4;     // State License Number 4 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp5;     // State License Number 5 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp6;     // State License Number 6 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp7;     // State License Number 7 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp8;     // State License Number 8 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp9;     // State License Number 9 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp10;    // State License Number 10 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp11;    // State License Number 11 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp12;    // State License Number 12 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp13;    // State License Number 13 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp14;    // State License Number 14 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp15;    // State License Number 15 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp16;    // State License Number 16 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp17;    // State License Number 17 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp18;    // State License Number 18 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp19;    // State License Number 19 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp20;    // State License Number 20 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp21;    // State License Number 21 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp22;    // State License Number 22 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp23;    // State License Number 23 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp24;    // State License Number 24 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp25;    // State License Number 25 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp26;    // State License Number 26 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp27;    // State License Number 27 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp28;    // State License Number 28 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp29;    // State License Number 29 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp30;    // State License Number 30 Date Expire, fmt YYYYMMDD                         
    string8		st_lic_num_exp31;    // State License Number 31 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp32;    // State License Number 32 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp33;    // State License Number 33 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp34;    // State License Number 34 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp35;    // State License Number 35 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp36;    // State License Number 36 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp37;    // State License Number 37 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp38;    // State License Number 38 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp39;    // State License Number 39 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp40;    // State License Number 40 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp41;    // State License Number 41 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp42;    // State License Number 42 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp43;    // State License Number 43 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp44;    // State License Number 44 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp45;    // State License Number 45 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp46;    // State License Number 46 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp47;    // State License Number 47 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp48;    // State License Number 48 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp49;    // State License Number 49 Date Expire, fmt YYYYMMDD
    string8		st_lic_num_exp50;    // State License Number 50 Date Expire, fmt YYYYMMDD
    string3		st_lic_stat1;        // State License 1 Status (A=Active)
    string3		st_lic_stat2;        // State License 2 Status (A=Active)
    string3		st_lic_stat3;        // State License 3 Status (A=Active)
    string3		st_lic_stat4;        // State License 4 Status (A=Active)
    string3		st_lic_stat5;        // State License 5 Status (A=Active)
    string3		st_lic_stat6;        // State License 6 Status (A=Active)
    string3		st_lic_stat7;        // State License 7 Status (A=Active)
    string3		st_lic_stat8;        // State License 8 Status (A=Active)
    string3		st_lic_stat9;        // State License 9 Status (A=Active)
    string3		st_lic_stat10;       // State License 10 Status (A=Active)
    string3		st_lic_stat11;       // State License 11 Status (A=Active)
    string3		st_lic_stat12;       // State License 12 Status (A=Active)
    string3		st_lic_stat13;       // State License 13 Status (A=Active)
    string3		st_lic_stat14;       // State License 14 Status (A=Active)
    string3		st_lic_stat15;       // State License 15 Status (A=Active)
    string3		st_lic_stat16;       // State License 16 Status (A=Active)
    string3		st_lic_stat17;       // State License 17 Status (A=Active)
    string3		st_lic_stat18;       // State License 18 Status (A=Active)
    string3		st_lic_stat19;       // State License 19 Status (A=Active)
    string3		st_lic_stat20;       // State License 20 Status (A=Active)
    string3		st_lic_stat21;       // State License 21 Status (A=Active)
    string3		st_lic_stat22;       // State License 22 Status (A=Active)
    string3		st_lic_stat23;       // State License 23 Status (A=Active)
    string3		st_lic_stat24;       // State License 24 Status (A=Active)
    string3		st_lic_stat25;       // State License 25 Status (A=Active)
    string3		st_lic_stat26;       // State License 26 Status (A=Active)
    string3		st_lic_stat27;       // State License 27 Status (A=Active)
    string3		st_lic_stat28;       // State License 28 Status (A=Active)
    string3		st_lic_stat29;       // State License 29 Status (A=Active)
    string3		st_lic_stat30;       // State License 30 Status (A=Active)
    string3		st_lic_stat31;       // State License 31 Status (A=Active)
    string3		st_lic_stat32;       // State License 32 Status (A=Active)
    string3		st_lic_stat33;       // State License 33 Status (A=Active)
    string3		st_lic_stat34;       // State License 34 Status (A=Active)
    string3		st_lic_stat35;       // State License 35 Status (A=Active)
    string3		st_lic_stat36;       // State License 36 Status (A=Active)
    string3		st_lic_stat37;       // State License 37 Status (A=Active)
    string3		st_lic_stat38;       // State License 38 Status (A=Active)
    string3		st_lic_stat39;       // State License 39 Status (A=Active)
    string3		st_lic_stat40;       // State License 40 Status (A=Active)
    string3		st_lic_stat41;       // State License 41 Status (A=Active)
    string3		st_lic_stat42;       // State License 42 Status (A=Active)
    string3		st_lic_stat43;       // State License 43 Status (A=Active)
    string3		st_lic_stat44;       // State License 44 Status (A=Active)
    string3		st_lic_stat45;       // State License 45 Status (A=Active)
    string3		st_lic_stat46;       // State License 46 Status (A=Active)
    string3		st_lic_stat47;       // State License 47 Status (A=Active)
    string3		st_lic_stat48;       // State License 48 Status (A=Active)
    string3		st_lic_stat49;       // State License 49 Status (A=Active)
    string3		st_lic_stat50;       // State License 50 Status (A=Active)
    string10	st_lic_type1;        // State License 1 Type
    string10	st_lic_type2;        // State License 2 Type
    string10	st_lic_type3;        // State License 3 Type
    string10	st_lic_type4;        // State License 4 Type
    string10	st_lic_type5;        // State License 5 Type
    string10	st_lic_type6;        // State License 6 Type
    string10	st_lic_type7;        // State License 7 Type
    string10	st_lic_type8;        // State License 8 Type                                        
    string10	st_lic_type9;        // State License 9 Type
    string10	st_lic_type10;       // State License 10 Type
    string10	st_lic_type11;       // State License 11 Type
    string10	st_lic_type12;       // State License 12 Type
    string10	st_lic_type13;       // State License 13 Type
    string10	st_lic_type14;       // State License 14 Type
    string10	st_lic_type15;       // State License 15 Type
    string10	st_lic_type16;       // State License 16 Type
    string10	st_lic_type17;       // State License 17 Type
    string10	st_lic_type18;       // State License 18 Type                                       
    string10	st_lic_type19;       // State License 19 Type
    string10	st_lic_type20;       // State License 20 Type
    string10	st_lic_type21;       // State License 21 Type
    string10	st_lic_type22;       // State License 22 Type
    string10	st_lic_type23;       // State License 23 Type
    string10	st_lic_type24;       // State License 24 Type
    string10	st_lic_type25;       // State License 25 Type
    string10	st_lic_type26;       // State License 26 Type
    string10	st_lic_type27;       // State License 27 Type
    string10	st_lic_type28;       // State License 28 Type
    string10	st_lic_type29;       // State License 29 Type
    string10	st_lic_type30;       // State License 30 Type
    string10	st_lic_type31;       // State License 31 Type
    string10	st_lic_type32;       // State License 32 Type
    string10	st_lic_type33;       // State License 33 Type
    string10	st_lic_type34;       // State License 34 Type
    string10	st_lic_type35;       // State License 35 Type
    string10	st_lic_type36;       // State License 36 Type
    string10	st_lic_type37;       // State License 37 Type
    string10	st_lic_type38;       // State License 38 Type
    string10	st_lic_type39;       // State License 39 Type
    string10	st_lic_type40;       // State License 40 Type
    string10	st_lic_type41;       // State License 41 Type
    string10	st_lic_type42;       // State License 42 Type
    string10	st_lic_type43;       // State License 43 Type
    string10	st_lic_type44;       // State License 44 Type
    string10	st_lic_type45;       // State License 45 Type
    string10	st_lic_type46;       // State License 46 Type
    string10	st_lic_type47;       // State License 47 Type
		string10	st_lic_type48;       // State License 48 Type
    string10	st_lic_type49;       // State License 49 Type
    string10	st_lic_type50;       // State License 50 Type
    string10	fednum1;             // Federal Number 1
    string10	fednum2;             // Federal Number 2
    string10	fednum3;             // Federal Number 3
    string10	fednum4;             // Federal Number 4
    string1		fednum_type1;        // Federal Number 1 Type (R=Medicare, D=Medicaid, E=EIN ,N=NPI)
    string1		fednum_type2;        // Federal Number 2 Type (R=Medicare, D=Medicaid, E=EIN ,N=NPI)
    string1		fednum_type3;        // Federal Number 3 Type (R=Medicare, D=Medicaid, E=EIN ,N=NPI)
    string1		fednum_type4;        // Federal Number 4 Type (R=Medicare, D=Medicaid, E=EIN ,N=NPI)
    string3		profcode;            // $FPROF. Code assigned to profession
    string1		profstat;            // Provider Status (A=Active, I=Inactive)
    string60	ownername;           // Owner of the facility
    string2		ownertype;           // $OWNTYPE. Type of ownership
    string10	ncpdpnbr1;           // NCPDP Number 1
    string10	ncpdpnbr2;           // NCPDP Number 2
    string10	ncpdpnbr3;           // NCPDP Number 3
    string10	npi1;                // NPI Number 1
    string10	npi2;                // NPI Number 2
    string10	npi3;                // NPI Number 3
    string2		factype;             // $FACTYPE.    Type of facility
    string1		inhospital;          // Indicates if this facility contained within a hospital
    string1		inchain;             // Indicates if this facility is part of a chain of facilities 
    string3		aff_code;            // $AFFCODE.    Code used to access the CMVAFFILIATION table
    string8		survey_date1;        // Survey Date 1, fmtYYYYMMDD
    string8		survey_date2;        // Survey Date 2, fmtYYYYMMDD
    string8		survey_date3;        // Survey Date 3, fmtYYYYMMDD
    string8		survey_date4;        // Survey Date 4, fmtYYYYMMDD
    string8		survey_date5;        // Survey Date 5, fmtYYYYMMDD
    string8		survey_date6;        // Survey Date 6, fmtYYYYMMDD
    string1		survey_type1;        // Survey Type 1
    string1		survey_type2;        // Survey Type 2
    string1		survey_type3;        // Survey Type 3
    string1		survey_type4;        // Survey Type 4
    string1		survey_type5;        // Survey Type 5
    string1		survey_type6;        // Survey Type 6
    string4		def_code1;           // Deficiency Code 1
    string4		def_code2;           // Deficiency Code 2
    string4		def_code3;           // Deficiency Code 3
    string4		def_code4;           // Deficiency Code 4
    string4		def_code5;           // Deficiency Code 5
    string4		def_code6;           // Deficiency Code 6
    string1		def_rate1;           // Deficiency Rating 1
    string1		def_rate2;           // Deficiency Rating 2
    string1		def_rate3;           // Deficiency Rating 3
    string1		def_rate4;           // Deficiency Rating 4
    string1		def_rate5;           // Deficiency Rating 5
    string1		def_rate6;           // Deficiency Rating 6
    string1		def_status1;         // Deficiency Status 1
    string1		def_status2;         // Deficiency Status 2
    string1		def_status3;         // Deficiency Status 3
    string1		def_status4;         // Deficiency Status 4
    string1		def_status5;         // Deficiency Status 5
    string1		def_status6;         // Deficiency Status 6
    string1		def_type1;           // Deficiency Type 1
    string1		def_type2;           // Deficiency Type 2
    string1		def_type3;           // Deficiency Type 3
    string1		def_type4;           // Deficiency Type 4
    string1		def_type5;           // Deficiency Type 5
    string1		def_type6;           // Deficiency Type 6
    string8		sanction_date1;      // Date Sanction 1, fmt YYYYMMDD
    string8		sanction_date2;      // Date Sanction 2, fmt YYYYMMDD
    string8		sanction_date3;      // Date Sanction 3, fmt YYYYMMDD
    string8		sanction_date4;      // Date Sanction 4, fmt YYYYMMDD
    string8		sanction_date5;      // Date Sanction 5, fmt YYYYMMDD
    string8		sanction_date6;      // Date Sanction 6, fmt YYYYMMDD
    string2		sanction_state1;     // State Sanction Occurred 1
    string2		sanction_state2;     // State Sanction Occurred 2
    string2		sanction_state3;     // State Sanction Occurred 3
    string2		sanction_state4;     // State Sanction Occurred 4
    string2		sanction_state5;     // State Sanction Occurred 5
    string2		sanction_state6;     // State Sanction Occurred 6
    string30	sanction_case1;      // Sanction 1 Case Number
    string30	sanction_case2;      // Sanction 2 Case Number
    string30	sanction_case3;      // Sanction 3 Case Number
    string30	sanction_case4;      // Sanction 4 Case Number
    string30	sanction_case5;      // Sanction 5 Case Number
    string30	sanction_case6;      // Sanction 6 Case Number
    unsigned integer	sanction_amt1;       // Sanction 1 Amount
    unsigned integer	sanction_amt2;       // Sanction 2 Amount
    unsigned integer	sanction_amt3;       // Sanction 3 Amount
    unsigned integer	sanction_amt4;       // Sanction 4 Amount
    unsigned integer	sanction_amt5;       // Sanction 5 Amount
    unsigned integer	sanction_amt6;       // Sanction 6 Amount
end;		