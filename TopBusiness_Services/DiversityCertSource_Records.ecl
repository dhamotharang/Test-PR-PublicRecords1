// ================================================================================
// ===== RETURNS Diversity Cert Source Docs and Count Info 
// ================================================================================
IMPORT BIPV2, Diversity_Certification, iesp;

EXPORT DiversityCertSource_Records (
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
	SHARED div_key_layout := RECORD
		Diversity_Certification.layouts.Temp.unique_id;
	END;
 
	SHARED div_layout_wLinkIds := RECORD
		Layouts.rec_input_ids_wSrc;
		Diversity_Certification.Layouts.KeyBuild - BIPV2.IDlayouts.l_header_ids;
	END;
	
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get div cert keys
  ds_divkeys := PROJECT(Diversity_Certification.Key_LinkIds.KeyFetch(in_docs_linkonly,inoptions.fetch_level,,
	                     TopBusiness_Services.Constants.SlimKeepLimit),
																TRANSFORM(Layouts.rec_input_ids_wSrc,
																					SELF.IdValue := (STRING) LEFT.unique_id,
																					SELF := LEFT,
																					SELF := []));
																					
	div_keys_comb := in_docids+ds_divkeys;
	
	div_keys := PROJECT(div_keys_comb(IdValue != ''),TRANSFORM(div_key_layout,SELF.unique_id := (INTEGER) LEFT.IdValue));
	
	div_keys_dedup := DEDUP(div_keys,ALL); 
	
	// Since there is no existing ???_Services.raw(???) that accesses diversity cert data,
	// source doc will be built using divcer unique_id key.
	div_recs := JOIN(div_keys_dedup,Diversity_Certification.Key_UniqueID,
														KEYED(LEFT.unique_id = RIGHT.unique_id),
														TRANSFORM(Diversity_Certification.Layouts.KeyBuild,
																					SELF := RIGHT,
																					SELF := LEFT,
																					SELF := []),LIMIT(TopBusiness_Services.Constants.defaultJoinLimit,SKIP));
	
	div_recs_wLinkIds := JOIN(div_recs,div_keys_comb,
																					(STRING) LEFT.unique_id = RIGHT.IdValue,
																					TRANSFORM(div_layout_wLinkIds,
																							SELF := RIGHT,
																							SELF := LEFT),
																					KEEP(1));   // For cases in which a idvalue has multiple linkids
	
	
	SHARED div_recs_grp := GROUP(SORT(div_recs_wLinkIds,unique_id),unique_id);
	
	iesp.share.t_Address xform_addresses(div_layout_wLinkIds L, INTEGER cnt) := transform
		SELF.StreetName := IF(cnt=1,L.m_prim_name,L.p_prim_name);
		SELF.StreetPreDirection := IF(cnt=1,L.m_predir,L.p_predir);
		SELF.StreetNumber := IF(cnt=1,L.m_prim_range,L.p_prim_range);
		SELF.StreetSuffix := IF(cnt=1,L.m_addr_suffix,L.p_addr_suffix);
		SELF.StreetPostDirection := IF(cnt=1,L.m_postdir,L.p_postdir);
		SELF.UnitDesignation := IF(cnt=1,L.m_unit_desig,L.p_unit_desig);
		SELF.UnitNumber := IF(cnt=1,L.m_sec_range,L.p_sec_range);
		SELF.City := IF(cnt=1,L.m_v_city_name,L.p_v_city_name);
		SELF.State := IF(cnt=1,L.m_st,L.p_st);
		SELF.Zip5 := IF(cnt=1,L.m_zip,L.p_zip);
		SELF.Zip4 := IF(cnt=1,L.m_zip4,L.p_zip4);
		SELF := [];
	end;
	
	iesp.diversitycertification.t_DivCertProcurement xform_procurements(div_layout_wLinkIds L, integer C) := transform
		SELF.Category := CHOOSE(C,L.ProcurementCategory1,L.ProcurementCategory2,L.ProcurementCategory3,
															L.ProcurementCategory4,L.ProcurementCategory5);
		SELF.SubCategory := CHOOSE(C,L.SubprocurementCategory1,L.SubprocurementCategory2,L.SubprocurementCategory3,
																	L.SubprocurementCategory4,L.SubprocurementCategory5);  
	END;
	
	iesp.diversitycertification.t_DivCertSICCode xform_siccodes(div_layout_wLinkIds L, integer C) := transform
		SELF.Code := CHOOSE(C,L.SICCode1,L.SICCode2,L.SICCode3,L.SICCode4,L.SICCode5,L.SICCode6,L.SICCode7,L.SICCode8);
		SELF.Description := CHOOSE(C,L.SICCode1_desc,L.SICCode2_desc,L.SICCode3_desc,L.SICCode4_desc,
																	L.SICCode5_desc,L.SICCode6_desc,L.SICCode7_desc,L.SICCode8_desc);  
	END;
	
	iesp.diversitycertification.t_DivCertNAICSCodes xform_naiccodes(div_layout_wLinkIds L, integer C) := transform
		SELF.Code := CHOOSE(C,L.NAICSCode1,L.NAICSCode2,L.NAICSCode3,L.NAICSCode4,L.NAICSCode5,L.NAICSCode6,L.NAICSCode7,L.NAICSCode8);
		SELF.Description := CHOOSE(C,L.NAICSCode1_desc,L.NAICSCode2_desc,L.NAICSCode3_desc,L.NAICSCode4_desc,
																	L.NAICSCode5_desc,L.NAICSCode6_desc,L.NAICSCode7_desc,L.NAICSCode8_desc);  
	END;
		
	iesp.diversitycertification.t_DivCertLocation xform_locations(div_layout_wLinkIds L, integer C) := transform
		SELF._type := CHOOSE(C,L.BusinessType1,L.BusinessType2,L.BusinessType3,L.BusinessType4,L.BusinessType5);
		SELF.Location := CHOOSE(C,L.BusinessLocation1,L.BusinessLocation2,L.BusinessLocation3,L.BusinessLocation4,L.BusinessLocation5);  
	END;
	
	iesp.diversitycertification.t_DivCertClassDescription xform_classDesc(div_layout_wLinkIds L, integer C) := transform
		SELF.Main := CHOOSE(C,L.ClassDescription1,L.ClassDescription2,L.ClassDescription3,L.ClassDescription4,L.ClassDescription5);
		SELF.Sub := CHOOSE(C,L.SubClassDescription1,L.SubClassDescription2,L.SubClassDescription3,L.SubClassDescription4,L.SubClassDescription5);  
	END;
	
	iesp.diversitycertification.t_DivCertCertification xform_certificates(div_layout_wLinkIds L, integer C) := transform
		startDate := CHOOSE(C,L.certificatedatefrom1,L.certificatedatefrom2,L.certificatedatefrom3,
													L.certificatedatefrom4,L.certificatedatefrom5,L.certificatedatefrom6);
													
		endDate := CHOOSE(C,L.certificatedateto1,L.certificatedateto2,L.certificatedateto3,
													L.certificatedateto4,L.certificatedateto5,L.certificatedateto6);
													
		SELF.Date.StartDate := iesp.ECL2ESP.toDatestring8(startDate);
		SELF.Date.EndDate := iesp.ECL2ESP.toDatestring8(endDate);
		SELF.Status := CHOOSE(C,L.certificatestatus1,L.certificatestatus2,L.certificatestatus3,
														L.certificatestatus4,L.certificatestatus5,L.certificatestatus6);
		SELF.Number := CHOOSE(C,L.certificationnumber1,L.certificationnumber2,L.certificationnumber3,
														L.certificationnumber4,L.certificationnumber5,L.certificationnumber6);
		SELF._Type := CHOOSE(C,L.certificationtype1,L.certificationtype2,L.certificationtype3,
														L.certificationtype4,L.certificationtype5,L.certificationtype6);  
	END;
	
	iesp.diversitycertification.t_DivCertPhone xform_phones(div_layout_wLinkIds L, integer C) := transform
		SELF._type := CHOOSE(C,'Phone','Phone','Phone','Cell','Fax');
		SELF.number := CHOOSE(C,L.Phone1,L.Phone2,L.Phone3,L.Cell,L.Fax);  
	END;
	
	iesp.diversitycertification.t_DivCertExporter xform_exporters(div_layout_wLinkIds L) := transform
		SELF._Type := L.Exporter;
		SELF.BusinessActivities := L.ExportBusinessActivities; 
		SELF.Regions := L.ExportTo;
		SELF.BusinessRelationships := L.ExportBusinessRelationships;
		SELF.Objectives := L.ExportObjectives;
	END;
	
	SHARED iesp.diversitycertification.t_DiversityCertificationSourceRecord toOut(div_layout_wLinkIds L,
																																								DATASET(div_layout_wLinkIds) allRows) := TRANSFORM
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.IDValue								:= (STRING) L.unique_id;
		SELF.BusinessName        		:= L.BusinessName;
		
		// Multiple records (2 normally) are created for a single unique_id when multiple addresses exist.
		addresses := DEDUP(NORMALIZE(allRows,2,xform_addresses(LEFT,counter)),ALL);
		SELF.addresses := addresses(StreetName != '');
		SELF.County := L.County;
		contactFull := IF(L.Contact != 'NONE GIVEN',L.contact,'');
		SELF.Contact.Name := iesp.ECL2ESP.SetName(L.FName,L.MName,L.LName,L.Suffix,L.Title,contactFull);
		SELF.Contact.Gender := L.Gender;
		SELF.Contact.Ethnicity := L.Ethnicity;
		phones := NORMALIZE(DATASET(L),5,xform_phones(left,counter));
		SELF.Phones := phones(number != '');
		emails := NORMALIZE(DATASET(L),3,TRANSFORM(iesp.share.t_StringArrayItem,
																			SELF.value := CHOOSE(COUNTER,LEFT.email1,LEFT.email2,LEFT.email3)));
		SELF.emails := emails(value != '');
		urls := NORMALIZE(DATASET(L),3,TRANSFORM(iesp.share.t_StringArrayItem,
																			SELF.value := CHOOSE(COUNTER,LEFT.Webpage1,LEFT.Webpage2,LEFT.Webpage3)));
		SELF.URLs := urls(value != '');
		SELF.DBA := L.DBA;
		SELF.FederallyCertified := L.certfed;
		SELF.StateCertified := L.certstate;
		SELF.AcceptsFederalContracts := L.contractsfederal;
		SELF.AcceptsVAContacts := L.contractsva;
		SELF.AcceptsCommercialContracts := L.contractscommercial;
		SELF.IsGovernmentPrimeContractor := L.ContractorGovernmentPrime;
		SELF.IsGovernmentSubContractor := L.ContractorGovernmentSub;
		SELF.IsNonGovernmentContractor := L.ContractorNonGovernment;
		SELF.IsGovernmentRegisteredBusiness := L.registeredgovernmentbus;
		SELF.IsNonGovernmentRegisteredBusiness := L.registerednongovernmentbus;
		certifications := NORMALIZE(DATASET(L),6,xform_certificates(left,counter));
		SELF.Certifications := certifications;
		SELF.DateEstablished := iesp.ECL2ESP.toDatestring8(L.DateEstablished);
		SELF.DunsNumber := L.DUNSNumber;
		SELF.ExpirationDate := iesp.ECL2ESP.toDatestring8(L.ExpirationDate);
		SELF.ExtendedDate := iesp.ECL2ESP.toDatestring8(L.ExtendedDate);
		SELF.LicenseNumber := L.LicenseNumber;
		SELF.LicenseType := L.LicenseType;
		sics := NORMALIZE(DATASET(L),8,xform_siccodes(left,counter));
		SELF.SICCodes := sics(Code != '' or Description != '');
		naics := NORMALIZE(DATASET(L),8,xform_naiccodes(left,counter));
		SELF.NAICSCode := naics(Code != '' or Description != '');
		SELF.PrequalifiedForBidding := L.Prequalify;
		procures := NORMALIZE(DATASET(L),5,xform_procurements(left,counter));
		SELF.Procurements := procures(Category != '' or SubCategory != '');
		SELF.Renewal := stringlib.StringToUpperCase(l.renewal) = 'RENEWAL';
		SELF.RenewalDate := iesp.ECL2ESP.toDatestring8(L.RenewalDate);
		wcodes := NORMALIZE(DATASET(L),8,TRANSFORM(iesp.share.t_StringArrayItem,
																			SELF.value := CHOOSE(COUNTER,LEFT.WorkCode1,LEFT.WorkCode2,LEFT.WorkCode3,
																												LEFT.WorkCode4,LEFT.WorkCode5,LEFT.WorkCode6,
																												LEFT.WorkCode7,LEFT.WorkCode8)));
		SELF.WorkCodes := wcodes(REGEXREPLACE('\\s',value,'')!='');
		references := NORMALIZE(DATASET(L),3,TRANSFORM(iesp.share.t_StringArrayItem,
																			SELF.value := CHOOSE(COUNTER,LEFT.Reference1,LEFT.Reference2,LEFT.Reference3)));
		SELF.BusinessReferences := references(REGEXREPLACE('\\s',value,'')!='');
		
		regions := NORMALIZE(DATASET(L),5,TRANSFORM(iesp.share.t_StringArrayItem,
																			SELF.value := CHOOSE(COUNTER,LEFT.Region1,LEFT.Region2,LEFT.Region3,LEFT.Region4,LEFT.Region5)));
		SELF.BusinessFirmographics.Regions := regions(REGEXREPLACE('\\s',value,'')!='');
		SELF.BusinessFirmographics.ServiceArea := L.ServiceArea;
		SELF.BusinessFirmographics.ID := L.BusinessID;
		locations := NORMALIZE(DATASET(L),5,xform_locations(left,counter));
		SELF.BusinessFirmographics.Locations := locations(_type!='' or Location != '');
		SELF.BusinessFirmographics.Industry := L.Industry;
		SELF.BusinessFirmographics.Trade := L.Trade;
		SELF.BusinessFirmographics.Resources := L.ResourceDescription;
		SELF.BusinessFirmographics.NatureOfBusiness := L.NatureofBusiness;
		SELF.BusinessFirmographics.Description := TRIM(L.BusinessDescription) + ' ' + TRIM(L.Keywords);
		SELF.BusinessFirmographics.OrgStructure := L.BusinessStructure;
		SELF.BusinessFirmographics.NumberEmployees := L.TotalEmployees;
		SELF.BusinessFirmographics.AverageContractSize := L.AvgContractSize;
		SELF.BusinessFirmographics.ClearanceLevelPersonnel := L.ClearanceLevelPersonnel;
		SELF.BusinessFirmographics.ClearanceLevelFacility := L.ClearanceLevelFacility;
		SELF.BusinessFirmographics.StarRating := L.StarRating;
		SELF.BusinessFirmographics.Assets := L.Assets;
		SELF.BusinessFirmographics.Capabilities := L.CapabilitiesNarrative;
		SELF.BusinessFirmographics.Category := L.Category;
		SELF.BusinessFirmographics.CharteringClass := L.ChtrClass;
		prodDesc := NORMALIZE(DATASET(L),5,TRANSFORM(iesp.share.t_StringArrayItem,
																			SELF.value := CHOOSE(COUNTER,LEFT.ProductDescription1,LEFT.ProductDescription2,LEFT.ProductDescription3,
																																LEFT.ProductDescription4,LEFT.ProductDescription5)));
		SELF.BusinessFirmographics.ProductDescriptions := prodDesc(value != '');
		classDesc := NORMALIZE(DATASET(L),5,xform_classDesc(left,counter));
		SELF.BusinessFirmographics.ClassDescriptions := classDesc(Main != '' or Sub != '');
		SELF.BusinessFirmographics.Classifications := L.Classifications;
		commods := NORMALIZE(DATASET(L),8,TRANSFORM(iesp.share.t_StringArrayItem,
																			SELF.value := CHOOSE(COUNTER,LEFT.Commodity1,LEFT.Commodity2,LEFT.Commodity3,
																																	LEFT.Commodity4,LEFT.Commodity5,LEFT.Commodity6,
																																	LEFT.Commodity7,LEFT.Commodity8)));
		SELF.BusinessFirmographics.Commodities := commods(value != '');	
		SELF.BusinessFirmographics.Deposits := IF(L.Deposits != '',(STRING)(INTEGER)(REAL)L.Deposits,'');
		SELF.BusinessFirmographics.ProgramPartner := L.UnitedCertProgramPartner;
		
		SELF.Minority.Classification := L.MinCD;
		SELF.Minority.Affiliation := L.MinorityAffiliation;
		SELF.Minority.OwnershipDate := iesp.ECL2ESP.toDatestring8(L.MinorityOwnershipDate);
		
		SELF.Vendor.Key := L.VendorKey;
		SELF.Vendor.Number := L.Vendornumber;
		SELF.IssuingAuthority := L.issuingauthority;
		
		SELF.Exporters := PROJECT(L,xform_exporters(LEFT));
		
		SELF := [];
	END;

	SourceView_RecsIesp := ROLLUP(div_recs_grp, GROUP, toOUT(LEFT,ROWS(LEFT)));
	EXPORT SourceView_Recs := DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT IDValue,businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
																							businessIds.dotid,businessIds.empid,businessIds.powid);
	EXPORT SourceView_RecCount := COUNT(SourceView_Recs);

END;	