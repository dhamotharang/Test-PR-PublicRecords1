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
																						ut.fntrim2upper(Website),ut.fntrim2upper(State),ut.fntrim2upper(ProfileLastUpdated),ut.fntrim2upper(County),ut.fntrim2upper(ServiceArea),ut.fntrim2upper(Region1),ut.fntrim2upper(Region2),ut.fntrim2upper(Region3),ut.fntrim2upper(Region4),
																						ut.fntrim2upper(Region5),ut.fntrim2upper(FName),ut.fntrim2upper(LName),ut.fntrim2upper(MName),ut.fntrim2upper(Suffix),ut.fntrim2upper(Title),ut.fntrim2upper(Ethnicity),ut.fntrim2upper(Gender),ut.fntrim2upper(Address1),ut.fntrim2upper(Address2),ut.fntrim2upper(AddressCity),
																						ut.fntrim2upper(AddressState),ut.fntrim2upper(AddressZipcode),ut.fntrim2upper(AddressZip4),ut.fntrim2upper(Building),ut.fntrim2upper(Contact),ut.fntrim2upper(Phone1),ut.fntrim2upper(Phone2),ut.fntrim2upper(Phone3),ut.fntrim2upper(Cell),ut.fntrim2upper(Fax),
																						ut.fntrim2upper(Email1),ut.fntrim2upper(Email2),ut.fntrim2upper(Email3),ut.fntrim2upper(Webpage1),ut.fntrim2upper(Webpage2),ut.fntrim2upper(Webpage3),ut.fntrim2upper(BusinessName),ut.fntrim2upper(DBA),ut.fntrim2upper(BusinessID),
																						ut.fntrim2upper(BusinessType1),ut.fntrim2upper(BusinessLocation1),ut.fntrim2upper(BusinessType2),ut.fntrim2upper(BusinessLocation2),ut.fntrim2upper(BusinessType3),ut.fntrim2upper(BusinessLocation3),
																						ut.fntrim2upper(BusinessType4),ut.fntrim2upper(BusinessLocation4),ut.fntrim2upper(BusinessType5),ut.fntrim2upper(BusinessLocation5),ut.fntrim2upper(Industry),
																						ut.fntrim2upper(Trade),ut.fntrim2upper(ResourceDescription),ut.fntrim2upper(NatureofBusiness),ut.fntrim2upper(BusinessDescription),ut.fntrim2upper(BusinessStructure),
																						ut.fntrim2upper(TotalEmployees),ut.fntrim2upper(AvgContractSize),ut.fntrim2upper(FirmID),ut.fntrim2upper(FirmLocationAddress),ut.fntrim2upper(FirmLocationAddressCity), 
																						ut.fntrim2upper(FirmLocationAddressZip4),ut.fntrim2upper(FirmLocationAddressZipCode),ut.fntrim2upper(FirmLocationCounty),ut.fntrim2upper(FirmLocationState),
																						ut.fntrim2upper(CertFed),ut.fntrim2upper(CertState),ut.fntrim2upper(ContractsFederal),ut.fntrim2upper(ContractsVA),ut.fntrim2upper(ContractsCommercial),ut.fntrim2upper(ContractorGovernmentPrime), 
																						ut.fntrim2upper(ContractorGovernmentSub),ut.fntrim2upper(ContractorNonGovernment),ut.fntrim2upper(RegisteredGovernmentBus),ut.fntrim2upper(RegisteredNonGovernmentBus), 
																						ut.fntrim2upper(ClearanceLevelPersonnel),ut.fntrim2upper(ClearanceLevelFacility),ut.fntrim2upper(CertificateDateFrom1),ut.fntrim2upper(CertificateDateTo1),ut.fntrim2upper(CertificateStatus1), 
																						ut.fntrim2upper(CertificationNumber1),ut.fntrim2upper(CertificationType1),ut.fntrim2upper(CertificateDateFrom2),ut.fntrim2upper(CertificateDateTo2),ut.fntrim2upper(CertificateStatus2), 
																						ut.fntrim2upper(CertificationNumber2),ut.fntrim2upper(CertificationType2),ut.fntrim2upper(CertificateDateFrom3),ut.fntrim2upper(CertificateDateTo3),ut.fntrim2upper(CertificateStatus3), 
																						ut.fntrim2upper(CertificationNumber3),ut.fntrim2upper(CertificationType3),ut.fntrim2upper(CertificateDateFrom4),ut.fntrim2upper(CertificateDateTo4),ut.fntrim2upper(CertificateStatus4), 
																						ut.fntrim2upper(CertificationNumber4),ut.fntrim2upper(CertificationType4),ut.fntrim2upper(CertificateDateFrom5),ut.fntrim2upper(CertificateDateTo5),ut.fntrim2upper(CertificateStatus5),  
																						ut.fntrim2upper(CertificationNumber5),ut.fntrim2upper(CertificationType5),ut.fntrim2upper(CertificateDateFrom6),ut.fntrim2upper(CertificateDateTo6),ut.fntrim2upper(CertificateStatus6), 
																						ut.fntrim2upper(CertificationNumber6),ut.fntrim2upper(CertificationType6),ut.fntrim2upper(StarRating),ut.fntrim2upper(Assets),ut.fntrim2upper(BidDescription),ut.fntrim2upper(CompetitiveAdvantage), 
																						ut.fntrim2upper(CageCode),ut.fntrim2upper(CapabilitiesNarrative),ut.fntrim2upper(Category),ut.fntrim2upper(ChtrClass),ut.fntrim2upper(ProductDescription1),ut.fntrim2upper(ProductDescription2),ut.fntrim2upper(ProductDescription3),   
																						ut.fntrim2upper(ProductDescription4),ut.fntrim2upper(ProductDescription5),ut.fntrim2upper(ClassDescription1),ut.fntrim2upper(SubClassDescription1),ut.fntrim2upper(ClassDescription2),ut.fntrim2upper(SubClassDescription2), 
																						ut.fntrim2upper(ClassDescription3),ut.fntrim2upper(SubClassDescription3),ut.fntrim2upper(ClassDescription4),ut.fntrim2upper(SubClassDescription4),ut.fntrim2upper(ClassDescription5),ut.fntrim2upper(SubClassDescription5), 
																						ut.fntrim2upper(Classifications),ut.fntrim2upper(Commodity1),ut.fntrim2upper(Commodity2),ut.fntrim2upper(Commodity3),ut.fntrim2upper(Commodity4),ut.fntrim2upper(Commodity5),ut.fntrim2upper(Commodity6),ut.fntrim2upper(Commodity7),ut.fntrim2upper(Commodity8), 
																						ut.fntrim2upper(CompleteDate),ut.fntrim2upper(CrossReference),ut.fntrim2upper(DateEstablished),ut.fntrim2upper(BusinessAge),ut.fntrim2upper(Deposits),ut.fntrim2upper(DUNSNumber),ut.fntrim2upper(EntType),ut.fntrim2upper(ExpirationDate),ut.fntrim2upper(ExtendedDate),  
																						ut.fntrim2upper(IssuingAuthority),ut.fntrim2upper(Keywords),ut.fntrim2upper(LicenseNumber),ut.fntrim2upper(LicenseType),ut.fntrim2upper(MinCD),ut.fntrim2upper(MinorityAffiliation),ut.fntrim2upper(MinorityOwnershipDate), 
																						ut.fntrim2upper(SICCode1),ut.fntrim2upper(SICCode2),ut.fntrim2upper(SICCode3),ut.fntrim2upper(SICCode4),ut.fntrim2upper(SICCode5),ut.fntrim2upper(SICCode6),ut.fntrim2upper(SICCode7),ut.fntrim2upper(SICCode8),ut.fntrim2upper(NAICSCode1),ut.fntrim2upper(NAICSCode2),ut.fntrim2upper(NAICSCode3), 
																						ut.fntrim2upper(NAICSCode4),ut.fntrim2upper(NAICSCode5),ut.fntrim2upper(NAICSCode6),ut.fntrim2upper(NAICSCode7),ut.fntrim2upper(NAICSCode8),ut.fntrim2upper(Prequalify),ut.fntrim2upper(ProcurementCategory1),ut.fntrim2upper(SubprocurementCategory1), 
																						ut.fntrim2upper(ProcurementCategory2),ut.fntrim2upper(SubprocurementCategory2),ut.fntrim2upper(ProcurementCategory3),ut.fntrim2upper(SubprocurementCategory3),ut.fntrim2upper(ProcurementCategory4), 
																						ut.fntrim2upper(SubprocurementCategory4),ut.fntrim2upper(ProcurementCategory5),ut.fntrim2upper(SubprocurementCategory5),ut.fntrim2upper(Renewal),ut.fntrim2upper(RenewalDate),ut.fntrim2upper(UnitedCertProgramPartner), 
																						ut.fntrim2upper(VendorKey),ut.fntrim2upper(Vendornumber),ut.fntrim2upper(WorkCode1),ut.fntrim2upper(WorkCode2),ut.fntrim2upper(WorkCode3),ut.fntrim2upper(WorkCode4),ut.fntrim2upper(WorkCode5),ut.fntrim2upper(WorkCode6),ut.fntrim2upper(WorkCode7),ut.fntrim2upper(WorkCode8),ut.fntrim2upper(Exporter), 
																						ut.fntrim2upper(ExportBusinessActivities),ut.fntrim2upper(ExportTo),ut.fntrim2upper(ExportBusinessRelationships),ut.fntrim2upper(ExportObjectives),ut.fntrim2upper(Reference1),ut.fntrim2upper(Reference2),ut.fntrim2upper(Reference3),local);


	output_Dataset 		:= pDataset_rollup;
						 
	return output_Dataset;
end;
