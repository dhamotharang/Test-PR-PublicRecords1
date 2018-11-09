IMPORT doxie, doxie_raw, iesp;//, AutoHeaderI, AutoStandardI;

// Produces static counts (from header key)

// TODO: should be kept in sync with  IPTree* BpsDenormalizer::buildSourceCountsSection()
// TODO: who decides the versioning -- still ESP?
// TODO: eventually should replace doxie.Source_counts 
// TODO: check input parameters structure; check whether FCRA is required

// NB: ESP often implements versioning as "if, then, else". 
// I'm more conservative here, explicitely checking version instead of "else": 
// i.e. if (ver=1, then), if (ver=2, then), etc.

out_rec := iesp.share.t_SourceSection;

// produces source counts for (single) DID
//TODO: rewrite doxie, making it ESDL-compliant
EXPORT out_rec SourceCounts_records (dataset (doxie.layout_references) dids,
  input._sources param, 
  boolean IsFCRA = false
  ) := FUNCTION

  did := dids[1].did;
  did_ref_prefix := 'P' + (string) did + '$';
  
  src_row := Doxie.Source_counts (dids)[1]; // returns flat view of the counts

  // if subject's "pure" header (vs. single source) information is requested; true by assumption
  boolean header_include := true;

//Rules (bpsreport.cpp: makeReportSection, BpsDenormalizer::buildSourceCountsSection)
//  "Counts" and "Sources" are created only when count is positive;
//  Sections are not created for TU (PL2), EQ (PL1), TARG, EN (PL5);
//  Sections ADDRESS, SSN, DOB are taken from raw header.
//  Section NAME is hardcoded

  sources := 
         dataset ([{'NAME', 0, did_ref_prefix, 'Section'}], iesp.share.t_SourceSection) +

         if (param.include_atf and (src_row.atf_cnt > 0), dataset ([
             {'Federal Firearms and Explosives Licenses', src_row.atf_cnt, did_ref_prefix + 'ATF', 'Retrievable'},
             {'ATF',                                      0,               did_ref_prefix + 'ATF', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_bankruptcy and (param.bankruptcy_version = 1) and (src_row.bk_cnt >0), dataset ([
             {'Bankruptcy Records', src_row.bk_cnt, did_ref_prefix + 'BK', 'Retrievable'},
             {'BANKRUPTCY',         0,              did_ref_prefix + 'BK', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_bankruptcy and (param.bankruptcy_version = 2) and (src_row.bkv2_cnt >0), dataset ([
             {'Bankruptcy Records', src_row.bkv2_cnt, did_ref_prefix + 'BK_V2', 'Retrievable'},
             {'BANKRUPTCY',         0,                did_ref_prefix + 'BK_V2', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_liensjudgments and (param.liensjudgments_version = 1) and (src_row.lien_cnt > 0), dataset ([
             {'Liens and Judgments', src_row.lien_cnt, did_ref_prefix + 'LIEN', 'Retrievable'},
             {'LIENJUDGMENT',        0,                did_ref_prefix + 'LIEN', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_liensjudgments and (param.liensjudgments_version = 2) and (src_row.lienv2_cnt > 0), dataset ([
             {'Liens and Judgments', src_row.lienv2_cnt, did_ref_prefix + 'LIEN_V2', 'Retrievable'},
             {'LIENJUDGMENT',        0,                  did_ref_prefix + 'LIEN_V2', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_driverslicenses and (param.dl_version = 1) and (src_row.dl_cnt > 0), dataset ([
             {'Driver Licenses', src_row.dl_cnt, did_ref_prefix + 'DL', 'Retrievable'},
             {'DL',              0,              did_ref_prefix + 'DL', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_driverslicenses and (param.dl_version = 2) and (src_row.dl2_cnt > 0), dataset ([
             {'Driver Licenses', src_row.dl2_cnt, did_ref_prefix + 'DL_V2', 'Retrievable'},
             {'DL_V2',           0,               did_ref_prefix + 'DL_V2', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_deceased and (src_row.death_cnt > 0),        dataset ([
             {'Deceased', src_row.death_cnt, did_ref_prefix + 'DEATH', 'Retrievable'},
             {'DEATH',    0,                 did_ref_prefix + 'DEATH', 'Section'}], iesp.share.t_SourceSection)) +
// this is a bit strange: providers and sanctions depend on prof license version
         if (param.include_proflicenses and (src_row.proflic_cnt > 0),    dataset ([
             {'Professional Licenses', src_row.proflic_cnt, did_ref_prefix + 'PROFLIC', 'Retrievable'},
             {'PROFLIC',               0,                   did_ref_prefix + 'PROFLIC', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_providers and (src_row.prov_cnt > 0) and (param.proflicense_version = 2), dataset ([
             {'Providers', src_row.prov_cnt, did_ref_prefix + 'PROV', 'Retrievable'},
             {'PROV',      0,                did_ref_prefix + 'PROV', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_sanctions and (src_row.sanc_cnt > 0) and (param.proflicense_version = 2),       dataset ([
             {'Sanctions', src_row.sanc_cnt, did_ref_prefix + 'SANC', 'Retrievable'},
             {'SANC',      0,                did_ref_prefix + 'SANC', 'Section'}], iesp.share.t_SourceSection)) +
//NB: conditions are slightly different in "counts" and "sections" in ESP
         if (param.include_motorvehicles and (src_row.veh_cnt > 0) and (param.vehicles_version = 1), dataset ([
             {'Motor Vehicle Registrations', src_row.veh_cnt, did_ref_prefix + 'VEH', 'Retrievable'},
             {'VEHICLE',                     0,               did_ref_prefix + 'VEH', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_motorvehicles and (src_row.vehv2_cnt > 0) and (param.vehicles_version = 2), dataset ([
             {'Motor Vehicle Registrations', src_row.vehv2_cnt, did_ref_prefix + 'VEH_V2', 'Retrievable'},
             {'VEHICLE',                     0,                 did_ref_prefix + 'VEH_V2', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_eq and (src_row.eq_cnt > 0), dataset ([
             {'Person Locator 1', src_row.eq_cnt, did_ref_prefix + 'PL1', 'Retrievable'}], iesp.share.t_SourceSection)) +
         if (param.include_controlledsubstances and (src_row.dea_cnt > 0) and (param.dea_version = 1), dataset ([
             {'DEA Controlled Substance Registrations', src_row.dea_cnt, did_ref_prefix + 'DEA', 'Retrievable'},
             {'DEA',                                   0,               did_ref_prefix + 'DEA', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_controlledsubstances and (src_row.deav2_cnt > 0) and (param.dea_version = 2), dataset ([
             {'DEA Controlled Substance Registrations', src_row.deav2_cnt, did_ref_prefix + 'DEA_V2', 'Retrievable'},
             {'DEA_V2',                                0,                 did_ref_prefix + 'DEA_V2', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_faaaircrafts and (src_row.airc_cnt >0), dataset ([
             {'FAA Aircraft Registrations', src_row.airc_cnt, did_ref_prefix + 'AIRC', 'Retrievable'},
             {'AIRCRAFT',                   0,                did_ref_prefix + 'AIRC', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_email and (src_row.email_cnt >0), dataset ([
             {'Email Addresses', src_row.email_cnt, did_ref_prefix + 'EMAIL', 'Retrievable'},
             {'EMAILADDRESS',    0,                 did_ref_prefix + 'EMAIL', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_faacertificates and (src_row.pilot_cnt > 0), dataset ([
             {'FAA Pilot Licenses', src_row.pilot_cnt, did_ref_prefix + 'PILOT', 'Retrievable'},
             {'PILOT',              0,                 did_ref_prefix + 'PILOT', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_faacertificates and (src_row.pilotcert_cnt > 0), dataset ([
             {'FAA Pilot Certifications', src_row.pilotcert_cnt, did_ref_prefix + 'PILOTCERT', 'Retrievable'},
             {'PILOTCERT',                0,                     did_ref_prefix + 'PILOTCERT', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_watercrafts and (src_row.watercraft_cnt > 0),     dataset ([
             {'WaterCraft Registrations', src_row.watercraft_cnt, did_ref_prefix + 'WATERCRAFT', 'Retrievable'},
             {'WATERCRAFT',               0,                      did_ref_prefix + 'WATERCRAFT', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_corpaffiliations and (src_row.corpaffil_cnt > 0), dataset ([
             {'Corporate Affiliations', src_row.corpaffil_cnt, did_ref_prefix + 'CORPAFFIL', 'Retrievable'},
             {'CORPAFFIL',              0,                     did_ref_prefix + 'CORPAFFIL', 'Section'}], iesp.share.t_SourceSection)) +
// not implemented:         if (param.aaa, dataset ([{'MerchantVessel Registrations', src_row.merchvessel_cnt, 'MERCHVESSEL', 'Retrievable'}], iesp.share.t_SourceSection) +
         if (param.include_voters and (src_row.voter_cnt > 0) and (param.voters_version = 1), dataset ([
             {'Voter Registrations', src_row.voter_cnt, did_ref_prefix + 'VOTER', 'Retrievable'},
             {'VOTER',               0,                 did_ref_prefix + 'VOTER', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_voters and (src_row.voterv2_cnt > 0) and (param.voters_version = 2), dataset ([
             {'Voter Registrations', src_row.voterv2_cnt, did_ref_prefix + 'VOTER_V2', 'Retrievable'},
             {'VOTER_V2',             0,                   did_ref_prefix + 'VOTER_V2', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_phonesplus and (src_row.phonesplus_cnt > 0) /*and (param.phonesplus_version=1)*/, dataset ([
             {'PhonesPlus Records', src_row.phonesplus_cnt, did_ref_prefix + 'PP', 'Retrievable'},
             {'PP',                 0,                      did_ref_prefix + 'PP', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_weaponpermits and (src_row.ccw_cnt > 0),   dataset ([
             {'Weapon Permits', src_row.ccw_cnt, did_ref_prefix + 'CCW', 'Retrievable'},
             {'WEAPON',         0,               did_ref_prefix + 'CCW', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_huntingfishing and (src_row.hunt_cnt > 0),   dataset ([
             {'Hunting and Fishing Licenses', src_row.hunt_cnt, did_ref_prefix + 'HUNT', 'Retrievable'},
             {'HUNTFISH',                     0,                did_ref_prefix + 'HUNT', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_domains and (src_row.whois_cnt > 0),         dataset ([
             {'Internet Domain Registrations', src_row.whois_cnt, did_ref_prefix + 'WHOIS', 'Retrievable'},
             {'WHOIS',                         0,                 did_ref_prefix + 'WHOIS', 'Section'}], iesp.share.t_SourceSection)) +
         if (header_include and (src_row.phone_cnt > 0),             dataset ([
             {'Phone', src_row.phone_cnt, did_ref_prefix + 'PHONE', 'Retrievable'},
             {'PHONE', 0,                 did_ref_prefix + 'PHONE', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_flcrash and (src_row.flcrash_cnt > 0),         dataset ([
             {'Accident', src_row.flcrash_cnt, did_ref_prefix + 'FLCRASH', 'Retrievable'},
             {'FLCRASH',  0,                   did_ref_prefix + 'FLCRASH', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_sexualoffences and (src_row.so_cnt > 0),  dataset ([
             {'Sexual Offense', src_row.so_cnt, did_ref_prefix + 'SEXOFFENDER', 'Retrievable'},
             {'SO',            0,              did_ref_prefix + 'SEXOFFENDER', 'Section'}], iesp.share.t_SourceSection)) +
									if (param.include_students and (src_row.student_cnt > 0),  dataset ([
             {'Student Locator', src_row.student_cnt, did_ref_prefix + 'STUDENT', 'Retrievable'},
             {'STUDENT',            0,         did_ref_prefix + 'STUDENT', 'Section'}], iesp.share.t_SourceSection)) +		 
         if (header_include and (src_row.ak_cnt > 0),             dataset ([
             {'Alaskan Permenant Fund', src_row.ak_cnt, did_ref_prefix + 'AK', 'Retrievable'},
             {'AK',                     0,              did_ref_prefix + 'AK', 'Section'}], iesp.share.t_SourceSection)) +
         if (header_include and (src_row.mswork_cnt > 0), dataset ([
             {'Mississippi Worker\'s Compensation', src_row.mswork_cnt, did_ref_prefix + 'MSWORK', 'Retrievable'},
             {'MSWORK',                             0,                  did_ref_prefix + 'MSWORK', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_foreclosures and (src_row.for_cnt > 0), dataset ([
             {'Foreclosure Records', src_row.for_cnt, did_ref_prefix + 'FOR', 'Retrievable'},
             {'FOR',                 0,               did_ref_prefix + 'FOR', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_nod and (src_row.nod_cnt > 0), dataset ([
             {'Notice Of Defaults Records', src_row.nod_cnt, did_ref_prefix + 'NOD', 'Retrievable'},
             {'NOD',                        0,               did_ref_prefix + 'NOD', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_fbn and (src_row.fbnv2_cnt > 0), dataset ([
             {'Fictitious Business Names Records', src_row.fbnv2_cnt, did_ref_prefix + 'FBNV2', 'Retrievable'},
             {'FBNV2',                             0,                 did_ref_prefix + 'FBNV2', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_boaters and (src_row.boater_cnt > 0), dataset ([
             {'Boat Registrations', src_row.boater_cnt, did_ref_prefix + 'BOATER', 'Retrievable'},
             {'BOATER',             0,                  did_ref_prefix + 'BOATER', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_uccfilings and (src_row.ucc_cnt > 0) and (param.ucc_version = 1),      dataset ([
             {'UCC Lien Filings', src_row.ucc_cnt, did_ref_prefix + 'UCC', 'Retrievable'},
             {'UCC',              0,               did_ref_prefix + 'UCC', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_uccfilings and (src_row.uccv2_cnt > 0) and (param.ucc_version = 2),      dataset ([
             {'UCC Lien Filings', src_row.uccv2_cnt, did_ref_prefix + 'UCC_V2', 'Retrievable'},
             {'UCC_V2',           0,                 did_ref_prefix + 'UCC_V2', 'Section'}], iesp.share.t_SourceSection)) +
         if (header_include and (src_row.finder_cnt > 0),             dataset ([
             {'Historical Person Locator', src_row.finder_cnt, did_ref_prefix + 'FINDER', 'Retrievable'},
             {'FINDER',                    0,                  did_ref_prefix + 'FINDER', 'Section'}], iesp.share.t_SourceSection)) +
         if (header_include and (src_row.tu_cnt > 0), dataset ([
             {'Person Locator 2', src_row.tu_cnt, did_ref_prefix + 'PL2', 'Retrievable'}], iesp.share.t_SourceSection)) +
         if (param.include_properties and (src_row.deed_cnt > 0) and (param.property_version = 1), dataset ([
             {'Deed Transfers', src_row.deed_cnt, did_ref_prefix + 'DEED', 'Retrievable'},
             {'DEED',           0,                did_ref_prefix + 'DEED', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_properties and (src_row.deed2_cnt > 0) and (param.property_version = 2), dataset ([
             {'Deed Transfers', src_row.deed2_cnt, did_ref_prefix + 'DEED_V2', 'Retrievable'},
             {'DEED_V2',        0,                 did_ref_prefix + 'DEED_V2', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_crimrecords and (src_row.doc_cnt > 0), dataset ([
             {'Criminal', src_row.doc_cnt, did_ref_prefix + 'DOC', 'Retrievable'},
             {'DOC',      0,               did_ref_prefix + 'DOC', 'Section'}], iesp.share.t_SourceSection)) +
         if (param.include_properties and (src_row.assessment_cnt > 0) and (param.property_version = 1), dataset ([
             {'Tax Assessor Records', src_row.assessment_cnt, did_ref_prefix + 'ASSESSMENT', 'Retrievable'}, 
             {'ASSESSMENT',           0,                      did_ref_prefix + 'ASSESSMENT', 'Retrievable'}], iesp.share.t_SourceSection)) +
         if (param.include_properties and (src_row.assessment2_cnt > 0) and (param.property_version = 2), dataset ([
             {'Tax Assessor Records', src_row.assessment2_cnt, did_ref_prefix + 'ASSESSMENT_V2','Retrievable'},
             {'ASSESSMENT_V2',        0,                       did_ref_prefix + 'ASSESSMENT_V2','Section'}], iesp.share.t_SourceSection)) +
									if (param.include_properties and (src_row.assessment2_cnt > 0) and (param.property_version = 2), dataset ([
             {'Property Records', src_row.assessment2_cnt + src_row.deed2_cnt, did_ref_prefix + 'PROPERTY_V2','Retrievable'},
             {'PROPERTY_V2',        0,                       did_ref_prefix + 'PROPERTY_V2','Section'}], iesp.share.t_SourceSection)) +		 
         if (header_include and (src_row.util_cnt > 0), dataset ([
             {'Utility Locator', src_row.util_cnt, did_ref_prefix + 'UTIL', 'Retrievable'},
             {'UTIL',            0,                did_ref_prefix + 'UTIL', 'Section'}], iesp.share.t_SourceSection)) +
         if (header_include and (src_row.statedeath_cnt > 0) /*and (param.statedeath_version = 1)*/, dataset ([
             {'State Death Records', src_row.statedeath_cnt, did_ref_prefix + 'STATEDEATH', 'Retrievable'},
             {'STATEDEATH',          0,                      did_ref_prefix + 'STATEDEATH', 'Section'}], iesp.share.t_SourceSection)) +
									if (header_include and (src_row.targ_cnt > 0) /*and (param.targus_version = 1)*/, dataset ([
             {'Person Locator 4', src_row.targ_cnt, did_ref_prefix + 'TARG', 'Retrievable'},
             {'Person Locator 4', 0,                did_ref_prefix + 'TARG', 'Section'}], iesp.share.t_SourceSection)) +
									if (header_include and (src_row.tn_cnt > 0), dataset ([
             {'Person Locator 6', src_row.tn_cnt, did_ref_prefix + 'PL6', 'Retrievable'}], iesp.share.t_SourceSection)) +		
									if (header_include and (src_row.en_cnt > 0) /*and (param.en_version = 1)*/, dataset ([
             {'Person Locator 5', src_row.en_cnt, did_ref_prefix + 'PL5', 'Retrievable'}], iesp.share.t_SourceSection)) +
       
									if (header_include and (src_row.en_cnt > 0) /*and (param.en_version = 1)*/, dataset ([
             {'Person Locator 1', src_row.eq_cnt, did_ref_prefix + 'PL1', 'Retrievable'}], iesp.share.t_SourceSection));

//  self.quickheader_cnt := count(dedup(SORT(L.quickheader_child, RECORD), record));

  // Take sections from header file (this is almost exact copy of the code from doxie.CRS)  
  //TODO: add dateVal to the interface
  header_recs := Doxie_Raw.Header_Raw (dids, , param.DPPAPurpose, param.GLBPurpose);

  header_sections := 
    if (exists (header_recs),             dataset ([{'ADDRESSES', 0, did_ref_prefix + 'ADDRESSES', 'Section'}], iesp.share.t_SourceSection)) +
    if (exists (header_recs (ssn != '')), dataset ([{'SSN',       0, did_ref_prefix + 'SSN',       'Section'}], iesp.share.t_SourceSection)) +
    if (exists (header_recs (dob != 0)),  dataset ([{'DOB',       0, did_ref_prefix + 'DOB',       'Section'}], iesp.share.t_SourceSection));

  return sources + header_sections;
END;  
    // those are actually included unconditionally...
  // self.death_cnt := count(dedup(SORT(L.death_child, RECORD), record));
  // self.statedeath_cnt := count(dedup(SORT(L.state_death_child,RECORD),record));  
  // self.ak_cnt := count(dedup(SORT(L.ak_child, RECORD), record));
  // self.mswork_cnt := count(dedup(SORT(L.mswork_child, RECORD), record));
  // self.util_cnt := count(dedup(SORT(L.util_child, RECORD), record));
  // self.quickheader_cnt := count(dedup(SORT(L.quickheader_child, RECORD), record));
  // self.eq_cnt := count(dedup(SORT(L.eq_child, RECORD), record));
  // self.en_cnt := count(dedup(SORT(L.en_child, RECORD), record));
  // self.boater_cnt := count(dedup(SORT(L.boater_child, RECORD), record));
  // self.tu_cnt := count(dedup(SORT(L.tu_child, RECORD), record));
  // self.finder_cnt := count(dedup(SORT(L.finder_child, RECORD), record));
  // self.phone_cnt := count(dedup(SORT(L.phone_child, RECORD), record));
  // self.targ_cnt := count(dedup(SORT(L.targ_child, RECORD), record));
  // self.phonesPlus_cnt := count(dedup(SORT(L.phonesPlus_child, RECORD), record));
