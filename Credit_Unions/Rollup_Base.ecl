import ut, Credit_Unions;
export Rollup_Base(

	dataset(Credit_Unions.Layouts.Base) pDataset
	
) :=
function

	pDataset_Dist := distribute(pDataset, hash(Charter));
	 
	Credit_Unions.Layouts.Base  trans_RecID(Credit_Unions.Layouts.Base l ):=transform
	
	DATA temp_record_id := HASHMD5(ut.CleanSpacesAndUpper(l.Charter) + 
																 ut.CleanSpacesAndUpper(l.join_number) + 
																 ut.CleanSpacesAndUpper(l.SiteId) + 
																 ut.CleanSpacesAndUpper(l.CU_Name) + 
																 ut.CleanSpacesAndUpper(l.SiteName) + 
																 ut.CleanSpacesAndUpper(l.SiteTypeName) + 
																 ut.CleanSpacesAndUpper(l.MainOffice) +
																 ut.CleanSpacesAndUpper(l.Address1) + 
																 ut.CleanSpacesAndUpper(l.Address2) + 
																 ut.CleanSpacesAndUpper(l.City) +
																 ut.CleanSpacesAndUpper(l.State) + 
																 ut.CleanSpacesAndUpper(l.StateName) + 
																 ut.CleanSpacesAndUpper(l.Zip_Code) + 
																 ut.CleanSpacesAndUpper(l.CountyName) + 
																 ut.CleanSpacesAndUpper(l.Country) + 
																 ut.CleanSpacesAndUpper(l.Phone) +
																 ut.CleanSpacesAndUpper(l.Contact_Name) +               
																 ut.CleanSpacesAndUpper(l.Assets) +
																 ut.CleanSpacesAndUpper(l.Loans) +
																 ut.CleanSpacesAndUpper(l.NetWorthRatio) +
																 ut.CleanSpacesAndUpper(l.Perc_ShareGrowth) +
																 ut.CleanSpacesAndUpper(l.Perc_LoanGrowth) +
																 ut.CleanSpacesAndUpper(l.LoantoAssetsRatio) +
																 ut.CleanSpacesAndUpper(l.InvestAssetsRatio) +
																 ut.CleanSpacesAndUpper(l.NumMem) +
																 ut.CleanSpacesAndUpper(l.NumFull)
																);																	
		self.Source_rec_id := hash64(temp_record_id); 
		self							 := l;
	end;
	
  pDataset_RecID := project(pDataset ,trans_RecID(left));
	
	pDataset_sort  := sort(distribute(pDataset_RecID, hash64(charter)),
												 except 
												 dt_vendor_first_reported
												 ,dt_vendor_last_reported	
												 ,record_type
												 ,ultscore
												 ,orgscore
												 ,selescore
												 ,proxscore
												 ,powscore
												 ,empscore
												 ,dotscore
												 ,ultweight
												 ,orgweight
												 ,seleweight
												 ,proxweight
												 ,powweight
												 ,empweight
												 ,dotweight
												 ,local
												 );
											 
	
	Credit_Unions.Layouts.Base RollupUpdate(Credit_Unions.Layouts.Base l, Credit_Unions.Layouts.Base r) := transform
		self.dt_vendor_first_reported := Min(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		self.dt_vendor_last_reported 	:= Max(l.dt_vendor_last_reported, r.dt_vendor_last_reported	);
		self.cycle_date			          := (string) Max((unsigned4)l.cycle_date	,(unsigned4) r.cycle_date);
		self 													:= l;
	end;

	pDataset_rollup := rollup(pdataset_sort
														,RollupUpdate(left, right)
														,record
														,except 
														dt_vendor_first_reported
														,dt_vendor_last_reported	
														,record_type
														,cycle_date
														,source_rec_id
														,ultscore
														,orgscore
														,selescore
														,proxscore
														,powscore
														,empscore
														,dotscore
														,ultweight
														,orgweight
														,proxweight
														,seleweight
														,powweight
														,empweight
														,dotweight
														,local
													 );

	
	return pDataset_rollup;

end;