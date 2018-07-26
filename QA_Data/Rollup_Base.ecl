IMPORT ut;

EXPORT Rollup_Base(DATASET(QA_Data.Layouts.Base) pDataset) := FUNCTION

	pDataset_Dist := DISTRIBUTE(pDataset, HASH(rawAddr.MasterAddressId));
	pDataset_sort := SORT(pDataset_Dist 
												,rawAddr.MasterAddressId
												,rawAddr.FirstName
												,rawAddr.MiddleInitial
												,rawAddr.LastName
												,rawAddr.Company
												,rawAddr.Other
												,rawAddr.Phone
												,rawAddr.DatabaseMatchCode
												,rawAddr.HomeBusinessFlag
												,rawAddr.AddressOne
												,rawAddr.AddressTwo
												,rawAddr.StreetNumber
												,rawAddr.PreDirection
												,rawAddr.StreetName
												,rawAddr.StreetType
												,rawAddr.PostDirection
												,rawAddr.Extension
												,rawAddr.ExtensionNumber
												,rawAddr.Village
												,rawAddr.City
												,rawAddr.State
												,rawAddr.ZipPlus4
												,rawAddr.ZipCode
												,rawAddr.ZipAddOn
												,rawAddr.CarrierRoute
												,rawAddr.PMB
												,rawAddr.PMBDesignator
												,rawAddr.DeliveryPoint
												,rawAddr.DeliveryPointCheckDigit
												,rawAddr.CMRA
												,rawAddr.DPV
												,rawAddr.DPVFootnote
												,rawAddr.CongressDistrict
												,rawAddr.County
												,rawAddr.CountyNumber
												,rawAddr.StateNumber
												,rawAddr.Latitude
												,rawAddr.Longitude
												,rawAddr.CensusTract
												,rawAddr.BlockNumber
												,rawAddr.BlockGroup
												,rawTrans.MasterAddressId
												//,rawTrans.Date  exclude vendor date
												,rawTrans.Category
												,rawTrans.Subcategory
												,rawTrans.Name
												,rawTrans.Company
												,rawTrans.AddressOne
												,rawTrans.AddressTwo
												,rawTrans.City
												,rawTrans.State
												,rawTrans.PostalCode
												,LOCAL );
	
	QA_Data.Layouts.Base RollupUpdate(QA_Data.Layouts.Base L, QA_Data.Layouts.Base R) := TRANSFORM
	  L_Trans_Date                  := (UNSIGNED4)StringLib.StringFilter(L.rawTrans.date, '0123456789')[1..8];
		R_Trans_Date                  := (UNSIGNED4)StringLib.StringFilter(R.rawTrans.date, '0123456789')[1..8];
		Earliest_Date                 := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
		SELF.dt_first_seen 						:= ut.EarliestDate(ut.EarliestDate(L.dt_first_seen, R.dt_first_seen)
																						        ,ut.EarliestDate(L.dt_last_seen,  R.dt_last_seen));
		SELF.dt_last_seen 						:= max(L.dt_last_seen, R.dt_last_seen);
		SELF.dt_vendor_last_reported 	:= max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported := Earliest_Date;
		SELF.record_type							:= IF(L.record_type = 'C' OR R.record_type = 'C', 'C', 'H');
		SELF.source_rec_id						:= IF(Earliest_Date = L.dt_vendor_first_reported, L.source_rec_id, R.source_rec_id);  //Use the earliest source_rec_id
		SELF.rawTrans.date						:= IF(max(L_Trans_Date, R_Trans_Date) = L_Trans_Date
		                                   ,L.rawTrans.date
																			 ,R.rawTrans.date);
		SELF                          := L;
	END;

	pDataset_rollup := ROLLUP(pDataset_sort
														,RollupUpdate(LEFT, RIGHT)
														,rawAddr.MasterAddressId
														,rawAddr.FirstName
														,rawAddr.MiddleInitial
														,rawAddr.LastName
														,rawAddr.Company
														,rawAddr.Other
														,rawAddr.Phone
														,rawAddr.DatabaseMatchCode
														,rawAddr.HomeBusinessFlag
														,rawAddr.AddressOne
														,rawAddr.AddressTwo
														,rawAddr.StreetNumber
														,rawAddr.PreDirection
														,rawAddr.StreetName
														,rawAddr.StreetType
														,rawAddr.PostDirection
														,rawAddr.Extension
														,rawAddr.ExtensionNumber
														,rawAddr.Village
														,rawAddr.City
														,rawAddr.State
														,rawAddr.ZipPlus4
														,rawAddr.ZipCode
														,rawAddr.ZipAddOn
														,rawAddr.CarrierRoute
														,rawAddr.PMB
														,rawAddr.PMBDesignator
														,rawAddr.DeliveryPoint
														,rawAddr.DeliveryPointCheckDigit
														,rawAddr.CMRA
														,rawAddr.DPV
														,rawAddr.DPVFootnote
														,rawAddr.CongressDistrict
														,rawAddr.County
														,rawAddr.CountyNumber
														,rawAddr.StateNumber
														,rawAddr.Latitude
														,rawAddr.Longitude
														,rawAddr.CensusTract
														,rawAddr.BlockNumber
														,rawAddr.BlockGroup
														,rawTrans.MasterAddressId
														//,rawTrans.Date  exclude vendor date
														,rawTrans.Category
														,rawTrans.Subcategory
														,rawTrans.Name
														,rawTrans.Company
														,rawTrans.AddressOne
														,rawTrans.AddressTwo
														,rawTrans.City
														,rawTrans.State
														,rawTrans.PostalCode
														,LOCAL );

	RETURN pDataset_rollup;

END;