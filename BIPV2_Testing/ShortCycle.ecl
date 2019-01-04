import LN_PropertyV2, business_header_ss, Corp2, bizlinkfull,tools;

EXPORT ShortCycle := 
MODULE

// **************************** Prop **********************************

export Prop :=
MODULE

//answer key
prop_all := BIPV2_Testing.ShortCycleData.prop;

//get data and find current status
prop_key := LN_PropertyV2.key_search_fid_linkids;

// prop_key := LN_PropertyV2.key_search_fid_linkids(ln_fares_id in ['DA0325845414','DA0325845413']);
// prop_key := LN_PropertyV2.key_search_fid_linkids(ln_fares_id = 'DA0325845414');
// prop_key := LN_PropertyV2.key_search_fid_linkids(ln_fares_id = 'OA0779489191');//valley
// prop_key := LN_PropertyV2.key_search_fid_linkids(ln_fares_id = 'DD0026093119');//bank


BIPV2_Testing.ShortCycleMacros.mac_set_mtype(prop_key, prop_all, prop_recs, prop_now, ln_fares_id, fid)
BIPV2_Testing.ShortCycleMacros.mac_reset(prop_recs, prop_reset, prop_layout)
																					
//test through macro for future status
business_header_ss.MAC_Match_Flex(
	prop_reset							// infile
	,['A','F','P']						// ,matchset
	,cname							// ,company_name_field
	,prim_range							// ,prange_field
	,prim_name							// ,pname_field
	,zip							// ,zip_field
	,sec_range							// ,srange_field
	,st							// ,state_field
	,phone_number							// ,phone_field
	,ln_fares_id							// ,fein_field - HACK (no fein field and no blank allowed)
	,bdid							// ,BDID_field
	,prop_layout							// ,outrec
	,FALSE							// ,bool_outrec_has_score
	,bdid_score2							// ,BDID_Score_field				//these should default to zero in definition
	,prop_out							// ,outfile
	,							// ,keep_count							= '1'
	,							// ,score_threshold				= '75'
	,							// ,pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,							// ,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	,[BIPV2.IDconstants.xlink_version_BIP]							// ,pSetLinkingVersions 		= BIPV2.IDconstants.xlink_versions_default	
	,							// ,pURL										=	''
	,							// ,pEmail									=	''
	,							// ,pCity									= ''	
	,fname							// ,pContact_fname					= ''
	,mname							// ,pContact_mname					= ''
	,lname							// ,pContact_lname					= ''
	,							// ,contact_ssn					  = ''
	,source_new							// ,source					        = ''
	,source_rec_id							// ,source_record_id				= ''
								// ,src_matching_is_priority	= FALSE
)

// output(prop_recs, named('prop_recs'));
// output(prop_out, named('prop_out'));
// output(prop_out(seleid in [16013341,130178935,152869835]), named('prop_out_int'));

BIPV2_Testing.ShortCycleMacros.mac_set_mtype(prop_out, prop_all, prop_future_wdups, prop_future, ln_fares_id, fid)
// output(prop_future_wdups(seleid in [16013341,130178935,152869835]), named('prop_future__wdups_int'));
// output(prop_future(seleid in [16013341,130178935,152869835]), named('prop_future_int'));
// output(prop_future(mtype = 'M', old_mtype = 'G'), named('prop_future_lost'));
// output(prop_future(mtype = 'M', old_mtype = 'G', old_seleid = seleid), named('prop_future_lost_seles_eq'));
// output(choosen(prop_future, 500), named('prop_future'));
BIPV2_Testing.ShortCycleMacros.mac_measure(prop_now,			go_prop_now,		out_prop_now,		prop_all, fid)
BIPV2_Testing.ShortCycleMacros.mac_measure(prop_future, 	go_prop_future,	out_prop_future,prop_all, fid)

// export go := parallel(go_prop_now,go_prop_future);
export out := out_prop_now + out_prop_future;

END;//Prop



// **************************** LNCA **********************************

export LNCA :=
MODULE
import DCAV2,DCA;


//answer key
LNCA_all := BIPV2_Testing.ShortCycleData.LNCA;

//get data and find current status
LNCA_key := DCA.Key_DCA_Root_Sub;
LNCA_linkids_key := 
project(
	DCAV2.Key_LinkIds.key, 
	transform(
		// {DCAV2.Key_LinkIds.key.ultid, DCAV2.Key_LinkIds.key.orgid, DCAV2.Key_LinkIds.key.seleid, DCAV2.Key_LinkIds.key.proxid,DCAV2.Key_LinkIds.key.dotid,
		{bipv2.IDlayouts.l_key_ids,
		 LNCA_key.root, LNCA_key.sub, LNCA_key.name, LNCA_key.prim_range, LNCA_key.prim_name, LNCA_key.sec_range, LNCA_key.z5, LNCA_key.st, LNCA_key.v_city_name, LNCA_key.phone,
		 LNCA_key.bdid, LNCA_key.exec1_fname, LNCA_key.exec1_mname, LNCA_key.exec1_lname
		},
		self.phone := left.clean_phones.phone,
		self.root	:= intformat((unsigned)left.rawfields.root,9,1),
		self.sub		:= intformat((unsigned)left.rawfields.sub,4,1),				
		self := left.rawfields,
		self := left.physical_Address,
		self.z5 := left.physical_Address.zip,
		self := left,
		self := []
	)
);



combined := BIPV2_Testing.ShortCycleMacros.mac_combine_two_indexes(LNCA_key, LNCA_linkids_key, LNCA_all, root, root, sub, sub);
combined2 := dedup(combined, seleid, root, sub, all);
BIPV2_Testing.ShortCycleMacros.mac_set_mtype(combined2, LNCA_all, LNCA_recs, LNCA_now, root, root, sub, sub)
BIPV2_Testing.ShortCycleMacros.mac_reset(LNCA_recs, LNCA_reset, LNCA_layout)

//test through macro for future status
business_header_ss.MAC_Match_Flex(
	LNCA_reset							// infile
	,['A','F','P']						// ,matchset
	,name							// ,company_name_field
	,prim_range							// ,prange_field
	,prim_name							// ,pname_field
	,z5							// ,zip_field
	,sec_range							// ,srange_field
	,st							// ,state_field
	,phone							// ,phone_field
	,phone							// ,fein_field - HACK (no fein field and no blank allowed)
	,bdid							// ,BDID_field
	,lnca_layout							// ,outrec
	,FALSE							// ,bool_outrec_has_score
	,bdid_score2							// ,BDID_Score_field				//these should default to zero in definition
	,lnca_out							// ,outfile
	,							// ,keep_count							= '1'
	,							// ,score_threshold				= '75'
	,							// ,pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,							// ,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	,[BIPV2.IDconstants.xlink_version_BIP]							// ,pSetLinkingVersions 		= BIPV2.IDconstants.xlink_versions_default	
	,							// ,pURL										=	''
	,							// ,pEmail									=	''
	,v_city_name							// ,pCity									= ''	
	,exec1_fname							// ,pContact_fname					= ''
	,exec1_mname							// ,pContact_mname					= ''
	,exec1_lname							// ,pContact_lname					= ''
	,							// ,contact_ssn					  = ''
	// ,source_new							// ,source					        = ''
	// ,source_rec_id							// ,source_record_id				= ''

)

output(combined, named('combined'));
output(combined2, named('combined2'));
output(LNCA_recs, named('LNCA_recs'));
// output(LNCA_out, named('LNCA_out'));

BIPV2_Testing.ShortCycleMacros.mac_set_mtype(LNCA_out, LNCA_all, LNCA_future_wdups, LNCA_future,root,root,sub,sub)
// output(LNCA_future, named('LNCA_future'));
BIPV2_Testing.ShortCycleMacros.mac_measure(LNCA_now,			go_LNCA_now,		out_LNCA_now,		LNCA_all, root)
BIPV2_Testing.ShortCycleMacros.mac_measure(LNCA_future, 	go_LNCA_future,	out_LNCA_future,LNCA_all, root)

// export go := parallel(go_LNCA_now,go_LNCA_future);
export out := out_LNCA_now + out_LNCA_future;

END;//LNCA


// **************************** dnbfein **********************************

export dnbfein :=
MODULE
import DNB_FEINV2;


//answer key
dnbfein_all := BIPV2_Testing.ShortCycleData.dnbfein;

//get data and find current status
dnbfein_key := DNB_FEINV2.key_dnb_fein_tmsid;
dnbfein_linkids_key := DNB_FEINV2.Key_LinkIds.key;



combined := BIPV2_Testing.ShortCycleMacros.mac_combine_two_indexes(dnbfein_key, dnbfein_linkids_key, dnbfein_all, tmsid, tmsid);

BIPV2_Testing.ShortCycleMacros.mac_set_mtype(combined, dnbfein_all, dnbfein_recs, dnbfein_now, tmsid, tmsid)
BIPV2_Testing.ShortCycleMacros.mac_reset(dnbfein_recs, dnbfein_reset, dnbfein_layout)
																					
//test through macro for future status
business_header_ss.MAC_Match_Flex(
	dnbfein_reset							// infile
	,['A','F','P']						// ,matchset
	,company_name							// ,company_name_field
	,prim_range							// ,prange_field
	,prim_name							// ,pname_field
	,zip							// ,zip_field
	,sec_range							// ,srange_field
	,st							// ,state_field
	,telephone_number							// ,phone_field
	,fein							// ,fein_field - HACK (no fein field and no blank allowed)
	,bdid							// ,BDID_field
	,dnbfein_layout							// ,outrec
	,FALSE							// ,bool_outrec_has_score
	,bdid_score2							// ,BDID_Score_field				//these should default to zero in definition
	,dnbfein_out							// ,outfile
	,							// ,keep_count							= '1'
	,							// ,score_threshold				= '75'
	,							// ,pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,							// ,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	,[BIPV2.IDconstants.xlink_version_BIP]							// ,pSetLinkingVersions 		= BIPV2.IDconstants.xlink_versions_default	
	,							// ,pURL										=	''
	,							// ,pEmail									=	''
	,p_city_name							// ,pCity									= ''	
	,fname							// ,pContact_fname					= ''
	,mname							// ,pContact_mname					= ''
	,lname							// ,pContact_lname					= ''
	,							// ,contact_ssn					  = ''
	,source_new							// ,source					        = ''
	,source_rec_id							// ,source_record_id				= ''
								// ,src_matching_is_priority	= FALSE
)

// output(dnbfein_recs, named('dnbfein_recs'));
// output(dnbfein_out, named('dnbfein_out'));

BIPV2_Testing.ShortCycleMacros.mac_set_mtype(dnbfein_out, dnbfein_all, dnbfein_future_wdups, dnbfein_future,tmsid, tmsid)
// output(dnbfein_future, named('dnbfein_future'));
BIPV2_Testing.ShortCycleMacros.mac_measure(dnbfein_now,			go_dnbfein_now,		out_dnbfein_now,		dnbfein_all, tmsid)
BIPV2_Testing.ShortCycleMacros.mac_measure(dnbfein_future, 	go_dnbfein_future,	out_dnbfein_future,dnbfein_all, tmsid)

// export go := parallel(go_dnbfein_now,go_dnbfein_future);
export out := out_dnbfein_now + out_dnbfein_future;

END;//dnbfein


shared common_rec := record
	string cr_company_name;
	string cr_prim_range;
	string cr_prim_name;
	string cr_zip;
	string cr_sec_range;
	string cr_st;
	string cr_phone_number;
	string cr_fein;
	string cr_p_city_name;
end;


// **************************** Accutrend **********************************

export Accu :=
MODULE
import BusReg;

//answer key
Accu_all := BIPV2_Testing.ShortCycleData.Accu;

//get data and find current status
Accu_key := BusReg.key_busreg_company_linkids.key(ultid in set(Accu_all, ultid));

BIPV2_Testing.ShortCycleMacros.mac_set_mtype(Accu_key, Accu_all, Accu_recs, Accu_now, ultid, ultid, orgid, orgid, source_rec_id, source_rec_id)//a bit hacky in this case..probably misses out on collapse detection, but no way around it
BIPV2_Testing.ShortCycleMacros.mac_reset(Accu_recs, Accu_reset, Accu_layout)
																					
//test through macro for future status
business_header_ss.MAC_Match_Flex(
	Accu_reset							// infile
	,['A','F','P']						// ,matchset
	,rawfields.company							// ,company_name_field
	,clean_mailing_address.prim_range							// ,prange_field
	,clean_mailing_address.prim_name							// ,pname_field
	,clean_mailing_address.zip							// ,zip_field
	,clean_mailing_address.sec_range							// ,srange_field
	,clean_mailing_address.st							// ,state_field
	,clean_phones.biz_phone							// ,phone_field
	,rawfields.tax_cl							// ,fein_field - HACK (no fein field and no blank allowed)
	,bdid							// ,BDID_field
	,Accu_layout							// ,outrec
	,FALSE							// ,bool_outrec_has_score
	,bdid_score2							// ,BDID_Score_field				//these should default to zero in definition
	,Accu_out							// ,outfile
	,							// ,keep_count							= '1'
	,							// ,score_threshold				= '75'
	,							// ,pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,							// ,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	,[BIPV2.IDconstants.xlink_version_BIP]							// ,pSetLinkingVersions 		= BIPV2.IDconstants.xlink_versions_default	
	,							// ,pURL										=	''
	,							// ,pEmail									=	''
	,clean_mailing_address.p_city_name							// ,pCity									= ''	
	,clean_officer1_name.fname							// ,pContact_fname					= ''
	,clean_officer1_name.mname							// ,pContact_mname					= ''
	,clean_officer1_name.lname							// ,pContact_lname					= ''
	,							// ,contact_ssn					  = ''
	,source_new							// ,source					        = ''
	,source_rec_id							// ,source_record_id				= ''
								// ,src_matching_is_priority	= FALSE
)




BIPV2_Testing.ShortCycleMacros.mac_set_mtype(Accu_out, Accu_all, Accu_future_wdups, Accu_future, source_rec_id, source_rec_id)
// output(Accu_all, named('Accu_all'));
// output(Accu_key(ultid in set(Accu_all, ultid)));
// output(Accu_key(ultid in set(Accu_all, ultid) and source_rec_id in set(accu_all, (integer)source_rec_id)));
// output(Accu_recs, named('Accu_recs'));
// output(Accu_out, named('Accu_out'));
// output(Accu_future, named('Accu_future'));
BIPV2_Testing.ShortCycleMacros.mac_measure(Accu_now,			go_Accu_now,		out_Accu_now,		Accu_all, source_rec_id)
BIPV2_Testing.ShortCycleMacros.mac_measure(Accu_future, 	go_Accu_future,	out_Accu_future,Accu_all, source_rec_id)

// export go := parallel(go_Accu_now,go_Accu_future);
export out := out_Accu_now + out_Accu_future;

END;//Accu


// **************************** FBN **********************************


export FBN :=
MODULE
import FBNV2;

//answer key
fbn_all := BIPV2_Testing.ShortCycleData.fbn;

//get data and find current status
fbn_key_raw := FBNV2.Key_Rmsid_Business;//and maybe FBNV2.Key_Rmsid_Contact to be better
fbn_key := fbn_key_raw;

fbn_linkids_key_raw := FBNV2.Key_LinkIds.key;
fbn_linkids_key := fbn_linkids_key_raw;

combined_nocontact := BIPV2_Testing.ShortCycleMacros.mac_combine_two_indexes(fbn_key, fbn_linkids_key, fbn_all, tmsid, tmsid, rmsid, rmsid);

ck := FBNV2.Key_Rmsid_Contact;
combined :=
join(
	combined_nocontact,
	ck,
	left.tmsid <> '' and
	keyed(left.tmsid = right.tmsid) and
	left.rmsid = right.rmsid,
	transform(
		{combined_nocontact, ck.ssn, ck.fname, ck.mname, ck.lname},
		self := left,
		self := right
	)
);

BIPV2_Testing.ShortCycleMacros.mac_set_mtype(combined, fbn_all, fbn_recs, fbn_now, tmsid, tmsid, rmsid, rmsid)
BIPV2_Testing.ShortCycleMacros.mac_reset(fbn_recs, fbn_reset, fbn_layout)
																					
//test through macro for future status
business_header_ss.MAC_Match_Flex(
	fbn_reset							// infile
	,['A','F','P']						// ,matchset
	,bus_name							// ,company_name_field
	,prim_range							// ,prange_field
	,prim_name							// ,pname_field
	,zip5							// ,zip_field
	,sec_range							// ,srange_field
	,st							// ,state_field
	,bus_phone_num							// ,phone_field
	,bus_phone_num							// ,fein_field - HACK (no fein field and no blank allowed)
	,bdid							// ,BDID_field
	,fbn_layout							// ,outrec
	,FALSE							// ,bool_outrec_has_score
	,bdid_score2							// ,BDID_Score_field				//these should default to zero in definition
	,fbn_out							// ,outfile
	,							// ,keep_count							= '1'
	,							// ,score_threshold				= '75'
	,							// ,pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,							// ,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	,[BIPV2.IDconstants.xlink_version_BIP]							// ,pSetLinkingVersions 		= BIPV2.IDconstants.xlink_versions_default	
	,							// ,pURL										=	''
	,							// ,pEmail									=	''
	,v_city_name			// ,pCity									= ''	
	,fname							// ,pContact_fname					= ''
	,mname							// ,pContact_mname					= ''
	,lname							// ,pContact_lname					= ''
	,ssn							// ,contact_ssn					  = ''
	,source_new							// ,source					        = ''
	,source_rec_id							// ,source_record_id				= ''
								// ,src_matching_is_priority	= FALSE
)

// output(combined, named('combined'));
// output(choosen(fbn_recs, 100), named('fbn_recs'));
// output(choosen(fbn_out, 100), named('fbn_out'));

BIPV2_Testing.ShortCycleMacros.mac_set_mtype(fbn_out, fbn_all, fbn_future_wdups, fbn_future, tmsid, tmsid, rmsid, rmsid)
// output(choosen(fbn_future, 100), named('fbn_future'));
BIPV2_Testing.ShortCycleMacros.mac_measure(fbn_now,			go_fbn_now,			out_fbn_now,		fbn_all, tmsid)
BIPV2_Testing.ShortCycleMacros.mac_measure(fbn_future, 	go_fbn_future,	out_fbn_future,	fbn_all, tmsid)

// export go := parallel(go_fbn_now,go_fbn_future);
export out := out_fbn_now + out_fbn_future;

END;//fbn


// **************************** EBR **********************************


export EBR :=
MODULE
import EBR;

//answer key
ebr_all := BIPV2_Testing.ShortCycleData.ebr;

//get data and find current status
ebr_key_raw := EBR.Key_0010_Header_FILE_NUMBER;
ebr_key := 
project(
	ebr_key_raw, 
	transform(
		{ebr_key_raw, common_rec}, 
		self.cr_company_name := left.company_name;
		self.cr_prim_range := left.prim_range;
		self.cr_prim_name := left.prim_name;
		self.cr_zip := left.zip;
		self.cr_sec_range := left.sec_Range;
		self.cr_st := left.st;
		self.cr_phone_number := left.phone_number;
		self.cr_fein := '';
		self.cr_p_city_name := left.p_city_name;		
		self := left
	)
);

ebr_linkids_key_raw := EBR.Key_0010_Header_linkids.key;
ebr_linkids_key := 
project(
	ebr_linkids_key_raw, 
	transform(
		{ebr_linkids_key_raw, common_rec}, 
		self.cr_company_name := left.company_name;
		self.cr_prim_range := left.clean_address.prim_range;
		self.cr_prim_name := left.clean_address.prim_name;
		self.cr_zip := left.clean_address.zip;
		self.cr_sec_range := left.clean_address.sec_Range;
		self.cr_st := left.clean_address.st;
		self.cr_phone_number := left.phone_number;
		self.cr_fein := '';
		self.cr_p_city_name := left.clean_address.p_city_name;		
		self := left
	)
);

combined := BIPV2_Testing.ShortCycleMacros.mac_combine_two_indexes(ebr_key, ebr_linkids_key, ebr_all, file_number, file_number);

BIPV2_Testing.ShortCycleMacros.mac_set_mtype(combined, ebr_all, ebr_recs, ebr_now, file_number, file_number)
BIPV2_Testing.ShortCycleMacros.mac_reset(ebr_recs, ebr_reset, ebr_layout)
																					
//test through macro for future status
business_header_ss.MAC_Match_Flex(
	ebr_reset							// infile
	,['A','F','P']						// ,matchset
	,cr_company_name							// ,company_name_field
	,cr_prim_range							// ,prange_field
	,cr_prim_name							// ,pname_field
	,cr_zip							// ,zip_field
	,cr_sec_range							// ,srange_field
	,cr_st							// ,state_field
	,cr_phone_number							// ,phone_field
	,cr_fein							// ,fein_field - HACK (no fein field and no blank allowed)
	,bdid							// ,BDID_field
	,ebr_layout							// ,outrec
	,FALSE							// ,bool_outrec_has_score
	,bdid_score2							// ,BDID_Score_field				//these should default to zero in definition
	,ebr_out							// ,outfile
	,							// ,keep_count							= '1'
	,							// ,score_threshold				= '75'
	,							// ,pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,							// ,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	,[BIPV2.IDconstants.xlink_version_BIP]							// ,pSetLinkingVersions 		= BIPV2.IDconstants.xlink_versions_default	
	,							// ,pURL										=	''
	,							// ,pEmail									=	''
	,cr_p_city_name			// ,pCity									= ''	
	,							// ,pContact_fname					= ''
	,							// ,pContact_mname					= ''
	,							// ,pContact_lname					= ''
	,							// ,contact_ssn					  = ''
	,source_new							// ,source					        = ''
	,source_rec_id							// ,source_record_id				= ''
								// ,src_matching_is_priority	= FALSE
)

// output(combined, named('combined'));
// output(choosen(ebr_recs, 100), named('ebr_recs'));
// output(choosen(ebr_out, 100), named('ebr_out'));

BIPV2_Testing.ShortCycleMacros.mac_set_mtype(ebr_out, ebr_all, ebr_future_wdups, ebr_future, file_number, file_number)

BIPV2_Testing.ShortCycleMacros.mac_measure(ebr_now,			go_ebr_now,		out_ebr_now,		ebr_all, file_number)
BIPV2_Testing.ShortCycleMacros.mac_measure(ebr_future, 	go_ebr_future,	out_ebr_future,ebr_all, file_number)

// export go := parallel(go_ebr_now,go_ebr_future);
export out := out_ebr_now + out_ebr_future;

END;//EBR



// **************************** DBDMI **********************************


export DBDMI :=
MODULE
import DNB_DMI;

//answer key
dbdmi_all := BIPV2_Testing.ShortCycleData.dbdmi;

//get data and find current status
dbdmi_key := DNB_DMI.Keys(,tools._Constants.IsDataland).Duns.qa;

BIPV2_Testing.ShortCycleMacros.mac_set_mtype(dbdmi_key, dbdmi_all, dbdmi_recs, dbdmi_now, duns, duns_number)
BIPV2_Testing.ShortCycleMacros.mac_reset(dbdmi_recs, dbdmi_reset, dbdmi_layout)
																					
//test through macro for future status
business_header_ss.MAC_Match_Flex(
	dbdmi_reset							// infile
	,['A','F','P']						// ,matchset
	,business_name							// ,company_name_field
	,prim_range							// ,prange_field
	,prim_name							// ,pname_field
	,zip							// ,zip_field
	,sec_range							// ,srange_field
	,st							// ,state_field
	,telephone_number							// ,phone_field
	,telephone_number							// ,fein_field - HACK (no fein field and no blank allowed)
	,bdid							// ,BDID_field
	,dbdmi_layout							// ,outrec
	,FALSE							// ,bool_outrec_has_score
	,bdid_score2							// ,BDID_Score_field				//these should default to zero in definition
	,dbdmi_out							// ,outfile
	,							// ,keep_count							= '1'
	,							// ,score_threshold				= '75'
	,							// ,pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,							// ,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	,[BIPV2.IDconstants.xlink_version_BIP]							// ,pSetLinkingVersions 		= BIPV2.IDconstants.xlink_versions_default	
	,							// ,pURL										=	''
	,							// ,pEmail									=	''
	,							// ,pCity									= ''	
	,							// ,pContact_fname					= ''
	,							// ,pContact_mname					= ''
	,							// ,pContact_lname					= ''
	,							// ,contact_ssn					  = ''
	,source_new							// ,source					        = ''
	,							// ,source_record_id				= ''										//********** missing source rids
								// ,src_matching_is_priority	= FALSE
)

// output(dbdmi_recs, named('dbdmi_recs'));
// output(dbdmi_out, named('dbdmi_out'));

BIPV2_Testing.ShortCycleMacros.mac_set_mtype(dbdmi_out, dbdmi_all, dbdmi_future_wdups, dbdmi_future, duns, duns_number)

BIPV2_Testing.ShortCycleMacros.mac_measure(dbdmi_now,			go_dbdmi_now,			out_dbdmi_now,		dbdmi_all, duns_number)
BIPV2_Testing.ShortCycleMacros.mac_measure(dbdmi_future, 	go_dbdmi_future,	out_dbdmi_future,	dbdmi_all, duns_number)

// export go := parallel(go_dbdmi_now,go_dbdmi_future);
export out := out_dbdmi_now + out_dbdmi_future;

END;//DBDMI


// **************************** BK **********************************


export BK :=
MODULE
import BankruptcyV3;

//answer key
bk_all := BIPV2_Testing.ShortCycleData.bk;

//get data and find current status
bk_key := BankruptcyV3.key_bankruptcyv3_search_full_bip();

BIPV2_Testing.ShortCycleMacros.mac_set_mtype(bk_key, bk_all, bk_recs, bk_now, tmsid, tmsid)
BIPV2_Testing.ShortCycleMacros.mac_reset(bk_recs, bk_reset, bk_layout, 'BA')
																					
//test through macro for future status
business_header_ss.MAC_Match_Flex(
	bk_reset							// infile
	,['A','F','P']						// ,matchset
	,cname							// ,company_name_field
	,prim_range							// ,prange_field
	,prim_name							// ,pname_field
	,zip							// ,zip_field
	,sec_range							// ,srange_field
	,st							// ,state_field
	,phone							// ,phone_field
	,tax_id							// ,fein_field - HACK (no fein field and no blank allowed)
	,bdid							// ,BDID_field
	,bk_layout							// ,outrec
	,FALSE							// ,bool_outrec_has_score
	,bdid_score2							// ,BDID_Score_field				//these should default to zero in definition
	,bk_out							// ,outfile
	,							// ,keep_count							= '1'
	,							// ,score_threshold				= '75'
	,							// ,pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,							// ,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	,[BIPV2.IDconstants.xlink_version_BIP]							// ,pSetLinkingVersions 		= BIPV2.IDconstants.xlink_versions_default	
	,							// ,pURL										=	''
	,							// ,pEmail									=	''
	,							// ,pCity									= ''	
	,fname							// ,pContact_fname					= ''
	,mname							// ,pContact_mname					= ''
	,lname							// ,pContact_lname					= ''
	,ssn							// ,contact_ssn					  = ''
	,source_new							// ,source					        = ''											************************ SOURCE NOT SET HERE ***********************
	,source_rec_id							// ,source_record_id				= ''
								// ,src_matching_is_priority	= FALSE
)

// output(bk_recs, named('bk_recs'));
// output(bk_out, named('bk_out'));

BIPV2_Testing.ShortCycleMacros.mac_set_mtype(bk_out, bk_all, bk_future_wdups, bk_future, tmsid, tmsid)

BIPV2_Testing.ShortCycleMacros.mac_measure(bk_now,			go_bk_now		, out_bk_now,			bk_all, tmsid)
BIPV2_Testing.ShortCycleMacros.mac_measure(bk_future, 	go_bk_future	, out_bk_future,bk_all, tmsid)

// export go := parallel(go_bk_now,go_bk_future);
export out := out_bk_now + out_bk_future;

END;//BK


// **************************** UCC **********************************


export UCC :=
MODULE
import uccv2;

//answer key
ucc_all := BIPV2_Testing.ShortCycleData.ucc;

//get data and find current status
ucc_key := UCCV2.Key_rmsid_party_linkids();

BIPV2_Testing.ShortCycleMacros.mac_set_mtype(ucc_key, ucc_all, ucc_recs, ucc_now, tmsid, tmsid)
BIPV2_Testing.ShortCycleMacros.mac_reset(ucc_recs, ucc_reset, ucc_layout)
																					
//test through macro for future status
business_header_ss.MAC_Match_Flex(
	ucc_reset							// infile
	,['A','F','P']						// ,matchset
	,company_name							// ,company_name_field
	,prim_range							// ,prange_field
	,prim_name							// ,pname_field
	,zip5							// ,zip_field
	,sec_range							// ,srange_field
	,st							// ,state_field
	,prim_name							// ,phone_field
	,fein							// ,fein_field - HACK (no fein field and no blank allowed)
	,bdid							// ,BDID_field
	,ucc_layout							// ,outrec
	,FALSE							// ,bool_outrec_has_score
	,bdid_score2							// ,BDID_Score_field				//these should default to zero in definition
	,ucc_out							// ,outfile
	,							// ,keep_count							= '1'
	,							// ,score_threshold				= '75'
	,							// ,pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,							// ,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	,[BIPV2.IDconstants.xlink_version_BIP]							// ,pSetLinkingVersions 		= BIPV2.IDconstants.xlink_versions_default	
	,							// ,pURL										=	''
	,							// ,pEmail									=	''
	,							// ,pCity									= ''	
	,fname							// ,pContact_fname					= ''
	,mname							// ,pContact_mname					= ''
	,lname							// ,pContact_lname					= ''
	,ssn							// ,contact_ssn					  = ''
	,source_new							// ,source					        = ''											************************ SOURCE NOT SET HERE ***********************
	,persistent_record_id							// ,source_record_id				= ''
								// ,src_matching_is_priority	= FALSE
)

// output(ucc_recs, named('ucc_recs'));
// output(ucc_out, named('ucc_out'));

BIPV2_Testing.ShortCycleMacros.mac_set_mtype(ucc_out, ucc_all, ucc_future_wdups, ucc_future, tmsid, tmsid)

BIPV2_Testing.ShortCycleMacros.mac_measure(ucc_now,			go_ucc_now		, out_ucc_now,		ucc_all, tmsid)
BIPV2_Testing.ShortCycleMacros.mac_measure(ucc_future, 	go_ucc_future	, out_ucc_future, ucc_all, tmsid)

// export go := parallel(go_ucc_now,go_ucc_future);
export out := out_ucc_now + out_ucc_future;

END;//UCC


// **************************** MVR **********************************


export MVR :=
MODULE
import VehicleV2;

//mac call in VehicleV2.VehicleV2_DID
//source is MDR.sourceTools.str_convert_vehicle
//source_rec_id


//answer key
mvr_all := BIPV2_Testing.ShortCycleData.mvr;

//get data and find current status
// mvr_key := VehicleV2.Key_Vehicle_Party_Key;//same as VehicleV2.Key_Vehicle_Party_Key_Linkids?
mvk0 := VehicleV2.Key_Vehicle_Party_Key_Linkids;
mvr_key := //workaround bug 140309
join(
	mvr_all,
	mvk0,
	keyed(left.vk = right.vehicle_key[1..15]),	
	transform(
		{mvk0}, 
		self.vehicle_key := right.vehicle_key[1..15], 
		self := right
	)
);


BIPV2_Testing.ShortCycleMacros.mac_set_mtype(mvr_key, mvr_all, mvr_recs, mvr_now, vehicle_key, vk, iteration_key, ik, sequence_key, sk)
BIPV2_Testing.ShortCycleMacros.mac_reset(mvr_recs, mvr_reset, mvr_layout)

																		
//test through macro for future status
business_header_ss.MAC_Match_Flex(
	mvr_reset							// infile
	,['A','F','P']						// ,matchset
	,append_clean_cname							// ,company_name_field
	,append_clean_address.prim_range							// ,prange_field
	,append_clean_address.prim_name							// ,pname_field
	,append_clean_address.zip5							// ,zip_field
	,append_clean_address.sec_range							// ,srange_field
	,append_clean_address.st							// ,state_field
	,append_clean_name.fname							// ,phone_field - HACK
	,append_clean_name.fname							// ,fein_field - HACK (no fein field and no blank allowed)
	,bdid							// ,BDID_field
	,mvr_layout							// ,outrec
	,FALSE							// ,bool_outrec_has_score
	,bdid_score2							// ,BDID_Score_field				//these should default to zero in definition
	,mvr_out							// ,outfile
	,							// ,keep_count							= '1'
	,							// ,score_threshold				= '75'
	,							// ,pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,							// ,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	,[BIPV2.IDconstants.xlink_version_BIP]							// ,pSetLinkingVersions 		= BIPV2.IDconstants.xlink_versions_default	
	,							// ,pURL										=	''
	,							// ,pEmail									=	''
	,append_clean_address.v_city_name							// ,pCity									= ''	
	,append_clean_name.fname							// ,pContact_fname					= ''
	,append_clean_name.mname							// ,pContact_mname					= ''
	,append_clean_name.lname							// ,pContact_lname					= ''
	,							// ,contact_ssn					  = ''
	,source_code							// ,source					        = ''
	,							// ,source_record_id				= ''
								// ,src_matching_is_priority	= FALSE
)

// output(choosen(mvr_all, 200), named('mvr_all'));
// output(choosen(dedup(mvr_all, vk, all), 2000), named('mvr_all_vks'));
// output(choosen(mvr_key, 200), named('mvr_key'));
// output(choosen(mvr_key(vehicle_key in set(mvr_all, vk)), 200), named('mvr_key_int'));
// output(choosen(mvr_recs, 200), named('mvr_recs'));
// output(choosen(mvr_out, 200), named('mvr_out'));

BIPV2_Testing.ShortCycleMacros.mac_set_mtype(mvr_out, mvr_all, mvr_future_wdups, mvr_future, vehicle_key, vk, iteration_key, ik, sequence_key, sk)

BIPV2_Testing.ShortCycleMacros.mac_measure(mvr_now,			go_mvr_now		, out_mvr_now,		mvr_all, vk)
BIPV2_Testing.ShortCycleMacros.mac_measure(mvr_future, 	go_mvr_future	, out_mvr_future, mvr_all, vk)

// export go := parallel(go_mvr_now,go_mvr_future);
export out := out_mvr_now + out_mvr_future;

END;//MVR


// **************************** LJ **********************************


export LJ := 
MODULE
import LiensV2;

lj_all := BIPV2_Testing.ShortCycleData.lj;
lj_key := LiensV2.Key_liens_party_ID_linkids;

BIPV2_Testing.ShortCycleMacros.mac_set_mtype(lj_key, lj_all, lj_recs, lj_now, tmsid, tmsid)
BIPV2_Testing.ShortCycleMacros.mac_reset(lj_recs, lj_reset, lj_layout)
																					
//test through macro for future status
business_header_ss.MAC_Match_Flex(
	lj_reset							// infile
	,['A','F','P']						// ,matchset
	,cname							// ,company_name_field
	,prim_range							// ,prange_field
	,prim_name							// ,pname_field
	,zip							// ,zip_field
	,sec_range							// ,srange_field
	,st							// ,state_field
	,phone							// ,phone_field
	,tax_id							// ,fein_field
	,bdid							// ,BDID_field
	,lj_layout							// ,outrec
	,FALSE							// ,bool_outrec_has_score
	,bdid_score2							// ,BDID_Score_field				//these should default to zero in definition
	,lj_out							// ,outfile
	,							// ,keep_count							= '1'
	,							// ,score_threshold				= '75'
	,							// ,pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,							// ,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	,[BIPV2.IDconstants.xlink_version_BIP]							// ,pSetLinkingVersions 		= BIPV2.IDconstants.xlink_versions_default	
	,							// ,pURL										=	''
	,							// ,pEmail									=	''
	,							// ,pCity									= ''	
	,fname							// ,pContact_fname					= ''
	,mname							// ,pContact_mname					= ''
	,lname							// ,pContact_lname					= ''
	,							// ,contact_ssn					  = ''
	,source_new							// ,source					        = ''
	,persistent_record_id							// ,source_record_id				= ''
								// ,src_matching_is_priority	= FALSE
)

// output(lj_recs, named('lj_recs'));
// output(lj_out, named('lj_out'));

BIPV2_Testing.ShortCycleMacros.mac_set_mtype(lj_out, lj_all, lj_future_wdups, lj_future, tmsid, tmsid)

BIPV2_Testing.ShortCycleMacros.mac_measure(lj_now,			go_lj_now,		out_lj_now,		lj_all, tmsid)
BIPV2_Testing.ShortCycleMacros.mac_measure(lj_future, 	go_lj_future,	out_lj_future,lj_all, tmsid)

// export go := parallel(go_lj_now,go_lj_future);
export out := out_lj_now + out_lj_future;

END;//LJ



// **************************** CORP **********************************


import mdr;

export Corp := 
MODULE


corp_all := BIPV2_Testing.ShortCycleData.corp

;

corp_key := Corp2.Key_Corp_Corpkey;

BIPV2_Testing.ShortCycleMacros.mac_set_mtype(corp_key, corp_all, corp_recs, corp_now, corp_key, ck)



//a couple of corp specific patches
corp_patch_layout := record
	corp_recs;
	string25 fname;
	string25 mname;
	string25 lname;
	string2 src := '';
	unsigned8 src_rcid := 0;
end;

corp_patch0 :=
join(
	corp_recs,
	Corp2.Key_Cont_Corpkey,
	keyed(left.corp_key = right.corp_key) 
	and left.corp_key <> '',
	transform(
		corp_patch_layout,
		self.fname := right.cont_fname,
		self.mname := right.cont_mname,
		self.lname := right.cont_lname,
		self := left
	),
	left outer,
	keep(100)
);

corp_patch := //this is hacky, but i think it at least prevents some of the dropoff when we rerun
join(
	corp_patch0,
	Corp2.Key_LinkIDs.corp.key,
	keyed(left.ultid = right.ultid and left.orgid = right.orgid and left.seleid = right.seleid and left.proxid = right.proxid),
	transform(
		corp_patch_layout,
		self.src := MDR.sourceTools.fCorpV2(left.corp_key, left.corp_state_origin),
		self.src_rcid := right.source_rec_id,
		self := left
	),
	left outer,
	keep(100)
);		
	


BIPV2_Testing.ShortCycleMacros.mac_reset(corp_patch, corp_reset, corp_layout)


	

//get source like this MDR.sourceTools.fCorpV2(l.corp_key, l.corp_state_origin)

business_header_ss.MAC_Match_Flex(           //********* AGAIN MISSING SOURCE MATCH
	corp_reset							// infile
	,['A','F','P']						// ,matchset
	,corp_legal_name							// ,company_name_field
	,corp_addr1_prim_range							// ,prange_field
	,corp_addr1_prim_name							// ,pname_field
	,corp_addr1_zip5							// ,zip_field
	,corp_addr1_sec_range							// ,srange_field
	,corp_addr1_state							// ,state_field
	,corp_phone_number							// ,phone_field
	,corp_fed_tax_id							// ,fein_field - HACK (no fein field and no blank allowed)
	,bdid							// ,BDID_field
	,corp_layout							// ,outrec
	,FALSE							// ,bool_outrec_has_score
	,bdid_score2							// ,BDID_Score_field				//these should default to zero in definition
	,corp_out							// ,outfile
	,							// ,keep_count							= '1'
	,							// ,score_threshold				= '75'
	,							// ,pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,							// ,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	,[BIPV2.IDconstants.xlink_version_BIP]							// ,pSetLinkingVersions 		= BIPV2.IDconstants.xlink_versions_default	
	,							// ,pURL										=	''
	,							// ,pEmail									=	''
	,							// ,pCity									= ''	
	,fname							// ,pContact_fname					= ''
	,mname							// ,pContact_mname					= ''
	,lname							// ,pContact_lname					= ''
	,							// ,contact_ssn					  = ''
	,src							// ,source					        = ''
	,src_rcid							// ,source_record_id				= ''
								// ,src_matching_is_priority	= FALSE
)

BIPV2_Testing.ShortCycleMacros.mac_set_mtype(corp_out, corp_all, corp_future_wdups, corp_future, corp_key, ck)

BIPV2_Testing.ShortCycleMacros.mac_measure(corp_now		,go_corp_now,			out_corp_now,		corp_all, ck)
BIPV2_Testing.ShortCycleMacros.mac_measure(corp_future, go_corp_future,	out_corp_future,corp_all, ck)

// export go := parallel(go_corp_now,go_corp_future);
export out := out_corp_now + out_corp_future;

END;//Corp


// **************************** AS LINKING **********************************



export AL :=
MODULE


al_all := BIPV2_Testing.ShortCycleData.rawp;
al_key := BIPV2_Testing.ShortCycleDataAsLinking.my._all;

BIPV2_Testing.ShortCycleMacros.mac_set_mtype(al_key, al_all, al_recs, al_now, vl_id, id1)
BIPV2_Testing.ShortCycleMacros.mac_reset(al_recs, al_reset, al_layout)
																					
//test through macro for future status
business_header_ss.MAC_Match_Flex(
	al_reset							// infile
	,['A','F','P']						// ,matchset
	,company_name							// ,company_name_field
	,company_address.prim_range							// ,prange_field
	,company_address.prim_name							// ,pname_field
	,company_address.zip							// ,zip_field
	,company_address.sec_range							// ,srange_field
	,company_address.st							// ,state_field
	,company_phone							// ,phone_field
	,company_fein							// ,fein_field
	,bdid							// ,BDID_field
	,al_layout							// ,outrec
	,FALSE							// ,bool_outrec_has_score
	,bdid_score2							// ,BDID_Score_field				//these should default to zero in definition
	,al_out1							// ,outfile
	,							// ,keep_count							= '1'
	,							// ,score_threshold				= '75'
	,							// ,pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,							// ,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	,[BIPV2.IDconstants.xlink_version_BIP]							// ,pSetLinkingVersions 		= BIPV2.IDconstants.xlink_versions_default	
	,company_url							// ,pURL										=	''
	,conatact_url							// ,pEmail									=	''
	,company_address.p_city_name							// ,pCity									= ''	
	,contact_name.fname							// ,pContact_fname					= ''
	,contact_name.mname							// ,pContact_mname					= ''
	,contact_name.lname							// ,pContact_lname					= ''
	,contact_ssn							// ,contact_ssn					  = ''
	,source							// ,source					        = ''
	,source_record_id							// ,source_record_id				= ''
								// ,src_matching_is_priority	= FALSE
)

// we should split this part up too for accurate mtype when extra fields

al_out := al_out1 : persist('~thor_data400::BIPV2_Testing.ShortCycle.al_out');
corp_out := al_out(src2 = 'corp');
bk_out 	:= al_out(src2 = 'bk');
// lnca_out 	:= al_out(src2 = 'lnca');
dbdmi_out 	:= al_out(src2 = 'dbdmi');
ebr_out 	:= al_out(src2 = 'ebr');
lj_out 	:= al_out(src2 = 'lj');
prop_out 	:= al_out(src2 = 'prop');
ucc_out 	:= al_out(src2 = 'ucc');
mvr_out 	:= al_out(src2 = 'mvr');


BIPV2_Testing.ShortCycleMacros.mac_set_mtype(corp_out, 		BIPV2_Testing.ShortCycleData.corp		,corp_future_wdups_aslinking, 	corp_future_aslinking, 	vl_id, ck)
BIPV2_Testing.ShortCycleMacros.mac_set_mtype(bk_out, 			BIPV2_Testing.ShortCycleData.bk			,bk_future_wdups_aslinking, 		bk_future_aslinking, 		vl_id, tmsid)
//lnca
BIPV2_Testing.ShortCycleMacros.mac_set_mtype(dbdmi_out, 	BIPV2_Testing.ShortCycleData.dbdmi 	,dbdmi_future_wdups_aslinking, dbdmi_future_aslinking, vl_id, duns_number)
BIPV2_Testing.ShortCycleMacros.mac_set_mtype(ebr_out, 		BIPV2_Testing.ShortCycleData.ebr 		,ebr_future_wdups_aslinking, 	ebr_future_aslinking, 	vl_id, file_number)
BIPV2_Testing.ShortCycleMacros.mac_set_mtype(lj_out, 			BIPV2_Testing.ShortCycleData.lj 		,lj_future_wdups_aslinking, 		lj_future_aslinking, 		vl_id, tmsid)
BIPV2_Testing.ShortCycleMacros.mac_set_mtype(prop_out, 		BIPV2_Testing.ShortCycleData.prop 	,prop_future_wdups_aslinking, 	prop_future_aslinking, 	vl_id, fid)
BIPV2_Testing.ShortCycleMacros.mac_set_mtype(ucc_out, 		BIPV2_Testing.ShortCycleData.ucc 		,ucc_future_wdups_aslinking, 	ucc_future_aslinking, 	vl_id, tmsid)
BIPV2_Testing.ShortCycleMacros.mac_set_mtype(mvr_out, 		BIPV2_Testing.ShortCycleData.mvr 		,mvr_future_wdups_aslinking, 	mvr_future_aslinking, 	vl_id, vk)

// output(al_recs, named('al_recs'));
// output(al_out, named('al_out'));

//split them back up by src2 and measure each separately


BIPV2_Testing.ShortCycleMacros.mac_measure(corp_future_aslinking, 	go_corp_al_future,	out_corp_al_future,	BIPV2_Testing.ShortCycleData.corp, 	ck)
BIPV2_Testing.ShortCycleMacros.mac_measure(bk_future_aslinking, 		go_bk_al_future,		out_bk_al_future,		BIPV2_Testing.ShortCycleData.bk, 		tmsid)
//lnca
BIPV2_Testing.ShortCycleMacros.mac_measure(dbdmi_future_aslinking, 	go_dbdmi_al_future,	out_dbdmi_al_future,BIPV2_Testing.ShortCycleData.dbdmi, duns_number)
BIPV2_Testing.ShortCycleMacros.mac_measure(ebr_future_aslinking, 		go_ebr_al_future,		out_ebr_al_future,	BIPV2_Testing.ShortCycleData.ebr, 	file_number)
BIPV2_Testing.ShortCycleMacros.mac_measure(lj_future_aslinking, 		go_lj_al_future,		out_lj_al_future,		BIPV2_Testing.ShortCycleData.lj, 		tmsid)
BIPV2_Testing.ShortCycleMacros.mac_measure(prop_future_aslinking, 	go_prop_al_future,	out_prop_al_future,	BIPV2_Testing.ShortCycleData.prop, 	fid)
BIPV2_Testing.ShortCycleMacros.mac_measure(ucc_future_aslinking, 		go_ucc_al_future,		out_ucc_al_future,	BIPV2_Testing.ShortCycleData.ucc, 	tmsid)
BIPV2_Testing.ShortCycleMacros.mac_measure(mvr_future_aslinking, 		go_mvr_al_future,		out_mvr_al_future,	BIPV2_Testing.ShortCycleData.mvr, 	vk)

// export go := parallel(go_al_now,go_al_future);
export out := out_corp_al_future + out_bk_al_future + /*lnca*/ out_dbdmi_al_future + out_ebr_al_future + out_lj_al_future + out_prop_al_future + out_ucc_al_future + out_mvr_al_future;


END;//AL

//**********  STATS  **************
shared c := BIPV2_Testing.Constants.SC.Settings;

shared outs := 
AL.out(c.DoAL) + prop.out(c.DoProp) + ucc.out(c.DoUCC) + corp.out(c.DoCorp) + lj.out(c.DoLJ) 
+ bk.out(c.DoBK) + dbdmi.out(c.DoDBDMI) + ebr.out(c.DoEBR) + fbn.out(c.DoFBN) + accu.out(c.DoAccu) 
+ dnbfein.out(c.DoDNBFEIN) + mvr.out(c.DoMVR)
;

shared outs_now := outs(dstime = 'now');
shared outs_future := outs(dstime = 'future');
shared outs_future_aslinking := outs(dstime = 'future_aslinking');
shared outs_sum :=
project(
	dataset([{1}], {unsigned a}),
	transform(
		{outs},
		self.dsname := '  ALL',
		self.dstime := max(outs_now, dstime),
		self.good_hits := sum(outs_now, good_hits),
		self.bad_hits := sum(outs_now, bad_hits),
		self.unknown_hits := sum(outs_now, unknown_hits),
		self.misses := sum(outs_now, misses),
		self.total_answers_given := sum(outs_now, total_answers_given),
		self.total_measured := sum(outs_now, total_measured),
		self := []
	)
)
+project(
	dataset([{1}], {unsigned a}),
	transform(
		{outs},
		self.dsname := '  ALL',
		self.dstime := max(outs_future, dstime),
		self.good_hits := sum(outs_future, good_hits),
		self.bad_hits := sum(outs_future, bad_hits),
		self.unknown_hits := sum(outs_future, unknown_hits),
		self.misses := sum(outs_future, misses),
		self.total_answers_given := sum(outs_future, total_answers_given),
		self.total_measured := sum(outs_future, total_measured),
		self := []
	)
)
+project(
	dataset([{1}], {unsigned a}),
	transform(
		{outs},
		self.dsname := '  ALL',
		self.dstime := max(outs_future_aslinking, dstime),
		self.good_hits := sum(outs_future_aslinking, good_hits),
		self.bad_hits := sum(outs_future_aslinking, bad_hits),
		self.unknown_hits := sum(outs_future_aslinking, unknown_hits),
		self.misses := sum(outs_future_aslinking, misses),
		self.total_answers_given := sum(outs_future_aslinking, total_answers_given),
		self.total_measured := sum(outs_future_aslinking, total_measured),
		self := []
	)
);
shared outs_all := outs + outs_sum;

shared stats := 
sort(
	project(
		outs_all,
		transform(
			{outs},
			self.precision := 						100 * (left.good_hits / (left.good_hits + left.bad_hits));
			self.recall :=								100 * (left.good_hits / (left.good_hits + left.misses));
			self.potential_recall :=			100 * ((left.good_hits + left.unknown_hits) / (left.good_hits + left.unknown_hits + left.misses));
			self.pct_measured :=					100 * ((left.total_measured) / (left.total_answers_given));
			
			self := left
		)
	),
dsname, -dstime
);

shared baddsname := BIPV2_Testing.ShortCycleData.RawP(datasource_name not in BIPV2_Testing.Constants.sc.dsnames.alls);

shared strPrevBuildNum := (string)BIPV2.KeySuffix_mod2.PreviousBuild.BuildNumber;
shared strThisBuildNum := (string)BIPV2.KeySuffix_mod2.ThisBuild.BuildNumber;

shared oldLF := BIPV2_Testing.Constants.SC.LFPrefx + 'Build_' + strPrevBuildNum + '.' + BIPV2.KeySuffix_mod2.PreviousBuild.versionDate;
shared newLF := BIPV2_Testing.Constants.SC.LFPrefx + 'Build_' + strThisBuildNum + '.' + BIPV2.KeySuffix_mod2.ThisBuild.versionDate;

shared oldStats := dataset(oldLF, {stats}, thor, opt);//dont fail just because this is missing

//compare old to new
shared compareRec := record
	string BuildNumber;
	stats;
end;

shared macd(f) := macro
			self.f := right.f - left.f,
endmacro;

shared diffAll := 
join(
	oldStats,
	stats,
	left.dsname = right.dsname and
	left.dstime = right.dstime,
	transform(
		compareRec,
		self.BuildNumber := ' CHANGE ',
		macd(total_answers_given	)
		macd(total_measured	)
		macd(pct_measured	)
		macd(good_hits	)
		macd(bad_hits	)
		macd(unknown_hits	)
		macd(misses	)
		macd(precision	)
		macd(recall	)
		macd(potential_recall	)
		macd(pct_amgibigous_match)
		self := left
	)
)+
project(
	stats,
	transform(
		compareRec,
		self.BuildNumber := strThisBuildNum,
		self := left
	)
)+	
project(
	oldstats,
	transform(
		compareRec,
		self.BuildNumber := strPrevBuildNum,
		self := left
	)
);

shared diffAllsrt := sort(diffAll, dsname, -dstime, if(BuildNumber = ' CHANGE ', 99999, (integer)BuildNumber));

shared writeToDisk := 
~tools._Constants.IsDataland;//write to disk when running as part of prod build.  dont bother when just in dataland 
// TRUE; //for testing

////////////
  import strata,BIPV2_Build;
  
  export do_strata(
     string                     pversion    = bipv2.KeySuffix
		,dataset(recordof(stats))   pStatsPR    = stats
    ,boolean                    pIsTesting  = false
  ) := 
  function
 
  lStatsPR := project(pStatsPR,transform({string dsname,string dstime,unsigned countgroup,recordof(stats) - pct_amgibigous_match - dsname - dstime, integer4 pct_ambiguous_match},self.countgroup := left.total_answers_given,self.dsname := trim(left.dsname,left,right),self.pct_ambiguous_match := left.pct_amgibigous_match,self := left))
    : independent;
  
    return parallel(

       Strata.macf_CreateXMLStats(lStatsPR  ,'BIPV2','XlinkSample'	,pversion	,BIPV2_Build.mod_email.emailList	,'Recall' ,'Precision' 	,pIsTesting) //group on src_name
      
    );
  end;
////////////////////
export Out := 
parallel(
	 output(oldStats, named('oldSTATS'))
	,output(stats, named('newSTATS'))
  ,do_strata()
	,output(diffAllsrt, named('DiffAll'))
	,output(diffAllsrt(BuildNumber = ' CHANGE ',dsname = '  ALL', dstime = 'future'), named('Diff'))

	#if(writeToDisk)
		,output(stats,,newLF + workunit)//this one will live forever in case you need to come back to it
		,output(stats,,newLF, overwrite)//this one will always have the latest for a particular sprint
	#end
	
	,output(count(baddsname), named('cnt_bad_Ds_name'))
	,output(dedup(baddsname, datasource_name, all), named('bad_Ds_names'))
	,output(BIPV2_Testing.Constants.SC.Settings)
	
);




END;