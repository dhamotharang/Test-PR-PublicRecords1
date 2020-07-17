/*--SOAP--
<message name="Medlic_PL_Combined_Batch_Service">
	<part name="batch_in"          type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="DPPAPurpose"       type="xsd:byte"/>
  <part name="GLBPurpose"        type="xsd:byte"/>
	<part name="DataRestrictionMask"   type="xsd:string"/>
	<part name="DataPermissionMask"    type="xsd:string"/>
	<part name="ApplicationType"   type="xsd:string"/>
	<part name="MaxResults"        type="xsd:unsignedInt"/>
	<part name="PenaltThreshold"   type="xsd:unsignedInt"/>
</message>
*/

IMPORT Address,doxie,suppress,ut;

EXPORT Medlic_PL_Combined_Batch_Service(useCannedRecs = 'false') := MACRO

  // *** Temporary constants & layouts to be used below.
	unsigned1 addr_country := Address.Components.Country.US;
	gm := AutoStandardI.GlobalModule();

	// PenaltThreshold default in Medlic=10; PenaltThreshold default in PL=20.
	// Set individual Penalty Threshold attrs based upon if one was input or not.
  unsigned2 penTh   := gm.penalty_threshold;
  unsigned2 penThML := if(penTh<>0,penTh,10);
  unsigned2 penThPL := if(penTh<>0,penTh,20);
	appType := gm.ApplicationType;

  // Get the date the batch service is being run on for use in checking against
	// expiration_date below.
  string8 run_date := StringLib.GetDateYYYYMMDD();

  // Medlic_PL Combined Batch Service output layout for referencing in multiple places below.
	layout_comb_out := prof_LicenseV2_Services.Layout_MLPL_Combined_Output;

  // Temp medlic results layout plus additional fields.
	layout_ml_res_plus := record
		recordof(prof_LicenseV2_Services.Medlic_Batch_Service_Records);
    string9  ssn;
		/* Commented out, but not removed because may be needed in the near future.
		   See comment below after ml_ssn_appended := ...
		string10 prim_range;
    string2  predir;
    string28 prim_name;
    string4  suffix;
    string2  postdir;
    string10 unit_desig;
    string8  sec_range;
    string25 p_city_name;
    string25 v_city_name;
    string2  st;
    string5  zip;
    string4  zip4;
		*/
	end;


  // ******************************************************************************
	// ****** Get results using the Medlic_Batch_Service.
  // The first parm below is passing the PenaltThreshold to the new function.
	// The second parm below is passing on the input useCannedRecs boolean for testing.
	// The third parm below is set to true, which means you ARE running the combined BS.
  ml_results := prof_LicenseV2_Services.Medlic_Batch_Service_Records(penThML,useCannedRecs, true);

 	// *** Append the ssn before doing the normalize by joining to watchdog best files.
	ml_dids := dedup(sort(project(ml_results(did<>''), transform(doxie.layout_references, self.did := (unsigned6) left.did)), did), did);

	doxie.mac_best_records(ml_dids, did, ml_best_recs, true, ut.glb_ok(gm.GLBPurpose),, doxie.DataRestriction.fixed_DRM);

	ml_ssn_appended := join(ml_results, ml_best_recs,
													(unsigned6) left.did = right.did,
													transform(layout_ml_res_plus,
															self.ssn             := right.ssn,
															// Take the rest of the fields from the ml_results
															self                 := left),
													left outer, atmost(1));

 /* !!! Based upon a telephone discussion on 05/19/2010, Julie Gardner did not want
	  to return the address from the Medlic_Batch_Service in the new ML/PL Combined
	  Batch Service output.
	  So this project/transform is not needed at this point in time.
	  However, she mentioned that once customers start using the new batch service,
		she may want to change her mind and start including it.
		Therefore I thought it might help if she does ask for the ML address in the
		near future, to leave this coding in, but just comment it out.

  // *** Use a project with a transform to parse the ML Address1_1&2 fields into the
	// standard individual address fields so the ML address will be in same format
	// as the PL address.
  ml_appended_parsed := project(ml_ssn_appended, transform(layout_ml_res_plus,
	  addr_line1   := trim(left.Address1_1,left,right) +
		                if(left.Address2_1 <>'', ' ' + trim(left.Address2_1,left,right),'');
		addr_line2   := Address.Addr2FromComponents(left.city_1, left.st_1, left.zip_1);
		// obtain data fields (module) from "results" structure of address cleaner.
		parsed_addr  := Address.GetCleanAddress(addr_line1,addr_line2, addr_country).results;
	  //addr1_exists := left.Addrress1_1<>'';
	  self.prim_range  := parsed_addr.prim_range;
	  self.predir      := parsed_addr.predir;
    self.prim_name   := parsed_addr.prim_name;
    self.suffix      := parsed_addr.suffix;
    self.postdir     := parsed_addr.postdir;
    self.unit_desig  := parsed_addr.unit_desig;
    self.sec_range   := parsed_addr.sec_range;
    self.p_city_name := parsed_addr.p_city;
    self.v_city_name := parsed_addr.v_city;
    self.st          := parsed_addr.state;
    self.zip         := parsed_addr.zip;
    self.zip4        := parsed_addr.zip4;
		self             := left;
	));
 END OF COMMENTED OUT CODING */

  // *** Normalize the ML results records after ssn appended
	// to split out the Lic*_xxxx fields, also transforming them into the combined
	// batch service output layout.
	layout_comb_out norm_xform(layout_ml_res_plus L, integer C) := transform
	  // Set or split out certain individual fields
    self.data_source     := 'ML';
		self.title           := ''; // only on PL data, so blank it here
		self.fname           := L.prov_clean_fname;
		self.mname           := L.prov_clean_mname;
		self.lname           := L.prov_clean_lname;
		self.name_suffix     := ''; // only on PL data, so blank it here
		// Only take address parts from PL, not ML per Julie Gardner on 05/06 & 05/19/10;
		// so blank them out here when normalizing the ML data.
		self.prim_range      := '';
    self.predir          := '';
    self.prim_name       := '';
    self.suffix          := '';
    self.postdir         := '';
    self.unit_desig      := '';
    self.sec_range       := '';
    self.p_city_name     := '';
    self.v_city_name     := '';
    self.st              := '';
    self.zip             := '';
    self.zip4            := '';
 		self.license_number  := choose(C, L.Lic1_Number,  L.Lic2_Number,  L.Lic3_Number,  L.Lic4_Number,
		                                  L.Lic5_Number,  L.Lic6_Number,  L.Lic7_Number,  L.Lic8_Number,
		                                  L.Lic9_Number,  L.Lic10_Number, L.Lic11_Number, L.Lic12_Number,
		                                  L.Lic13_Number, L.Lic14_Number, L.Lic15_Number, L.Lic16_Number,
		                                  L.Lic17_Number, L.Lic18_Number, L.Lic19_Number, L.Lic20_Number);
		self.license_state   := choose(C, L.Lic1_State,  L.Lic2_State,  L.Lic3_State,  L.Lic4_State,
		                                  L.Lic5_State,  L.Lic6_State,  L.Lic7_State,  L.Lic8_State,
		                                  L.Lic9_State,  L.Lic10_State, L.Lic11_State, L.Lic12_State,
		                                  L.Lic13_State, L.Lic14_State, L.Lic15_State, L.Lic16_State,
																			L.Lic17_State, L.Lic18_State, L.Lic19_State, L.Lic20_State);
		temp_issue_date10    := choose(C, L.Lic1_Eff_Date,  L.Lic2_Eff_Date,  L.Lic3_Eff_Date,  L.Lic4_Eff_Date,
                                      L.Lic5_Eff_Date,  L.Lic6_Eff_Date,  L.Lic7_Eff_Date,  L.Lic8_Eff_Date,
                                      L.Lic9_Eff_Date,  L.Lic10_Eff_Date, L.Lic11_Eff_Date, L.Lic12_Eff_Date,
                                      L.Lic13_Eff_Date, L.Lic14_Eff_Date, L.Lic15_Eff_Date, L.Lic16_Eff_Date,
                                      L.Lic17_Eff_Date, L.Lic18_Eff_Date, L.Lic16_Eff_Date, L.Lic20_Eff_Date);
		temp_exp_date10      := choose(C, L.Lic1_Exp_Date,  L.Lic2_Exp_Date,  L.Lic3_Exp_Date,  L.Lic4_Exp_Date,
                                      L.Lic5_Exp_Date,  L.Lic6_Exp_Date,  L.Lic7_Exp_Date,  L.Lic8_Exp_Date,
                                      L.Lic9_Exp_Date,  L.Lic10_Exp_Date, L.Lic11_Exp_Date, L.Lic12_Exp_Date,
                                      L.Lic13_Exp_Date, L.Lic14_Exp_Date, L.Lic15_Exp_Date, L.Lic16_Exp_Date,
                                      L.Lic17_Exp_Date, L.Lic18_Exp_Date, L.Lic16_Exp_Date, L.Lic20_Exp_Date);
		// strip "/"s in the issue & expiration date
		string8 temp_issue_date8  := StringLib.StringFilterOut(temp_issue_date10, '/');
		string8 temp_exp_date8    := StringLib.StringFilterOut(temp_exp_date10, '/');
		self.issue_date           := temp_issue_date8;
		self.expiration_date      := temp_exp_date8;
		// Set expired_flag based upon contents of expiration_date
		self.expired_flag    := if(temp_exp_date8='','U',
		                           if(run_date>temp_exp_date8,'Y','N'));
    self.last_renewal_date      := ''; // only on PL data, so blank it here
		// default to issue-date, but may be over-layed in rollup
    self.first_known_issue_date := temp_issue_date8;
    self.profession_or_board    := ''; // only on PL data, so blank it here
    self.license_type           := ''; // only on PL data, so blank it here
		// the rest of the fields are taken from the input L
		self                        :=	L;
	end;

	ml_normed   := normalize(ml_ssn_appended,20,norm_xform(left,counter));

  // *** Filter to remove recs with empty lic#
	ml_filtered := ml_normed(license_number <>'');


  // ******************************************************************************
	// ****** Get results using the PL_Batch_Service.
	// The first parm below is passing the PenaltThreshold to the new function.
	// The second parm below is passing on the input useCannedRecs boolean for testing.
	// The third parm below is set to true, which means you ARE running the combined BS.

	ds_batch_in_raw := DATASET([], prof_LicenseV2_Services.Layout_MLPL_Combined_Input) : STORED('batch_in', FEW);
  pl_results := prof_LicenseV2_Services.PL_Batch_Service_Records(penThPL,useCannedRecs, true,ds_batch_in_raw);

  // *** Project PL_Batch_service output into combined output layout
  pl_projected := project(PL_results,
	                        transform(layout_comb_out,
													  // set certain fields
                            self.data_source   := 'PL';
                            self.ssn           := left.best_ssn;
												    self.license_state := left.source_st;
														// default to issue-date, but may be over-layed in rollup
												    self.first_known_issue_date := left.issue_date;
														// the rest of fields have the same name as PL BS output
                            self               := left));

  // *** Filter to remove recs with empty lic#
	pl_filtered := pl_projected(license_number <>'');


  // ******************************************************************************
  // ****** Combine the ML & PL results which are in the common output layout.
  comb_ml_pl := ml_filtered + pl_filtered;

	// *** DID & SSN pulling ***
	Suppress.MAC_Suppress(comb_ml_pl,comb_dids_pulled,appType,Suppress.Constants.LinkTypes.DID,did);
	Suppress.MAC_Suppress(comb_dids_pulled,comb_ssns_pulled,appType,Suppress.Constants.LinkTypes.SSN,ssn);
	doxie.MAC_PruneOldSSNs(comb_ssns_pulled, comb_pulled, ssn, did);

  // *** Sort by acctno, lic_state, lic_number, lname, fname, did,
	// descending expiration_date (puts most current first) and
	// descending data_source (puts preferred 'PL' data first) for a license and
	// descending issue_date (puts most recent/non-blank on first).
  comb_sorted := sort(comb_pulled,acctno,license_state,license_number, lname, fname,
	                                did, -expiration_date, -data_source, -issue_date,record);

	// *** Roll up the records for each unique acctno, lic_state, lic_number, lname, fname.
	layout_comb_out rollup_xform(layout_comb_out le, layout_comb_out ri) := transform
		// For each unique acctno/lic_state/lic#/lname/fname (the rollup condition),
		// use the record with the most current (greatest) expiration date.
		// If the exp dates are the same, use the one from the 'PL' data.
		keep_left := if(le.expiration_date > ri.expiration_date,
		                true,
										if(le.expiration_date = ri.expiration_date and
										   le.data_source = 'PL',true,false));
	  // Keep the lowest non-blank/non-zero issue_date of all recs being rolled together.
		self.first_known_issue_date  := MAP(ri.issue_date = ''  => le.issue_date,
            			                      le.issue_date = ''  => ri.issue_date,
                                        if(le.issue_date < ri.issue_date,
					                                 le.issue_date, ri.issue_date));
    // Keep all dids for the person
		string le_did_trimmed := trim(le.did,left,right);
		string ri_did_trimmed := trim(ri.did,left,right);
		self.did := if(le_did_trimmed <>'',
		               (if(le_did_trimmed = ri_did_trimmed,        // true le.did <>''
									     le_did_trimmed,                         // "
		                   if(ri_did_trimmed <>'',le_did_trimmed + '; ' + ri_did_trimmed,
											                        le_did_trimmed)) // "
									 ),
									 ri_did_trimmed                              // false le.did = ''
								  );
	  // For all other fields, use left if boolean was set on, otherwise use right.
		self := if(keep_left,le,ri);
	end;

	comb_rolled := rollup(comb_sorted, rollup_xform(LEFT,RIGHT),
												  (LEFT.acctno         = RIGHT.acctno),
													(LEFT.license_state  = RIGHT.license_state),
													(LEFT.license_number = RIGHT.license_number),
													(LEFT.lname          = RIGHT.lname),
													(LEFT.fname          = RIGHT.fname));

	// *** Sort final output by acctno, penalt, Lname, Fname, mname, descending exp_date, lic_state, lic_num
  combined_final := sort(comb_rolled,acctno,penalt,lname,fname,mname,-expiration_date,license_state,license_number, record);


	// Uncomment lines below as needed for debugging
	//output(run_date,           named('run_date'));
	//output(ml_results,         named('ml_results'));
	//output(ml_ssn_appended,    named('ml_ssn_appended'));
	//output(ml_appended_parsed, named('ml_appended_parsed'));
	//output(ml_normed,          named('ml_normed'));
	//output(ml_filtered,        named('ml_filtered'));
	//output(pl_results,         named('pl_results'));
	//output(pl_projected,       named('pl_projected'));
	//output(pl_filtered,        named('pl_filtered'));
	//output(comb_ml_pl,         named('comb_ml_pl'));
	//output(comb_pulled,        named('comb_pulled'));
	//output(comb_sorted,        named('comb_sorted'));
  //output(comb_rolled,        named('comb_rolled'));

  // output final results.
  OUTPUT(combined_final, NAMED('Results'));

ENDMACRO;
