import ut;

export Rollup_Base(dataset(layouts.keybuild) pDataset) := function

pDataset_sort	:=	sort( distribute(pDataset,hash64(BusinessName)),  
												Website,State,ProfileLastUpdated,County,ServiceArea,Region1,Region2,Region3,Region4,
												Region5,FName,LName,MName,Suffix,Title,Ethnicity,Gender,Address1,Address2,AddressCity,
												AddressState,AddressZipcode,AddressZip4,Building,Contact,Phone1,Phone2,Phone3,Cell,
												Fax,Email1,Email2,Email3,Webpage1,Webpage2,Webpage3,BusinessName,DBA,BusinessID,
												BusinessType1,BusinessLocation1,BusinessType2,BusinessLocation2,BusinessType3,
												BusinessLocation3,BusinessType4,BusinessLocation4,BusinessType5,BusinessLocation5,
												Industry,Trade,ResourceDescription,NatureofBusiness,BusinessDescription,BusinessStructure,
												TotalEmployees,AvgContractSize,FirmID,FirmLocationAddress,FirmLocationAddressCity,
												FirmLocationAddressZip4,FirmLocationAddressZipCode,FirmLocationCounty,FirmLocationState,
												CertFed,CertState,ContractsFederal,ContractsVA,ContractsCommercial,ContractorGovernmentPrime,
												ContractorGovernmentSub,ContractorNonGovernment,RegisteredGovernmentBus,RegisteredNonGovernmentBus,
												ClearanceLevelPersonnel,ClearanceLevelFacility,CertificateDateFrom1,CertificateDateTo1,CertificateStatus1,
												CertificationNumber1,CertificationType1,CertificateDateFrom2,CertificateDateTo2,CertificateStatus2,
												CertificationNumber2,CertificationType2,CertificateDateFrom3,CertificateDateTo3,CertificateStatus3,
												CertificationNumber3,CertificationType3,CertificateDateFrom4,CertificateDateTo4,CertificateStatus4,
												CertificationNumber4,CertificationType4,CertificateDateFrom5,CertificateDateTo5,CertificateStatus5,
												CertificationNumber5,CertificationType5,CertificateDateFrom6,CertificateDateTo6,CertificateStatus6,
												CertificationNumber6,CertificationType6,StarRating,Assets,BidDescription,CompetitiveAdvantage,
												CageCode,CapabilitiesNarrative,Category,ChtrClass,ProductDescription1,ProductDescription2,ProductDescription3,
												ProductDescription4,ProductDescription5,ClassDescription1,SubClassDescription1,ClassDescription2,SubClassDescription2,
												ClassDescription3,SubClassDescription3,ClassDescription4,SubClassDescription4,ClassDescription5,SubClassDescription5,
												Classifications,Commodity1,Commodity2,Commodity3,Commodity4,Commodity5,Commodity6,Commodity7,Commodity8,
												CompleteDate,	CrossReference,DateEstablished,BusinessAge,Deposits,DUNSNumber,EntType,ExpirationDate,ExtendedDate,
												IssuingAuthority,Keywords,LicenseNumber,LicenseType,MinCD,MinorityAffiliation,MinorityOwnershipDate,
												SICCode1,SICCode2,SICCode3,SICCode4,SICCode5,SICCode6,SICCode7,SICCode8,NAICSCode1,NAICSCode2,NAICSCode3,
												NAICSCode4,NAICSCode5,NAICSCode6,NAICSCode7,NAICSCode8,Prequalify,ProcurementCategory1,SubprocurementCategory1,
												ProcurementCategory2,SubprocurementCategory2,ProcurementCategory3,SubprocurementCategory3,ProcurementCategory4,
												SubprocurementCategory4,ProcurementCategory5,SubprocurementCategory5,Renewal,RenewalDate,UnitedCertProgramPartner,
												VendorKey,Vendornumber,WorkCode1,WorkCode2,WorkCode3,WorkCode4,WorkCode5,WorkCode6,WorkCode7,WorkCode8,Exporter,
												ExportBusinessActivities,ExportTo,ExportBusinessRelationships,ExportObjectives,Reference1,Reference2,Reference3,local);										
   
layouts.keybuild  RollupUpdate(layouts.keybuild  l, layouts.keybuild  r) := transform
	self.dt_vendor_first_reported  	:=  if(l.dt_vendor_first_reported < r.dt_vendor_first_reported, l.dt_vendor_first_reported, r.dt_vendor_first_reported);
  self.dt_vendor_last_reported   	:= 	if(l.dt_vendor_last_reported  < r.dt_vendor_last_reported,  r.dt_vendor_last_reported,  l.dt_vendor_last_reported);
	self.dt_first_seen							:=	if(l.dt_first_seen < r.dt_first_seen, l.dt_first_seen,r.dt_first_seen);
	self.dt_last_seen								:=	if(l.dt_last_seen  < r.dt_last_seen,  r.dt_last_seen,  l.dt_last_seen);
	self.DateAdded   						    := 	if(l.DateAdded < r.DateAdded, l.DateAdded, r.DateAdded);
	self.DateUpdated   						  := 	if(l.DateUpdated < r.DateUpdated, r.DateUpdated, l.DateUpdated);
	self 													  :=  l;
end;
	
pDataset_rollup 									:= rollup(pDataset_sort,
																						RollupUpdate(left,right),
																						ut.CleanSpacesAndUpper(Website),ut.CleanSpacesAndUpper(State),ut.CleanSpacesAndUpper(ProfileLastUpdated),ut.CleanSpacesAndUpper(County),ut.CleanSpacesAndUpper(ServiceArea),ut.CleanSpacesAndUpper(Region1),ut.CleanSpacesAndUpper(Region2),ut.CleanSpacesAndUpper(Region3),ut.CleanSpacesAndUpper(Region4),
																						ut.CleanSpacesAndUpper(Region5),ut.CleanSpacesAndUpper(FName),ut.CleanSpacesAndUpper(LName),ut.CleanSpacesAndUpper(MName),ut.CleanSpacesAndUpper(Suffix),ut.CleanSpacesAndUpper(Title),ut.CleanSpacesAndUpper(Ethnicity),ut.CleanSpacesAndUpper(Gender),ut.CleanSpacesAndUpper(Address1),ut.CleanSpacesAndUpper(Address2),ut.CleanSpacesAndUpper(AddressCity),
																						ut.CleanSpacesAndUpper(AddressState),ut.CleanSpacesAndUpper(AddressZipcode),ut.CleanSpacesAndUpper(AddressZip4),ut.CleanSpacesAndUpper(Building),ut.CleanSpacesAndUpper(Contact),ut.CleanSpacesAndUpper(Phone1),ut.CleanSpacesAndUpper(Phone2),ut.CleanSpacesAndUpper(Phone3),ut.CleanSpacesAndUpper(Cell),ut.CleanSpacesAndUpper(Fax),
																						ut.CleanSpacesAndUpper(Email1),ut.CleanSpacesAndUpper(Email2),ut.CleanSpacesAndUpper(Email3),ut.CleanSpacesAndUpper(Webpage1),ut.CleanSpacesAndUpper(Webpage2),ut.CleanSpacesAndUpper(Webpage3),ut.CleanSpacesAndUpper(BusinessName),ut.CleanSpacesAndUpper(DBA),ut.CleanSpacesAndUpper(BusinessID),
																						ut.CleanSpacesAndUpper(BusinessType1),ut.CleanSpacesAndUpper(BusinessLocation1),ut.CleanSpacesAndUpper(BusinessType2),ut.CleanSpacesAndUpper(BusinessLocation2),ut.CleanSpacesAndUpper(BusinessType3),ut.CleanSpacesAndUpper(BusinessLocation3),
																						ut.CleanSpacesAndUpper(BusinessType4),ut.CleanSpacesAndUpper(BusinessLocation4),ut.CleanSpacesAndUpper(BusinessType5),ut.CleanSpacesAndUpper(BusinessLocation5),ut.CleanSpacesAndUpper(Industry),
																						ut.CleanSpacesAndUpper(Trade),ut.CleanSpacesAndUpper(ResourceDescription),ut.CleanSpacesAndUpper(NatureofBusiness),ut.CleanSpacesAndUpper(BusinessDescription),ut.CleanSpacesAndUpper(BusinessStructure),
																						ut.CleanSpacesAndUpper(TotalEmployees),ut.CleanSpacesAndUpper(AvgContractSize),ut.CleanSpacesAndUpper(FirmID),ut.CleanSpacesAndUpper(FirmLocationAddress),ut.CleanSpacesAndUpper(FirmLocationAddressCity), 
																						ut.CleanSpacesAndUpper(FirmLocationAddressZip4),ut.CleanSpacesAndUpper(FirmLocationAddressZipCode),ut.CleanSpacesAndUpper(FirmLocationCounty),ut.CleanSpacesAndUpper(FirmLocationState),
																						ut.CleanSpacesAndUpper(CertFed),ut.CleanSpacesAndUpper(CertState),ut.CleanSpacesAndUpper(ContractsFederal),ut.CleanSpacesAndUpper(ContractsVA),ut.CleanSpacesAndUpper(ContractsCommercial),ut.CleanSpacesAndUpper(ContractorGovernmentPrime), 
																						ut.CleanSpacesAndUpper(ContractorGovernmentSub),ut.CleanSpacesAndUpper(ContractorNonGovernment),ut.CleanSpacesAndUpper(RegisteredGovernmentBus),ut.CleanSpacesAndUpper(RegisteredNonGovernmentBus), 
																						ut.CleanSpacesAndUpper(ClearanceLevelPersonnel),ut.CleanSpacesAndUpper(ClearanceLevelFacility),ut.CleanSpacesAndUpper(CertificateDateFrom1),ut.CleanSpacesAndUpper(CertificateDateTo1),ut.CleanSpacesAndUpper(CertificateStatus1), 
																						ut.CleanSpacesAndUpper(CertificationNumber1),ut.CleanSpacesAndUpper(CertificationType1),ut.CleanSpacesAndUpper(CertificateDateFrom2),ut.CleanSpacesAndUpper(CertificateDateTo2),ut.CleanSpacesAndUpper(CertificateStatus2), 
																						ut.CleanSpacesAndUpper(CertificationNumber2),ut.CleanSpacesAndUpper(CertificationType2),ut.CleanSpacesAndUpper(CertificateDateFrom3),ut.CleanSpacesAndUpper(CertificateDateTo3),ut.CleanSpacesAndUpper(CertificateStatus3), 
																						ut.CleanSpacesAndUpper(CertificationNumber3),ut.CleanSpacesAndUpper(CertificationType3),ut.CleanSpacesAndUpper(CertificateDateFrom4),ut.CleanSpacesAndUpper(CertificateDateTo4),ut.CleanSpacesAndUpper(CertificateStatus4), 
																						ut.CleanSpacesAndUpper(CertificationNumber4),ut.CleanSpacesAndUpper(CertificationType4),ut.CleanSpacesAndUpper(CertificateDateFrom5),ut.CleanSpacesAndUpper(CertificateDateTo5),ut.CleanSpacesAndUpper(CertificateStatus5),  
																						ut.CleanSpacesAndUpper(CertificationNumber5),ut.CleanSpacesAndUpper(CertificationType5),ut.CleanSpacesAndUpper(CertificateDateFrom6),ut.CleanSpacesAndUpper(CertificateDateTo6),ut.CleanSpacesAndUpper(CertificateStatus6), 
																						ut.CleanSpacesAndUpper(CertificationNumber6),ut.CleanSpacesAndUpper(CertificationType6),ut.CleanSpacesAndUpper(StarRating),ut.CleanSpacesAndUpper(Assets),ut.CleanSpacesAndUpper(BidDescription),ut.CleanSpacesAndUpper(CompetitiveAdvantage), 
																						ut.CleanSpacesAndUpper(CageCode),ut.CleanSpacesAndUpper(CapabilitiesNarrative),ut.CleanSpacesAndUpper(Category),ut.CleanSpacesAndUpper(ChtrClass),ut.CleanSpacesAndUpper(ProductDescription1),ut.CleanSpacesAndUpper(ProductDescription2),ut.CleanSpacesAndUpper(ProductDescription3),   
																						ut.CleanSpacesAndUpper(ProductDescription4),ut.CleanSpacesAndUpper(ProductDescription5),ut.CleanSpacesAndUpper(ClassDescription1),ut.CleanSpacesAndUpper(SubClassDescription1),ut.CleanSpacesAndUpper(ClassDescription2),ut.CleanSpacesAndUpper(SubClassDescription2), 
																						ut.CleanSpacesAndUpper(ClassDescription3),ut.CleanSpacesAndUpper(SubClassDescription3),ut.CleanSpacesAndUpper(ClassDescription4),ut.CleanSpacesAndUpper(SubClassDescription4),ut.CleanSpacesAndUpper(ClassDescription5),ut.CleanSpacesAndUpper(SubClassDescription5), 
																						ut.CleanSpacesAndUpper(Classifications),ut.CleanSpacesAndUpper(Commodity1),ut.CleanSpacesAndUpper(Commodity2),ut.CleanSpacesAndUpper(Commodity3),ut.CleanSpacesAndUpper(Commodity4),ut.CleanSpacesAndUpper(Commodity5),ut.CleanSpacesAndUpper(Commodity6),ut.CleanSpacesAndUpper(Commodity7),ut.CleanSpacesAndUpper(Commodity8), 
																						ut.CleanSpacesAndUpper(CompleteDate),ut.CleanSpacesAndUpper(CrossReference),ut.CleanSpacesAndUpper(DateEstablished),ut.CleanSpacesAndUpper(BusinessAge),ut.CleanSpacesAndUpper(Deposits),ut.CleanSpacesAndUpper(DUNSNumber),ut.CleanSpacesAndUpper(EntType),ut.CleanSpacesAndUpper(ExpirationDate),ut.CleanSpacesAndUpper(ExtendedDate),  
																						ut.CleanSpacesAndUpper(IssuingAuthority),ut.CleanSpacesAndUpper(Keywords),ut.CleanSpacesAndUpper(LicenseNumber),ut.CleanSpacesAndUpper(LicenseType),ut.CleanSpacesAndUpper(MinCD),ut.CleanSpacesAndUpper(MinorityAffiliation),ut.CleanSpacesAndUpper(MinorityOwnershipDate), 
																						ut.CleanSpacesAndUpper(SICCode1),ut.CleanSpacesAndUpper(SICCode2),ut.CleanSpacesAndUpper(SICCode3),ut.CleanSpacesAndUpper(SICCode4),ut.CleanSpacesAndUpper(SICCode5),ut.CleanSpacesAndUpper(SICCode6),ut.CleanSpacesAndUpper(SICCode7),ut.CleanSpacesAndUpper(SICCode8),ut.CleanSpacesAndUpper(NAICSCode1),ut.CleanSpacesAndUpper(NAICSCode2),ut.CleanSpacesAndUpper(NAICSCode3), 
																						ut.CleanSpacesAndUpper(NAICSCode4),ut.CleanSpacesAndUpper(NAICSCode5),ut.CleanSpacesAndUpper(NAICSCode6),ut.CleanSpacesAndUpper(NAICSCode7),ut.CleanSpacesAndUpper(NAICSCode8),ut.CleanSpacesAndUpper(Prequalify),ut.CleanSpacesAndUpper(ProcurementCategory1),ut.CleanSpacesAndUpper(SubprocurementCategory1), 
																						ut.CleanSpacesAndUpper(ProcurementCategory2),ut.CleanSpacesAndUpper(SubprocurementCategory2),ut.CleanSpacesAndUpper(ProcurementCategory3),ut.CleanSpacesAndUpper(SubprocurementCategory3),ut.CleanSpacesAndUpper(ProcurementCategory4), 
																						ut.CleanSpacesAndUpper(SubprocurementCategory4),ut.CleanSpacesAndUpper(ProcurementCategory5),ut.CleanSpacesAndUpper(SubprocurementCategory5),ut.CleanSpacesAndUpper(Renewal),ut.CleanSpacesAndUpper(RenewalDate),ut.CleanSpacesAndUpper(UnitedCertProgramPartner), 
																						ut.CleanSpacesAndUpper(VendorKey),ut.CleanSpacesAndUpper(Vendornumber),ut.CleanSpacesAndUpper(WorkCode1),ut.CleanSpacesAndUpper(WorkCode2),ut.CleanSpacesAndUpper(WorkCode3),ut.CleanSpacesAndUpper(WorkCode4),ut.CleanSpacesAndUpper(WorkCode5),ut.CleanSpacesAndUpper(WorkCode6),ut.CleanSpacesAndUpper(WorkCode7),ut.CleanSpacesAndUpper(WorkCode8),ut.CleanSpacesAndUpper(Exporter), 
																						ut.CleanSpacesAndUpper(ExportBusinessActivities),ut.CleanSpacesAndUpper(ExportTo),ut.CleanSpacesAndUpper(ExportBusinessRelationships),ut.CleanSpacesAndUpper(ExportObjectives),ut.CleanSpacesAndUpper(Reference1),ut.CleanSpacesAndUpper(Reference2),ut.CleanSpacesAndUpper(Reference3),local);


	output_Dataset 		:= pDataset_rollup;
						 
	return output_Dataset;
end;
