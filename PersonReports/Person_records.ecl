﻿// ESP-compliant code. If you need to add new sections, they should comply
// to ESP output layouts as well (some sections' implementation can be found
// in the history of PersonReports.Addrs_Imposters_Rels_Assocs)

IMPORT ut, DeathV2_Services, doxie_crs, doxie, suppress, DriversV2_Services, iesp, header, CriminalRecords_Services, FCRA, FFD, MDR;

EXPORT Person_records (
  dataset (doxie.layout_references) dids,
  PersonReports.input.personal in_params = module (PersonReports.input.personal) end,
  boolean IsFCRA = false,
	dataset(fcra.Layout_override_flag) ds_flags = dataset([],fcra.Layout_override_flag),
	dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim
) := MODULE

// Get values missing from the input from global.
// Can't project from {input} because of different type of ssn_mask (string vs. string6);
shared mod_access := MODULE (doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule ()))
  EXPORT unsigned1 glb := in_params.GLBPurpose;
  EXPORT unsigned1 dppa := in_params.DPPAPurpose;
  EXPORT string DataPermissionMask := in_params.DataPermissionMask;
  EXPORT string DataRestrictionMask := in_params.DataRestrictionMask;
  EXPORT boolean ln_branded := in_params.ln_branded;
  EXPORT string5 industry_class := in_params.industryclass;
  EXPORT string32 application_type := in_params.applicationtype;
  EXPORT unsigned3 date_threshold := in_params.dateVal;
  EXPORT string ssn_mask := in_params.ssn_mask;
END;

shared input_dids_set := SET (dids, did);


shared fcra_csa_wrap :=FCRA.comp_subject (dids, 
																					mod_access.dppa,
																					mod_access.glb,
																					false, // exclude Gong so far
																					mod_access.industry_class,
																					//in_params.dialcontactprecision
																					, 
																					/*Addresses_PerSubject*/,
																					ds_flags,
																					slim_pc_recs,
																					in_params.FFDOptionsMask);

bestrecs_reg := doxie.best_records (dids, IsFCRA, , , true, includeDOD:=true, modAccess := mod_access); // use non-blank key, see #39788
																		
shared bestrecs_ffd := if(IsFCRA, fcra_csa_wrap.best_record, 
	project(bestrecs_reg, transform(doxie_crs.layout_best_information, self := left, self := [])));
																			
// TODO: rename to src_bestrecords
export bestrecs := project(bestrecs_ffd, doxie.layout_best);

ssnr_pre_reg := doxie.fn_ssn_records (bestrecs); 
//doxie_crs.layout_ssn_records 

ssnr_pre_fcra := fcra_csa_wrap.ssn_recs;
shared src_ssn_main := if (IsFCRA,ssnr_pre_fcra,ssnr_pre_reg);

src_residents_reg := if (in_params.include_residents,
                            project (doxie.Resident_Records, transform (PersonReports.layouts.comp_names, self :=left))); 
src_residents_fcra := dataset([],PersonReports.layouts.comp_names);
shared src_residents := if(IsFCRA , src_residents_fcra , src_residents_reg);


// replication of a best records in doxie/central_header
shared idid := max(dids(did > 0), did);//dids has no more than 1 record here. see #stored('useOnlyBestDID',true) in doxie.Comprehensive_Report_Service

// ============================ a patch for death master records ============================
// so far these are needed to access deceased records:
glb_ok := mod_access.isValidGLB ();
rna_glb_ok := mod_access.isValidGLB (header.constants.checkRNA);
death_params := DeathV2_Services.IParam.GetFromDataAccess(mod_access);
//NB: FCRA does not have permission to use/return RNA  

// Get all DIDs that will be used in the report; set "is subject" indicator for a subject
rec_did_owner := record (doxie.layout_references)
  boolean is_subject := false;
end;
all_dids_pre_reg := project (dids, transform (rec_did_owner, Self.did := Left.did, Self.is_subject := true;)) +
                dedup (project (src_ssn_main (did not in input_dids_set), rec_did_owner), did, all) + 
                dedup (project (src_residents, rec_did_owner), did, all) + 
                project (doxie.Get_RNA_DIDs, rec_did_owner);
                                                                                                                                
all_dids_pre_fcra := project (dids, transform (rec_did_owner, Self.did := Left.did, Self.is_subject := true;));

all_dids_pre :=  if(IsFCRA ,all_dids_pre_fcra ,all_dids_pre_reg );
dids_owners := dedup (sort (all_dids_pre, did, ~is_subject), did);


doxie_crs.layout_deathfile_records GetDeadRecords (rec_did_owner L, doxie.key_death_masterV2_ssa_DID R) := transform
  self.age_at_death := ut.Age((unsigned8)R.dob8,(unsigned8)R.dod8);
  self.did := (string)((integer)(R.did));
  self.IsLimitedAccessDMF := (R.src = MDR.sourceTools.src_Death_Restricted);
  self := R;
end;

dear  := if(~IsFCRA,JOIN (dids_owners, doxie.key_death_masterV2_ssa_DID, 
               keyed (Left.did = Right.l_did) 
               and not DeathV2_Services.Functions.Restricted (right.src, right.glb_flag,if (Left.is_subject, glb_ok, rna_glb_ok), death_params),
               GetDeadRecords (Left, Right),
               left outer, limit (ut.limits.HEADER_PER_DID), keep (ut.limits.DEATH_PER_DID)));

							 
// dear := doxie.deathfile_records (in_params.include_BlankDOD or (unsigned)dod8 != 0);


//============================  

// for the purpose of deceased indicator we need only one record per person, preferrably with a county

shared src_deceased := dedup (sort (dear, did, -dod8, trim (county_name) = ''), did, dod8);	  
 
besr_choice := IF(EXISTS(bestrecs), bestrecs, project (dids, transform (doxie.layout_best , 
                                                                            Self.did := Left.did, Self := [])));

  iesp.bpsreport.t_BpsReportBestInfo transform_best (doxie.layout_best L) := transform
    Self.Name := iesp.ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, L.title);
    Self.Gender := iesp.ECL2ESP.GetGender (L.title);
    Self.Address := iesp.ECL2ESP.SetAddress (L.prim_name, L.prim_range, L.predir, L.postdir,
                                             L.suffix, L.unit_desig, L.sec_range, L.city_name,
                                             L.st, L.zip, L.zip4, '', // TODO: county name
                                             '', '', '', '');
    Self.DOD := iesp.ECL2ESP.toDatestring8 (src_deceased((unsigned6)did = idid)[1].dod8);
    phs := doxie_crs.verifiedPhones (in_params.legacy_verified).records;
    Self.Phones := if(~IsFCRA, project (phs, transform (iesp.bpsreport.t_BpsReportBestInfoPhone,
                                            Self.Phone10 := Left.listed_phone, Self.TimeZone := Left.timezone)));
    Self.DOB := iesp.ECL2ESP.toDate (L.dob);
    Self.SSN := if (L.ssn <> '', L.ssn, src_ssn_main (did = idid and ssn = in_params._ssn)[1].ssn);
    Self.Deceased := if (exists (src_deceased ((unsigned6)did = idid)), 'Y', 'N');
    Self.IsLimitedAccessDMF := src_deceased((unsigned6)did = idid)[1].IsLimitedAccessDMF;
  end;
//self.deceased := if(exists(dear((unsigned)did = idid)),'Y','N'),
  export bestrecs_esdl := project (besr_choice, transform_best (Left));


// =======================================================================
// ===== Driver License (Sub)Section =====================================
// =======================================================================
dl_rec := DriversV2_Services.layouts.result_wide;
// need to export it just because of "we also found"
export dlsr := if(~IsFCRA, choosen (project (DriversV2_Services.DLRaw.wide_view.by_did (dids), dl_rec),iesp.Constants.MaxCountDL)) : global;
esp_drivers := project (dlsr, iesp.transform_dl_bps (Left));
EXPORT driver_licenses := if(in_params.include_driverslicenses and ~IsFCRA,
                              esp_drivers,
                              dataset ([], iesp.bps_share.t_BpsReportDriverLicense));
// this is to temporarily fix the confusion with DL/DL2 in ESP layouts
esp_drivers_v2 := iesp.transform_dl (dlsr);
EXPORT driver_licenses_v2:=if(in_params.include_driverslicenses and ~IsFCRA,
                              esp_drivers_v2,
															dataset([],iesp.driverlicense2.t_DLEmbeddedReport2Record));

// =======================================================================
// ====================  Address / Phones Section ========================
// =======================================================================

// same as doxie_crs.Comp_Addresses_Verified, but WITHOUT verification codes
shared address_orig := doxie.Comp_Addresses; //doxie/Layout_Comp_Addresses

// some name variations are missing in the source addresses; try to append from complete residents' list
// this may improve address-phone linking, since names can be used.
address_expanded := Functions.Address (in_params).ExpandWithResidents (address_orig, src_residents);
shared src_address := if (in_params.expand_address, address_expanded, address_orig);


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
EXPORT SubjectShortAddresses := if (~IsFCRA, project (subj_slim, GetSubjectShortAddress (Left)));


// Add phones to addresses
// Fetch phones (can't call doxie.phone_records: it uses strict sec_range comparisons);
// original addresses are used, since expanded ones don't add new addresses
phones_wide := doxie.fn_phone_records_wide (address_orig, false, true); // relaxed sec. range;
phones_rec := record (doxie_crs.layout_phone_records)
  typeof (phones_wide.st) st;   // only for mac_AddHRIPhone call
  typeof (phones_wide.name_last) lname;  // only for mac_AddHRIPhone call
  typeof (phones_wide.omit_phone) omit_phone; // in addition to 'unpub'
end;


// TODO: append HRIs conditionally
phones_wide_hri := project (phones_wide, transform (phones_rec, Self := Left; Self.hri_phone := []));
maxHriPer_value := 10; //TODO: include into input (unsigned1 maxHriPer_value := 10 : stored('MaxHriPer'));
doxie.mac_AddHRIPhone(phones_wide_hri, phor_pre);
phor := project (phor_pre, transform (phones_rec, Self.lname := Left.name_last, Self := Left));

// FinderReport style: verifies phones by last residents' names, among other things
// Address-phone match is done at that point, so "extra" addresses appended (if any) from residents list can be removed.
export addr_base := Functions.Address (in_params).AttachPhones (src_address, phor) 
  (address_seq_no != Constants.APPENDED_BY_RESIDENTS);
// ---------- Now have addresses with phones ----------



// ====================================================================
// ========================  Residents Section ========================
// ====================================================================
shared ssn_lookups := doxie.SSN_Lookups; // doxie_crs/layout_SSN_Lookups

// flat table of residents with SSN, death, etc. info;
// contains DID and address sequence, which can be used for linking.
// Residents are effectively CURRENT RESIDENTS (i.e. those who reside recently). 
shared residents_base := Functions.GetPersonBase (src_residents, ssn_lookups, src_deceased, in_params);

// ------------------------- expanded residents -------------------------
// a serious of transformations to produce most complete identity
// all DID-linking should be done before the rollup

res_expanded := project (residents_base, Functions.ExpandIdentity (Left));

res_grouped := group (sort (res_expanded, address_seq_no), address_seq_no);

PersonReports.layouts.identity_bps_rolled RollIdentity (PersonReports.layouts.identity_bps l, dataset(PersonReports.layouts.identity_bps) r):=transform
  self.did := L.did; // note: DID can be unreliable here, if input is grouped by seq_no
  self.address_seq_no := l.address_seq_no;
  self.akas := choosen (project (r, iesp.bps_share.t_BpsReportIdentity), iesp.Constants.BR.MaxAddress_Residents);
END;
shared residents_wide := rollup (res_grouped, group, RollIdentity (Left, rows (Left)));


// ------------------- slim residents -------------------
// there's already enough info to produce slim residents
// shared res_slim := group(sort (residents_base, address_seq_no), address_seq_no);
res_slim_grouped := group (sort (residents_base, address_seq_no), address_seq_no);

PersonReports.layouts.identity_slim_rolled RollIdentitySlim (PersonReports.layouts.identity_slim l, dataset(PersonReports.layouts.identity_slim) r):=transform
  self.did := L.did; // note: DID can be unreliable here, if input is grouped by seq_no
  self.address_seq_no := l.address_seq_no;
  self.akas := choosen (project (r, iesp.bpsreport.t_BpsReportIdentitySlim), iesp.Constants.BR.MaxAddress_Residents);
END;
export residents_slim := if (~IsFCRA, rollup (res_slim_grouped, group, RollIdentitySlim (Left, rows (Left))));
// residents ready; now they can be attached to addresses


// =======================================================================
// ==============  Address: add Residents, Properties, etc. ==============
// =======================================================================
// Residents are effectively CURRENT RESIDENTS (i.e. those who reside recently). 
// Thus, some of the addresses from address sequence table will not have residents yet (say, historical neighbors)

// ------------------------- wide addresses -------------------------
shared addr_wide := Functions.Address (in_params).AddResidents (addr_base, residents_wide);
// NOTE: these addresses don't contain properties, census, etc. data;
//       Since they are used in relatives and neighbors sections so far, it is not required. 
//       But, if either is needed, it should be done here.


// take this subject records only
subj_addr := addr_wide (did IN input_dids_set);

// Get Census info (only by request and only for subject's:
subj_addr_census := if (in_params.include_censusdata,
                               Functions.Address (in_params).AddCensus (subj_addr),
                               subj_addr);

// TODO: add properties, etc. here
EXPORT x_SubjectAddresses := if (~IsFCRA, sort (subj_addr_census, -DateLastSeen, -DateFirstSeen, Address.Zip4, Address.StreetNumber));
EXPORT SubjectAddresses := if (~IsFCRA, project (x_SubjectAddresses, iesp.bpsreport.t_BpsReportAddress));


// -------------------------------- slim --------------------------------
shared addr_slim := Functions.Address (in_params).AddResidentsSlim (addr_base, residents_slim);
EXPORT x_SubjectAddressesSlim := if (~IsFCRA, sort (addr_slim (did IN input_dids_set), -DateLastSeen, -DateFirstSeen, Address.Zip4, Address.StreetNumber));
EXPORT SubjectAddressesSlim := if (~IsFCRA, project (x_SubjectAddressesSlim, iesp.bpsreport.t_BpsReportAddressSlim));




// =======================================================================
// =====  Section ===============================================
// =======================================================================
// Imposters are defined as complete bps identity layout, but it seems that actually they are
// represented by a slim Identity in the output

// flat table of ssn records, containing imposters and subject's AKAs
// contains DID, which can be used for linking 
shared all_persons := Functions.GetSSNRecordsBase (src_ssn_main, src_deceased, in_params, IsFCRA);

EXPORT Imposters := if(~IsFCRA,Functions.GetImposters (all_persons (did NOT IN input_dids_set), bestrecs, in_params));




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
aka_best := Functions.GetSubjectBestAKA (bestrecs_ffd, src_deceased, in_params ,IsFCRA);


// append DL: only "best" record will have DLs, all other AKAs won't (ESP defect, actually)
//shared iesp.bps_share.t_BpsReportIdentity AppendDL (layouts.identity_slim L) := transform
PersonReports.layouts.CommonPreLitigationReportIdentity AppendDL (PersonReports.layouts.identity_slim L) := transform
  Self.DriverLicenses := driver_licenses;
  Self.DriverLicenses2 := [];
  Self.CriminalHistories := [];
  Self.SubjectSSNIndicator := 'yes';
  Self := L;
  Self := [];
end;

// project instead of JOIN: there's only one record in both sides
aka_best_dl := project (aka_best, AppendDL (Left));

// add together AKA from "best" file and all other AKAs
// TODO: use filter instead of join
other_akas := project (join (all_persons, dids, left.did=right.did, keep (1)), 
                                    transform (PersonReports.layouts.CommonPreLitigationReportIdentity,
			Self.SubjectSSNIndicator := IF(Left.SSNInfo.SSN!='' and 
			Left.SSNInfo.SSN=bestrecs[1].SSN,'yes','no'),
			Self := Left, Self := []));

subj_names := aka_best_dl & sort (other_akas, if (SSNInfo.Valid = 'yes', 0, 1));
Suppress.MAC_Mask (subj_names, subj_names_suppress, SSNInfo.ssn, null, true, false, maskVal := mod_access.ssn_mask);

EXPORT Akas := subj_names_suppress;





// =======================================================================
// ===== Relatives And Associates Section ================================
// =======================================================================
// relassocs' addresses don't use Census or Property info

src_relatives := doxie.relative_summary; //did, name, depth, etc.

// AKAs will be taken from 'names_src', so we don't need to keep dupes in relatives.
// Dedup by DID, choose the closest relatives
//max_relassoc := iesp.Constants.BR.MaxRelatives + iesp.Constants.BR.MaxAssociates;
max_relassoc := iesp.Constants.SMART.MaxRelatives + iesp.Constants.SMART.MaxAssociates;  
shared rel_assoc := choosen (dedup (sort (src_relatives, person2, depth, ~relative), person2), max_relassoc);

src_names := doxie.Comp_Names; //did, name, ssn
// generally, just 'relative_src' could be used, but it doesn' have SSNs
// Note that 'names_src' may contain more names than 'relative_src'

// Choose the appropriate source for AKA: in some cases only best AKA is needed
// rel_dids := dedup (sort (project (rel_assoc, transform (doxie.layout_references, Self.did := Left.person2)),
                         // did), did);
rel_dids := project (rel_assoc, transform (doxie.layout_references, Self.did := Left.person2));
best_akas := doxie.best_records (rel_dids, IsFCRA, , , true, header.constants.checkRNA, modAccess := mod_access);

aka_src := if (in_params.use_bestaka_ra,
               project (best_akas, transform (PersonReports.layouts.comp_names, Self.address_seq_no := 0; Self:=Left)),
               project (src_names, transform (PersonReports.layouts.comp_names, Self.address_seq_no := 0; Self:=Left)));
// alternatively relative_records or relative_summary can be used, utilizing records' counts

// attach SSN and death information; this is in effect AKAs
shared relassoc_base := Functions.GetPersonBase (aka_src, ssn_lookups, src_deceased, in_params);

// ------------------------- expanded relatives/associates -------------------------
// choose appropriate rel/assoc addresses
relassoc_addr := addr_wide (did NOT IN input_dids_set,
                                   ~in_params.use_verified_address_ra or Verified);
shared all_relassoc := Functions.CreateRelativesBps (rel_assoc, relassoc_base, relassoc_addr, in_params);

// TODO: verify that this sorting will work (alternatively, sort right before the output)

// add crim indicators
CriminalRecords_Services.MAC_Indicators(all_relassoc,relatives_crim_ind);
relativeRecs := IF(in_params.include_criminalindicators,relatives_crim_ind,all_relassoc);

EXPORT Relatives := if (~IsFCRA, sort (PROJECT (relativeRecs (RelativeDepth > 0), iesp.bpsreport.t_BpsReportRelative), RelativeDepth));



//---------------------------------------------- slim ----------------------------------------------

relassoc_addr_slim := addr_slim (did NOT IN input_dids_set,
                                        ~in_params.use_verified_address_ra or Verified);



shared all_relassoc_slim := Functions.CreateRelativesSlim (rel_assoc, relassoc_base, relassoc_addr_slim, in_params);

// TODO: verify that this sorting will work (alternatively, sort right before the output)
EXPORT RelativesSlim := if (~IsFCRA, sort (PROJECT (all_relassoc_slim (RelativeDepth > 0), iesp.bpsreport.t_BpsReportRelativeSlim), RelativeDepth));
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

// add crim indicators
CriminalRecords_Services.MAC_Indicators(all_relassoc,associates_crim_ind);
AssociateRecs := IF(in_params.include_criminalindicators,associates_crim_ind,all_relassoc);

EXPORT Associates := if (~IsFCRA, PROJECT (AssociateRecs (RelativeDepth < 0), Relative2Associate (Left)));

// Slimming down associates
EXPORT AssociatesSlim := if (~IsFCRA, project (all_relassoc_slim (RelativeDepth < 0), iesp.bpsreport.t_BpsReportAssociateSlim));



// =======================================================================
// ============================= Neighbours ==============================
// =======================================================================
// Address main sequence table contains records from both old and new neighbor routines.
// Only new routine is used here to produce neighbors, which means that some addresses from address table
// will be silently dicarded, i.e. lost.

// need to preserve correct sorting order (maybe, there's a better way)
shared rec_neighb_ext := record
  unsigned2 seq;
  doxie.layout_nbr_records_slim;
end;

// TODO: use includes
src_neighbors := doxie_crs.nbr_records_slim (mode = 'C'); //layout is not published

// mode: Current or Historical
// base_address_seq_no: (subject's address; seems to be the same as seqTarget)
// seqNPA (distance), seqNbr (a resident within the given household)
// Note: comp report is using doxie/resident_links, which is just a slimmed down dataset
// Note: ESP is using neighbors' DIDs to get residents; in this implementation current residents
//       were already created here I create residents for all addresses by sequence.


rec_neighb_ext PreserveSorting (doxie.layout_nbr_records_slim L, integer C) := transform
  Self.seq := C;
  Self := L;
end;
shared ds_neighbors := project (src_neighbors, PreserveSorting (Left, Counter));

// (TODO: find out why this will not work, and dedup after JOIN does)
// shared ds_neighbors := dedup (sort (ds_neighbors_seq, address_seq_no), address_seq_no);

layout_nbr_addr_ext := record (iesp.bpsreport.t_NeighborAddress)
  unsigned2 seq;
  integer3 seqtarget; // subject's address (neighbourhood) indicator
end;

layout_nbr_addr_ext SetNeighborsAddresses (rec_neighb_ext L, PersonReports.layouts.address_bps R) := transform
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
nbr_addr := JOIN (ds_neighbors, nbr_filtered,
                         Left.address_seq_no = Right.address_seq_no,
                         SetNeighborsAddresses (left,right)); // always 1:1


// dedup same addresses (they all must have same residents -- a probable issue, btw)
// NB: sequence number is dropped here.
nbr_ddp := dedup (sort (nbr_addr, Address.StreetName, Address.StreetNumber, Address.UnitNumber, Address.zip5, Address.zip4),
                                         Address.StreetName, Address.StreetNumber, Address.UnitNumber, Address.zip5, Address.zip4);

// combine neighbors by subjects' neighborhoods
nb_addr_grp := group (sort (nbr_ddp, seqtarget), seqtarget);

layout_nbr_ext := record (iesp.bpsreport.t_Neighbor)
  integer3 seqtarget;
end;

layout_nbr_ext SetNeighborhoods (layout_nbr_addr_ext L, dataset (layout_nbr_addr_ext) R) := transform
  Self.SubjectAddress := []; // will be taken in the next join
  // set addresses, apply optional filters, if any
  nbr_addrs := project (sort (R, seq), iesp.bpsreport.t_NeighborAddress) (~in_params.nbrs_with_phones OR exists (Phones));
  Self.NeighborAddresses := choosen (nbr_addrs, iesp.Constants.BR.NeigborsInNeighborhood);
  Self.seqtarget := L.seqtarget;
END;

 ds_neighborhoods := rollup (nb_addr_grp, group, SetNeighborhoods (left, rows (left)));


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
EXPORT Neighbors := if (~IsFCRA, neighbors_res);



// --------------------------------------- slim ---------------------------------
layout_nbr_addr_ext_slim := record (iesp.bpsreport.t_NeighborAddressSlim)
  unsigned2 seq;
  integer3 seqtarget; // subject's neighbourhood indicator
end;

// Set neighbors' addresses in appropriate format
iesp.bpsreport.t_BpsReportIdentitySlim UnfoldResidentsSlim (iesp.bpsreport.t_BpsReportIdentitySlim L) := transform
  Self := L;
end;

layout_nbr_addr_ext_slim SetNeighborsAddressesSlim (rec_neighb_ext L, PersonReports.layouts.address_slim R) := transform
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
nbr_addr_slim := JOIN (ds_neighbors, nbr_filtered_slim,
                         Left.address_seq_no = Right.address_seq_no,
                         SetNeighborsAddressesSlim (left,right)); // always 1:1

// dedup same addresses (they all must have same residents -- a probable issue, btw)
// NB: sequence number is dropped here.
nbr_ddp_slim := dedup (sort (nbr_addr_slim, Address.StreetName, Address.StreetNumber, Address.UnitNumber, Address.zip5, Address.zip4),
                                         Address.StreetName, Address.StreetNumber, Address.UnitNumber, Address.zip5, Address.zip4);

// combine neighbors by subjects' neighborhoods
nb_addr_grp_slim := group (sort (nbr_ddp_slim, seqtarget), seqtarget);

layout_nbr_ext_slim := record (iesp.bpsreport.t_NeighborSlim)
  integer3 seqtarget;
end;

layout_nbr_ext_slim SetNeighborhoodsSlim (layout_nbr_addr_ext_slim L, dataset (layout_nbr_addr_ext_slim) R) := transform
  Self.SubjectAddress := []; // will be taken in the next join
  // set addresses, apply optional filters, if any
  nbr_addrs := project (sort (R, seq), iesp.bpsreport.t_NeighborAddressSlim) (~in_params.nbrs_with_phones OR exists (Phones));
  Self.NeighborAddresses := choosen (nbr_addrs, min(iesp.Constants.BR.NeigborsInNeighborhood,in_params.neighbors_per_address));
  Self.seqtarget := L.seqtarget;
END;

ds_neighborhoods_slim := rollup (nb_addr_grp_slim, group, SetNeighborhoodsSlim (left, rows (left)));

// Finally, set subject's address
iesp.bpsreport.t_NeighborSlim SetSubjectAddressSlim (layout_nbr_ext_slim L, PersonReports.layouts.address_slim R) := transform
  phones := choosen (project (R.phones, BpsPhone2Phone (Left)), iesp.Constants.BR.Neigbors_Phones);
  Self.SubjectAddress := project (R, transform (iesp.bpsreport.t_NeighborAddressSlim, 
                                                Self.Phones := phones; Self := Left));
  Self.NeighborAddresses := L.NeighborAddresses; //choosen was used before
end;

// cannot join by "sequence number"
neighbors_res_slim := JOIN (ds_neighborhoods_slim, choosen(x_SubjectAddressesSlim,in_params.neighborhoods),
                       Left.seqtarget = Right.address_seq_no,
                       SetSubjectAddressSlim (Left, Right)); // always 1:1
EXPORT NeighborsSlim := if (~IsFCRA, neighbors_res_slim);

// TODO:
EXPORT neighbors_historical := dataset ([], iesp.bpsreport.t_HistoricalNeighbor);
EXPORT neighbors_historical_ext := dataset ([], iesp.bpsreport.t_Neighbor);
// dataset(t_HistoricalNeighbor) HistoricalNeighbors {xpath('HistoricalNeighbors/Neighborhood'), MAXCOUNT(iesp.constants.BR.MaxHistoricalNeighborhood)};//hidden[internal]
// dataset(t_Neighbor) HistoricalNeighborsEx {xpath('HistoricalNeighborsEx/Neighborhood'), MAXCOUNT(iesp.constants.BR.MaxHistoricalNeighborhood)};
END;
