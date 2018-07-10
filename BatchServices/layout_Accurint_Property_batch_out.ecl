import batchShare, FFD;
EXPORT layout_Accurint_Property_batch_out := 
	RECORD

		STRING30 acctno              := '';
		FFD.Layouts.ConsumerStatementBatch.SequenceNumber;
		batchshare.Layouts.shareErrors;
		STRING8   matchcodes := '';
		
//	***** POTENTIALLY USEFUL DATA *****
		
		STRING10  record_type        := '';
		STRING8   sortby_date        := '';
		STRING1   current_record     := '';

//	***** REQUIRED OUTPUT *****

		STRING45  parcel_number      := '';
		STRING1   fares_source_id    := '';
		STRING5   source_code        := '';
		STRING12  unique_id          := '';
		
		STRING60  name_owner_1       := '';
		STRING60  name_owner_2       := '';
		
		STRING10  prop_prim_range    := '';
		STRING2   prop_predir        := '';
		STRING28  prop_prim_name     := '';
		STRING4   prop_suffix        := '';
		STRING2   prop_postdir       := '';
		STRING10  prop_unit_desig    := '';
		STRING8   prop_sec_range     := '';
		STRING25  prop_p_city_name   := '';
		STRING2   prop_st            := '';
		STRING5   prop_zip           := '';
		STRING4   prop_zip4          := '';
		STRING5   fips               := '';
		
		STRING11  total_value        := '';
		
		STRING8   sale_date          := '';
		STRING11  sale_price         := '';
		
		STRING60  name_seller        := '';
		
		STRING11  mortgage_amount    := '';
		STRING11  assessed_value     := '';
		STRING11  total_market_value := '';
		STRING8   recording_date     := '';
		STRING250 legal_description  := '';
		
		FFD.Layouts.ConsumerFlags;

		STRING12 owner_1_did;
		STRING12 owner_2_did;
		STRING12 seller_did;
    
    STRING12 inquiry_lexid := '';
	END;
	
/*
	BATCH NAME                      MOXIE NAME
    "parcel-number",                "formatted_apn",           
    "source-code",                  "source_code",         
    "unique-id",                    "fares_id",                     
    "name-owner-1",                 "owner_name1",                 
    "name-owner-2",                 "owner_name2",                 
    "prop-street-number",           "prop_prim_range",            
    "prop-street-pre-direction",    "prop_predir",                  
    "prop-street-name",             "prop_prim_name",            
    "prop-street-post-direction",   "prop_postdir",                
    "prop-street-suffix",           "prop_suffix",                  
    "prop-unit-designation",        "prop_unit_desig",        
    "prop-unit-number",             "prop_sec_range",            
    "prop-city",                    "prop_p_city_name",            
    "prop-state",                   "prop_st",                   
    "prop-zip",                     "prop_zip",                   
    "prop-zip4",                    "prop_zip4",                  
    "prop-fips",                    "prop_ace_county",             
    "total-value",                  "total_val_calc",           
    "sale-date",                    "sale_date",               
    "sale-price",                   "sale_price",                 
    "name-seller",                  "seller_name",                  
    "mortgage-amount",              "mortgage_amount",    
    "assessed-value",               "assd_total_val",            
    "total-market-value",           "mkt_total_val",              
    "recording-date",               "record_date",               
    "legal-description",            "legal1",                      

45   char parcel-number_1
62   char name-owner-1_1
62   char name-owner-2_1
70   char prop-street-numberaddress_1
25   char prop-city_1
2    char prop-state_1
10   char prop-zipzipcode_1
11   char total-value_1
8    char sale-date_1
11   char sale-price_1
60   char name-seller_1
11   char mortgage-amount_1
11   char assessed-value_1
11   char total-market-value_1
250  char legal-description_1

45   char parcel-number_2
62   char name-owner-1_2
62   char name-owner-2_2
70   char prop-street-numberaddress_2
25   char prop-city_2
2    char prop-state_2
10   char prop-zipzipcode_2
11   char total-value_2
8    char sale-date_2
11   char sale-price_2
60   char name-seller_2
11   char mortgage-amount_2
11   char assessed-value_1
11   char total-market-value_2
250  char legal-description_2

45   char parcel-number_3
62   char name-owner-1_3
62   char name-owner-2_3
70   char prop-street-numberaddress_3
25   char prop-city_3
2    char prop-state_3
10   char prop-zipzipcode_3
11   char total-value_3
8    char sale-date_3
11   char sale-price_3
60   char name-seller_3
11   char mortgage-amount_3
11   char assessed-value_3
11   char total-market-value_3
250  char legal-description_3

45   char parcel-number_4
62   char name-owner-1_4
62   char name-owner-2_4
70   char prop-street-numberaddress_4
25   char prop-city_4
2    char prop-state_4
10   char prop-zipzipcode_4
11   char total-value_4
8    char sale-date_4
11   char sale-price_4
60   char name-seller_4
11   char mortgage-amount_4
11   char assessed-value_4
11   char total-market-value_4
250  char legal-description_4

45   char parcel-number_5
62   char name-owner-1_5
62   char name-owner-2_5
70   char prop-street-numberaddress_5
25   char prop-city_5
2    char prop-state_5
10   char prop-zipzipcode_5
11   char total-value_5
8    char sale-date_5
11   char sale-price_5
60   char name-seller_5
11   char mortgage-amount_5
11   char assessed-value_5
11   char total-market-value_5
250  char legal-description_5
*/
