import doxie,PersonReports,AutoStandardI,iesp,ut,DeathV2_Services,doxie_crs,suppress, DriversV2_Services, header,Healthcare_Header_Services;

export Person_Records (Healthcare_Header_Services.IParams.ReportParams inputData,dataset(doxie.layout_references) dsDids=dataset([],doxie.layout_references)) := MODULE

  shared gmod := AutoStandardI.GlobalModule();
	shared in_params:= MODULE(PROJECT(gmod, PersonReports.input.personal,opt)) 
		export unsigned1 neighborhoods := inputData.NeighborhoodCount;
		export unsigned1 historical_neighborhoods := inputData.HistoricalNeighborhoodCount;
		export unsigned1 relative_depth := inputData.RelativeDepth;
		export unsigned1 max_relatives := inputData.MaxRelatives;
		export boolean include_relativeaddresses := inputData.IncludeRelativeAddresses;
		export unsigned1 max_relatives_addresses  := inputData.MaxRelativeAddresses;
		export boolean include_BlankDOD := inputData.IncludeBlankDOD; // allows to return death records with no DOD
	END;

	shared mod_access := MODULE (doxie.IDataAccess)
    EXPORT unsigned1 glb := in_params.glbpurpose;
    EXPORT unsigned1 dppa := in_params.dppapurpose;
    EXPORT string DataPermissionMask := in_params.DataPermissionMask;
    EXPORT string DataRestrictionMask := in_params.DataRestrictionMask;
    EXPORT boolean ln_branded := in_params.ln_branded;
    EXPORT boolean probation_override := gmod.probationoverride;
    EXPORT string5 industry_class := in_params.industryclass;
    EXPORT string32 application_type := AutoStandardI.InterfaceTranslator.application_type_val.val(project(gmod,AutoStandardI.InterfaceTranslator.application_type_val.params));
    EXPORT boolean no_scrub := AutoStandardI.InterfaceTranslator.no_scrub.val(project(gmod,AutoStandardI.InterfaceTranslator.no_scrub.params));
		EXPORT unsigned3 date_threshold := in_params.dateVal;
    EXPORT boolean suppress_dmv := gmod.suppressDMVInfo;
    EXPORT string ssn_mask := in_params.ssn_mask;
    EXPORT unsigned1 dl_mask := IF (in_params.mask_dl, 1, 0);
	END;

	//Taken from PersonReports.Person_records modified to actually work correctly
	shared input_dids_set := SET (dsDids, did);
//	shared string6 ssn_mask_value := mod_access.ssn_mask; // unfortunate artefact: used in some macro

	// TODO: rename to src_bestrecords
//	EXPORT bestrecs := doxie.best_records (dsDids, , in_params.DPPAPurpose, in_params.GLBPurpose, true, false, , , true, includeDOD:=true); // use non-blank key, see #39788
	EXPORT bestrecs := doxie.best_records (dsDids, false, , , true, includeDOD:=true, modAccess := mod_access); // use non-blank key, see #39788

	shared src_ssn_main := Healthcare_Provider_Services.Person_records_functions.fn_ssn_records (bestrecs,,dsDids); //doxie_crs.layout_ssn_records
	export src_residents := if (in_params.include_residents,
															project (Healthcare_Provider_Services.Person_records_functions.Resident_Records(dsDids), transform (PersonReports.layouts.comp_names, self :=left)));

	// replication of a best records in doxie/central_header
	shared idid := max(dsDids(did > 0), did);//dids has no more than 1 record here. see #stored('useOnlyBestDID',true) in doxie.Comprehensive_Report_Service

	// ============================ a patch for death master records ============================
	// so far these are needed to access deceased records:
	shared glb_ok := mod_access.isValidGLB ();
	shared rna_glb_ok := mod_access.isValidDPPA (header.constants.checkRNA);
	shared death_params := DeathV2_Services.IParam.GetDeathRestrictions(gmod);

	// Get all DIDs that will be used in the report; set "is subject" indicator for a subject
	shared rec_did_owner := record (doxie.layout_references)
		boolean is_subject := false;
	end;
	export all_dids_pre1 := project (dsDids, transform (rec_did_owner, Self.did := Left.did, Self.is_subject := true;));
	export all_dids_pre2 := dedup (project (src_ssn_main (did not in input_dids_set), rec_did_owner), did, all);
	export all_dids_pre3 := dedup (project (src_residents, rec_did_owner), did, all);
	export all_dids_pre4 := project (Healthcare_Provider_Services.Person_records_functions.Get_RNA_DIDs(dsDids), rec_did_owner);
	export all_dids_pre := all_dids_pre1+all_dids_pre2+all_dids_pre3+all_dids_pre4;

	dids_owners := dedup (sort (all_dids_pre, did, ~is_subject), did);

	doxie_crs.layout_deathfile_records GetDeadRecords (rec_did_owner L, doxie.key_death_masterV2_DID R) := transform
		self.age_at_death := ut.Age((unsigned8)R.dob8,(unsigned8)R.dod8);
		self.did := (string)((integer)(R.did));
		self := R;
	end;
	dear  := JOIN (dids_owners, doxie.key_death_masterV2_DID, 
								 keyed (Left.did = Right.l_did) 
								 and not DeathV2_Services.Functions.Restricted (right.src, right.glb_flag, if (Left.is_subject, glb_ok, rna_glb_ok), death_params),
								 GetDeadRecords (Left, Right),
								 left outer, limit (ut.limits.HEADER_PER_DID), keep (ut.limits.DEATH_PER_DID)); //
	//============================

	// dear := doxie.deathfile_records (in_params.include_BlankDOD or (unsigned)dod8 != 0);
	// for the purpose of deceased indicator we need only one record per person, preferrably with a county
	export src_deceased := dedup (sort (dear, did, -dod8, trim (county_name) = ''), did, dod8);

		besr_choice := IF(EXISTS(bestrecs), bestrecs, project (dsDids, transform (doxie.layout_best, 
																																						Self.did := Left.did, Self := [];)));

		iesp.bpsreport.t_BpsReportBestInfo transform_best (doxie.layout_best L) := transform
			Self.Name := iesp.ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, L.title);
			Self.Gender := iesp.ECL2ESP.GetGender (L.title);
			Self.Address := iesp.ECL2ESP.SetAddress (L.prim_name, L.prim_range, L.predir, L.postdir,
																							 L.suffix, L.unit_desig, L.sec_range, L.city_name,
																							 L.st, L.zip, L.zip4, '', // TODO: county name
																							 '', '', '', '');
			Self.DOD := iesp.ECL2ESP.toDatestring8 (src_deceased((unsigned6)did = idid)[1].dod8);
			phs := Healthcare_Provider_Services.Person_records_functions.verifiedPhones (in_params.legacy_verified,dsDids).records;
			Self.Phones := project (phs, transform (iesp.bpsreport.t_BpsReportBestInfoPhone,
																							Self.Phone10 := Left.listed_phone, Self.TimeZone := Left.timezone));
			Self.DOB := iesp.ECL2ESP.toDate (L.dob);
			Self.SSN := if (L.ssn <> '', L.ssn, src_ssn_main (did = idid and ssn = in_params._ssn)[1].ssn);
			Self.Deceased := if (exists (src_deceased ((unsigned6)did = idid)), 'Y', 'N');
		end;
				//self.deceased := if(exists(dear((unsigned)did = idid)),'Y','N'),
		export bestrecs_esdl := project (besr_choice, transform_best (Left));


	// =======================================================================
	// ===== Driver License (Sub)Section =====================================
	// =======================================================================
	dl_rec := DriversV2_Services.layouts.result_wide;

	// need to export it just because of "we also found"
	export dlsr := choosen (project (DriversV2_Services.DLRaw.wide_view.by_did (dsDids), dl_rec), 
													iesp.Constants.MaxCountDL) : global;
	esp_drivers := project (dlsr, iesp.transform_dl_bps (Left));
	EXPORT driver_licenses := if (in_params.include_driverslicenses,
																esp_drivers,
																dataset ([], iesp.bps_share.t_BpsReportDriverLicense));

	// this is to temporarily fix the confusion with DL/DL2 in ESP layouts
	esp_drivers_v2 := iesp.transform_dl (dlsr);
	EXPORT driver_licenses_v2 := if (in_params.include_driverslicenses,
																	 esp_drivers_v2,
																	 dataset ([], iesp.driverlicense2.t_DLEmbeddedReport2Record));


	// =======================================================================
	// ====================  Address / Phones Section ========================
	// =======================================================================

	// same as doxie_crs.Comp_Addresses_Verified, but WITHOUT verification codes
	export address_orig := Healthcare_Provider_Services.Person_records_functions.Comp_Addresses(dsDids); //doxie/Layout_Comp_Addresses

	// some name variations are missing in the source addresses; try to append from complete residents' list
	// this may improve address-phone linking, since names can be used.
	address_expanded := PersonReports.Functions.Address (in_params).ExpandWithResidents (address_orig, src_residents);
	export src_address := if (in_params.expand_address, address_expanded, address_orig);


	// This is performance fix for the cases when no other data than address itself 
	// is required (like in eAuth); can be extended with risk indicators, etc. if needed.
	PersonReports.layouts.t_AddressTimeLine GetSubjectShortAddress (doxie.Layout_Comp_Addresses L) := transform
		Self.StreetName          := L.prim_name;
		Self.StreetNumber        := L.prim_range;
		Self.StreetPreDirection  := L.predir;
		Self.StreetPostDirection := L.postdir;
		Self.StreetSuffix        := L.suffix;
		Self.UnitDesignation     := L.unit_desig;
		Self.UnitNumber          := L.sec_range;
		Self.State               := L.st;
		Self.City                := L.city_name;
		Self.Zip5                := L.zip;
		Self.Zip4                := L.zip4;
		Self.County              := L.county_name;
		Self.DateLastSeen  := iesp.ECL2ESP.toDate ((unsigned4) (L.dt_last_seen + '00'));
		Self.DateFirstSeen := iesp.ECL2ESP.toDate ((unsigned4) (L.dt_first_seen + '00'));
		Self := []; //StreetAddress1, StreetAddress2, PostalCode, StateCityZip
	end;
	subj_slim := sort (address_orig (isSubject=true), -dt_last_seen, address_seq_no);
	EXPORT SubjectShortAddresses := project (subj_slim, GetSubjectShortAddress (Left));


	// Add phones to addresses
	// Fetch phones (can't call doxie.phone_records: it uses strict sec_range comparisons);
	// original addresses are used, since expanded ones don't add new addresses
	export phones_wide := doxie.fn_phone_records_wide (address_orig, false, true); // relaxed sec. range;
	shared phones_rec := record (doxie_crs.layout_phone_records)
		typeof (phones_wide.st) st;   // only for mac_AddHRIPhone call
		typeof (phones_wide.name_last) lname;  // only for mac_AddHRIPhone call
		typeof (phones_wide.omit_phone) omit_phone; // in addition to 'unpub'
	end;


	// TODO: append HRIs conditionally
	phones_wide_hri := project (phones_wide, transform (phones_rec, Self := Left; Self.hri_phone := []));
	maxHriPer_value := 10; //TODO: include into input (unsigned1 maxHriPer_value := 10 : stored('MaxHriPer'));
	doxie.mac_AddHRIPhone(phones_wide_hri, phor_pre);
	export phor := project (phor_pre, transform (phones_rec, Self.lname := Left.name_last, Self := Left));

	// FinderReport style: verifies phones by last residents' names, among other things
	// Address-phone match is done at that point, so "extra" addresses appended (if any) from residents list can be removed.
	export addr_base := PersonReports.Functions.Address (in_params).AttachPhones (src_address, phor) 
		(address_seq_no != PersonReports.Constants.APPENDED_BY_RESIDENTS);
	// ---------- Now have addresses with phones ----------



	// ====================================================================
	// ========================  Residents Section ========================
	// ====================================================================
	export ssn_lookups := Healthcare_Provider_Services.Person_records_functions.SSN_Lookups(dsDids); // doxie_crs/layout_SSN_Lookups

	shared identity := iesp.bps_share.t_BpsReportIdentity;//RECORD
	shared identity_slim := iesp.bpsreport.t_BpsReportIdentitySlim;

	// flat table of residents with SSN, death, etc. info;
	// contains DID and address sequence, which can be used for linking.
	// Residents are effectively CURRENT RESIDENTS (i.e. those who reside recently). 
	shared residents_base := PersonReports.Functions.GetPersonBase (src_residents, ssn_lookups, src_deceased, in_params);


	// ------------------------- expanded residents -------------------------
	// a serious of transformations to produce most complete identity
	// all DID-linking should be done before the rollup

	shared res_expanded := project (residents_base, PersonReports.Functions.ExpandIdentity (Left));
	shared res_grouped := group (sort (res_expanded, address_seq_no), address_seq_no);

	shared PersonReports.layouts.identity_bps_rolled RollIdentity (PersonReports.layouts.identity_bps l, dataset(PersonReports.layouts.identity_bps) r):=transform
		self.did := L.did; // note: DID can be unreliable here, if input is grouped by seq_no
		self.address_seq_no := l.address_seq_no;
		self.akas := choosen (project (r, iesp.bps_share.t_BpsReportIdentity), iesp.Constants.BR.MaxAddress_Residents);
	END;
	shared residents_wide := rollup (res_grouped, group, RollIdentity (Left, rows (Left)));


	// ------------------- slim residents -------------------
	// there's already enough info to produce slim residents
	// shared res_slim := group(sort (residents_base, address_seq_no), address_seq_no);
	shared res_slim_grouped := group (sort (residents_base, address_seq_no), address_seq_no);

	shared PersonReports.layouts.identity_slim_rolled RollIdentitySlim (PersonReports.layouts.identity_slim l, dataset(PersonReports.layouts.identity_slim) r):=transform
		self.did := L.did; // note: DID can be unreliable here, if input is grouped by seq_no
		self.address_seq_no := l.address_seq_no;
		self.akas := choosen (project (r, iesp.bpsreport.t_BpsReportIdentitySlim), iesp.Constants.BR.MaxAddress_Residents);
	END;
	export residents_slim := rollup (res_slim_grouped, group, RollIdentitySlim (Left, rows (Left)));
	// residents ready; now they can be attached to addresses


	// =======================================================================
	// ==============  Address: add Residents, Properties, etc. ==============
	// =======================================================================
	// Residents are effectively CURRENT RESIDENTS (i.e. those who reside recently). 
	// Thus, some of the addresses from address sequence table will not have residents yet (say, historical neighbors)

	// ------------------------- wide addresses -------------------------
	shared addr_wide := PersonReports.Functions.Address (in_params).AddResidents (addr_base, residents_wide);
	// NOTE: these addresses don't contain properties, census, etc. data;
	//       Since they are used in relatives and neighbors sections so far, it is not required. 
	//       But, if either is needed, it should be done here.


	// take this subject records only
	shared subj_addr := addr_wide (did IN input_dids_set);

	// Get Census info (only by request and only for subject's:
	shared subj_addr_census := if (in_params.include_censusdata,
																 PersonReports.Functions.Address (in_params).AddCensus (subj_addr),
																 subj_addr);

	// TODO: add properties, etc. here
	EXPORT x_SubjectAddresses := sort (subj_addr_census, -DateLastSeen, -DateFirstSeen, Address.Zip4, Address.StreetNumber);
	EXPORT SubjectAddresses := project (x_SubjectAddresses, iesp.bpsreport.t_BpsReportAddress);


	// -------------------------------- slim --------------------------------
	shared addr_slim := PersonReports.Functions.Address (in_params).AddResidentsSlim (addr_base, residents_slim);
	EXPORT x_SubjectAddressesSlim := sort (addr_slim (did IN input_dids_set), -DateLastSeen, -DateFirstSeen, Address.Zip4, Address.StreetNumber);
	EXPORT SubjectAddressesSlim := project (x_SubjectAddressesSlim, iesp.bpsreport.t_BpsReportAddressSlim);




	// =======================================================================
	// ===== Imposters Section ===============================================
	// =======================================================================
	// Imposters are defined as complete bps identity layout, but it seems that actually they are
	// represented by a slim Identity in the output

	// flat table of ssn records, containing imposters and subject's AKAs
	// contains DID, which can be used for linking 
	shared all_persons := PersonReports.Functions.GetSSNRecordsBase (src_ssn_main, src_deceased, in_params);

	EXPORT Imposters := PersonReports.Functions.GetImposters (all_persons (did NOT IN input_dids_set), bestrecs, in_params);




	// =======================================================================
	// ===== AKAS Section ====================================================
	// =======================================================================

	//--------------------------------------------------------------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------------
	// This is an unfortunate artefact of the old Comp Report (and a weird code, having said that):
	// doxie/ssn_records doesn't contain "best" record, so here I have to add it to AKAs
	// (see also #14515)
	// I believe it is still better than what was here before (calls to both doxie/ssn_records and doxie/ssn_persons)
	// Eventually, doxie/ssn_records MUST be modified to return all persons, and all this code will be gone.
	//--------------------------------------------------------------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------------
	shared aka_best := PersonReports.Functions.GetSubjectBestAKA (project(bestrecs, transform(doxie_crs.layout_best_information, self := left, self := [])), src_deceased, in_params);

	// append DL: only "best" record will have DLs, all other AKAs won't (ESP defect, actually)
	shared iesp.bps_share.t_BpsReportIdentity AppendDL (PersonReports.layouts.identity_slim L) := transform
		Self.DriverLicenses := driver_licenses;
		Self.DriverLicenses2 := [];
		Self.CriminalHistories := [];
		Self.SubjectSSNIndicator := 'yes';
		Self := L;
		Self := [];
	end;
	// project instead of JOIN: there's only one record in both sides
	shared aka_best_dl := project (aka_best, AppendDL (Left));


	// add together AKA from "best" file and all other AKAs
	// TODO: use filter instead of join
	shared other_akas := project (join (all_persons, dsDids, left.did=right.did, keep (1)), 
																			transform (iesp.bps_share.t_BpsReportIdentity,
																			Self.SubjectSSNIndicator := IF(Left.SSNInfo.SSN!='' and Left.SSNInfo.SSN=bestrecs[1].SSN,'yes','no'),
																			Self := Left, Self := []));
	shared subj_names := aka_best_dl & sort (other_akas, if (SSNInfo.Valid = 'yes', 0, 1));
	Suppress.MAC_Mask (subj_names, shared subj_names_suppress, SSNInfo.ssn, null, true, false, maskVal := mod_access.ssn_mask);

	EXPORT Akas := subj_names_suppress;




	// =======================================================================
	// ===== Relatives And Associates Section ================================
	// =======================================================================
	// relassocs' addresses don't use Census or Property info

	shared src_relatives := Healthcare_Provider_Services.Person_records_functions.relative_summary(dsDids); //did, name, depth, etc.
	shared src_names := Healthcare_Provider_Services.Person_records_functions.Comp_Names(dsDids); //did, name, ssn
	// generally, just 'relative_src' could be used, but it doesn' have SSNs
	// Note that 'names_src' may contain more names than 'relative_src'

	// AKAs will be taken from 'names_src', so we don't need to keep dupes in relatives.
	// Dedup by DID, choose the closest relatives
	//max_relassoc := iesp.Constants.BR.MaxRelatives + iesp.Constants.BR.MaxAssociates;
	max_relassoc := iesp.Constants.SMART.MaxRelatives + iesp.Constants.SMART.MaxAssociates;  
	export rel_assoc := choosen (dedup (sort (src_relatives, person2, depth, ~relative), person2), max_relassoc);


	// Choose the appropriate source for AKA: in some cases only best AKA is needed
	// rel_dids := dedup (sort (project (rel_assoc, transform (doxie.layout_references, Self.did := Left.person2)),
													 // did), did);
	rel_dids := project (rel_assoc, transform (doxie.layout_references, Self.did := Left.person2));
	//best_akas := doxie.best_records (rel_dids, , in_params.DPPAPurpose, in_params.GLBPurpose, true, false, , , true,header.constants.checkRNA);
  best_akas := doxie.best_records (rel_dids, false, , , true, checkRNA := header.constants.checkRNA, modAccess := mod_access);

		export aka_src := if (in_params.use_bestaka_ra,
								 project (best_akas, transform (PersonReports.layouts.comp_names, Self.address_seq_no := 0; Self:=Left)),
								 project (src_names, transform (PersonReports.layouts.comp_names, Self.address_seq_no := 0; Self:=Left)));
	// alternatively relative_records or relative_summary can be used, utilizing records' counts

	// attach SSN and death information; this is in effect AKAs
	export relassoc_base := PersonReports.Functions.GetPersonBase (aka_src, ssn_lookups, src_deceased, in_params);


	// ------------------------- expanded relatives/associates -------------------------
	// choose appropriate rel/assoc addresses
	shared relassoc_addr := addr_wide (did NOT IN input_dids_set,
																		 ~in_params.use_verified_address_ra or Verified);
	shared all_relassoc := PersonReports.Functions.CreateRelativesBps (rel_assoc, relassoc_base, relassoc_addr, in_params);

	// TODO: verify that this sorting will work (alternatively, sort right before the output)
	EXPORT Relatives := sort (PROJECT (all_relassoc (RelativeDepth > 0), iesp.bpsreport.t_BpsReportRelative), RelativeDepth);



	//---------------------------------------------- slim ----------------------------------------------

	export relassoc_addr_slim := addr_slim (did NOT IN input_dids_set,
																					~in_params.use_verified_address_ra or Verified);



	shared all_relassoc_slim := PersonReports.Functions.CreateRelativesSlim (rel_assoc, relassoc_base, relassoc_addr_slim, in_params);

	// TODO: verify that this sorting will work (alternatively, sort right before the output)
	EXPORT RelativesSlim := sort (PROJECT (all_relassoc_slim (RelativeDepth > 0), iesp.bpsreport.t_BpsReportRelativeSlim), RelativeDepth);
	//---------------------------------------------------------------------------------------------



	shared iesp.share.t_PhoneInfoEx BpsPhone2Phone (iesp.bpsreport.t_BpsReportPhone L) := transform
		Self.ListingTimeZone := '';//L.TimeZone;
		Self.ListingPhone10 := '';//L.Phone10;
		Self.Messages := [];
		Self.HighRiskIndicators := L.HighRiskIndicators;
		Self := L;
	end;

	iesp.bpsreport.t_BpsReportAssociate Relative2Associate (iesp.bpsreport.t_BpsReportRelative L) := transform
		Self.Addresses := project (L.addresses, transform (iesp.bpsreport.t_BpsReportAssociateAddress, 
																											 phones := project (Left.Phones, BpsPhone2Phone (Left));
																											 Self.Phones := project (phones, iesp.share.t_PhoneInfo);
																											 Self.PhonesEx := phones;
																											 Self := Left;));
		Self := L;
	end;
	EXPORT Associates := PROJECT (all_relassoc (RelativeDepth < 0), Relative2Associate (Left));

	// Slimming down associates
	EXPORT AssociatesSlim := project (all_relassoc_slim (RelativeDepth < 0), iesp.bpsreport.t_BpsReportAssociateSlim);



	// =======================================================================
	// ============================= Neighbours ==============================
	// =======================================================================
	// Address main sequence table contains records from both old and new neighbor routines.
	// Only new routine is used here to produce neighbors, which means that some addresses from address table
	// will be silently dicarded, i.e. lost.

	// TODO: use includes
	export src_neighbors := Healthcare_Provider_Services.Person_records_functions.nbr_records_slim(dsDids) (mode = 'C'); //layout is not published
	shared rec_neighbors := recordof (src_neighbors);

	// mode: Current or Historical
	// base_address_seq_no: (subject's address; seems to be the same as seqTarget)
	// seqNPA (distance), seqNbr (a resident within the given household)
	// Note: comp report is using doxie/resident_links, which is just a slimmed down dataset
	// Note: ESP is using neighbors' DIDs to get residents; in this implementation current residents
	//       were already created here I create residents for all addresses by sequence.


	// need to preserve correct sorting order (maybe, there's a better way)
	shared rec_neighb_ext := record
		unsigned2 seq;
		recordof (src_neighbors);
	end;
	rec_neighb_ext PreserveSorting (recordof (src_neighbors) L, integer C) := transform
		Self.seq := C;
		Self := L;
	end;
	shared ds_neighbors := project (src_neighbors, PreserveSorting (Left, Counter));

	// (TODO: find out why this will not work, and dedup after JOIN does)
	// shared ds_neighbors := dedup (sort (ds_neighbors_seq, address_seq_no), address_seq_no);

	export layout_nbr_addr_ext := record (iesp.bpsreport.t_NeighborAddress)
		unsigned2 seq;
		integer3 seqtarget; // subject's address (neighbourhood) indicator
	end;

	shared layout_nbr_addr_ext SetNeighborsAddresses (rec_neighb_ext L, PersonReports.layouts.address_bps R) := transform
		Self.seq := L.seq;
		Self.seqtarget := L.base_address_seq_no;
		Self.AddressEx := project (R.Address, transform (iesp.share.t_AddressEx, self.HighRiskIndicators := []; self := Left));

		phones := project (choosen (R.Phones, iesp.Constants.BR.Neigbors_Phones), BpsPhone2Phone (Left));
		Self.Phones := project (phones, iesp.share.t_PhoneInfo);
		Self.PhonesEx := phones;

		Self.Residents := project (R.residents, iesp.bps_share.t_BpsReportIdentity); // slim: remove DID and sequence
		Self := R; //Address, DateLastSeen, DateFirstSeen, Verified, _Shared, LocationID
	end;

	// choose appropriate neighbors' addresses
	nbr_filtered := addr_wide (did NOT IN input_dids_set,
														 ~in_params.use_verified_address_nb or Verified);
	export nbr_addr := JOIN (ds_neighbors, nbr_filtered,
													 Left.address_seq_no = Right.address_seq_no,
													 SetNeighborsAddresses (left,right)); // always 1:1


	// dedup same addresses (they all must have same residents -- a probable issue, btw)
	// NB: sequence number is dropped here.
	shared nbr_ddp := dedup (sort (nbr_addr, Address.StreetName, Address.StreetNumber, Address.UnitNumber, Address.zip5, Address.zip4),
																					 Address.StreetName, Address.StreetNumber, Address.UnitNumber, Address.zip5, Address.zip4);

	// combine neighbors by subjects' neighborhoods
	export nb_addr_grp := group (sort (nbr_ddp, seqtarget), seqtarget);

	export layout_nbr_ext := record (iesp.bpsreport.t_Neighbor)
		integer3 seqtarget;
	end;

	shared layout_nbr_ext SetNeighborhoods (layout_nbr_addr_ext L, dataset (layout_nbr_addr_ext) R) := transform
		Self.SubjectAddress := []; // will be taken in the next join
		// set addresses, apply optional filters, if any
		nbr_addrs := project (sort (R, seq), iesp.bpsreport.t_NeighborAddress) (~in_params.nbrs_with_phones OR exists (Phones));
		Self.NeighborAddresses := choosen (nbr_addrs, iesp.Constants.BR.NeigborsInNeighborhood);
		Self.seqtarget := L.seqtarget;
	END;

	export ds_neighborhoods := rollup (nb_addr_grp, group, SetNeighborhoods (left, rows (left)));


	// Finally, set subject's address
	iesp.bpsreport.t_Neighbor SetSubjectAddress (layout_nbr_ext L, PersonReports.layouts.address_bps R) := transform
		//Self.seqtarget := L.seqtarget; // subject's neighbourhood indicator
		Self.SubjectAddress.LocationId := R.LocationId;
		phones := choosen (project (R.phones, BpsPhone2Phone (Left)), iesp.Constants.BR.Neigbors_Phones);
		Self.SubjectAddress.Phones := [];//project (phones, iesp.share.t_PhoneInfo);
		Self.SubjectAddress.PhonesEx := phones;
		Self.SubjectAddress.Address := [];//R.Address;
		Self.SubjectAddress.AddressEx := project (R.Address, transform (iesp.share.t_AddressEx, self.HighRiskIndicators := []; self := Left));
		// Self.SubjectAddress.Residents := project (R.residents, UnfoldResidents (Left));
		Self.SubjectAddress.Residents := project (R.residents, iesp.bps_share.t_BpsReportIdentity);
		Self.SubjectAddress := R; //DateFirstSeen, DateLastSeen, Verified, _Shared 
		Self.NeighborAddresses := L.NeighborAddresses; //choosen was used before
	end;


	// cannot join by "sequence number"
	neighbors_res := JOIN (ds_neighborhoods, x_SubjectAddresses,
												 Left.seqtarget = Right.address_seq_no,
												 SetSubjectAddress (Left, Right)); // always 1:1
	EXPORT Neighbors := neighbors_res;



	// --------------------------------------- slim ---------------------------------
	export layout_nbr_addr_ext_slim := record (iesp.bpsreport.t_NeighborAddressSlim)
		unsigned2 seq;
		integer3 seqtarget; // subject's neighbourhood indicator
	end;

	// Set neighbors' addresses in appropriate format
	shared iesp.bpsreport.t_BpsReportIdentitySlim UnfoldResidentsSlim (identity_slim L) := transform
		Self := L;
	end;

	shared layout_nbr_addr_ext_slim SetNeighborsAddressesSlim (rec_neighb_ext L, PersonReports.layouts.address_slim R) := transform
		Self.seq := L.seq;
		Self.seqtarget := L.base_address_seq_no;
		Self.Address := R.Address;
		Self.Phones := project (choosen (R.Phones, iesp.Constants.BR.Neigbors_Phones), BpsPhone2Phone (Left));

		Self.Residents := project (R.residents, UnfoldResidentsSlim (Left));
		Self := R; //DateLastSeen, DateFirstSeen, Verified, _Shared, LocationID
	end;

	// choose appropriate neighbors' addresses
	nbr_filtered_slim := addr_slim (did NOT IN input_dids_set,
																	~in_params.use_verified_address_nb or Verified);
	export nbr_addr_slim := JOIN (ds_neighbors, nbr_filtered_slim,
													 Left.address_seq_no = Right.address_seq_no,
													 SetNeighborsAddressesSlim (left,right)); // always 1:1

	// dedup same addresses (they all must have same residents -- a probable issue, btw)
	// NB: sequence number is dropped here.
	shared nbr_ddp_slim := dedup (sort (nbr_addr_slim, Address.StreetName, Address.StreetNumber, Address.UnitNumber, Address.zip5, Address.zip4),
																					 Address.StreetName, Address.StreetNumber, Address.UnitNumber, Address.zip5, Address.zip4);

	// combine neighbors by subjects' neighborhoods
	export nb_addr_grp_slim := group (sort (nbr_ddp_slim, seqtarget), seqtarget);

	export layout_nbr_ext_slim := record (iesp.bpsreport.t_NeighborSlim)
		integer3 seqtarget;
	end;

	shared layout_nbr_ext_slim SetNeighborhoodsSlim (layout_nbr_addr_ext_slim L, dataset (layout_nbr_addr_ext_slim) R) := transform
		Self.SubjectAddress := []; // will be taken in the next join
		// set addresses, apply optional filters, if any
		nbr_addrs := project (sort (R, seq), iesp.bpsreport.t_NeighborAddressSlim) (~in_params.nbrs_with_phones OR exists (Phones));
		Self.NeighborAddresses := choosen (nbr_addrs, iesp.Constants.BR.NeigborsInNeighborhood);
		Self.seqtarget := L.seqtarget;
	END;

	export ds_neighborhoods_slim := rollup (nb_addr_grp_slim, group, SetNeighborhoodsSlim (left, rows (left)));

	// Finally, set subject's address
	iesp.bpsreport.t_NeighborSlim SetSubjectAddressSlim (layout_nbr_ext_slim L, PersonReports.layouts.address_slim R) := transform
		phones := choosen (project (R.phones, BpsPhone2Phone (Left)), iesp.Constants.BR.Neigbors_Phones);
		Self.SubjectAddress := project (R, transform (iesp.bpsreport.t_NeighborAddressSlim, 
																									Self.Phones := phones; Self := Left));
		Self.NeighborAddresses := L.NeighborAddresses; //choosen was used before
	end;

	// cannot join by "sequence number"
	neighbors_res_slim := JOIN (ds_neighborhoods_slim, x_SubjectAddressesSlim,
												 Left.seqtarget = Right.address_seq_no,
												 SetSubjectAddressSlim (Left, Right)); // always 1:1
	EXPORT NeighborsSlim := neighbors_res_slim;

	// TODO:
	EXPORT neighbors_historical := dataset ([], iesp.bpsreport.t_HistoricalNeighbor);
	EXPORT neighbors_historical_ext := dataset ([], iesp.bpsreport.t_Neighbor);
	shared nbrRels := inputData.MaxRelatives;
	shared nbrRelsFinal := if(nbrRels=0,iesp.Constants.HPR.MAX_Relatives,min(nbrRels,iesp.Constants.BR.MaxRelatives));
	export dsRelatives := if(count(dsDids(did>0))>0,choosen(relativesSlim,nbrRelsFinal));
	export dsNeighbors := if(count(dsDids(did>0))>0,choosen(neighborsslim,iesp.Constants.HPR.MAX_Relatives));
	export dsAssociates := if(count(dsDids(did>0))>0,choosen(associates, iesp.constants.BR.MaxAssociates));
	export dsHistoricalNeighbors := if(count(dsDids(did>0))>0,choosen(neighbors_historical, iesp.constants.BR.MaxHistoricalNeighborhood));
	export dsDOD := if(count(dsDids(did>0))>0,project(bestrecs(length(trim(dod,all))>1),transform(iesp.share.t_Date, self := iesp.ECL2ESP.toDatestring8(Left.dod))));
	shared dsDODBlank := JOIN (dsDids, doxie.key_death_masterV2_DID, 
											keyed (Left.did = Right.l_did),
											keep(1),limit(0));
	shared dsDodBlankVerified := dsDODBlank(dod8='');
	shared blankDODExists := count(dsDodBlankVerified)>=1 and inputData.IncludeBlankDOD;
	export DeceasedFlag := if(count(dsDOD)>0 or blankDODExists,true,false);
	export echo := dsDids; 
end;
