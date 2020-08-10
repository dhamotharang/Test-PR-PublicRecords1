IMPORT PublicRecords_KEL, STD;

EXPORT Fn_CleanInputBus_Roxie( DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) ds_input) := FUNCTION

		PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII xfm_GetInputCleaned(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII le ) := 
			TRANSFORM
				cleaned_name      := PublicRecords_KEL.ECL_Functions.Fn_Clean_Business_Name(le.B_InpName);
				cleaned_alt_name  := PublicRecords_KEL.ECL_Functions.Fn_Clean_Business_Name(le.B_InpAltName);
				cleaned_zip       := PublicRecords_KEL.ECL_Functions.Fn_Clean_Zip(le.B_InpAddrZip);
				cleaned_Addr			:= PublicRecords_KEL.ECL_Functions.Fn_Clean_Address_Roxie(le.B_InpAddrLine1 + ' ' + le.B_InpAddrLine2, le.B_InpAddrCity, le.B_InpAddrState, cleaned_zip);
				cleaned_email     := PublicRecords_KEL.ECL_Functions.Fn_Clean_Email(le.B_InpEmail);
				cleaned_phone10   := PublicRecords_KEL.ECL_Functions.Fn_Clean_Phone(le.B_InpPhone);
				cleaned_TIN       := PublicRecords_KEL.ECL_Functions.Fn_Clean_SSN(le.B_InpTIN, IsTIN := TRUE);
				cleaned_archivedate := PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(le.B_InpArchDt, 
																																						PublicRecords_KEL.ECL_Functions.Constants.VALIDATE_DATE_RANGE_LOW_ARCHIVEDATE, 
																																						PublicRecords_KEL.ECL_Functions.Constants.VALIDATE_DATE_RANGE_HIGH_ARCHIVEDATE,
																																						SetDefault := TRUE /*if no date was input, set to current date/time*/)[1];

				// Input Echo perserved
				SELF.B_InpLexIDUlt := le.B_InpLexIDUlt;
				SELF.B_InpLexIDOrg := le.B_InpLexIDOrg;
				SELF.B_InpLexIDLegal := le.B_InpLexIDLegal;
				SELF.B_InpLexIDSite := le.B_InpLexIDSite;
				SELF.B_InpLexIDLoc := le.B_InpLexIDLoc;
				SELF.B_InpName := le.B_InpName;
				SELF.B_InpAltName := le.B_InpAltName;
				SELF.B_InpAddrLine1 := le.B_InpAddrLine1;
				SELF.B_InpAddrLine2 := le.B_InpAddrLine2;				
				SELF.B_InpAddrCity := le.B_InpAddrCity;
				SELF.B_InpAddrState := le.B_InpAddrState;
				SELF.B_InpAddrZip := le.B_InpAddrZip;
				SELF.B_InpPhone := le.B_InpPhone;
				SELF.B_InpTIN := le.B_InpTIN;
				SELF.B_InpIPAddr := le.B_InpIPAddr;
				SELF.B_InpURL := le.B_InpURL;
				SELF.B_InpEmail := le.B_InpEmail;
				SELF.B_InpSICCode := le.B_InpSICCode;
				SELF.B_InpNAICSCode := le.B_InpNAICSCode;
				SELF.B_InpArchDt := le.B_InpArchDt;

				// Cleaned Archive Date
				SELF.B_InpClnArchDt := cleaned_archivedate.ValidPortion_01 + cleaned_archivedate.TimeStamp; 

				// Cleaned address
				SELF.B_InpClnAddrPrimRng   := cleaned_Addr.prim_range;
				SELF.B_InpClnAddrPreDir      := cleaned_Addr.predir;
				SELF.B_InpClnAddrPrimName    := cleaned_Addr.prim_name;
				SELF.B_InpClnAddrSffx  := cleaned_Addr.addr_suffix;
				SELF.B_InpClnAddrPostDir     := cleaned_Addr.postdir;
				SELF.B_InpClnAddrUnitDesig   := cleaned_Addr.unit_desig;
				SELF.B_InpClnAddrSecRng    := cleaned_Addr.sec_range;
				SELF.B_InpClnAddrCity        := cleaned_Addr.v_city_name;
				SELF.B_InpClnAddrCityPost       := cleaned_Addr.p_city_name;
				SELF.B_InpClnAddrState       := cleaned_Addr.st;
				SELF.B_InpClnAddrZip5        := cleaned_Addr.zip;
				SELF.B_InpClnAddrZip4        := cleaned_Addr.zip4;
				SELF.B_InpClnAddrLat    := cleaned_Addr.geo_lat;
				SELF.B_InpClnAddrLng   := cleaned_Addr.geo_long;
				SELF.B_InpClnAddrType    := cleaned_Addr.rec_type;
				SELF.B_InpClnAddrStatus  := cleaned_Addr.err_stat;
				SELF.B_InpClnAddrStateCode := cleaned_Addr.county[1..2];
				SELF.B_InpClnAddrCnty      := cleaned_Addr.county[3..5];
				SELF.B_InpClnAddrGeo    := cleaned_Addr.geo_blk;
						
				// Other cleaned fields (Business name, email, phone, TIN)
				SELF.B_InpClnName					:= cleaned_name;
				SELF.B_InpClnAltName := cleaned_alt_name;
				SELF.B_InpClnEmail     		:= cleaned_email;
				SELF.B_InpClnPhone 				:= cleaned_phone10;
				SELF.B_InpClnTIN       		:= cleaned_TIN;

				SELF := le;
				SELF := [];
			END;

  ds_cleanInput := PROJECT( ds_input, xfm_GetInputCleaned(LEFT) );
          
  RETURN ds_cleanInput;

END;