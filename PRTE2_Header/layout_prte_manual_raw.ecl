EXPORT layout_prte_manual_raw := module

EXPORT main := RECORD
        
        STRING link_dob;
        STRING link_ssn;
        STRING fname;
        STRING mname;
        STRING lname;
        STRING suffix;
        
        STRING alias1;
        STRING alias2;
        STRING alias3;
        STRING alias4;

        STRING dob;
        STRING ssn;

        STRING addr1;
        STRING addr2;
        STRING city;
        STRING st;
        STRING zip;

        STRING src;
        STRING phone;
        STRING email;
        
        STRING date_first_reported;
        STRING date_last_reported;
        STRING date_first_seen;
        STRING date_last_seen;
        STRING age_flag;
        
        STRING related_dob;
        STRING related_ssn;
        STRING related_title_cd;
        STRING related_desc;
        STRING Related_tier;
        
        STRING related_dob2;
        STRING related_ssn2;
        STRING related_title_cd2;
        STRING related_desc2;
        STRING Related_tier2;
        
        STRING related_dob3;
        STRING related_ssn3;
        STRING related_title_cd3;
        STRING related_desc3;
        STRING related_tier3;
        
        STRING related_dob4;
        STRING related_ssn4;
        STRING related_title_cd4;
        STRING related_desc4;
        STRING Related_tier4;
        
        STRING related_dob5;
        STRING related_ssn5;
        STRING related_title_cd5;
        STRING related_desc5;
        STRING Related_tier5;
        
        STRING risk_code;
        STRING SIC;
        STRING Prev1_addr;
        STRING Prev1_citystzip;
        STRING prev1_in_dt;
        STRING prev1_out_dt;
        STRING prevsrc1;
        
        STRING Prev2_addr;
        STRING Prev2_citystzip;
        STRING prev2_in_dt;
        STRING prev2_out_dt;
        STRING prevsrc2;

        STRING Prev3_addr;
        STRING Prev3_citystzip;
        STRING prev3_in_dt;
        STRING prev3_out_dt;
        STRING prevsrc3;
        
        STRING Prev4_addr;
        STRING Prev4_citystzip;
        STRING prev4_in_dt;
        STRING prev4_out_dt;
        STRING prevsrc4;

        STRING Prev5_addr;
        STRING Prev5_citystzip;
        STRING prev5_in_dt;
        STRING prev5_out_dt;
        STRING prevsrc5;

        STRING Prev6_addr;
        STRING Prev6_citystzip;
        STRING prev6_in_dt;
        STRING prev6_out_dt;
        STRING prevsrc6;

        STRING Prev7_addr;
        STRING Prev7_citystzip;
        STRING prev7_in_dt;
        STRING prev7_out_dt;
        STRING prevsrc7;

        STRING Prev8_addr;
        STRING Prev8_citystzip;
        STRING prev8_in_dt;
        STRING prev8_out_dt;
        STRING prevsrc8;

        STRING Prev9_addr;
        STRING Prev9_citystzip;
        STRING prev9_in_dt;
        STRING prev9_out_dt;
        STRING prevsrc9;

        STRING Prev10_addr;
        STRING Prev10_citystzip;
        STRING prev10_in_dt;
        STRING prev10_out_dt;
        STRING prevsrc10;

        STRING Filler1;
        STRING Filler2;
        STRING Filler3;
        STRING Filler4;
        STRING Filler5;
        STRING Filler6;
        STRING cust_name;
        STRING bug_num;
END;
EXPORT slim := RECORD

main.link_dob;       main.link_ssn;
main.related_dob;    main.related_ssn;    main.related_title_cd;
main.related_dob2;   main.related_ssn2;   main.related_title_cd2;
main.related_dob3;   main.related_ssn3;   main.related_title_cd3;
main.related_dob4;   main.related_ssn4;   main.related_title_cd4;
main.related_dob5;   main.related_ssn5;   main.related_title_cd5;
        
END;
END;
