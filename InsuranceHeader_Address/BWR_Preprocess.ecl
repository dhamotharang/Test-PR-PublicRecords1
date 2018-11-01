import idl_header,InsuranceHeader_Address;

hdr     := distribute(idl_header.files.DS_IDL_POLICY_HEADER_BASE,hash(did));
prep    := InsuranceHeader_Address.addr_linking_preprocess(hdr) : persist('persist::for_addrlink_preprocess');;
link    := InsuranceHeader_Address.Proc_Iterate(workunit,prep).DoAll;

//--------------------------------------------------------------------------
// Start Super File Transaction
//--------------------------------------------------------------------------
SF_Start  := FileServices.StartSuperFileTransaction();

//--------------------------------------------------------------------------
// Create Super Files
//--------------------------------------------------------------------------
SF_Create_new_link     := IF(~FileServices.SuperfileExists(InsuranceHeader_Address.files().addr_link_sfname), 
                              FileServices.CreateSuperFile(InsuranceHeader_Address.files().addr_link_sfname));	
SF_Create_father_link  := IF(~FileServices.SuperfileExists(InsuranceHeader_Address.files().addr_link_sfname_father), 
                              FileServices.CreateSuperFile(InsuranceHeader_Address.files().addr_link_sfname_father));	
SF_Create_gfather_link := IF(~FileServices.SuperfileExists(InsuranceHeader_Address.files().addr_link_sfname_gfather), 
                              FileServices.CreateSuperFile(InsuranceHeader_Address.files().addr_link_sfname_gfather));

//--------------------------------------------------------------------------
// Promote Superfiles
//--------------------------------------------------------------------------
SF_Promote_link            := FileServices.PromoteSuperFileList([InsuranceHeader_Address.files().addr_link_sfname,
                                                 InsuranceHeader_Address.files().addr_link_sfname_father,
																								 InsuranceHeader_Address.files().addr_link_sfname_gfather],
																								 InsuranceHeader_Address.files().addr_link_fname,,TRUE);
Empty_DS := output(dataset([],InsuranceHeader_Address.Layout_Address_Link),,InsuranceHeader_Address.files().addr_link_fname,thor);
SF_Promote_link_with_empty := FileServices.PromoteSuperFileList([InsuranceHeader_Address.files().addr_link_sfname,
                                                 InsuranceHeader_Address.files().addr_link_sfname_father],
																								 InsuranceHeader_Address.files().addr_link_fname,,TRUE);
SF_Add := FileServices.AddSuperFile(InsuranceHeader_Address.files().addr_link_sfname,
                                    InsuranceHeader_Address.files().addr_link_fname);



//--------------------------------------------------------------------------
// Finish Super File Transaction
//--------------------------------------------------------------------------
SF_Fin    := FileServices.FinishSuperFileTransaction();

SEQUENTIAL(SF_Start,
           IF(~FileServices.SuperfileExists(InsuranceHeader_Address.files().addr_link_sfname),
					    SEQUENTIAL(SF_Create_new_link,
							           empty_ds,
												 SF_add,
												 SF_Fin),
							SF_Fin),
           link,
					 SF_Start,
           IF(~FileServices.SuperfileExists(InsuranceHeader_Address.files().addr_link_sfname_Father),
					    SEQUENTIAL(SF_Create_father_link,
							           SF_Create_gfather_link,
							           SF_Fin,
							           SF_Promote_Link_with_Empty),
							SEQUENTIAL(SF_Fin,SF_Promote_Link))); 
