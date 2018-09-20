// Fetches header data for a person: addresses, names, relatives, etc. Input [dids] has no more than one record.
IMPORT doxie, doxie_crs, suppress, fcra, header, AID_Build, Relationship, Advo, FFD;

EXPORT central_header (DATASET (doxie.layout_references) dids,
                       boolean IsFCRA = false, 
											 boolean VerifyUniqueID = false,
											 boolean in_getSSNBest = false,
											 dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = dataset([], FFD.Layouts.PersonContextBatchSlim), 											 
											 integer8 inFFDOptionsMask = 0,
											 dataset (FCRA.Layout_override_flag) ds_flags = FCRA.compliance.blank_flagfile
											 ) := FUNCTION

boolean includeGeoLocation := false : stored('IncludeGeoLocation');
boolean IncludePhoneMetadata := false : stored('IncludePhoneMetadata'); //For Accurint CompReport

doxie.MAC_Header_Field_Declare(IsFCRA); //ssn_value, fname_value, lname_value, dial_contactprecision_value
mod_access := doxie.functions.GetGlobalDataAccessModule ();

doxie.MAC_Selection_Declare();

// non-FCRA header data
idid := max(dids(did > 0, did < header.constants.QH_start_rid), did);//dids has no more than 1 record here.  this is just a technique for turning it into an integer value.  see #stored('useOnlyBestDID',true) in doxie.Comprehensive_Report_Service
boolean IncludeBlankDOD := false : stored('IncludeBlankDOD');
dear0 := doxie.Deathfile_Records(IncludeBlankDOD or (unsigned)dod8 != 0); 

best_full := doxie.best_records (dids, FALSE, useNonBlankKey := true, getSSNBest := in_getSSNBest, modAccess := mod_access);

ssnr_pre := doxie.fn_ssn_records(best_full);

besr_pre := project(best_full, 
    transform (doxie_crs.layout_best_information, 
      self.phones := doxie_crs.verifiedPhones(Legacy_Verified_Value).records, 
      self.dod := max(dear0((unsigned)did = idid),dod8),
			self.deceased := if(exists(dear0((unsigned)did = idid)),'Y','N'),
      self.ssn := if (left.ssn <> '',
                      left.ssn, 
                      if(exists(ssnr_pre(did = idid and ssn = ssn_value)), ssn_value, ''));
      self := left)
);

// TODO: It looks like there's no reliable way to fetch flag records by SSN in the FCRA context:
//   consider just taking it from the input, if any.

// FCRA header data -- based on the DIDs fetched from the neutral site.
// All FCRA-relevant corrections are applied inside
fcra_csa_wrap := FCRA.comp_subject (dids, mod_access.dppa, mod_access.glb, false, // exclude Gong so far
                                    mod_access.industry_class,
                                    dial_contactprecision_value, // *, Addresses_PerSubject * //
																		, ds_flags, slim_pc_recs(datagroup in FFD.Constants.DataGroupSet.HDR), inFFDOptionsMask);

// Additional validation of DID, if requested
did_verify_input := module (doxie.IVerifyLexID)
  export unsigned6 did := choosen (dids, 1)[1].did;
  export string9 ssn := ssn_value;
  export string fname := fname_value;
  export string lname := lname_value;
end;

best_fcra := IF (VerifyUniqueID and ~fcra_csa_wrap.is_verified (did_verify_input),
                 FAIL (dataset ([], doxie_crs.layout_best_information), 307, doxie.ErrorCodes (307)),
                 fcra_csa_wrap.best_record);

besr0 := if (IsFCRA, best_fcra, besr_pre);
ssnr0 := if (IsFCRA, fcra_csa_wrap.ssn_recs, ssnr_pre);

// choose addresses/names depending on fcra:
csa_wrap := doxie.Comp_Subject_Addresses_wrap;

csa_addresses := if (IsFCRA, fcra_csa_wrap.addresses, csa_wrap.addresses);
csa_names := if (IsFCRA, fcra_csa_wrap.names, csa_wrap.names);


shrr0 := doxie.HRI_SSN_records;

_addr_verified := doxie_Crs.Comp_Addresses_Verified(Legacy_Verified_Value);

_addr_geo := join(_addr_verified, AID_Build.Key_AID_Base, 
                  left.rawaid = right.rawaid, 
                  transform(recordof(_addr_verified), self.geo_lat := right.geo_lat, self.geo_long := right.geo_long, self := left), 
									left outer, keep(1), limit(0));

_addr_temp := if(includeGeoLocation, _addr_geo, _addr_verified);
_addr := IF (IsFCRA, csa_addresses, _addr_temp);

doxie.MAC_Add_UtilityConnection(_addr, doxie.Layout_Comp_Addr_Utility_Recs, //addr, 
                                addr_util, TRUE, IsFCRA, mod_access.isValidGLB()); // Appends Utility recs to subject address.
																

//adding address type for residence/business indicator comp report redesign
 
//Look up data by address (using zip)
ds_zip_key := join(addr_util,Advo.Key_Addr1,
		keyed(left.zip != '' and left.zip = right.zip) and
		keyed(left.prim_range = right.prim_range) and
		keyed(left.prim_name = right.prim_name) and
		keyed(left.suffix = right.addr_suffix) and
		keyed(left.predir = right.predir) and
		keyed(left.postdir = right.postdir) and
		keyed(left.sec_range = right.sec_range),
		transform(doxie.Layout_Comp_Addr_Utility_Recs,
			self.Address_type := Advo.Lookup_Descriptions.fn_resbus_mixed(right.Residential_Or_Business_Ind),
			self := left),left outer,
		LIMIT(0),keep(1));
		
//  Look up data by address (using City/State)
addr_nonfcra := join(ds_zip_key,Advo.Key_Addr2,
												keyed(left.Address_type = '' and left.st != '' and left.city_name != '' and left.st = right.st) and
												keyed(left.city_name = right.v_city_name) and
								        keyed(left.prim_range = right.prim_range) and
												keyed(left.prim_name = right.prim_name) and
												keyed(left.sec_range = right.sec_range),
												transform(doxie.Layout_Comp_Addr_Utility_Recs,
																	self.Address_type := If(left.Address_type='',Advo.Lookup_Descriptions.fn_resbus_mixed(right.Residential_Or_Business_Ind),left.Address_type),
																	self := left),left outer,
												LIMIT(0),keep(1));
												
addr0 := if(IsFCRA,	addr_util , addr_nonfcra); 																			
resr := if (IsFCRA, fcra_csa_wrap.residents, doxie.Resident_Links);

namr_unmasked := if (IsFCRA, fcra_csa_wrap.comp_names, doxie.comp_names);
suppress.MAC_Mask(namr_unmasked,namr_masked,ssn,blank,true,false,maskVal := mod_access.ssn_mask);
namr0 := if (mod_access.ln_branded, global(namr_unmasked), global(namr_masked));

relationship.IParams.storeHighConfidence(mod_access.application_type);
relr0 := ungroup(doxie.relative_summary);
assr0 := doxie_crs.associate_summary;
nbrr := doxie.Historic_Nbr_Summary();
nbrr20 := doxie_crs.nbr_records_slim;
nbhr := doxie.Comp_NBrHds;

phrecs := doxie.comp_phones (include_hri_val, maxHriPer_value, IncludePhoneMetadata);
phrecs_nogeo := phrecs.current;
phrecs_geo := join(phrecs_nogeo, AID_Build.Key_AID_Base, 
                  left.rawaid = right.rawaid, 
                  transform(recordof(phrecs_nogeo), self.geo_lat := right.geo_lat, self.geo_long := right.geo_long, self := left), 
								  left outer, keep(1), limit(0));
phrecs_temp := if (includeGeoLocation, phrecs_geo, phrecs_nogeo);
phor0       := if (IsFCRA, fcra_csa_wrap.phones, phrecs_temp);

phOld0 := if (IsFCRA, fcra_csa_wrap.phones_old, phrecs.old);
sslr0 := if (IsFCRA, fcra_csa_wrap.ssn_lookups, doxie.SSN_Lookups);

// ****************************************************************************
// This section of coding was added for the FDN project.
// A new Append_FDN_Inds module was created to check multiple datasets for fdn
// data in 1 module and then it's exports can used conditionally further below.
// ****************************************************************************
// Set shorter alias names for the new FDN related DPM & DRM positions & Includes.
boolean FDNContDataPermitted := doxie.DataPermission.use_FDNContributoryData;
boolean FDNInqDataPermitted  := ~doxie.DataRestriction.FDNInquiry;
boolean FDN_Any        := IncludeFDNSubjectOnly or IncludeFDNAllAssociations;
boolean FDN_Associates := IncludeFDNAllAssociations;

mod_append_fdn_inds := doxie.Append_FDN_Inds(besr0, ssnr0, shrr0, dear0, addr0, namr0, phor0, 
                                             phold0, sslr0, relr0, assr0, nbrr20,
																						 IncludeFDNSubjectOnly,  IncludeFDNAllAssociations,
                                             in_FDN_gcid, in_FDN_indtype, in_FDN_prodcode,
                                             FDNContDataPermitted, FDNInqDataPermitted);

besr := if(NOT IsFCRA and FDN_Any ,mod_append_fdn_inds.ds_besr_fdn_checked, besr0);

// NOTE: FDN_Any used above because even though assocaites are not in the besr dataset, 
//       the fdn waf ind is in there and fdn waf applies to both subject and associates

ssnr  := if(NOT IsFCRA and FDN_Any, mod_append_fdn_inds.ds_ssnr_fdn_checked, ssnr0);
shrr  := if(NOT IsFCRA and FDN_Any, mod_append_fdn_inds.ds_shrr_fdn_checked, shrr0);
dear  := if(NOT IsFCRA and FDN_Any, mod_append_fdn_inds.ds_dear_fdn_checked, dear0);
addr  := if(NOT IsFCRA and FDN_Any, mod_append_fdn_inds.ds_addr_fdn_checked, addr0);
namr  := if(NOT IsFCRA and FDN_Any, mod_append_fdn_inds.ds_namr_fdn_checked, namr0);
phor  := if(NOT IsFCRA and FDN_Any, mod_append_fdn_inds.ds_phor_fdn_checked, phor0);
phold := if(NOT IsFCRA and FDN_Any, mod_append_fdn_inds.ds_phold_fdn_checked, phold0);
sslr  := if(NOT IsFCRA and FDN_Any, mod_append_fdn_inds.ds_sslr_fdn_checked, sslr0);
relr  := if(NOT IsFCRA and FDN_Associates, mod_append_fdn_inds.ds_relr_fdn_checked, relr0);
assr  := if(NOT IsFCRA and FDN_Associates, mod_append_fdn_inds.ds_assr_fdn_checked, assr0);
nbrr2 := if(NOT IsFCRA and FDN_Associates, mod_append_fdn_inds.ds_nbrr2_fdn_checked, nbrr20);

// Added for the FDN Project to create the new FDN child dataset/section of the report
fdnrecs := if(NOT IsFCRA and FDN_Any, 
              doxie.FDN_Records(mod_append_fdn_inds.ds_fdnidkey_recs_matched));
// end of the coding section added for FDN changes

doxie.layout_central_header Format () := transform
         self.best_information_children    := global(besr);
         self.hri_ssn_children             := IF (~IsFCRA, global(shrr));
         self.deathfile_children           := IF (~IsFCRA, global(dear));
         self.ssn_children                 := global(ssnr);
         self.addresses_children           := global(addr);
         self.resident_links_children      := global(resr);
         self.phones_children              := global(phor);
         self.phones_old_children          := if (Include_OldPhones_Val, global(phOld));
         self.ssn_lookups_children         := global(sslr);
         self.names_children               := namr;
         self.relative_summary_children    := IF (~IsFCRA, global(relr(relative = true)) );
         self.associate_summary_children   := IF (~IsFCRA, global(assr) );
         self.nbrs_summary_children        := IF (~IsFCRA, global(nbrr) );
         self.nbrs_summary2_children       := IF (~IsFCRA, global(nbrr2) );
         self.nbrhoods_children            := IF (~IsFCRA, global(nbhr) );
         self.fdn_children                 := IF(~IsFCRA, global(fdnrecs) );
         // these two datasets were not returned from neutral or central_record services before,
         // but were calculated in central records for use in certain single-sources
         self.subject_names                := global(csa_names);
         self.subject_addresses            := global(csa_addresses);
         self.errors := []; // this can be eventually removed from the layout
end;

preSuppress := dataset ([Format ()]);
//This is being added here to accomodate the Peoplewise product until such time as all the all the pullssn and pullid
//changes are made to get everything on the new suppression, then this becomes redundant.
Suppress.MAC_Suppress(preSuppress,postSuppress,mod_access.application_type,suppress.constants.LinkTypes.DID,best_information_children[1].did);

// this should be a temporary measure on FCRA side:

return postSuppress;//IF (IsFCRA,preSuppress,postSuppress);
  
END;
