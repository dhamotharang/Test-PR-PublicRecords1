IMPORT address, BIPV2, dx_common;

EXPORT Layouts := MODULE
  
	////////////////////////////////////////////////////////////////////////
	// -- Input Layouts
	////////////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
      	EXPORT Layout_Header := RECORD
        integer4    LINK_ID;                	//	NUMBER(9)	9-digit unique number assigned by Cortera to a company in its database.
        string100   NAME;                    	//	VARCHAR2(100)	Business/Company name 
        string100   ALTERNATE_BUSINESS_NAME;	//	VARCHAR2(100)	Alternate name on file 
        string80    ADDRESS;                	//	VARCHAR2(80)	Address 
        string80    ADDRESS2;                	//	VARCHAR2(80)	Address 2 line
        string80    CITY;                    	//	VARCHAR2(80)	City 
        string50    STATE;                    //	VARCHAR2(50)	State 
        string2    	COUNTRY;                	//	VARCHAR2(2)	Two character Country Code 
        string20    POSTALCODE;               //	VARCHAR2(20)	Zip/Postal Code 
        string30    PHONE;                    //	VARCHAR2(30)	Phone
        string30    FAX;                    	//	VARCHAR2(30)	Fax
        string10    LATITUDE;                	//	VARCHAR2(10)	Latitude 
        string11    LONGITUDE;                //	VARCHAR2(11)	Longitude 
        string200   URL;                    	//	VARCHAR2(200)	Website
        string9    	FEIN;                    	//	VARCHAR2(9)	FEIN
        string1    	POSITION_TYPE;            //	CHAR(1)	Location in the corporate hierarchy.  Possible Values: 'S' - Single Location, 'B' - Branch, 'H' - Headquarters
        integer4    ULTIMATE_LINKID;        	//	NUMBER(20)	9-digit unique number of the ultimate parent location.
        string100   ULTIMATE_NAME;            //	VARCHAR2(100)	Name of the ultimate parent
        string8    	LOC_DATE_LAST_SEEN;       //	YYYYMMDD	Date of last update to the location
        string20    PRIMARY_SIC;            	//	VARCHAR2(20)	Primary SIC for the business
        string100   SIC_DESC;                	//	VARCHAR2(100)	SIC description
        string20    PRIMARY_NAICS;            //	VARCHAR2(20)	Primary NAICS for the business
        string200   NAICS_DESC;               //	VARCHAR2(200)	NAICS description
        string10    SEGMENT_ID;               //	NUMBER(10)	Cortera defined segment ID for the business
        string255   SEGMENT_DESC;            	//	VARCHAR2(255)	Cortera defined segment for the business
        string4    	YEAR_START;               //	VARCHAR2(4)	Year business started
        string1    	OWNERSHIP;                //	CHAR(1)	Possible Values: 'P' - Public,  'V' - Private
        string10    TOTAL_EMPLOYEES;        	//	VARCHAR2(10)	Total employees for the family
        string30    EMPLOYEE_RANGE;           //	VARCHAR2(30)	Employee range
        string15    TOTAL_SALES;            	//	VARCHAR2(15)	Estimated total annual sales for the family
        string50    SALES_RANGE;            	//	VARCHAR2(50)	Estimate sales range
        string250   EXECUTIVE_NAME1;        	//	VARCHAR2(250)	Executive Name
        string250   TITLE1;                   //	VARCHAR2(250)	Executive Title
        string250   EXECUTIVE_NAME2;        	//	VARCHAR2(250)	Executive Name
        string250   TITLE2;                   // 	VARCHAR2(250)	Executive Title
        string250   EXECUTIVE_NAME3;        	//	VARCHAR2(250)	Executive Name
        string250   TITLE3;                   //	VARCHAR2(250)	Executive Title
        string250   EXECUTIVE_NAME4;        	//	VARCHAR2(250)	Executive Name
        string250   TITLE4;                   //	VARCHAR2(250)	Executive Title
        string250   EXECUTIVE_NAME5;        	//	VARCHAR2(250)	Executive Name
        string250   TITLE5;                   //	VARCHAR2(250)	Executive Title
        string250   EXECUTIVE_NAME6;        	//	VARCHAR2(250)	Executive Name
        string250   TITLE6;                   //	VARCHAR2(250)	Executive Title
        string250   EXECUTIVE_NAME7;        	//	VARCHAR2(250)	Executive Name
        string250   TITLE7;                   //	VARCHAR2(250)	Executive Title
        string250   EXECUTIVE_NAME8;        	//	VARCHAR2(250)	Executive Name
        string250   TITLE8;                   //	VARCHAR2(250)	Executive Title
        string250   EXECUTIVE_NAME9;        	//	VARCHAR2(250)	Executive Name
        string250   TITLE9;                   //	VARCHAR2(250)	Executive Title
        string250   EXECUTIVE_NAME10;        	//	VARCHAR2(250)	Executive Name
        string250   TITLE10;                	//	VARCHAR2(250)	Executive Title
        string1    	STATUS;                   //	CHAR(1)	Possible Values: 'A' - Active, 'D' - Dormant  (Dormant means we have not seen any activity within 30 months)
        string1    	IS_CLOSED;                //	CHAR(1)	Possible Values: 'Y' - Yes
        string9    	CLOSED_DATE;
    	END;
      
			Number	:= string;
    	Ratio   := string;
    	EXPORT Layout_Attributes := RECORD
        integer4  ULTIMATE_LINKID;
        string    CORTERA_SCORE;
        string    CPR_SCORE;
        string    CPR_SEGMENT;
        Ratio     DBT;
        Number    AVG_BAL;
        Number    AIR_SPEND;
        Number    FUEL_SPEND; 
        Number    LEASING_SPEND; 
        Number    LTL_SPEND;
        Number    RAIL_SPEND; 
        Number    TL_SPEND; 
        Number    TRANSVC_SPEND; 
        Number    TRANSUP_SPEND; 
        Number    BST_SPEND; 
        Number    DG_SPEND; 
        Number    ELECTRICAL_SPEND; 
        Number    HVAC_SPEND; 
        Number    OTHER_B_SPEND;
        Number    PLUMBING_SPEND; 
        Number    RS_SPEND; 
        Number    WP_SPEND; 
        Number    CHEMICAL_SPEND; 
        Number    ELECTRONIC_SPEND; 
        Number    METAL_SPEND; 
        Number    OTHER_M_SPEND;
        Number    PACKAGING_SPEND; 
        Number    PVF_SPEND; 
        Number    PLASTIC_SPEND; 
        Number    TEXTILE_SPEND; 
        Number    BS_SPEND; 
        Number    CE_SPEND; 
        Number    HARDWARE_SPEND;
        Number    IE_SPEND; 
        Number    IS_SPEND; 
        Number    IT_SPEND; 
        Number    MLS_SPEND; 
        Number    OS_SPEND; 
        Number    PP_SPEND; 
        Number    SIS_SPEND; 
        Number    APPAREL_SPEND; 
        Number    BEVERAGES_SPEND; 
        Number    CONSTR_SPEND; 
        Number    CONSULTING_SPEND; 
        Number    FS_SPEND; 
        Number    FP_SPEND; 
        Number    INSURANCE_SPEND; 
        Number    LS_SPEND; 
        Number    OIL_GAS_SPEND;
        Number    UTILITIES_SPEND; 
        Number    OTHER_SPEND; 
        Number    ADVT_SPEND; 
        Ratio     AIR_GROWTH; 
        Ratio     FUEL_GROWTH; 
        Ratio     LEASING_GROWTH; 
        Ratio     LTL_GROWTH; 
        Ratio     RAIL_GROWTH; 
        Ratio     TL_GROWTH; 
        Ratio     TRANSVC_GROWTH; 
        Ratio     TRANSUP_GROWTH; 
        Ratio     BST_GROWTH; 
        Ratio     DG_GROWTH; 
        Ratio     ELECTRICAL_GROWTH; 
        Ratio     HVAC_GROWTH; 
        Ratio     OTHER_B_GROWTH; 
        Ratio     PLUMBING_GROWTH; 
        Ratio     RS_GROWTH; 
        Ratio     WP_GROWTH; 
        Ratio     CHEMICAL_GROWTH; 
        Ratio     ELECTRONIC_GROWTH; 
        Ratio     METAL_GROWTH; 
        Ratio     OTHER_M_GROWTH;
        Ratio     PACKAGING_GROWTH; 
        Ratio     PVF_GROWTH; 
        Ratio     PLASTIC_GROWTH; 
        Ratio     TEXTILE_GROWTH; 
        Ratio     BS_GROWTH; 
        Ratio     CE_GROWTH; 
        Ratio     HARDWARE_GROWTH; 
        Ratio     IE_GROWTH; 
        Ratio     IS_GROWTH; 
        Ratio     IT_GROWTH; 
        Ratio     MLS_GROWTH; 
        Ratio     OS_GROWTH; 
        Ratio     PP_GROWTH; 
        Ratio     SIS_GROWTH; 
        Ratio     APPAREL_GROWTH; 
        Ratio     BEVERAGES_GROWTH; 
        Ratio     CONSTR_GROWTH; 
        Ratio     CONSULTING_GROWTH; 
        Ratio     FS_GROWTH; 
        Ratio     FP_GROWTH; 
        Ratio     INSURANCE_GROWTH; 
        Ratio     LS_GROWTH; 
        Ratio     OIL_GAS_GROWTH;
        Ratio     UTILITIES_GROWTH; 
        Ratio     OTHER_GROWTH; 
        Ratio     ADVT_GROWTH; 
        Ratio     TOP5_GROWTH; 
        Number    SHIPPING_Y1; 
        Ratio     SHIPPING_GROWTH; 
        Number    MATERIALS_Y1; 
        Ratio     MATERIALS_GROWTH; 
        Number    OPERATIONS_Y1; 
        Ratio     OPERATIONS_GROWTH; 
        Ratio     TOTAL_PAID_AVERAGE_0T12; 
        Ratio     TOTAL_PAID_MONTHSPASTWORST_24; 
        Ratio     TOTAL_PAID_SLOPE_0T12; 
        Ratio     TOTAL_PAID_SLOPE_0T6; 
        Ratio     TOTAL_PAID_SLOPE_6T12; 
        Ratio     TOTAL_PAID_SLOPE_6T18; 
        Ratio     TOTAL_PAID_VOLATILITY_0T12; 
        Ratio     TOTAL_PAID_VOLATILITY_0T6; 
        Ratio     TOTAL_PAID_VOLATILITY_12T18; 
        Ratio     TOTAL_PAID_VOLATILITY_6T12; 
        Number    TOTAL_SPEND_MONTHSPASTLEAST_24; 
        Number    TOTAL_SPEND_MONTHSPASTMOST_24; 
        Ratio     TOTAL_SPEND_SLOPE_0T12; 
        Ratio     TOTAL_SPEND_SLOPE_0T24; 
        Ratio     TOTAL_SPEND_SLOPE_0T6; 
        Ratio     TOTAL_SPEND_SLOPE_6T12; 
        Ratio     TOTAL_SPEND_SUM_12; 
        Ratio     TOTAL_SPEND_VOLATILITY_0T12; 
        Ratio     TOTAL_SPEND_VOLATILITY_0T6; 
        Ratio     TOTAL_SPEND_VOLATILITY_12T18; 
        Ratio     TOTAL_SPEND_VOLATILITY_6T12; 
        Ratio     MFGMAT_PAID_AVERAGE_12; 
        Number    MFGMAT_PAID_MONTHSPASTWORST_24; 
        Ratio     MFGMAT_PAID_SLOPE_0T12; 
        Ratio     MFGMAT_PAID_SLOPE_0T24; 
        Ratio     MFGMAT_PAID_SLOPE_0T6; 
        Ratio     MFGMAT_PAID_VOLATILITY_0T12; 
        Ratio     MFGMAT_PAID_VOLATILITY_0T6; 
        Ratio     MFGMAT_SPEND_MONTHSPASTLEAST_24; 
        Ratio     MFGMAT_SPEND_MONTHSPASTMOST_24; 
        Ratio     MFGMAT_SPEND_SLOPE_0T12; 
        Ratio     MFGMAT_SPEND_SLOPE_0T24; 
        Ratio     MFGMAT_SPEND_SLOPE_0T6; 
        Ratio     MFGMAT_SPEND_SUM_12; 
        Ratio     MFGMAT_SPEND_VOLATILITY_0T6; 
        Ratio     MFGMAT_SPEND_VOLATILITY_6T12; 
        Ratio     OPS_PAID_AVERAGE_12; 
        Ratio     OPS_PAID_MONTHSPASTWORST_24; 
        Ratio     OPS_PAID_SLOPE_0T12; 
        Ratio     OPS_PAID_SLOPE_0T24; 
        Ratio     OPS_PAID_SLOPE_0T6; 
        Ratio     OPS_PAID_VOLATILITY_0T12; 
        Ratio     OPS_PAID_VOLATILITY_0T6; 
        Number    OPS_SPEND_MONTHSPASTLEAST_24; 
        Number    OPS_SPEND_MONTHSPASTMOST_24; 
        Ratio     OPS_SPEND_SLOPE_0T12; 
        Ratio     OPS_SPEND_SLOPE_0T24; 
        Ratio     OPS_SPEND_SLOPE_0T6; 
        Number    OPS_SPEND_SUM_12; 
        Ratio     OPS_SPEND_VOLATILITY_0T6; 
        Ratio     OPS_SPEND_VOLATILITY_6T12; 
        Ratio     FLEET_PAID_AVERAGE_12; 
        Number    FLEET_PAID_MONTHSPASTWORST_24; 
        Ratio     FLEET_PAID_SLOPE_0T12; 
        Ratio     FLEET_PAID_SLOPE_0T24; 
        Ratio     FLEET_PAID_SLOPE_0T6; 
        Ratio     FLEET_PAID_VOLATILITY_0T12; 
        Ratio     FLEET_PAID_VOLATILITY_0T6; 
        Number    FLEET_SPEND_MONTHSPASTLEAST_24; 
        Number    FLEET_SPEND_MONTHSPASTMOST_24; 
        Ratio     FLEET_SPEND_SLOPE_0T12; 
        Ratio     FLEET_SPEND_SLOPE_0T24; 
        Ratio     FLEET_SPEND_SLOPE_0T6; 
        Number    FLEET_SPEND_SUM_12; 
        Ratio     FLEET_SPEND_VOLATILITY_0T6; 
        Ratio     FLEET_SPEND_VOLATILITY_6T12; 
        Ratio     CARRIER_PAID_AVERAGE_12;
        Number    CARRIER_PAID_MONTHSPASTWORST_24; 
        Ratio     CARRIER_PAID_SLOPE_0T12; 
        Ratio     CARRIER_PAID_SLOPE_0T24; 
        Ratio     CARRIER_PAID_SLOPE_0T6; 
        Ratio     CARRIER_PAID_VOLATILITY_0T12; 
        Ratio     CARRIER_PAID_VOLATILITY_0T6; 
        Number    CARRIER_SPEND_MONTHSPASTLEAST_24; 
        Number    CARRIER_SPEND_MONTHSPASTMOST_24; 
        Ratio     CARRIER_SPEND_SLOPE_0T12; 
        Ratio     CARRIER_SPEND_SLOPE_0T24; 
        Ratio     CARRIER_SPEND_SLOPE_0T6; 
        Number    CARRIER_SPEND_SUM_12; 
        Ratio     CARRIER_SPEND_VOLATILITY_0T6; 
        Ratio     CARRIER_SPEND_VOLATILITY_6T12; 
        Ratio     BLDGMATS_PAID_AVERAGE_12; 
        Number    BLDGMATS_PAID_MONTHSPASTWORST_24; 
        Ratio     BLDGMATS_PAID_SLOPE_0T12; 
        Ratio     BLDGMATS_PAID_SLOPE_0T24; 
        Ratio     BLDGMATS_PAID_SLOPE_0T6; 
        Ratio     BLDGMATS_PAID_VOLATILITY_0T12; 
        Ratio     BLDGMATS_PAID_VOLATILITY_0T6; 
        Number    BLDGMATS_SPEND_MONTHSPASTLEAST_24; 
        Number    BLDGMATS_SPEND_MONTHSPASTMOST_24; 
        Ratio     BLDGMATS_SPEND_SLOPE_0T12; 
        Ratio     BLDGMATS_SPEND_SLOPE_0T24; 
        Ratio     BLDGMATS_SPEND_SLOPE_0T6; 
        Number    BLDGMATS_SPEND_SUM_12; 
        Ratio     BLDGMATS_SPEND_VOLATILITY_0T6; 
        Ratio     BLDGMATS_SPEND_VOLATILITY_6T12; 
        Ratio     TOP5_PAID_AVERAGE_12; 
        Number    TOP5_PAID_MONTHSPASTWORST_24; 
        Ratio     TOP5_PAID_SLOPE_0T12; 
        Ratio     TOP5_PAID_SLOPE_0T24; 
        Ratio     TOP5_PAID_SLOPE_0T6; 
        Ratio     TOP5_PAID_VOLATILITY_0T12; 
        Ratio     TOP5_PAID_VOLATILITY_0T6; 
        Number    TOP5_SPEND_MONTHSPASTLEAST_24; 
        Number    TOP5_SPEND_MONTHSPASTMOST_24; 
        Ratio     TOP5_SPEND_SLOPE_0T12; 
        Ratio     TOP5_SPEND_SLOPE_0T24; 
        Ratio     TOP5_SPEND_SLOPE_0T6; 
        Number    TOP5_SPEND_SUM_12; 
        Ratio     TOP5_SPEND_VOLATILITY_0T6; 
        Ratio     TOP5_SPEND_VOLATILITY_6T12; 
        Ratio     TOTAL_NUMREL_AVG12; 
        Number    TOTAL_NUMREL_MONTHPSPASTMOST_24; 
        Number    TOTAL_NUMREL_MONTHSPASTLEAST_24; 
        Ratio     TOTAL_NUMREL_SLOPE_0T12; 
        Ratio     TOTAL_NUMREL_SLOPE_0T24; 
        Ratio     TOTAL_NUMREL_SLOPE_0T6; 
        Ratio     TOTAL_NUMREL_SLOPE_6T12; 
        Ratio     TOTAL_NUMREL_VAR_0T12; 
        Ratio     TOTAL_NUMREL_VAR_0T24; 
        Ratio     TOTAL_NUMREL_VAR_12T24; 
        Ratio     TOTAL_NUMREL_VAR_6T18; 
        Ratio     MFGMAT_NUMREL_AVG12; 
        Ratio     MFGMAT_NUMREL_SLOPE_0T12; 
        Ratio     MFGMAT_NUMREL_SLOPE_0T24; 
        Ratio     MFGMAT_NUMREL_SLOPE_0T6; 
        Ratio     MFGMAT_NUMREL_SLOPE_6T12; 
        Ratio     MFGMAT_NUMREL_VAR_0T12; 
        Ratio     MFGMAT_NUMREL_VAR_12T24; 
        Ratio     OPS_NUMREL_AVG12; 
        Ratio     OPS_NUMREL_SLOPE_0T12; 
        Ratio     OPS_NUMREL_SLOPE_0T24; 
        Ratio     OPS_NUMREL_SLOPE_0T6; 
        Ratio     OPS_NUMREL_SLOPE_6T12; 
        Ratio     OPS_NUMREL_VAR_0T12; 
        Ratio     OPS_NUMREL_VAR_12T24; 
        Ratio     FLEET_NUMREL_AVG12; 
        Ratio     FLEET_NUMREL_SLOPE_0T12; 
        Ratio     FLEET_NUMREL_SLOPE_0T24; 
        Ratio     FLEET_NUMREL_SLOPE_0T6; 
        Ratio     FLEET_NUMREL_SLOPE_6T12; 
        Number    FLEET_NUMREL_VAR_0T12; 
        Ratio     FLEET_NUMREL_VAR_12T24; 
        Ratio     CARRIER_NUMREL_AVG12; 
        Ratio     CARRIER_NUMREL_SLOPE_0T12; 
        Ratio     CARRIER_NUMREL_SLOPE_0T24; 
        Ratio     CARRIER_NUMREL_SLOPE_0T6; 
        Ratio     CARRIER_NUMREL_SLOPE_6T12; 
        Ratio     CARRIER_NUMREL_VAR_0T12; 
        Ratio     CARRIER_NUMREL_VAR_12T24; 
        Ratio     BLDGMATS_NUMREL_AVG12; 
        Ratio     BLDGMATS_NUMREL_SLOPE_0T12; 
        Ratio     BLDGMATS_NUMREL_SLOPE_0T24; 
        Ratio     BLDGMATS_NUMREL_SLOPE_0T6; 
        Ratio     BLDGMATS_NUMREL_SLOPE_6T12; 
        Ratio     BLDGMATS_NUMREL_VAR_0T12; 
        Ratio     BLDGMATS_NUMREL_VAR_12T24; 
        Ratio     TOTAL_MONTHSOUTSTANDING_SLOPE24; 
        Ratio     TOTAL_PERCPROV30_AVG_0T12; 
        Ratio     TOTAL_PERCPROV30_SLOPE_0T12; 
        Ratio     TOTAL_PERCPROV30_SLOPE_0T24; 
        Ratio     TOTAL_PERCPROV30_SLOPE_0T6; 
        Ratio     TOTAL_PERCPROV30_SLOPE_6T12; 
        Ratio     TOTAL_PERCPROV60_AVG_0T12; 
        Ratio     TOTAL_PERCPROV60_SLOPE_0T12; 
        Ratio     TOTAL_PERCPROV60_SLOPE_0T24; 
        Ratio     TOTAL_PERCPROV60_SLOPE_0T6; 
        Ratio     TOTAL_PERCPROV60_SLOPE_6T12; 
        Ratio     TOTAL_PERCPROV90_AVG_0T12; 
        Ratio     TOTAL_PERCPROV90_LOWERLIM_0T12; 
        Ratio     TOTAL_PERCPROV90_SLOPE_0T24; 
        Ratio     TOTAL_PERCPROV90_SLOPE_0T6; 
        Ratio     TOTAL_PERCPROV90_SLOPE_6T12; 
        Ratio     TOTAL_PERCPROVOUTSTANDING_ADJUSTEDSLOPE_0T12; 
        Ratio     MFGMAT_MONTHSOUTSTANDING_SLOPE24; 
        Ratio     MFGMAT_PERCPROV30_SLOPE_0T12; 
        Ratio     MFGMAT_PERCPROV30_SLOPE_6T12; 
        Ratio     MFGMAT_PERCPROV60_SLOPE_0T12; 
        Ratio     MFGMAT_PERCPROV60_SLOPE_6T12; 
        Ratio     MFGMAT_PERCPROV90_SLOPE_0T24; 
        Ratio     MFGMAT_PERCPROV90_SLOPE_0T6; 
        Ratio     MFGMAT_PERCPROV90_SLOPE_6T12; 
        Ratio     MFGMAT_PERCPROVOUTSTANDING_ADJUSTEDSLOPE_0T12; 
        Ratio     OPS_MONTHSOUTSTANDING_SLOPE24; 
        Ratio     OPS_PERCPROV30_SLOPE_0T12; 
        Ratio     OPS_PERCPROV30_SLOPE_6T12; 
        Ratio     OPS_PERCPROV60_SLOPE_0T12; 
        Ratio     OPS_PERCPROV60_SLOPE_6T12; 
        Ratio     OPS_PERCPROV90_SLOPE_0T24; 
        Ratio     OPS_PERCPROV90_SLOPE_0T6; 
        Ratio     OPS_PERCPROV90_SLOPE_6T12; 
        Ratio     OPS_PERCPROVOUTSTANDING_ADJUSTEDSLOPE_0T12; 
        Ratio     FLEET_MONTHSOUTSTANDING_SLOPE24; 
        Ratio     FLEET_PERCPROV30_SLOPE_0T12; 
        Ratio     FLEET_PERCPROV30_SLOPE_6T12; 
        Ratio     FLEET_PERCPROV60_SLOPE_0T12; 
        Ratio     FLEET_PERCPROV60_SLOPE_6T12; 
        Ratio     FLEET_PERCPROV90_SLOPE_0T24; 
        Ratio     FLEET_PERCPROV90_SLOPE_0T6; 
        Ratio     FLEET_PERCPROV90_SLOPE_6T12; 
        Ratio     FLEET_PERCPROVOUTSTANDING_ADJUSTEDSLOPE_0T12; 
        Ratio     CARRIER_MONTHSOUTSTANDING_SLOPE24; 
        Ratio     CARRIER_PERCPROV30_SLOPE_0T12; 
        Ratio     CARRIER_PERCPROV30_SLOPE_6T12; 
        Ratio     CARRIER_PERCPROV60_SLOPE_0T12; 
        Ratio     CARRIER_PERCPROV60_SLOPE_6T12; 
        Ratio     CARRIER_PERCPROV90_SLOPE_0T24; 
        Ratio     CARRIER_PERCPROV90_SLOPE_0T6; 
        Ratio     CARRIER_PERCPROV90_SLOPE_6T12; 
        Ratio     CARRIER_PERCPROVOUTSTANDING_ADJUSTEDSLOPE_0T12; 
        Ratio     BLDGMATS_MONTHSOUTSTANDING_SLOPE24; 
        Ratio     BLDGMATS_PERCPROV30_SLOPE_0T12; 
        Ratio     BLDGMATS_PERCPROV30_SLOPE_6T12; 
        Ratio     BLDGMATS_PERCPROV60_SLOPE_0T12; 
        Ratio     BLDGMATS_PERCPROV60_SLOPE_6T12; 
        Ratio     BLDGMATS_PERCPROV90_SLOPE_0T24; 
        Ratio     BLDGMATS_PERCPROV90_SLOPE_0T6; 
        Ratio     BLDGMATS_PERCPROV90_SLOPE_6T12; 
        Ratio     BLDGMATS_PERCPROVOUTSTANDING_ADJUSTEDSLOPE_0T12; 
        Ratio     TOP5_MONTHSOUTSTANDING_SLOPE24; 
        Ratio     TOP5_PERCPROV30_SLOPE_0T12; 
        Ratio     TOP5_PERCPROV30_SLOPE_6T12; 
        Ratio     TOP5_PERCPROV60_SLOPE_0T12; 
        Ratio     TOP5_PERCPROV60_SLOPE_6T12; 
        Ratio     TOP5_PERCPROV90_SLOPE_0T24; 
        Ratio     TOP5_PERCPROV90_SLOPE_0T6; 
        Ratio     TOP5_PERCPROV90_SLOPE_6T12; 
        Ratio     TOP5_PERCPROVOUTSTANDING_ADJUSTEDSLOPE_0T12;
     END;      
 END;

 ////////////////////////////////////////////////////////////////////////
 // -- Cortera Header Base layout
 ////////////////////////////////////////////////////////////////////////
 EXPORT Layout_Header_Out := RECORD
    Input.Layout_Header;                 //*** Raw vendor fields
    
    unsigned4 processDate;
    string8   version;
    unsigned8 persistent_record_id := 0;
    unsigned4 dt_first_seen;             //*** Date record first seen at Seisint
    unsigned4 dt_last_seen;              //*** Date record last (most recently seen) at Seisint
    unsigned4 dt_vendor_first_reported;
    unsigned4 dt_vendor_last_reported;
    boolean   current;
    string10  clean_phone;
    string10  clean_fax;

    unsigned8 rawaid := 0;
    address.Layout_Clean182.prim_range
    ,address.Layout_Clean182.predir
    ,address.Layout_Clean182.prim_name
    ,address.Layout_Clean182.addr_suffix
    ,address.Layout_Clean182.postdir
    ,address.Layout_Clean182.unit_desig
    ,address.Layout_Clean182.sec_range
    ,address.Layout_Clean182.p_city_name
    ,address.Layout_Clean182.v_city_name
    ,address.Layout_Clean182.st
    ,address.Layout_Clean182.zip
    ,address.Layout_Clean182.zip4
    ,address.Layout_Clean182.cart
    ,address.Layout_Clean182.cr_sort_sz
    ,address.Layout_Clean182.lot
    ,address.Layout_Clean182.lot_order
    ,address.Layout_Clean182.dbpc
    ,address.Layout_Clean182.chk_digit
    ,address.Layout_Clean182.rec_type
    ,address.Layout_Clean182.county
    ,address.Layout_Clean182.geo_lat
    ,address.Layout_Clean182.geo_long
    ,address.Layout_Clean182.msa
    ,address.Layout_Clean182.geo_blk
    ,address.Layout_Clean182.geo_match
    ,address.Layout_Clean182.err_stat;

    unsigned6 bdid := 0;
    unsigned1 bdid_score := 0;
    BIPV2.IDlayouts.l_xlink_ids;
		dx_common.layout_metadata;           // Added for Delta build process. CCPA fields are also part of this.
 END;
 
 ////////////////////////////////////////////////////////////////////////
 // -- Cortera Attributes Base layout
 ////////////////////////////////////////////////////////////////////////
 EXPORT Layout_Attributes_Out := RECORD
    Input.Layout_Attributes;
    string100 NAME;                     //*** VARCHAR2(100) Business/Company name 
    unsigned4 processDate;
    unsigned4 dt_first_seen;            //*** Date record first seen at Seisint
    unsigned4 dt_last_seen;             //*** Date record last (most recently seen) at Seisint
    unsigned4 dt_vendor_first_reported;
    unsigned4 dt_vendor_last_reported;
    boolean   current_rec := false;

    unsigned8 rawaid := 0;
    address.Layout_Clean182.prim_range
    ,address.Layout_Clean182.predir
    ,address.Layout_Clean182.prim_name
    ,address.Layout_Clean182.addr_suffix
    ,address.Layout_Clean182.postdir
    ,address.Layout_Clean182.unit_desig
    ,address.Layout_Clean182.sec_range
    ,address.Layout_Clean182.p_city_name
    ,address.Layout_Clean182.v_city_name
    ,address.Layout_Clean182.st
    ,address.Layout_Clean182.zip
    ,address.Layout_Clean182.zip4
    ,address.Layout_Clean182.cart
    ,address.Layout_Clean182.cr_sort_sz
    ,address.Layout_Clean182.lot
    ,address.Layout_Clean182.lot_order
    ,address.Layout_Clean182.dbpc
    ,address.Layout_Clean182.chk_digit
    ,address.Layout_Clean182.rec_type
    ,address.Layout_Clean182.county
    ,address.Layout_Clean182.geo_lat
    ,address.Layout_Clean182.geo_long
    ,address.Layout_Clean182.msa
    ,address.Layout_Clean182.geo_blk
    ,address.Layout_Clean182.geo_match
    ,address.Layout_Clean182.err_stat;

    unsigned6 bdid := 0;
    unsigned1 bdid_score := 0;
    BIPV2.IDlayouts.l_xlink_ids;
		dx_common.layout_metadata;           // Added for Delta build process. CCPA fields are also part of this.
 END;
 
 ////////////////////////////////////////////////////////////////////////
 // -- Cortera Executive LinkID Key layout
 ////////////////////////////////////////////////////////////////////////
 EXPORT Layout_ExecLinkID := RECORD
    integer4  link_id;
    unsigned8 persistent_record_id;
    unsigned6 did;
    integer3  did_score;
    integer1  name_sequence;
    string5   title;
    string20  fname;
    string20  mname;
    string20  lname;
    string5   name_suffix;
    string1   ln_entity_type;
    string    executive_name;
    string    executive_title;
		dx_common.layout_metadata;           // Added for Delta build process. CCPA fields are also part of this.
 END;
 
 ////////////////////////////////////////////////////////////////////////
 // -- Cortera Executive Base layout
 ////////////////////////////////////////////////////////////////////////
 EXPORT Layout_Executives := RECORD
    Layout_Header_Out;
    INTEGER1  name_sequence;
    string    Executive_Name {maxlength(250)};   // VARCHAR2(250) Executive Name
    string    Executive_Title {maxlength(250)};  // VARCHAR2(250) Executive Title
    string5   title := '';
    string20  fname := '';
    string20  mname := '';
    string20  lname := '';
    string5   name_suffix := '';
    unsigned8 nid := 0;
    string1   ln_entity_type := '';
    unsigned6 did := 0;
    unsigned1 did_Score := 0;
  END;
  
	////////////////////////////////////////////////////////////////////////
  // -- Layout Key Delta RID
  ////////////////////////////////////////////////////////////////////////
  EXPORT Layout_Delta_Rid := RECORD
		dx_common.layout_ridkey;
  END;
  
	////////////////////////////////////////////////////////////////////////
  // -- Layout Key Build Version
  ////////////////////////////////////////////////////////////////////////
  EXPORT Layout_Version := RECORD
		dx_common.layout_build_version;
  END;

END;
