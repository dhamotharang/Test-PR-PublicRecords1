EXPORT Layout_raw_frs_deed := RECORD

string5         fips;//Federal Information Processing Standards codes used nationally to numerically idâ€¦
string3         fips_sub_code;//A secondary classification of a jurisdiction within a FIPS.â€¦
string6         municipality_code;//Code of the Municipality where parcel is located.â€¦
string45        apn_parcel_number_unformatted;//Assessors Parcel Number in an unformatted form. This is most often used by the câ€¦
string45        apn_parcel_number_formatted;//Assessors Parcel Number in a formatted form. Dashes and decimals are commonly usâ€¦
string3         apn_sequence_number;//This internal sequence number is used to ensure unique-ness of the Assessors Pâ€¦
string45        original_apn;//Assessors Parcel Number exactly as received by source (e.g., 10132-021A00000).â€¦
string15        account_number;//The county or source number used primary for billing. Note: this number is typicâ€¦
string1         corporate_indicator;//The Name of the property owner has been recognized as a corporation or business.â€¦
string30        owner_buyer_last_name;//Last name of the BUYER (OWNER)â€¦
string32        owner_buyer_first_name;//First name of the BUYER (OWNER)â€¦
string1         owner_etal_ind;//A code appearing in this field indicates additional ownership, whose name(s) werâ€¦
string20        c_o_name;//Care of Name as supplied by the sourceâ€¦
string3         owner_relationship_rights_code;//Form or Method of Property Ownership (e.g., Joint Tenancy, Living Trust). Pleaseâ€¦
string2         owner_relationship_type;//Relationship between multiple owners or the marital status of a single owner (e.â€¦
string5         owner_house_number_prefix;//The digits found to the left of a traditional house number (e.g., A123 MAIN ST) â€¦
string10        owner_house_number;//The digits found to the immediate right of the Situs House Number Prefix and to â€¦
string10        owner_house_number_suffix;//The digits found to the right of a traditional house number often representing aâ€¦
string2         owner_street_direction;//This field represents the direction found to the left of the street name (e.g., â€¦
string30        owner_street_name;//The name or number of the street where a parcel is located (e.g., 9340 N DUNHILLâ€¦
string5         owner_mode;//The Mode or Type of street found to the right of the street name (e.g.., 9340 N â€¦
string2         owner_quadrant;//The quadrant field is found to the right of Situs Mode (e.g., 100 TEMPLE ST NW, â€¦
string6         owner_apartment_unit;//The unit or suite number of the property address (e.g., 649 LAKE SHORE DR #1400)â€¦
string40        owner_city;//The city associated with the property address (e.g., CHICAGO, ATLANTA, DENVER).â€¦
string2         owner_state;//The two-letter USPS postal abbreviation associated with the state // protectorantâ€¦
string9         owner_zip_code;//The nine digit (i.e., ZIP & plus 4) assigned by the USPS. This is populated by vâ€¦
string4         owner_carrier_code;//This is the four digit code used by the local mail carrier to identify the delivâ€¦
string4         match_code;//Code used for internal purposesâ€¦
string1         address_indicator;//This field is used to indicate whether the Situs data (I.e., property location) â€¦
string5         prop_house_number_prefix;//The digits found to the left of a traditional house number (e.g., A123 MAIN ST) â€¦
string10        prop_house_number;//The digits found to the immediate right of the Mail House Number Prefix and to tâ€¦
string10        prop_house_number_suffix;//The digits found to the right of a traditional house number often representing aâ€¦
string30        prop_street_name;//The name or number of the street where a parcel is located (e.g., 9340 N DUNHILLâ€¦
string5         prop_mode;//The Mode or Type of street found to the right of the street name (e.g.., 9340 N â€¦
string2         prop_direction;//This field represents the direction found to the left of the street name (e.g., â€¦
string2         prop_quadrant;//The quadrant field is found to the right of Mail Mode (e.g., 100 TEMPLE ST NW, 2â€¦
string6         prop_apartment_unit;//The unit or suite number of the property address (e.g., 649 LAKE SHORE DR #1400)â€¦
string40        prop_city;//The city associated with the property address (e.g., CHICAGO, ATLANTA, DENVER).â€¦
string2         prop_state;//The two-letter USPS postal abbreviation associated with the state // protectorantâ€¦
string9         prop_property_address_zip_code_;//The nine digit (i.e., ZIP & plus 4) assigned by the USPS. This is populated by vâ€¦
string4         prop_carrier_code;//This is the four digit code used by the local mail carrier to identify the delivâ€¦
string12        batch_id;//FACL internal date number - can be used in the creation of unique keysâ€¦
string5         batch_seq;//FACL internal sequence number - can be used in the creation of unique keysâ€¦
string4         document_year;//Year that the document was recordedâ€¦
string60        seller_name;//The sellers name as it appears on the recorded sales transaction.â€¦
string11        sale_amount;//Price of the sale as depicted on the recorded sales transaction.â€¦
string11        mortgage_amount;//The amount of the first mortgage as depicted on the recorded document.â€¦
string8         sale_date_yyyymmdd;//The date the sales transaction was legally completed (i.e., contact signed) (e.gâ€¦
string8         recording_date_yyyymmdd;//The date the sales transaction was recorded at the county (e.g., 19621028)â€¦
string3         document_type;//Type of transfer document recorded (Grand Deed, Trust Deed etc) . Please see DEâ€¦
string3         transaction_type;//FACL code identifying the type of transaction Please see SALES TRANSACTION CODEâ€¦
string12        document_number;//The document number used by some counties to record sales transactions (e.g., 00â€¦
string12        book_page_6x6;//The Book and Page number used by some counties to catalog their sales recordingsâ€¦
string30        lender_last_name;//Name of Lender as recorded on the original documentâ€¦
string30        lender_first_name;//May be first name if lender is private partyâ€¦
//string60        lender_address;//
string30				lender_address;  //Address of the Lender, as recorded on the original documentâ€¦
string19				lender_city;  //Lender City, as recorded on the original documentâ€¦
string2					lender_state;  //Lender St, as recorded on the original documentâ€¦
string9					lender_zip;  //Lender ZIP, as recorded on the original documentâ€¦
string10        mortgage_company_code;//This is a FACL internal code used to identify the Lending Company that was assocâ€¦
string1         sale_code;//This field indicates whether the financial consideration is F = Full or P = Partâ€¦
string3         sales_transaction_code;
//string1				ownerbuyermiddleinitial;  //Middle initial of the BUYER (OWNER)â€¦
//string2				filler1;  //fillerâ€¦
string1         multi_apn;//The data contained in this field depicts multiple or split parcel sales. Please â€¦
string4         multi_apn_count;//This reflects the number of parcels associated with the sale (e.g., 14 parcels râ€¦
string5         title_company_code;//This is a FACL internal code used to identify the Title Company that was associaâ€¦
string1         residential_model_indicator;//A code to indicate whether the property is residential based on individual zipcoâ€¦
string8         mortgage_date;//The date the Mortgage was initiated.â€¦
string5         mortgage_loan_type_code;//Type of load secured as part of the 2nd mortgage (e.g., Conventional, FHA, VA). â€¦
string6         mortgage_deed_type;//Type of deed used for recording (e.g., Agreement of Sale, Assumption, Correctionâ€¦
string4         mortgage_term_code;//This code is used to identify whether the number stored in the MORTGAGE TERM fieâ€¦
string5         mortgage_term;//The length of time before the mortgage matures (e.g., 15yrs, 30 yrs, 45dys).â€¦
string8         mortgage_due_date;//The date the mortgage amount becomes due.â€¦
string11        mortgage_assumption_amount;//The assumption amount related to an existing mortgage.â€¦
string11        second_mortgage_amount;//This is the amount associated with the 2nd mortgage.â€¦
string5         second_mortgage_loan_type_code;//Type of load secured as part of the 2nd mortgage (e.g., Conventional, FHA, VA). â€¦
string6         second_deed_type;//Type of deed used for recording the 2nd mortgage (e.g., Agreement of Sale, Assumâ€¦
string4         prior_doc_year;//Year that the document was recordedâ€¦
string12        prior_doc_number;//The document number used by some counties to record sales transactions (e.g., 00â€¦
string12        prior_book_and_page;//The Book and Page number used by some counties to catalog their sales recordingsâ€¦
string1         prior_sales_deed_category_code;//The type of deed used to record the prior sales transaction (e.g., Grant, Quit, â€¦
string8         prior_recording_date;//The date the sales transaction was recorded at the county (e.g., 19621028)â€¦
string8         prior_sales_date;//The date the sales transaction was legally completed (i.e., contact signed) (e.gâ€¦
string11        prior_sales_price;//Price of the sale as depicted on the recorded sales transaction.â€¦
string1         prior_sales_code;//This field indicates whether the financial consideration is F = Full or P = Partâ€¦
string3         prior_sales_transaction_code;//This identifies situations associated with the sale (e.g., Resale, Construction â€¦
string1         prior_multi_apn_flag;//The data contained in this field depicts multiple or split parcel sales. Please â€¦
string4         prior_multi_apn_count;//This reflects the number of parcels associated with the sale (e.g., 14 parcels râ€¦
string11        prior_mortgage_amount;//This is the amount associated with the mortgage of the prior sale.â€¦
string1         prior_deed_type;//Type of deed used for recording (e.g., Agreement of Sale, Assumption, Correctionâ€¦
string1         absentee_indicator;//This field will be set with an A if the owner lives at a different location.â€¦
string2         property_indicator_code;//FACL generated code to easily identify types of property (Residential, Commerciaâ€¦
string9         building_square_feet;//The size of the building in Square Feet. This field is most commonly populated aâ€¦
string1         partial_interest_indicator;//An indicator showing the Owner//Buyer has a partial interest in the propertyâ€¦
string3         ownership_transfer_percentage;//A percentile showing the percentage of ownership transferredâ€¦
string3         universal_luse_code;//A FACL established Land Use code converted from various county Land Use codes toâ€¦
string2         pri_cat_code;//Primary category of the transaction type (i.e.: arms length)â€¦
string3         mortgage_interest_rate_type;//Interest rate type of the loan (Adjustable, Fixed)â€¦
string60        title_company_name;//This is the Title Company associated with the sales transactionâ€¦
string1         seller_carry_back;//Indicator showing the Seller carried the mortgageâ€¦
string1         private_party_lender;//Indicator showing the Lender is a Private Partyâ€¦
string1         construction_loan;//Indicator showing the loan is for constructionâ€¦
string1         resale_new_construction_m_resale_n_;//M shows the sale is a re-sale, N shows the sale is for new constructionâ€¦
string1         inter_family;//Indicator showing the sale is inter-familyâ€¦
string1         cash_mortgage_purchase_q_cash_r_mor;//Q indicates the sale was for cash, R indicates the sale was mortgagedâ€¦
string1         foreclosure;//Indicator showing the transaction is a foreclosureâ€¦
string1					refiflag;  //Indicator showing the transaction is a re-financeâ€¦
string1					equityflag;  //Indicator showing the transaction is an equity loanâ€¦
string6					tract;  //Comprised of Census Tract, Census Block and Census Block Suffix. These numbers aâ€¦
string1					blockgroup;  //Comprised of Census Tract, Census Block and Census Block Suffix. These numbers aâ€¦
string2         block;//Comprised of Census Tract, Census Block and Census Block Suffix. These numbers aâ€¦
string1         block_suffix;//Comprised of Census Tract, Census Block and Census Block Suffix. These numbers aâ€¦
string8         latitude_6_2;//The property location based upon the latitude component of latitude//longitude â€¦
string9         longitude_3_6;//The property location based upon the longitude component of latitude//longitudeâ€¦
string9         filler;//fillerâ€¦
string60        Iris_pidirisfrmtd;//APN that would link to FACL online products.â€¦
string2       	crlf;

END;