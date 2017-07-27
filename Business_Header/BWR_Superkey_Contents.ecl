c1  := fileservices.superfilecontents('~thor_data400::key::business_header.Business_Relatives_Group_qa');
c2  := fileservices.superfilecontents('~thor_data400::key::business_header.BusinessRelatives_qa');
c3  := fileservices.superfilecontents('~thor_data400::key::business_header.Best_qa');
c4  := fileservices.superfilecontents('~thor_data400::key::business_contacts.bdid_qa');
c5  := fileservices.superfilecontents('~thor_data400::key::business_contacts.did_qa');
c6  := fileservices.superfilecontents('~thor_data400::key::business_contacts.ssn_qa');
c7  := fileservices.superfilecontents('~thor_data400::key::business_contacts.state.city.name_qa');
c8  := fileservices.superfilecontents('~thor_data400::key::business_contacts.state.lfname_qa');
c9  := fileservices.superfilecontents('~thor_data400::key::business_contacts_stat_qa');
c10 := fileservices.superfilecontents('~thor_data400::key::company_title_qa');
c11 := fileservices.superfilecontents('~thor_data400::key::business_header.src_qa');
c12 := fileservices.superfilecontents('~thor_data400::key::business_header.Phone_2_qa');
c13 := fileservices.superfilecontents('~thor_data400::key::business_header.CoNameWords_qa');
c14 := fileservices.superfilecontents('~thor_data400::key::business_header.FEIN_2_qa');
c15 := fileservices.superfilecontents('~thor_data400::key::business_header.CompanyName_3_qa');
c16 := fileservices.superfilecontents('~thor_data400::key::business_header.CompanyName_Unlimited_qa');
c17 := fileservices.superfilecontents('~thor_data400::key::cbrs.bdid_NameVariations_qa');
c18 := fileservices.superfilecontents('~thor_data400::key::business_header_bdid.city.zip.fein.phone_qa');
c19 := fileservices.superfilecontents('~thor_data400::key::business_header.BDID_qa');
c20 := fileservices.superfilecontents('~thor_data400::key::business_header.BDID_pl_qa');
c21 := fileservices.superfilecontents('~thor_data400::key::business_header.Addr_pr_pn_zip_qa');
c22 := fileservices.superfilecontents('~thor_data400::key::business_header.Addr_pr_pn_sr_st_qa');
c23 := fileservices.superfilecontents('~thor_Data400::key::bh_supergroup_bdid_qa');
c24 := fileservices.superfilecontents('~thor_Data400::key::bh_supergroup_groupid_qa');
c25 := fileservices.superfilecontents('~thor_Data400::key::business_header.SIC_Code_qa');
c26 := fileservices.superfilecontents('~thor_data400::key::groupid_cnt_qa');
c27 := fileservices.superfilecontents('~thor_data400::key::business_header.BDID_pl_qa');
c28 := fileservices.superfilecontents('~thor_data400::key::cbrs.bdid_relsByContact_qa');
c29 := fileservices.superfilecontents('~thor_data400::key::cbrs.addr_proflic_qa');
c30 := fileservices.superfilecontents('~thor_data400::key::cbrs.phone10_gong_qa');
c31 := fileservices.superfilecontents('~thor_data400::key::cbrs.addr.bdid_qa');
c32 := fileservices.superfilecontents('~thor_Data400::key::bh_supergroup_bdid_qa');
c33 := fileservices.superfilecontents('~thor_Data400::key::bh_supergroup_groupid_qa');

c :=  c1 
     +c2 
     +c3 
     +c4 
     +c5 
     +c6 
     +c7 
     +c8 
     +c9 
     +c10
     +c11
     +c12
     +c13
     +c14
     +c15
     +c16
     +c17
     +c18
     +c19
     +c20
     +c21
     +c22
     +c23
     +c24
     +c25
     +c26
     +c27
     +c28
     +c29
     +c30
     +c31
     +c32
     +c33;
	 
output(c);
     