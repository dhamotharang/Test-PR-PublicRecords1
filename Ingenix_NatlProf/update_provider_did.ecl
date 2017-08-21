import Ingenix_natlprof;

prev_base := Ingenix_NatlProf.Basefile_Provider_Did;

ingenix_natlprof.Layout_In_Clean_Provider tslim(ingenix_natlprof.Layout_provider_base L) := transform

self := L;

end;

silm_base := project(prev_base, tslim(left));

in_file := Ingenix_NatlProf.File_in_Clean_Provider + silm_base;

file_dist := distribute(in_file, hash(FILETYP,ProviderID,AddressID));

//file_sort := sort(file_dist, FILETYP,ProviderID,AddressID,LastName,FirstName,MiddleName,Suffix,Address,Address2,City,
//                State,ZIP,extzip,BirthDate,PhoneNumber,-PROCESSDATE, local);
				 
file_sort := sort(in_file, FILETYP,ProviderID,AddressID,LastName,FirstName,MiddleName,Suffix,ProviderNameCompanyCount,ProviderNameTierID,Address,Address2,City,
                 State,County,ZIP,ExtZip,Latitude,Longitute,ProviderAddressCompanyCount,ProviderAddressTierTypeID,ProviderAddressTypeCode,BirthDate,BirthDateCompanyCount,
				 BirthDateTierTypeID,TaxID,TaxIDCompanyCount,TaxIDTierTypeID,PhoneNumber,PhoneType,PhoneNumberCompanyCount,PhoneNumberTierTypeID, -PROCESSDATE, local);


ingenix_natlprof.Layout_In_Clean_Provider  rollupXform(file_sort l, file_sort r) := transform
		self.Processdate    := if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
		self.dt_First_Seen := if(l.dt_First_Seen > r.dt_First_Seen, r.dt_First_Seen, l.dt_First_Seen);
		self.Dt_Last_Seen  := if(l.Dt_Last_Seen  < r.dt_Last_Seen,  r.dt_Last_Seen,  l.dt_Last_Seen);
		self.dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
		self.dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);
		self := l;
end;

//export Update_provider_DID:= rollup(file_sort,rollupXform(LEFT,RIGHT),FILETYP + ProviderID + AddressID + LastName + FirstName + MiddleName + Suffix + Address + Address2 + City
//                                    + State + ZIP + extzip + BirthDate + PhoneNumber, local);
									 
export Update_provider_did := rollup(file_sort,rollupXform(LEFT,RIGHT),RECORD,
                                EXCEPT Processdate, dt_First_Seen, dt_Last_Seen,
								dt_Vendor_First_Reported, dt_Vendor_Last_Reported,ProviderNameCompanyCount,ProviderNameTierID,
								Latitude,Longitute,ProviderAddressCompanyCount,ProviderAddressTierTypeID,BirthDateCompanyCount,
								BirthDateTierTypeID,TaxIDCompanyCount,TaxIDTierTypeID,PhoneNumberCompanyCount,
								PhoneNumberTierTypeID, local);



