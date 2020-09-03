//============================================================================
// Attribute: Veh_raw.  Based on Doxie.Vehicle_Search_Local.
// Function to get vehicle records by did, vin, tag, vid, or company name.
// Return value: dataset of Doxie.Layout_VehicleSearch.
//============================================================================

import doxie, suppress;

export Veh_Raw(
  dataset(Doxie.layout_references) dids,
  doxie.IDataAccess mod_access,
  string30 vin_value = '',
  string20 tag_value = '',
  string25 vid_value = '',
  string2 st_code_value = '',
  string20 veh_num_value = '',
  string120 company_name_value = '',
  dataset(Doxie.Layout_ref_bdid) bdids = doxie_raw.ds_EmptyBDIDs,
  boolean ExcludeLessors = false,
  boolean include_non_regulated_data = false
) := FUNCTION


//***** Decide which inputs to use and build the batch dataset
set of string2 set_use :=
   if(vid_value <> '', ['S'],
      if(vin_value <> '', ['N'],
         if(tag_value <> '', ['T'],
            if(company_name_value <> '', ['C','D'],
               if(st_code_value <> '' and veh_num_value <> '', ['S'],
                  ['D'])))));

boolean go(string1 s) := s in set_use;

brec:= doxie_Raw.Layout_VehRawBatchInput.out_layout;


refsrec := record
  dids;
  bdids;
end;

brec make_bds(refsrec l) := transform
  self.input.seq := 0;
  self.input.did := l.did;
  self.input.bdid := l.bdid;
  self.input.vin_value := if(go('N'), vin_value, '');
  self.input.tag_value := if(go('T'), tag_value, '');
  self.input.vid_value := if(go('V'), vid_value, '');
  self.input.st_code_value := if(go('S'), st_code_value, '');
  self.input.veh_num_value := if(go('S'), IF(veh_num_value<>'',veh_num_value,vid_value), '');
  comp_name_cleaned := StringLib.StringFilter(datalib.CompanyClean(company_name_value),' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
  self.input.cname_indic := if(go('C'),comp_name_cleaned[1..40],'');
  self.input.cname_sec := if(go('C'),comp_name_cleaned[41..80],'');
  self := [];
end;

refsrec tra1(dids l) := transform
  self.did := l.did;
  self.bdid := 0;
end;

refsrec tra2(bdids l) := transform
  self.did := 0;
  self.bdid := l.bdid;
end;

both := project(dids, tra1(left)) + project(bdids, tra2(left));

forp := if(go('D'), both, dataset([{0,0}], refsrec));
//for_batch := group(project(forp, make_bds(left)),input.seq);
for_batch := group( SORTED (project(forp, make_bds(left)),input.seq) ,input.seq);


// ***** Call Batch Function
from_batch := UNGROUP(doxie_raw.Veh_Raw_batch(for_batch, mod_access, , ExcludeLessors, include_non_regulated_data)(VEHICLE_NUMBERxBG1<>''));

// ***** Output Format

Doxie.Layout_VehicleSearch forout(from_batch l) := transform
  self.seq := l.input.seq;
  self := l;
end;

pFT := project(from_batch, forout(left));


out_f_tmp := dedup(pFT, all);

appType := mod_access.application_type;
Suppress.MAC_Suppress(out_f_tmp,pull_own_1_did,appType,Suppress.Constants.LinkTypes.DID,own_1_did);
Suppress.MAC_Suppress(pull_own_1_did,pull_own_2_did,appType,Suppress.Constants.LinkTypes.DID,own_2_did);
Suppress.MAC_Suppress(pull_own_2_did,pull_reg_1_did,appType,Suppress.Constants.LinkTypes.DID,reg_1_did);
Suppress.MAC_Suppress(pull_reg_1_did,pull_reg_2_did,appType,Suppress.Constants.LinkTypes.DID,reg_2_did);

Suppress.MAC_Suppress(pull_reg_2_did,pull_own_1_ssn,appType,Suppress.Constants.LinkTypes.SSN,own_1_ssn);
Suppress.MAC_Suppress(pull_own_1_ssn,pull_own_2_ssn,appType,Suppress.Constants.LinkTypes.SSN,own_2_ssn);
Suppress.MAC_Suppress(pull_own_2_ssn,pull_reg_1_ssn,appType,Suppress.Constants.LinkTypes.SSN,reg_1_ssn);
Suppress.MAC_Suppress(pull_reg_1_ssn,out_f,appType,Suppress.Constants.LinkTypes.SSN,reg_2_ssn);

doxie.MAC_PruneOldSSNs(out_f, out_f_p1, own_1_ssn, own_1_did);
doxie.MAC_PruneOldSSNs(out_f_p1, out_f_p2, own_2_ssn, own_2_did);
doxie.MAC_PruneOldSSNs(out_f_p2, out_f_p3, reg_1_ssn, reg_1_did);
doxie.MAC_PruneOldSSNs(out_f_p3, out_f_p4, reg_2_ssn, reg_2_did);

ssn_mask_value := mod_access.ssn_mask;
dl_mask_value := mod_access.dl_mask > 1;
suppress.MAC_Mask(out_f_p4, outf_c, own_1_ssn, OWN_1_DRIVER_LICENSE_NUMBER, true, true);
suppress.MAC_Mask(outf_c, outf_d, own_2_ssn, OWN_2_DRIVER_LICENSE_NUMBER, true, true);
suppress.MAC_Mask(outf_d, outf_e, reg_1_ssn, REG_1_DRIVER_LICENSE_NUMBER, true, true);
suppress.MAC_Mask(outf_e, out_mskd, reg_2_ssn, REG_2_DRIVER_LICENSE_NUMBER, true, true);

return out_mskd;
END;
