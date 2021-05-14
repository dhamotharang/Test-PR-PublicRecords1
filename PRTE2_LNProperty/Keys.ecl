IMPORT  doxie,mdr, PRTE2_LNProperty,BIPV2,AutoStandardI, ut;

EXPORT keys := MODULE

EXPORT key_addllegal(boolean IsFCRA) := INDEX(
		if (IsFCRA,FILES.DS_addllegal_fid(ln_fares_id[1] !='R'),FILES.DS_addllegal_fid),  
		{ln_fares_id},  
		{addl_legal}, 
		Constants.KeyName_ln_propertyv2 + IF(IsFCRA, 'fcra::', '') + doxie.Version_SuperKey + '::addllegal.fid');
	
EXPORT key_addlnames(boolean IsFCRA)  := INDEX(
		if (IsFCRA,FILES.DS_addlnames_fid(ln_fares_id[1] !='R'),FILES.DS_addlnames_fid),  
		{ln_fares_id},  
		{apnt_or_pin_number,buyer_or_seller,name_seq,name,id_code}, 
		Constants.KeyName_ln_propertyv2  + IF(IsFCRA, 'fcra::', '') + doxie.Version_SuperKey + '::addlnames.fid');

EXPORT key_addr_search(boolean IsFCRA) := INDEX(
		if (IsFCRA,FILES.KEY_ADDR_FID_PREP(ln_fares_id[1] !='R'),FILES.KEY_ADDR_FID_PREP),  
		{prim_name,prim_range,zip,predir,postdir,suffix,sec_range,string1 source_code_2 := source_code[2],LN_owner,owner,nofares_owner, 
					string1 source_code_1 := source_code[1]},
		{ln_fares_id, lname, fname, name_suffix}, 
		Constants.KeyName_ln_propertyv2  + IF(IsFCRA, 'fcra::', '') + doxie.Version_SuperKey + '::addr_search.fid');

EXPORT key_assessor(boolean IsFCRA):= function
dsTax := if(isFCRA,FILES.ln_propertyv2_tax(ln_fares_id[1] !='R',trim(ln_fares_id) != ''),FILES.ln_propertyv2_tax(trim(ln_fares_id) != ''));  
ut.MAC_CLEAR_FIELDS(dsTax, file_tax_cleared, prte2_lnproperty.Constants.field_to_clear_assessor_fid);
keyfile_tax := if(IsFCRA, file_tax_cleared, dsTax);
RETURN INDEX(keyfile_tax,
// if(isFCRA, keyfile_tax(ln_fares_id[1] !='R'),keyfile_tax),
		{ln_fares_id, unsigned6 proc_date := IF(IsFCRA,0,(unsigned)(IF(recording_date[1..6]!='',
		recording_date[1..6],sale_date[1..6])))},  
		{keyfile_tax} - [ln_fares_id],
		Constants.KeyName_ln_propertyv2  + IF(IsFCRA, 'fcra::', '') + doxie.Version_SuperKey + '::assessor.fid');
END;

EXPORT key_deed(boolean IsFCRA) := function
dsFile := if(isFCRA,Files.ln_propertyv2_deed(ln_fares_id[1] !='R' and trim(ln_fares_id) != ''),Files.ln_propertyv2_deed(trim(ln_fares_id) != ''));
ut.MAC_CLEAR_FIELDS(dsFile, file_deed_cleared, prte2_lnproperty.Constants.field_to_clear_deed_fid);
keyfile_deed := if(IsFCRA, file_deed_cleared, dsFile);
RETURN INDEX(keyfile_deed,
// if(IsFCRA, keyfile_deed(ln_fares_id[1] !='R' and trim(ln_fares_id) != ''),keyfile_deed(trim(ln_fares_id) != '')), 
		{ln_fares_id, unsigned6 proc_date := if(isFCRA, 0,(unsigned)(recording_date[1..6]))},  
		{keyfile_deed} - [ln_fares_id], 
		Constants.KeyName_ln_propertyv2 + IF(IsFCRA, 'fcra::', '') + doxie.Version_SuperKey + '::deed.fid');
END;		
	

EXPORT key_search_did(boolean IsFCRA) := INDEX(
		if (IsFCRA, FILES.file_search_building_dedup((unsigned)did > 0 and ln_fares_id[1] !='R'),FILES.file_search_building_dedup((unsigned)did > 0)), 
		{s_did := (unsigned)did, string1 source_code_2 := source_code[2]},  
		{ln_fares_id,source_code, lname, fname, prim_range, predir, prim_name, suffix, postdir, sec_range, st, p_city_name, zip, county, geo_blk}, 
		Constants.KeyName_ln_propertyv2 + IF(IsFCRA, 'fcra::', '') + doxie.Version_SuperKey + '::search.did');

EXPORT key_search_fid(boolean IsFCRA) := INDEX(
		Files.file_search_fid(IsFCRA),
		{ln_fares_id, which_orig, source_code_2 := source_code[2], source_code_1 := source_code[1]},  
		{Files.file_search_fid(IsFCRA)} - [which_orig, ln_fares_id], 
		Constants.KeyName_ln_propertyv2 + IF(IsFCRA, 'fcra::', '') + doxie.Version_SuperKey + '::search.fid');
											
EXPORT key_search_fid_county(boolean IsFCRA) := INDEX(
		if(IsFCRA,FILES.file_search_fid_county(ln_fares_id[1] !='R' ),FILES.file_search_fid_county),
		{ln_fares_id},  
		{p_county_name, o_county_name}, 
		Constants.KeyName_ln_propertyv2  + IF(IsFCRA, 'fcra::', '') + doxie.Version_SuperKey + '::search.fid_county');

EXPORT key_addlfaresdeed_fid := INDEX(
		FILES.DS_addlfaresdeed_fid,  
		{ln_fares_id},  
		{FILES.DS_addlfaresdeed_fid}, 
		Constants.KeyName_ln_propertyv2 + doxie.Version_SuperKey + '::addlfaresdeed.fid');
		
EXPORT key_addlfarestax_fid := INDEX(
		FILES.DS_addlfarestax_fid,  
		{ln_fares_id},  
		{FILES.DS_addlfarestax_fid}, 
		Constants.KeyName_ln_propertyv2 + doxie.Version_SuperKey + '::addlfarestax.fid');
		
EXPORT key_assessor_parcelnum := INDEX(
		FILES.file_assessor_pcn_df,  
		{fares_unformatted_apn},  
		{ln_fares_id}, 
		Constants.KeyName_ln_propertyv2 + doxie.Version_SuperKey + '::assessor.parcelnum');

EXPORT key_deed_parcelnum := INDEX(
		FILES.FILE_deed_pcn_df,  
		{fares_unformatted_apn},  
		{ln_fares_id}, 
		Constants.KeyName_ln_propertyv2 + doxie.Version_SuperKey + '::deed.parcelnum');


EXPORT key_deed_zip_loanamt := INDEX(	
		Files.dZipLoanAmt,
		{zip,loan_amount,loan_date},
		{ln_fares_id},
		Constants.KeyName_ln_propertyv2 + doxie.Version_SuperKey + '::deed.zip_loanamt'
	);

EXPORT Key_Search_BDID := INDEX(
		Files.ln_propertyv2_search((integer)bdid != 0),
		{unsigned6 s_bid := (integer)bdid},
		{Files.ln_propertyv2_search},
		Constants.KeyName_ln_propertyv2 + doxie.Version_SuperKey + '::search.bdid');
													
				
EXPORT Key_LinkIds := MODULE
	shared superfile_name		:= '~prte::key::ln_propertyv2::' + doxie.Version_SuperKey + '::search.linkids';
	shared Base				:= Files.file_search_fid_linkid;
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
	export Key := k;
	//DEFINE THE INDEX ACCESS
	EXPORT kFetch2(
		dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt),
		joinLimit=25000,
		unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin		) := 	FUNCTION 
	  BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, ds_fetched, Level, joinLimit, JoinType);
		arg1:= MDR.sourceTools.fProperty(ds_fetched.ln_fares_id);
		arg2 := BIPV2.mod_sources.faux_vlid(ds_fetched.ln_fares_id[1]);
		ds_restricted := ds_fetched(BIPV2.mod_sources.isPermitted(in_mod).bySource(arg1,arg2));
		return ds_restricted;																					
	END;

END;

EXPORT key_addr_full_v4(boolean IsFCRA, boolean filter_fares = false) := INDEX(
	File_Prop_Address_Prep_v4(IsFCRA, filter_fares), 
	 {prim_range, prim_name, sec_range, zip, suffix, predir, postdir}, 
	 {File_Prop_Address_Prep_v4(IsFCRA,filter_fares)} - [prim_range, prim_name, sec_range, zip, suffix, predir, postdir], 
	Map(IsFCRA=>'~prte::key::ln_propertyv2::fcra::' + doxie.Version_SuperKey + '::addr.full_v4',
			filter_fares=>'~prte::key::ln_propertyv2::' + doxie.Version_SuperKey + '::addr.full_v4',
			'~prte::key::ln_propertyv2::' + doxie.Version_SuperKey + '::addr.full_v4_no_fares'));

EXPORT key_ln_propertyv2_deedzip_avg_sales_price := INDEX(
	FILES.dAvgSalesPriceSort, 
	 {STRING5 z5 := zip,STRING4 z4 := zip4},
	{year,month,avg_sales_price}, 
	'~prte::key::ln_propertyv2::' + doxie.Version_SuperKey + '::deed::zip_avg_sales_price');	
EXPORT key_did_ownership_v4_fcra := INDEX(
  File_Prop_Ownership_FCRA_V4,
	{did},
	{File_Prop_Ownership_FCRA_V4},
	'~prte::key::ln_propertyv2::fcra::' + doxie.Version_SuperKey + '::did.ownership_v4');

EXPORT key_did_ownership_v4(boolean filter_fares) := INDEX(
	File_Prop_Ownership_V4(filter_fares),
	 {did}, 
	 {File_Prop_Ownership_V4(filter_fares)}, 
	if (	filter_fares , 
				'~prte::key::ln_propertyv2::' + doxie.Version_SuperKey + '::did.ownership_v4_no_fares',
				'~prte::key::ln_propertyv2::' + doxie.Version_SuperKey + '::did.ownership_v4'));

EXPORT key_ownership_addr := INDEX(
	Ownership_File.ownership_file_addr, 
	 {prim_range,predir,prim_name,addr_suffix,postdir,sec_range,zip5}, 
	 {Ownership_File.ownership_file_addr}, 
	'~prte::key::ln_propertyv2::' + doxie.Version_SuperKey + '::ownership_addr');

EXPORT key_tax_summary := INDEX(
	FILES.file_tax_summary, 
	 {zip,tax_year,avg_tax}, 
	 {zip,tax_year,avg_tax,avg_value}, 
	'~prte::key::ln_propertyv2::' + doxie.Version_SuperKey + '::tax_summary');
	
EXPORT key_ownership_did(boolean IsFCRA = false) := INDEX(
	Ownership_File.ownership_file_did, 
	 {did, current}, 
	 {Ownership_File.ownership_file_did}, 
	if(IsFCRA, '~prte::key::ln_propertyv2::fcra::' + doxie.Version_SuperKey + '::ownership_did', '~prte::key::ln_propertyv2::' + doxie.Version_SuperKey + '::ownership_did'));
	
EXPORT key_ownership_did2(boolean IsFCRA = false) := INDEX(
	Files.file_ownership_did, 
	{did,current}, 
	{Files.file_ownership_did}, 
	if(IsFCRA, '~prte::key::ln_propertyv2::fcra::' + doxie.Version_SuperKey + '::ownership.did','~prte::key::ln_propertyv2::' + doxie.Version_SuperKey + '::ownership.did'));

END;
