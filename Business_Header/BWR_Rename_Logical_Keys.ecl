import doxie, ut, business_header;
#workunit ('name', 'Rename All Business Header Keys, email roxie');

all_superkeynames := DATASET([

	{'~thor_Data400::key::bh_supergroup_bdid_qa', 							business_header.Keynames.NewConvention.Supergroup.Bdid.Template},
	{'~thor_Data400::key::bh_supergroup_groupid_qa', 						business_header.Keynames.NewConvention.Supergroup.Groupid.Template},
	{'~thor_data400::key::groupid_cnt_qa', 									business_header.Keynames.NewConvention.Supergroup.GroupidCnt.Template},

	{'~thor_data400::key::business_contacts.bdid_qa', 						business_header.Keynames.NewConvention.Contacts.Bdid.Template},
	{'~thor_data400::key::business_contacts.did_qa', 						business_header.Keynames.NewConvention.Contacts.Did.Template},
	{'~thor_data400::key::business_contacts.ssn_qa', 						business_header.Keynames.NewConvention.Contacts.Ssn.Template},
	{'~thor_data400::key::business_contacts.state.city.name_qa', 			business_header.Keynames.NewConvention.Contacts.StateCityName.Template},
	{'~thor_data400::key::business_contacts.state.lfname_qa', 				business_header.Keynames.NewConvention.Contacts.StateLfmname.Template},
	{'~thor_data400::key::cbrs.bdid_relsByContact_qa', 						business_header.Keynames.NewConvention.Contacts.BdidScore.Template},
//	{'~thor_data400::key::company_title_qa', 								business_header.Keynames.NewConvention.Contacts.Companytitle.Template}, // can't rename one node key yet

	{'~thor_data400::key::business_contacts_stat_qa', 						business_header.Keynames.NewConvention.ContactsStat.FileposData.Template},

	{'~thor_data400::key::business_header.src_qa', 							business_header.Keynames.NewConvention.Base.Src.Template},
	{'~thor_data400::key::business_header.Phone_2_qa', 						business_header.Keynames.NewConvention.Base.Phone.Template},
	{'~thor_data400::key::business_header.CoNameWords_qa', 					business_header.Keynames.NewConvention.Base.Conamewords.Template},
	{'~thor_data400::key::business_header.FEIN_2_qa', 						business_header.Keynames.NewConvention.Base.Fein.Template},
	{'~thor_data400::key::business_header.CompanyName_3_qa', 				business_header.Keynames.NewConvention.Base.CompanynameBdidCnBdids.Template},
	{'~thor_data400::key::business_header.CompanyName_Unlimited_qa', 		business_header.Keynames.NewConvention.Base.Companyname.Template},
	{'~thor_data400::key::cbrs.bdid_NameVariations_qa', 					business_header.Keynames.NewConvention.Base.BdidSeq.Template},
	{'~thor_data400::key::business_header_bdid.city.zip.fein.phone_qa', 	business_header.Keynames.NewConvention.Base.BdidCityZipFeinPhone.Template},
	{'~thor_data400::key::business_header.BDID_qa', 						business_header.Keynames.NewConvention.Base.Bdid.Template},
	{'~thor_data400::key::business_header.BDID_pl_qa', 						business_header.Keynames.NewConvention.Base.BdidPl.Template},
	{'~thor_data400::key::business_header.Addr_pr_pn_zip_qa', 				business_header.Keynames.NewConvention.Base.AddrPrPnZip.Template},
	{'~thor_data400::key::business_header.Addr_pr_pn_sr_st_qa', 			business_header.Keynames.NewConvention.Base.AddrPrPnSrSt.Template},
	{'~thor_Data400::key::business_header.SIC_Code_qa', 					business_header.Keynames.NewConvention.Base.Siccode.Template},
	{'~thor_data400::key::cbrs.addr.bdid_qa', 								business_header.Keynames.NewConvention.Base.Addr.Template},
	{'~thor_data400::key::business_header.address_qa',						business_header.Keynames.NewConvention.Base.PnStPrZipSr.Template},
                                                                                                         
	{'~thor_data400::key::business_header.Best_qa', 						business_header.Keynames.NewConvention.HeaderBest.FileposData.Template},

	{'~thor_data400::key::business_header.BusinessRelatives_qa', 			business_header.Keynames.NewConvention.Relatives.Bdid1.Template},

	{'~thor_data400::key::business_header.Business_Relatives_Group_qa',		business_header.Keynames.NewConvention.RelativesGroup.Groupid.Template},

	{'~thor_Data400::key::employment_did_qa',								business_header.Keynames.NewConvention.PAW.Did.Template},

	{'~thor_data400::key::bdid_table_qa',									business_header.Keynames.NewConvention.Risk.Bdid.Template},
	{'~thor_data400::key::fein_table_qa',									business_header.Keynames.NewConvention.Risk.Fein.Template},
	{'~thor_data400::key::groupid_cnt_qa',									business_header.Keynames.NewConvention.Risk.Groupid.Template},
	{'~thor_Data400::key::business_InstantID_FEIN2Addr_qa',					business_header.Keynames.NewConvention.Risk.FeinCompany.Template},
	{'~thor_data400::key::BH_BDID_To_Phone_qa',								business_header.Keynames.NewConvention.Risk.BdidPhone.Template},
	{'~thor_data400::key::bh_contacts_did_2_bdid_qa',						business_header.Keynames.NewConvention.Risk.Did.Template}
                                                                                                         
//	{'~thor_data400::key::cbrs.phone10_gong_qa', 							'~thor_data400::key::gong::@version@::phone10'}, this has already been done
	
//	{'~thor_data400::key::cbrs.addr_proflic_qa', 							'~thor_data400::key::prolicense::@version@::addr'}

], ut.Layout_Superkeynames.InputLayout);


rename_keys := ut.fLogicalKeyRenaming(all_superkeynames, false);

email_body 	:= ut.fPrepareRoxieEmailBody(business_header.keynames.oldconvention.dAll_superkeynames(regexfind('^(.*)_[qQ][aA]$', name)));

send_roxie_email := fileservices.sendemail(	 'roxiedeployment@seisint.com;vniemela@seisint.com;lbentley@seisint.com'
											,'Business Header Build Succeeded - ' + Business_header.Version
											,email_body);

sequential(
	 rename_keys
	,send_roxie_email
);