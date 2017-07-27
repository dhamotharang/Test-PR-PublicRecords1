//============================================================================
// Attribute: atf_raw.  Used by view source service and comp-report.
// Function to get atf records by did, or linum and trade.
// Return layout: atf.layout_firearms_explosives_out.
//============================================================================

import Doxie, suppress, ATF_Services, FCRA, Suppress;

nss_const := Suppress.Constants.NonSubjectSuppression;
export atf_raw(dataset(Doxie.layout_references) dids,
							 unsigned3 dateVal = 0,
							 unsigned1 dppa_purpose = 0,
							 unsigned1 glb_purpose = 0,
							 string6 ssn_mask_value = 'NONE',
							 boolean isFCRA = false, 
							 dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
							 integer nss = nss_const.doNothing) := FUNCTION
	
	did_recs 		 := project(dids, ATF_Services.Layouts.search_did);
	bydid 			 := ATF_services.Raw.byDIDs(did_recs, isFCRA);
	atf_recs 		 := ATF_Services.Raw.byATF_Ids(bydid, isFCRA, flagfile);
	atf_filtered := atf_recs(dateVal = 0 OR (unsigned3)(date_first_seen[1..6]) <= dateVal);
	
	//do non-subject suppression
	ATF_Services.layouts.firearms_out xformNss(atf_recs L) := transform
		//determine which name to use
		boolean is_license1 := l.rec_code in ATF_Services.Constants.license1_set;
		self.license1_fname := if(is_license1, l.license1_fname, '');
		self.license1_mname := if(is_license1, l.license1_mname, '');
		self.license1_lname := if(is_license1, l.license1_lname, 
																					 if(nss = nss_const.returnBlank, '', FCRA.Constants.FCRA_Restricted));
		self.license1_name_suffix := if(is_license1, l.license1_name_suffix, '');
		self.license1_title := if(is_license1, l.license1_title, '');
		self.license1_score := if(is_license1, l.license1_score, '');
		self.license2_fname := if(is_license1, '', l.license2_fname);
		self.license2_mname := if(is_license1, '', l.license2_mname);
		self.license2_lname := if(is_license1, if(nss = nss_const.returnBlank, '', FCRA.Constants.FCRA_Restricted), 
																					 l.license2_lname);
		self.license2_name_suffix := if(is_license1, '', l.license2_name_suffix);
		self.license2_title := if(is_license1, '', l.license2_title);
		self.license2_score := if(is_license1, '', l.license2_score);
		self.license_name :=  '';
		self := L;
	end;
	atf_nss := project(atf_filtered, xformNSS(left));
	
	atf_final:= if(nss = nss_const.doNothing, project(atf_filtered, ATF_Services.layouts.firearms_out), atf_nss);  
		
	out_f := sort(atf_final, whole record);

	doxie.MAC_PruneOldSSNs(out_f, out_f_pruned, best_ssn, did_out, isFCRA);
	suppress.MAC_Mask(out_f_pruned, out_mskd, best_ssn, blank, true, false);
	return out_mskd;

END;