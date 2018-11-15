IMPORT PublicRecords_KEL, STD;

EXPORT Fn_CleanInputBus_Roxie( DATASET(PublicRecords_KEL.ECL_Functions.Input_ALL_Bus_Layout) ds_input) := FUNCTION

		PublicRecords_KEL.ECL_Functions.Input_ALL_Bus_Layout xfm_GetInputCleaned(PublicRecords_KEL.ECL_Functions.Input_ALL_Bus_Layout le ) := 
			TRANSFORM
				cleaned_zip       := PublicRecords_KEL.ECL_Functions.Fn_Clean_Zip(le.BusInputZipEcho);
				cleaned_Addr      := PublicRecords_KEL.ECL_Functions.Fn_Clean_Address_Roxie(le.BusInputStreetEcho, le.BusInputCityEcho, le.BusInputStateEcho, cleaned_zip);
				cleaned_email     := PublicRecords_KEL.ECL_Functions.Fn_Clean_Email(le.BusInputEmailEcho);
				cleaned_phone10   := PublicRecords_KEL.ECL_Functions.Fn_Clean_Phone(le.BusInputPhoneEcho);
				cleaned_TIN       := PublicRecords_KEL.ECL_Functions.Fn_Clean_SSN(le.BusInputTINEcho);

				// Input Echo perserved
				SELF.InputLexIDBusExtendedFamilyEcho := le.InputLexIDBusExtendedFamilyEcho;
				SELF.InputLexIDBusLegalFamilyEcho := le.InputLexIDBusLegalFamilyEcho;
				SELF.InputLexIDBusLegalEntityEcho := le.InputLexIDBusLegalEntityEcho;
				SELF.InputLexIDBusPlaceGroupEcho := le.InputLexIDBusPlaceGroupEcho;
				SELF.InputLexIDBusPlaceEcho := le.InputLexIDBusPlaceEcho;
				SELF.BusInputNameEcho := le.BusInputNameEcho;
				SELF.BusInputAlternateNameEcho := le.BusInputAlternateNameEcho;
				SELF.BusInputStreetEcho := le.BusInputStreetEcho;
				SELF.BusInputCityEcho := le.BusInputCityEcho;
				SELF.BusInputStateEcho := le.BusInputStateEcho;
				SELF.BusInputZipEcho := le.BusInputZipEcho;
				SELF.BusInputPhoneEcho := le.BusInputPhoneEcho;
				SELF.BusInputTINEcho := le.BusInputTINEcho;
				SELF.BusInputIPAddressEcho := le.BusInputIPAddressEcho;
				SELF.BusInputURLEcho := le.BusInputURLEcho;
				SELF.BusInputEmailEcho := le.BusInputEmailEcho;
				SELF.BusInputSICCodeEcho := le.BusInputSICCodeEcho;
				SELF.BusInputNAICSCodeEcho := le.BusInputNAICSCodeEcho;
				SELF.BusInputArchiveDateEcho := le.BusInputArchiveDateEcho;

				// Cleaned address
				SELF.BusInputPrimRangeClean   := cleaned_Addr.prim_range;
				SELF.BusInputPreDirClean   := cleaned_Addr.predir;
				SELF.BusInputPrimNameClean    := cleaned_Addr.prim_name;
				SELF.BusInputAddrSuffixClean  := cleaned_Addr.addr_suffix;
				SELF.BusInputPostDirClean  := cleaned_Addr.postdir;
				SELF.BusInputUnitDesigClean      := cleaned_Addr.unit_desig;
				SELF.BusInputSecRangeClean := cleaned_Addr.sec_range;
				SELF.BusInputCityClean           := cleaned_Addr.p_city_name;
				SELF.BusInputStateClean          := cleaned_Addr.st;
				SELF.BusInputZip5Clean           := cleaned_Addr.zip;
				SELF.BusInputZip4Clean           := cleaned_Addr.zip4;
				SELF.BusInputLatitudeClean       := cleaned_Addr.geo_lat;
				SELF.BusInputLongitudeClean      := cleaned_Addr.geo_long;
				SELF.BusInputAddrTypeClean    := cleaned_Addr.rec_type;
				SELF.BusInputAddrStatusClean  := cleaned_Addr.err_stat;
				SELF.BusInputCountyClean         := cleaned_Addr.county;
				SELF.BusInputGeoblockClean       := cleaned_Addr.geo_blk;
						
				// Other cleaned fields (email, phone, TIN)
				SELF.BusInputEmailClean     := cleaned_email;
				SELF.BusInputPhoneClean 		:= cleaned_phone10;
				SELF.BusInputTINClean       := cleaned_TIN;

				SELF := le;
				SELF := [];
			END;

  ds_cleanInput := PROJECT( ds_input, xfm_GetInputCleaned(LEFT) );
          
  RETURN ds_cleanInput;

END;