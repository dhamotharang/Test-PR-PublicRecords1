import address;
export Layouts :=
module
   shared max_size := _Dataset().max_record_size;
   export Miscellaneous :=
   module
   
      export Cleaned_Dates :=
      record
         unsigned4      ExpirationDate          ;
         unsigned4      CurrentIssueDate         ;
      end;
      
   end;
   export Input :=
   module
   
      export Sprayed :=
      record
         
         string7     LicenseNumber     ;
         string100   LastorBusinessName;
         string100   FirstName         ;
         string100   BusinessName      ;
         string50    Address1          ;
         string50    Address2          ;
         string50    City              ;
         string2     State             ;
         string5     Zip               ;
         string50    ForeignCityState  ;
         string6     CanZip            ;
         string50    Country           ;
         string50    BusinessType      ;
         string8     CorporationNumber ;
         string8     ExpirationDate    ;
         string8     CurrentIssueDate  ;
         string1     Tobacco           ;
         string2     LineofBusiness    ;
         string6     PrimaryNAICS      ;
         string6     SecondaryNAICS    ;
         string1     lf                ;
      
      end;
   end;
   ////////////////////////////////////////////////////////////////////////
   // -- Base Layouts
   ////////////////////////////////////////////////////////////////////////
   export Base :=
   record, maxlength(max_size)
		  unsigned6							    					Bid												:= 0;
		  unsigned1														Bid_score									:= 0;
      unsigned6                           Did                       := 0;
      unsigned1                           did_score                 := 0;
      unsigned6                           Bdid                      := 0;
      unsigned1                           bdid_score                := 0;
      unsigned4                           dt_first_seen                 ;
      unsigned4                           dt_last_seen                  ;
      unsigned4                           dt_vendor_first_reported      ;
      unsigned4                           dt_vendor_last_reported       ;
      string1                             record_type                   ;
      input.Sprayed      - lf             rawfields                     ;
      Address.Layout_Clean_Name           clean_contact_name            ;
      Address.Layout_Clean182_fips        Clean_Company_address         ;
      Miscellaneous.Cleaned_Dates         clean_dates                   ;
   end;
   ////////////////////////////////////////////////////////////////////////
   // -- Temporary Layouts for processing
   ////////////////////////////////////////////////////////////////////////
   export Temporary :=
   module
      export StandardizeInput := 
      record, maxlength(max_size)
         unsigned8                              unique_id   ;
         string100                           address1 ;
         string50                            address2 ;
         Base                                                  ;
      end;
      export UniqueId := 
      record, maxlength(max_size)
         unsigned8                              unique_id   ;
         Base                                                  ;
      end;
      export DidSlim := 
      record
      
         unsigned8      unique_id            ;
         string20       fname                ;
         string20       mname                ;
         string20       lname                ;
         string5        name_suffix       ;
         string10    prim_range        ;
         string28    prim_name            ;
         string8        sec_range            ;
         string5        zip5                 ;
         string2        state                ;
         string10    phone                ;
         unsigned6      did               := 0;
         unsigned1      did_score      := 0;
   
      end;
      export BdidSlim := 
      record
         unsigned8      unique_id               ;
         string100   company_name         ;
         string10    prim_range           ;
         string28    prim_name               ;
         string5        zip5                    ;
         string8        sec_range               ;
         string2        state                   ;
         string10    phone                   ;
         unsigned6      bdid              := 0;
         unsigned1      bdid_score     := 0;
   
      end;
			
      export BidSlim := 
      record
         unsigned8   unique_id         ;
         string100   company_name      ;
         string10    prim_range        ;
         string28    prim_name         ;
         string5     zip5              ;
         string8     sec_range         ;
         string2     state             ;
         string10    phone             ;
         unsigned6   bid           := 0;
         unsigned1   bid_score     := 0;
				 string7     source_party      ;
      end;
   end;
end;
