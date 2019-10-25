EXPORT layouts := module
	export geoid := record
        Unsigned4 record_sid;
        Unsigned8 global_src_id;
        Unsigned6 dt_vendor_first_reported; 
        Boolean is_latest;
        unsigned2 seqno;
        string12 GEOID10_BlkGrp; 
        string3 State_FIPS10;
        string6 County_FIPS10;
        string1 Tract_FIPS10;
        unsigned2 BlkGrp_FIPS10;
        unsigned2 Total_Pop;
        unsigned2 Hispanic_Total;
        unsigned2 Non_Hispanic_Total;
        unsigned2 NH_White_alone;
        unsigned2 NH_Black_alone;
        unsigned2 NH_AIAN_alone;
        unsigned2 NH_API_alone;
        unsigned2 NH_Other_alone;
        unsigned2 NH_Mult_Total;
        unsigned2 NH_White_Other;
        unsigned2 NH_Black_Other;
        unsigned2 NH_AIAN_Other;
        unsigned2 NH_Asian_HPI;
        unsigned2 NH_API_Other;
        unsigned2 NH_Asian_HPI_Other;	
    end;
    export geoidOver18 := record
        Unsigned4 record_sid;
        Unsigned8 global_src_id;
        Unsigned6 dt_vendor_first_reported; 
        Boolean is_latest;
        string12 GeoInd; //key
        REAL4 geo_pr_White;
        REAL4 geo_pr_Black;
        REAL4 geo_pr_AIAN;
        REAL4 geo_pr_API;
        REAL4 geo_pr_mult_other;
        REAL4 geo_pr_Hispanic;
        REAL4 here;
        REAL4 here_given_white;
        REAL4 here_given_black;
        REAL4 here_given_aian;
        REAL4 here_given_api;
        REAL4 here_given_mult_other;
        REAL4 here_given_hispanic;
    end;
    export namecensus := record
        Unsigned4 record_sid;
        Unsigned8 global_src_id;
        Unsigned6 dt_vendor_first_reported; 
        Boolean is_latest;
        STRING20 name; //key
        UNSIGNED3 name_rank;
        UNSIGNED3 name_count;
        UDECIMAL5_2 prop100k;
        UDECIMAL9_2 cum_prop100k;
        UDECIMAL4_2 pctwhite;
        UDECIMAL4_2 pctblack;
        UDECIMAL4_2 pctapi;
        UDECIMAL4_2 pctaian;
        UDECIMAL4_2 pct2prace;
        UDECIMAL4_2 pcthispanic;
    end;
end;
