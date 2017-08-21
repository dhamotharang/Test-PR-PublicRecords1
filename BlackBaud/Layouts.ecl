
IMPORT LN_PropertyV2_Services;

EXPORT Layouts := MODULE
	
	EXPORT rec_input_raw := RECORD
		STRING20  acctno    := '';
		STRING20  name_last := '';
		STRING100 addr      := '';
		STRING10  zip       := '';
	END;
	
	EXPORT rec_acctnos_fids := RECORD
		STRING30  acctno             := '';
		UNSIGNED1 search_status      :=  0;
		STRING10  matchCode          := '';
		LN_PropertyV2_Services.layouts.fid;
	END;

	// The following record layout is the output format 
	// required by Blackbaud--the customer for this service.
	EXPORT rec_Blackbaud_out := RECORD
		LN_PropertyV2_Services.layouts.core;
		STRING4   Match_Code                        := ''; 
		STRING80  OwnerName                         := ''; 
		STRING20  OwnerFirst                        := ''; 
		STRING20  OwnerLast                         := ''; 
		STRING20  OwnerMi                           := ''; 
		STRING5   OwnerSuffix                       := ''; 
		STRING80  OwnerSpouse                       := ''; 
		STRING20  OwnerSpouseMi                     := ''; 
		STRING200 PropAddress                       := ''; 
		STRING25  PropCity                          := ''; 
		STRING2   PropState                         := ''; 
		STRING5   PropZip                           := ''; 
		STRING11  Assessed_Land_Value               := ''; 
		STRING11  Assessed_Improvement_Value        := ''; 
		STRING4   Assessment_Year                   := ''; 
		STRING45  Assessors_Parcel_Number           := ''; 
		STRING28  Book_Page                         := ''; 
		STRING160 Borrower                          := ''; 
		STRING200 Buyer_Mailing_Address             := ''; 
		STRING160 Buyer                             := ''; 
		STRING70  Deed_Type                         := ''; 
		STRING20  Document_Number                   := ''; 
		STRING8   Due_Date                          := ''; 
		STRING8   Estimated_Roll_Certification_Date := ''; 
		STRING41  Land_Use                          := ''; 
		STRING100 Legal_Description                 := ''; 
		STRING26  Lender_Type                       := ''; 
		STRING40  Lender                            := ''; 
		STRING11  Loan_Amount                       := ''; 
		STRING5   Loan_Type                         := ''; 
		STRING10  Lot_Size                          := ''; 
		STRING200 Mailing_Address                   := ''; 
		STRING11  Market_Improvement_Value          := ''; 
		STRING11  Market_Land_Value                 := ''; 
		STRING4   Market_Value_Year                 := ''; 
		STRING30  Mortgage_Record_For	              := 'No Boca data';
		STRING31  Mortgage_Type                     := ''; 
		STRING4   MSA                               := ''; 
		STRING160 Owner                             := ''; 
		STRING200 Property_Address                  := ''; 
		STRING480 Property_Characteristics		      := 'No Boca data';  // See LN_PropertyV2.BWR_Build_Deeds_Metadata, LN_PropertyV2.BWR_Build_Segment_Assess_Metadata
		STRING30  Property_Record_For		            := 'No Boca data';
		STRING30  Property_Transfer_Record_For		  := 'No Boca data';
		STRING41  Property_Use                      := ''; 
		STRING30  Recorded_Date		                  := 'No Boca data';
		STRING8   Recording_Date                    := ''; 
		STRING8   Sale_Date                         := ''; 
		STRING11  Sale_Price                        := ''; 
		STRING200 Seller_Mailing_Address            := ''; 
		STRING160 Seller                            := ''; 
		STRING30  Tape_Produced_By_County	          := '';
		STRING13  Tax_Amount                        := ''; 
		STRING18  Tax_Rate_Code                     := ''; 
		STRING8   Term                              := ''; 
		STRING60  Title_Company                     := ''; 
		STRING11  Total_Assessed_Value              := ''; 
		STRING11  Total_Market_Value                := ''; 
		STRING31  Type_of_Mortgage                  := ''; 
		STRING4   Year_Built                        := ''; 
		STRING5   Stories                           := ''; 
		STRING5   Units                             := ''; 
		STRING5   Bedrooms                          := ''; 
		STRING8   Baths                             := ''; 
		STRING2   Partial_Baths                     := ''; 
		STRING5   Total_Rooms                       := ''; 
		STRING3	  Fireplace                         := ''; 
		STRING30  Garage_Type                       := ''; 
		STRING5   Garage_Size                       := ''; 
		STRING27  Pool_Spa                          := ''; 
		STRING3   No_of_Buildings                   := ''; 
		STRING5   Style                             := ''; 
		STRING28  Air_Conditioning                  := ''; 
		STRING28  Heating                           := ''; 
		STRING27  Construction                      := ''; 
		STRING25  Basement                          := ''; 
		STRING30  Exterior_Walls                    := ''; 
		STRING31  Foundation                        := ''; 
		STRING28  Roof                              := ''; 
		STRING1   Elevator                          := ''; 
		STRING10  Property_Lot_Size                 := ''; 
		STRING9   Building_Area                     := ''; 
	END; //3594 CHARS
	
END;