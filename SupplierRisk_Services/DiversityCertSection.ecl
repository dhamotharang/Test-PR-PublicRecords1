IMPORT AutoStandardI, Diversity_Certification, BIPV2, iesp, MDR, TopBusiness_Services;

EXPORT DiversityCertSection := MODULE


 // *********** Main function to return Diversity Certification section of the report.
 EXPORT fn_FullView(
   dataset(SupplierRisk_Services.SupplierRisk_Layouts.rec_input_ids) ds_in_ids
	 ,SupplierRisk_Services.SupplierRisk_Layouts.Section_options in_options):= FUNCTION 
  	
	FETCH_LEVEL := in_options.ReportFetchLevel;

  // Strip off the input acctno from each record, will re-attach them later.
	ds_in_unique_ids_only := project(ds_in_ids,transform(BIPV2.IDlayouts.l_xlink_ids,
	                                                       self := left,
																							           self := []));

  //
  // *** Key fetch to get diversity cert key linking data from BIP2 linkids key file.
  ds_divcert_recs := Diversity_Certification.Key_LinkIds.KeyFetch(
	                         ds_in_unique_ids_only, // input file to join key with
													 FETCH_LEVEL); // level of ids to join with
							  					 // 3rd parm is ScoreThreshold, take default of 0

	divcert_recs := SORT(ds_divcert_recs,-dt_vendor_last_reported,RECORD);
	
	iesp.diversitycertification.t_DiversityCertificationRecord xfm_divcertRecs(recordof(ds_divcert_recs) l) := TRANSFORM
		SELF.FederallyCertified := l.certfed;
		SELF.StateCertified := l.certstate;
		SELF.AcceptsFederalContracts := l.contractsfederal;
		SELF.AcceptsVAContacts := l.contractsva;
		SELF.AcceptsCommercialContracts := l.contractscommercial;
		SELF.IsGovernmentPrimeContractor := l.ContractorGovernmentPrime;
		SELF.IsGovernmentSubContractor := l.ContractorGovernmentSub;
		SELF.IsNonGovernmentContractor := l.ContractorNonGovernment;
		SELF.IsGovernmentRegisteredBusiness := l.registeredgovernmentbus;
		SELF.IsNonGovernmentRegisteredBusiness := l.registerednongovernmentbus;
		SELF.Minority.Affiliation := l.minorityaffiliation;
		SELF.Minority.OwnershipDate := iesp.ECL2ESP.toDatestring8(l.minorityownershipdate);
		SELF.PrequalifiedForBidding := l.prequalify;
		SELF.Vendor.key := l.vendorkey;
		SELF.Vendor.number := l.vendornumber;
		SELF.IssuingAuthority := l.issuingauthority;
		SELF.Renewal := stringlib.StringToUpperCase(l.renewal) = 'RENEWAL';
		
		certTrans(String DateTo, String DateFrom, String Status, String Number, String _Type) := 
					TRANSFORM(iesp.diversitycertification.t_DivCertCertification,
												SELF.Date.StartDate := iesp.ECL2ESP.toDatestring8(DateFrom);
												SELF.Date.EndDate := iesp.ECL2ESP.toDatestring8(DateTo);
												SELF.Status := Status,
												SELF.Number := Number,
												SELF._Type := _Type);
		
		certRecs := DATASET([ CertTrans(l.certificatedateto1,l.certificatedatefrom1,l.certificatestatus1,l.certificationnumber1,l.certificationtype1),
													CertTrans(l.certificatedateto2,l.certificatedatefrom2,l.certificatestatus2,l.certificationnumber2,l.certificationtype2),
													CertTrans(l.certificatedateto3,l.certificatedatefrom3,l.certificatestatus3,l.certificationnumber3,l.certificationtype3),
													CertTrans(l.certificatedateto4,l.certificatedatefrom4,l.certificatestatus4,l.certificationnumber4,l.certificationtype4),
													CertTrans(l.certificatedateto5,l.certificatedatefrom5,l.certificatestatus5,l.certificationnumber5,l.certificationtype5),
													CertTrans(l.certificatedateto6,l.certificatedatefrom6,l.certificatestatus6,l.certificationnumber6,l.certificationtype6)]);
		SELF.Certifications := CHOOSEN(certRecs(Date.StartDate.Year != 0 or Date.EndDate.Year !=0 or Status!='' or Number != '' or _Type != ''),iesp.constants.DiversityCert.MaxCertifications);
		
		exportRecs := DATASET([{l.exporter,l.exportbusinessactivities,l.exportto,l.exportbusinessrelationships,l.exportobjectives}],iesp.diversitycertification.t_DivCertExporter);
		SELF.Exporters := CHOOSEN(exportRecs,iesp.constants.DiversityCert.MaxExports);
		
		refRecs := DATASET([{l.reference1},{l.reference2},{l.reference3}],iesp.share.t_StringArrayItem);
    SELF.BusinessReferences := CHOOSEN(refRecs(REGEXREPLACE('\\s',value,'')!=''),iesp.constants.DiversityCert.MaxBusinessReferences);
		
		procRecs := DATASET([{l.procurementcategory1,l.subprocurementcategory1},
											 	 {l.procurementcategory2,l.subprocurementcategory2},
												 {l.procurementcategory3,l.subprocurementcategory3},
												 {l.procurementcategory4,l.subprocurementcategory4},
												 {l.procurementcategory5,l.subprocurementcategory5}],iesp.diversitycertification.t_DivCertProcurement);
		SELF.Procurements := CHOOSEN(procRecs(Category!= '' or SubCategory!= ''),iesp.constants.DiversityCert.MaxProcurements);
		
		workRecs := DATASET([{l.workcode1},{l.workcode2},{l.workcode3},{l.workcode4},
										  	 {l.workcode5},{l.workcode6},{l.workcode7},{l.workcode8}],iesp.share.t_StringArrayItem);
		SELF.WorkCodes := CHOOSEN(workRecs(REGEXREPLACE('\\s',value,'')!=''),iesp.constants.DiversityCert.MaxWorkCodes);
		SELF := [];
	END;
	
	SupplierRisk_Services.SupplierRisk_layouts.div_cert_layout format() := TRANSFORM
				divrecs := DEDUP(PROJECT(divcert_recs,xfm_divcertRecs(LEFT)),ALL);
				divfinal := CHOOSEN(divrecs,iesp.constants.DiversityCert.MaxCountSuppRiskRecords);
				
				self.DiversityCertificationRecords := divfinal;
				self.DiversityCertificationCount := COUNT(divfinal);
				self.TotalDiversityCertificationCount := COUNT(divrecs);
				
				iesp.topbusiness_share.t_TopBusinessSourceDocInfo xfm_sourcedoc(SupplierRisk_Layouts.rec_input_ids l) := TRANSFORM
						TopBusiness_Services.IDMacros.mac_IespTransferLinkids(false)
						self.source := MDR.sourceTools.src_Diversity_Cert;
						self := [];
				END;
				
				sourceDoc := PROJECT(ds_in_ids[1],xfm_sourcedoc(LEFT));
				self.sourcedocs := IF(EXISTS(divrecs),sourceDoc);;
				self.acctno := ds_in_ids[1].acctno;
				self := [];
	end;
	
	divcert_final_results := DATASET([format()]);
	return divcert_final_results;
	 
 END; // end of the fn_FullView function
	
END; //end of the module