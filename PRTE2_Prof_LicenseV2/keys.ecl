 Import doxie, PRTE2_Prof_LicenseV2, BIPV2,  Prof_LicenseV2, ut;
 export keys :=Module

//bdid											
	export key_proflic_bdid := index(files.DS_File_prolicv2_Base2 ((integer)bdid != 0),
         {unsigned6 bd := (integer)files.DS_File_prolicv2_Base2.bdid},
				 {files.DS_File_prolicv2_Base2},
				 constants.KeyName_prolicv2 + doxie.Version_SuperKey +'::proflic_bdid');

 //did
 Export key_proflic_did (boolean isFCRA = false) := function

 //DF-22706: FCRA Consusmer Data Field Depreciation
 ut.MAC_CLEAR_FIELDS(files.DS_prolicv2_did, ds_did_cleaned, constants.fields_to_clear);
 dsFiles := if(isFCRA, ds_did_cleaned, files.DS_prolicv2_did);
 
 return index (dsFiles, {did}, {dsFiles}, 
        constants.KeyName_prolicv2 + 
        if (isFCRA,	'fcra::','') +			
				doxie.Version_SuperKey +'::prolicense_did');
end;
 
  //licensenum
 Export key_proflic_licensenum :=index (files.DS_prolicv2 (license_number !=''),
        {string20 s_license_number :=license_number,did,bdid},{files.DS_prolicv2},
				constants.KeyName_prolicv2 + doxie.Version_SuperKey + '::proflic_licensenum');

 //lnpid
  Export Key_Proflic_lnpid := index(files.DS_File_prolicv2_Base (lnpid!=0), {lnpid}, {prolic_key, prolic_seq_id},
         constants.KeyName_prolicv2 + doxie.Version_SuperKey +'::prolicense_lnpid');
													 
//addr
  Export key_proflic_addr :=index (files.DS_prolicv2 (prim_name <> '' and zip <> ''),
         {prim_name,prim_range,zip,sec_range},{files.DS_prolicv2},
         constants.KeyName_prolicv2 + doxie.Version_SuperKey + '::cbrs.addr_proflic');

 //id
 Export key_proflic_Id :=index (files.DS_prolicv2,
         {Prolic_seq_id},{files.DS_prolicv2},
         constants.KeyName_prolicv2 + doxie.Version_SuperKey + '::Prolic_Id');
					
//linkid

EXPORT Key_Proflic_LinkIDs := MODULE
BIPV2.IDmacros.mac_IndexWithXLinkIDs(files.DS_prolicv2_linkid (company_name<>''), out_key, 
	    constants.KeyName_prolicv2 + doxie.Version_SuperKey + '::linkids');
	
 Export Key:=out_key;
    
  //DEFINE THE INDEX ACCESS
  export KeyFetch(
	  dataset(BIPV2.IDlayouts.l_xlink_ids) in_ds_withids, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																												 //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																												//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0											 //Applied at lowest leve of ID
								) :=FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(in_ds_withids, Key, out_fetch, Level)
	  return out_fetch;																					

  END;

END;

//Lookup
EXPORT Key_LicenseType_lookup(boolean IsFCRA = false) := function

license_type_lookup_base := Prof_LicenseV2.File_ProfLic_LicenseType_lookup.License_Type_Base(license_type <>'');

filename := if (IsFCRA, 
	             constants.KeyName_prolicv2 + 'fcra::' + doxie.Version_SuperKey + '::professional_license_type_lookup',
							 constants.KeyName_prolicv2 + doxie.Version_SuperKey + '::professional_license_type_lookup');

return index(license_type_lookup_base, {license_type}, {license_type_lookup_base}, filename);								
								
end;

end;