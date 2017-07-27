
//---------Join Provider Name and Provider Address tables-------------------

//###############################Left Table##################################
Provider_id := Ingenix_NatlProf.update_Providers;

//###############################right Table##################################
Provider_Name := Ingenix_NatlProf.update_ProviderName;

//############################Layout for the Output##########################

Layout_ProvideridName := {
string  FILETYP;
string  PROCESSDATE;  
string	ProviderID;
string	LastName;
string	FirstName;
string	MiddleName;
string	Suffix;
string	Gender;
string	ProviderNameCompanyCount;
string	ProviderNameTierID;
string  clean_name;
string8  dt_first_seen;
string8  dt_last_seen;
string8  dt_vendor_first_reported;
string8  dt_vendor_last_reported;    

};

//#######################Transform for first Join################################################
Layout_ProvideridName Join_idName(Provider_id l,Provider_Name R) := Transform

self.Processdate    := if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
self.dt_First_Seen := if(l.dt_First_Seen > r.dt_First_Seen, r.dt_First_Seen, l.dt_First_Seen);
self.Dt_Last_Seen  := if(l.Dt_Last_Seen  < r.dt_Last_Seen,  r.dt_Last_Seen,  l.dt_Last_Seen);
self.dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
self.dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);		
self := L;
self := R;
end;

Joined_idName := join(Provider_id,Provider_Name,
										left.FILETYP = right.FILETYP and left.ProviderId = right.ProviderId,
										Join_idName(left,right), local);	
									   					   
//##############################Join ProviderNameAddress to Provider DOB############################
//#################################Left File##########################################
  
//###############################Right Table#################################

ProviderAddress := Ingenix_NatlProf.update_ProviderAddress;

//############################Layout for the Output##########################

Layout_ProviderNameAddress := {
string  FILETYP;
string  PROCESSDATE;  
string	ProviderID;
string	AddressID;
string	LastName;
string	FirstName;
string	MiddleName;
string	Suffix;
string	Gender;
string	ProviderNameCompanyCount;
string	ProviderNameTierID;
string  clean_name;
string  clean_address;
string	Address;
string	Address2;
string	City;
string	State;
string	County;
string	ZIP;
string 	ExtZip;
string	Latitude;
string	Longitute;
string	GeoReturn;
string	HighRisk;
string	ProviderAddressCompanyCount;
string	ProviderAddressTierTypeID;
string	ProviderAddressTypeCode;
string  ProviderAddressVerificationStatusCode;
string  ProviderAddressVerificationDate;
string8  dt_first_seen;
string8  dt_last_seen;
string8  dt_vendor_first_reported;
string8  dt_vendor_last_reported; 
};

//#######################Transform for first Join################################################
Layout_ProviderNameAddress Join_NameAddress(Joined_idName l,ProviderAddress R) := Transform

self.Processdate    := if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
self.dt_First_Seen := if(l.dt_First_Seen > r.dt_First_Seen, r.dt_First_Seen, l.dt_First_Seen);
self.Dt_Last_Seen  := if(l.Dt_Last_Seen  < r.dt_Last_Seen,  r.dt_Last_Seen,  l.dt_Last_Seen);
self.dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
self.dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);		
self := L;
self := R;
end;

Joined_NameAddress := join(Joined_idName,ProviderAddress,
										left.FILETYP = right.FILETYP and left.ProviderId = right.ProviderId,
										Join_NameAddress(left,right), left outer, local);	
									   
									   
//##############################Join ProviderNameAddress to Provider DOB############################
//#################################Left File##########################################

//############################Right File#############################################

ProviderDOB := Ingenix_NatlProf.update_ProviderBirthDate;

//###########################Layout_for_2nd Join#######################################
Layout_ProviderNameAddressDOB := {
string  FILETYP;
string  PROCESSDATE;
string	ProviderID;
string	AddressID;
string	LastName;
string	FirstName;
string	MiddleName;
string	Suffix;
string	Gender;
string	ProviderNameCompanyCount;
string	ProviderNameTierID;
string  clean_name;
string  clean_address;
string	Address;
string	Address2;
string	City;
string	State;
string	County;
string	ZIP;
string 	ExtZip;
string	Latitude;
string	Longitute;
string	GeoReturn;
string	HighRisk;
string	ProviderAddressCompanyCount;
string	ProviderAddressTierTypeID;
string	ProviderAddressTypeCode;
string  ProviderAddressVerificationStatusCode;
string  ProviderAddressVerificationDate;
string	BirthDate;
string	BirthDateCompanyCount;
string	BirthDateTierTypeID;
string8  dt_first_seen;
string8  dt_last_seen;
string8  dt_vendor_first_reported;
string8  dt_vendor_last_reported; 
};

//#####################Transform for the 2nd Join########################################

Layout_ProviderNameAddressDOB Join_NameAddDOB(Joined_NameAddress l,ProviderDOB r) := Transform

self.Processdate    := if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
self.dt_First_Seen := if(l.dt_First_Seen > r.dt_First_Seen, r.dt_First_Seen, l.dt_First_Seen);
self.Dt_Last_Seen  := if(l.Dt_Last_Seen  < r.dt_Last_Seen,  r.dt_Last_Seen,  l.dt_Last_Seen);
self.dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
self.dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);		
self := l;
self := r;
end;

Joined_NameAddDOB := join(Joined_NameAddress,ProviderDOB,
						  left.FILETYP = right.FILETYP and left.ProviderId = right.ProviderId,
						  Join_NameAddDOB(left,right),left outer,local
						 );

//#####################join NameAddDOB and TAXID########################################

//#####################left file################################################

NameAddDOB := distribute(Joined_NameAddDOB, hash(FILETYP, ProviderID, addressID));

NameAddDOB_sort := sort(NameAddDOB,FILETYP, ProviderID, addressID, local);

//#####################right file###############################################

TaxID := Ingenix_NatlProf.update_ProviderAddressTaxID;

//###################layout for output############################################

Layout_ProviderNameAddressDOBTaxID := {
string  FILETYP;
string  PROCESSDATE;
string	ProviderID;
string	AddressID;
string	LastName;
string	FirstName;
string	MiddleName;
string	Suffix;
string	Gender;
string	ProviderNameCompanyCount;
string	ProviderNameTierID;
string  clean_name;
string  clean_address;
string	Address;
string	Address2;
string	City;
string	State;
string	County;
string	ZIP;
string 	ExtZip;
string	Latitude;
string	Longitute;
string	GeoReturn;
string	HighRisk;
string	ProviderAddressCompanyCount;
string	ProviderAddressTierTypeID;
string	ProviderAddressTypeCode;
string  ProviderAddressVerificationStatusCode;
string  ProviderAddressVerificationDate;
string	BirthDate;
string	BirthDateCompanyCount;
string	BirthDateTierTypeID;
string	TaxID;
string	TaxIDCompanyCount;
string	TaxIDTierTypeID;
string8  dt_first_seen;
string8  dt_last_seen;
string8  dt_vendor_first_reported;
string8  dt_vendor_last_reported; 
};

//############################Transform for the join####################################

Layout_ProviderNameAddressDOBTaxID join_NameAddDOBTaxID(NameAddDOB_sort l,taxid r) := Transform

self.Processdate    := if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
self.dt_First_Seen := if(l.dt_First_Seen > r.dt_First_Seen, r.dt_First_Seen, l.dt_First_Seen);
self.Dt_Last_Seen  := if(l.Dt_Last_Seen  < r.dt_Last_Seen,  r.dt_Last_Seen,  l.dt_Last_Seen);
self.dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
self.dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);	
self := l;
self := r;
end;

Joined_NameAddDOBTaxID := join(NameAddDOB_sort,taxid,
							 left.ProviderId = right.ProviderId and left.FILETYP = right.FILETYP and
						     left.AddressID = right.AddressID,
							  join_NameAddDOBTaxID(left,right),left outer, local
							  );

//##############################Join for Phone No######################################

//#####################left file################################################

//################################Right File##########################################

Phone := Ingenix_NatlProf.update_ProviderAddressPhone;

//############################Layout_for_output#######################################

Layout_ProviderNameAddressDOBTaxIDPhone := {
string  FILETYP;
string  PROCESSDATE;
string	ProviderID;
string	AddressID;
string	LastName;
string	FirstName;
string	MiddleName;
string	Suffix;
string	Gender;
string	ProviderNameCompanyCount;
string	ProviderNameTierID;
string  clean_name;
string  clean_address;
string	Address;
string	Address2;
string	City;
string	State;
string	County;
string	ZIP;
string 	ExtZip;
string	Latitude;
string	Longitute;
string	GeoReturn;
string	HighRisk;
string	ProviderAddressCompanyCount;
string	ProviderAddressTierTypeID;
string	ProviderAddressTypeCode;
string  ProviderAddressVerificationStatusCode;
string  ProviderAddressVerificationDate;
string	BirthDate;
string	BirthDateCompanyCount;
string	BirthDateTierTypeID;
string	TaxID;
string	TaxIDCompanyCount;
string	TaxIDTierTypeID;
string	PhoneNumber;
string	PhoneType;
string	PhoneNumberCompanyCount;
string	PhoneNumberTierTypeID;
string8  dt_first_seen;
string8  dt_last_seen;
string8  dt_vendor_first_reported;
string8  dt_vendor_last_reported; 
};

//##################################Transform for file####################################

Layout_ProviderNameAddressDOBTaxIDPhone join_ProviderNameAddressDOBTaxIDPhone(Joined_NameAddDOBTaxID l,Phone r) := Transform

self.Processdate    := if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
self.dt_First_Seen := if(l.dt_First_Seen > r.dt_First_Seen, r.dt_First_Seen, l.dt_First_Seen);
self.Dt_Last_Seen  := if(l.Dt_Last_Seen  < r.dt_Last_Seen,  r.dt_Last_Seen,  l.dt_Last_Seen);
self.dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
self.dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);	
self := l;
self := r;
end;

joined_ProviderNameAddressDOBTaxIDPhone := join(Joined_NameAddDOBTaxID,Phone,
												left.ProviderId = right.ProviderId and left.FILETYP = right.FILETYP
										        and left.AddressId = right.AddressId,
												join_ProviderNameAddressDOBTaxIDPhone(left,right),left outer,local
												);

//##############################Join for license#######################################

//##############################Left File #############################################

//ProviderNameAddDOBTaxIDPhone := dedup(joined_ProviderNameAddressDOBTaxIDPhone,all);

Layout_ProviderNameAddressDOBTaxIDPhoneMedicareOptOut := record

		Layout_ProviderNameAddressDOBTaxIDPhone;
		
		string OptOutSiteDescription ;
		string AffidavitReceivedDate ;
		string OptOutEffectiveDate ;
		string DateOptOutTerminationDate;
		string OptOutStatus;
		string LastUpdate;

	end;						

Layout_ProviderNameAddressDOBTaxIDPhoneMedicareOptOut trans_ProviderIDMedicareOptOut(Layout_ProviderNameAddressDOBTaxIDPhone l,Ingenix_Natlprof.Layout_in_ProviderMedicareOptOut.raw_allsrc 	r):=transform
self.Processdate    						:= if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
self.dt_First_Seen						  := if(l.dt_First_Seen > r.dt_First_Seen, r.dt_First_Seen, l.dt_First_Seen);
self.Dt_Last_Seen  							:= if(l.Dt_Last_Seen  < r.dt_Last_Seen,  r.dt_Last_Seen,  l.dt_Last_Seen);
self.dt_Vendor_First_Reported 	:= if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
self.dt_Vendor_Last_Reported  	:= if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);		
self := l;
self := r;
end;


		Join_ProvNameAddrDOBTaxIDPhMedOptOut:=join( joined_ProviderNameAddressDOBTaxIDPhone,Ingenix_NatlProf.update_ProviderMedicareOptOut,
																								trim(left.ProviderID,left,right)= trim(right.ProviderID,left,right)and
																								trim(left.FILETYP,left,right)		= trim(right.FILETYP,left,right),
																								trans_ProviderIDMedicareOptOut(left,right),
																								left outer);
									
	Layout_ProvNameAddrDOBTaxIDPhMedOptOutDeceased := record

		Layout_ProviderNameAddressDOBTaxIDPhoneMedicareOptOut;
		string		DeceasedIndicator ; 
		string		DeceasedDate ;

	end;
	
Layout_ProvNameAddrDOBTaxIDPhMedOptOutDeceased trans_ProviderIDMedicareOptOutDeceased(Layout_ProviderNameAddressDOBTaxIDPhoneMedicareOptOut l,Ingenix_NatlProf.Layout_in_providerdeceased.raw_allsrc 	r):=transform
self.Processdate    					:= if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
self.dt_First_Seen 						:= if(l.dt_First_Seen > r.dt_First_Seen, r.dt_First_Seen, l.dt_First_Seen);
self.Dt_Last_Seen  						:= if(l.Dt_Last_Seen  < r.dt_Last_Seen,  r.dt_Last_Seen,  l.dt_Last_Seen);
self.dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
self.dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);		
self := l;
self := r;
end;

join_ProvNameAddrDOBTaxIDPhMedOptOutDeceased:=join( join_ProvNameAddrDOBTaxIDPhMedOptOut,Ingenix_NatlProf.update_ProviderDeceased,
																									  trim(left.ProviderID,left,right)= trim(right.ProviderID,left,right)and
																										trim(left.FILETYP,left,right)= trim(right.FILETYP,left,right),
																										trans_ProviderIDMedicareOptOutDeceased(left,right),
																										left outer);
									

export File_in_provider_joined := join_ProvNameAddrDOBTaxIDPhMedOptOutDeceased : persist('~thor_data400::persist::ingenix_provider_joined');






