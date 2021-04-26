IMPORT doxie,Address,Advo,Advo_Services,iesp,PersonReports, smartRollup;

EXPORT fn_smart_getAddrMetadata := MODULE
	
	EXPORT outLayout := RECORD(iesp.smartlinxreport.t_SLRAddressSeq)
		DATASET(iesp.bpsreport.t_BpsReportPhone) bpsPhones;
	END;

	EXPORT metaLayout := RECORD(iesp.smartlinxreport.t_SLRAddressMetaData)
		STRING20 acctNo;
	END;

	SHARED metaLayout toESDL(Advo_Services.Advo_Batch_Service_Layouts.Batch_Out L) := TRANSFORM
		SELF.AcctNo := L.AcctNo;
		SELF.RecordTypeDescription := advo.Lookup_Descriptions.Record_Type_Description_lookup_mixed(L.Record_Type_Code);
		SELF.RouteDescription := advo.Lookup_Descriptions.Route_Description_lookup(L.Route_Num);
		SELF.AddressVacancyDescription := advo.Lookup_Descriptions.Address_Vacancy_Description_lookup(L.Address_Vacancy_Indicator);
		SELF.SeasonalDeliveryDescription := advo.Lookup_Descriptions.Seasonal_Delivery_Description_lookup(L.Seasonal_Delivery_Indicator);
		SELF.DeliveryTypeDescription := advo.Lookup_Descriptions.fn_mixuse_mixed(L.Mixed_Address_Usage);
		SELF.RecordTypeCode := L.Record_Type_Code;
		SELF.RouteNumber := L.Route_Num;
		SELF.WalkSequence := L.Walk_Sequence;
		SELF.AddressVacancyIndicator := L.Address_Vacancy_Indicator;
		SELF.ThrowBackIndicator := L.Throw_Back_Indicator;
		SELF.SeasonalDeliveryIndicator := L.Seasonal_Delivery_Indicator;
		SELF.SeasonalStartSuppressionDate := iesp.ecl2esp.toDatestring8(stringlib.stringfilterout(L.Seasonal_Start_Suppression_Date,'-'));
		SELF.SeasonalEndSuppressionDate := iesp.ecl2esp.toDatestring8(stringlib.stringfilterout(L.Seasonal_End_Suppression_Date,'-'));
		SELF.DndIndicator := L.Dnd_Indicator;
		SELF.CollegeIndicator := L.College_Indicator;
		SELF.CollegeStartSuppressionDate := iesp.ecl2esp.toDatestring8(stringlib.stringfilterout(L.College_Start_Suppression_Date,'-'));
		SELF.CollegeEndSuppressionDate := iesp.ecl2esp.toDatestring8(stringlib.stringfilterout(L.College_End_Suppression_Date,'-'));
		SELF.AddressStyleFlag := L.Address_Style_Flag;
		SELF.dropIndicator := L.drop_Indicator;
		SELF.ResidentialOrBusinessIndicator := L.Residential_Or_Business_Ind;
		SELF.ResidentialOrBusinessDescription := advo.Lookup_Descriptions.fn_resbus_mixed(L.Residential_Or_Business_Ind);
		SELF.CountyNumber := L.County_Num;
		SELF.CountyName := L.County_Name;
		SELF.City := L.City_Name;
		SELF.StateCode := L.State_Code;
		SELF.StateNumber := L.State_Num;
		SELF.CongressionalDistrictNumber := L.Congressional_District_Number;
		SELF.AddressType := L.Address_Type;
		SELF.AddressTypeDescription := advo.Lookup_Descriptions.fn_addrtype(L.Address_Type);
		SELF.MixedAddressUsage := L.Mixed_Address_Usage;
		SELF.LookedUp := TRUE;
	END;

	EXPORT addresses(DATASET(iesp.smartlinxreport.t_SLRAddressBpsSeq) addresses, BOOLEAN doBadSecRange = FALSE, PersonReports.IParam._smartlinxreport param) := FUNCTION
		
		tmpLayout := RECORD(iesp.smartlinxreport.t_SLRAddressSeq AND NOT [addressCDS,Phones])
			STRING20 acctno;
			DATASET(iesp.bpsreport.t_BpsReportPhone) bpsPhones;
		END;
		tmpLayout setAcctNo(addresses l,INTEGER cnt) := TRANSFORM
			SELF.acctno := (STRING)cnt;  // join addr metadata
			SELF.address := l.addressEx; // has HRI
			SELF.bpsPhones := l.Phones;  // used for phones metadata
			SELF := l;
			SELF := [];
		END;
		Advo_Services.Advo_Batch_Service_Layouts.batch_in pullAddrs(tmpLayout l) := TRANSFORM
			SELF.acctno := l.acctNo;
			SELF.city   := l.address.City;
			SELF.state  := l.address.State;
			SELF.zip    := l.address.Zip5;
			SELF.addr   := Address.Addr1FromComponents(l.address.StreetNumber,l.address.StreetPreDirection,l.address.StreetName,
									l.address.StreetSuffix,l.address.StreetPostDirection,l.address.UnitDesignation,l.address.UnitNumber);
		END;
		tmpAddresses := PROJECT(addresses,setAcctNo(LEFT,COUNTER));
		addrMetadata := Advo_Services.Advo_Batch_Service_Records(PROJECT(tmpAddresses,pullAddrs(LEFT)),doBadSecRange);
		addrMetadataESDL := PROJECT(addrMetadata,toESDL(LEFT));

		addrMetaCDS := JOIN(tmpAddresses,addrMetadataESDL,LEFT.acctno=RIGHT.acctno,
												TRANSFORM(outLayout,SELF.addressCDS:=RIGHT,SELF:=LEFT,SELF:=[]),LEFT OUTER);
		
		// Add Key Risk Indicators
		
		iesp.smartlinxreport.t_SLRIdentity xfm_addResidentKri (iesp.bpsreport.t_BpsReportIdentitySlim inResd) := TRANSFORM
				kris := SmartRollup.fn_smart_KRIAttributes(param,(Integer)inResd.UniqueId,,,,,false);
				SELF.KriIndicators := PROJECT(kris[1],TRANSFORM(iesp.smartlinxreport.t_SLRKRIIndicators,SELF := LEFT));
				SELF := inResd;
				SELF := [];
		END;
		
		outLayout xfm_addKRI(outLayout l) := TRANSFORM
		  hidta := SmartRollup.Functions.CalcHidta(,l.addressCDS.StateCode,l.addressCDS.CountyNumber);
			hifca := SmartRollup.Functions.CalcHifca(,l.addressCDS.StateCode,l.addressCDS.CountyNumber);
			SELF.HIDTA := hidta;
			SELF.HIFCA := hifca;
			SELF.CrimeIndexInd := (hidta or hifca);
			SELF.ResidentsAML := IF(l.verified,PROJECT(l.Residents,xfm_addResidentKri(LEFT)),
																			PROJECT(l.Residents,TRANSFORM(iesp.smartlinxreport.t_SLRIdentity,SELF := LEFT,SELF:= [])));
			SELF := l;
			SELF := [];
		END;
		addrMetaKRI := PROJECT(addrMetaCDS,xfm_addKRI(LEFT));

		RETURN(IF(param.include_kris,addrMetaKRI,addrMetaCDS));
	END;
	
	EXPORT address(doxie.layout_best B, BOOLEAN doBadSecRange = FALSE) := FUNCTION
		Advo_Services.Advo_Batch_Service_Layouts.batch_in getAddr() := TRANSFORM
			SELF.acctno := (STRING)B.did,
			SELF.city   := B.city_name,
			SELF.state  := B.st,
			SELF.zip    := B.zip,
			SELF.addr   := Address.Addr1FromComponents(B.prim_range,B.predir,B.prim_name,B.suffix,B.postdir,B.unit_desig,B.sec_range)
		END;
		addrMetadata := Advo_Services.Advo_Batch_Service_Records(DATASET([getAddr()]),doBadSecRange);
		RETURN PROJECT(addrMetadata,toESDL(LEFT));
	END;
	EXPORT AddAddressSourceCounts(unsigned6 DIDVal,                                                               
                                                                dataset(  iesp.smartlinxreport.t_SLRAddressSeq) addresses,
												PersonReports.IParam._smartlinxreport param) := function

	      HeaderRecsDS := project(addresses, transform( PersonReports.layouts.header_recPlusSource, 
	      // setup address recs to be passed into above function just address and DID	
	                                                           self.did := didVal;
                                                                self.prim_range :=  left.address.StreetNumber;
											     self.predir :=  left.address.streetPreDirection;
												self.prim_name :=  left.address.streetName;
												self.suffix :=  left.address.StreetSuffix;
												self.postdir :=  left.address.StreetPostDirection;
												self.unit_desig :=  left.address.UnitDesignation;
												self.sec_range :=  left.address.UnitNumber;
												self.city_name :=  left.address.City;
												self.st :=  left.address.state;
												self.zip :=  left.address.zip5;
											      self.zip4 :=  left.address.zip4;													
											      self := [];
												));
											 	 
		outAddrWSourceInfo		:=  SmartRollup.fn_smart_getSourceCounts.GetAddressIndicators(HeaderRecsDS,param).Addresses;        
		addressesWithSourceInfo := join(addresses, outAddrWSourceInfo,
		                                left.address.state = right.address.state and
								 left.address.city = right.address.city and
						           left.address.zip5 = right.address.zip5 and
								 left.address.streetName = right.address.StreetName and
								 left.address.StreetNumber = right.address.StreetNumber and
								 left.address.UnitNumber = right.address.UnitNumber,															
                                            transform(iesp.smartlinxreport.t_SLRAddressSeq,
								    self.address.SourceCount := right.SourceCount;
								    self.address.sources := choosen(project(right.sources, transform(iesp.smartlinxreport.t_SLRSources,
										                                                                            self._type := left._type;
																								 self.Count := left.count;
																								 )), iesp.Constants.SLR.MaxSourceTypes);
								 self := left), LEFT OUTER);  
         FinalAddress :=   if ( param.include_AddressSourceInfo, addressesWithSourceInfo,  addresses);	
		 return FinalAddress;
      END;
END;