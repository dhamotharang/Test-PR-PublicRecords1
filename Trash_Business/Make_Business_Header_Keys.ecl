IMPORT Business_Header, ut, business_risk,doxie_cbrs;

#workunit ('name', 'Build Business_Keys');
build_base_files := true;

p_best := Business_Header.BestAll;
ut.MAC_SF_BuildProcess(p_best, 'BASE::Business_Header.Best', p_best_out)

ut.MAC_SK_BuildProcess_v2(business_header.Key_BH_Best, '~thor_data400::key::business_header.Best',
											    key_best)

p_cn := Business_Header_SS.CompanyName;

// Output the company_name slimsort.
ut.MAC_SF_BuildProcess(p_cn,'BASE::business_header.CompanyName',p_cn_out)

ut.MAC_SK_BuildProcess(business_header_ss.Key_Prep_BH_CompanyName, 'key::business_header.CompanyName_3',
											 'key::business_header.CompanyName_3', key_cn)
ut.MAC_SK_BuildProcess_v2(business_header_ss.Key_BH_CompanyName_Unlimited, '~thor_data400::key::business_header.CompanyName_Unlimited',
												key_cnu)

// Output the company_name.address slimsort.
p_cn_a := Business_Header_SS.CompanyName_Address;
ut.MAC_SF_BuildProcess(p_cn_a,'BASE::business_header.CompanyName_Address',p_cn_a_out)

ut.MAC_SK_BuildProcess(business_header_ss.Key_Prep_BH_Addr_pr_pn_sr_st, 'key::business_header.Addr_pr_pn_sr_st',
											 'key::business_header.Addr_pr_pn_sr_st', key_a1)
ut.MAC_SK_BuildProcess(business_header_ss.Key_Prep_BH_Addr_pr_pn_zip, 'key::business_header.Addr_pr_pn_zip',
											 'key::business_header.Addr_pr_pn_zip', key_a2)

// Output the company_name.phone slimsort.
p_cn_p := Business_Header_SS.CompanyName_Phone;
ut.MAC_SF_BuildProcess(p_cn_p,'BASE::business_header.CompanyName_Phone', p_cn_p_out)

ut.MAC_SK_BuildProcess(business_header_ss.Key_Prep_BH_Phone, 'key::business_header.Phone_2',
											 'key::business_header.Phone_2', key_p)

// Output the company_name.FEIN slimsort.
p_cn_f := Business_Header_SS.CompanyName_FEIN;
ut.MAC_SF_BuildProcess(p_cn_f,'BASE::business_header.CompanyName_FEIN',p_cn_f_out)

//key_f := BUILDINDEX(Business_Header_SS.Key_BH_FEIN, OVERWRITE);
ut.MAC_SK_BuildProcess(business_header_ss.Key_Prep_BH_FEIN, 'key::business_header.FEIN_2',
											 'key::business_header.FEIN_2', key_f)

// Business header keys
ut.MAC_SK_BuildProcess(business_header_ss.Key_Prep_BH_Source, 'key::business_header.src',
											 'key::business_header.src', key_src)
ut.MAC_SK_BuildProcess(business_header_ss.Key_Prep_BH_BDID, 'key::business_header.BDID',
											 'key::business_header.BDID', key_header)
ut.MAC_SK_BuildProcess_v2(business_header_ss.Key_BH_BDID_pl, '~thor_data400::key::business_header.BDID_pl',
											 key_header_pl)
ut.MAC_SK_BuildProcess_v2(business_header.Key_Business_Relatives, 'key::business_header.BusinessRelatives',
											 key_relatives)
ut.MAC_SK_BuildProcess_v2(business_header.Key_Business_Relatives_Group, 'key::business_header.Business_Relatives_Group',
											 key_relatives_group)
ut.MAC_SK_BuildProcess_v2(doxie_cbrs.key_addr_bdid,'~thor_data400::key::cbrs.addr.bdid',
											 kab)
ut.MAC_SK_BuildProcess_v2(Doxie_cbrs.key_BDID_NameVariations, '~thor_data400::key::cbrs.bdid_NameVariations', 
											 knv)

// Build the base Super Group file
ut.MAC_SF_BuildProcess(Business_Header.BH_Super_Group,'~thor_data400::BASE::BH_Super_Group',p_sg_out)

// Super Group Keys
ut.MAC_SK_BuildProcess_v2(Business_Header.Key_BH_SuperGroup_GroupID,'~thor_Data400::key::bh_supergroup_groupid',key_sg_gid)

ut.MAC_SK_BuildProcess_v2(Business_Header.Key_BH_SuperGroup_BDID,'~thor_Data400::key::bh_supergroup_bdid',key_sg_bdid)

ut.MAC_SK_BuildProcess_v2(business_risk.key_groupid_cnt, '~thor_data400::key::groupid_cnt',key_sg_cnt)

// SIC Code Keys
ut.MAC_SK_BuildProcess_v2(Business_Header.Key_Prep_SIC_Code,'~thor_Data400::key::business_header.SIC_Code',key_bdid_sic)


all_outs := PARALLEL(	p_best_out, p_cn_out, p_cn_a_out, p_cn_p_out, p_cn_f_out, p_sg_out);

build_best := key_best;
	
build_cn := 
	parallel(
		key_cnu,
		sequential(
			ut.SF_MaintBuilding('BASE::business_header.CompanyName'),
			key_cn,
			ut.SF_MaintBuilt('BASE::business_header.CompanyName')
		)
	);
build_a := 
	sequential(
		ut.SF_MaintBuilding('BASE::business_header.CompanyName_Address'),
		key_a1,
		key_a2,
		ut.SF_MaintBuilt('BASE::business_header.CompanyName_Address')
	);
	
build_p :=
	sequential(
		ut.SF_MaintBuilding('BASE::business_header.CompanyName_Phone'),
		key_p,
		ut.SF_MaintBuilt('BASE::business_header.CompanyName_Phone')
	);
	
build_f := 
	sequential(
		ut.SF_MaintBuilding('BASE::business_header.CompanyName_FEIN'),
		key_f,
		ut.SF_MaintBuilt('BASE::business_header.CompanyName_FEIN')
	);
	
build_h := 
	sequential(
		ut.SF_MaintBuilding('BASE::Business_Header'),
		key_src,
		key_header,
		key_header_pl,
		kab,
		knv,
		ut.SF_MaintBuilt('BASE::Business_Header')
	);
	
build_r := key_relatives;
	
build_rg := key_relatives_group;
	
build_sg :=
	parallel(
		key_sg_gid,
		key_sg_bdid,
		key_sg_cnt
	);
	
build_sic :=
	sequential(
		key_bdid_sic
	);

	
sequential(
	if(build_base_files, all_outs, output('Base files and SFs not affected.')),
	build_best,
	build_cn,
	build_a,
	build_p,
	build_f,
	build_h,
	build_r,
	build_rg,
	build_sg,
	build_sic
	);
	