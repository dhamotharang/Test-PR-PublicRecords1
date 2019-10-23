import idl_header,InsuranceHeader_Address, InsuranceHeader_Postprocess;

rawseg     := insuranceheader_postprocess.files.DS_HDR_SEGMENTATION;
rawhdr     := idl_header.files.DS_IDL_POLICY_HEADER_BASE;

distseg  := distribute(rawseg(ind='CORE'),hash(did));
dedupseg := dedup(sort(distseg,st,local),st,local,keep(10));

input   := join(rawhdr,dedupseg,
                left.did = right.did,
								transform(recordof(left),
								          self := left), hash);		
hdr := distribute(input,hash(did));

// hdr     := distribute(choosen(idl_header.files.DS_IDL_POLICY_HEADER_BASE,1000),hash(did));
prep    := InsuranceHeader_Address.addr_linking_preprocess(hdr,TRUE) : persist('persist::for_addrlink_preprocess_test');
link    := InsuranceHeader_Address.Proc_Iterate(workunit,prep).DoAll; 

//--------------------------------------------------------------------------
// Start Super File Transaction
//--------------------------------------------------------------------------
SF_Start  := FileServices.StartSuperFileTransaction();

//--------------------------------------------------------------------------
// Create Super Files
//--------------------------------------------------------------------------
SF_Create_new_link     := IF(~FileServices.SuperfileExists(InsuranceHeader_Address.files().addr_link_sfname + '::TEST'), 
                              FileServices.CreateSuperFile(InsuranceHeader_Address.files().addr_link_sfname + '::TEST'));	
SF_Create_father_link  := IF(~FileServices.SuperfileExists(InsuranceHeader_Address.files().addr_link_sfname_father + '::TEST'), 
                              FileServices.CreateSuperFile(InsuranceHeader_Address.files().addr_link_sfname_father + '::TEST'));	
SF_Create_gfather_link := IF(~FileServices.SuperfileExists(InsuranceHeader_Address.files().addr_link_sfname_gfather + '::TEST'), 
                              FileServices.CreateSuperFile(InsuranceHeader_Address.files().addr_link_sfname_gfather + '::TEST'));

//--------------------------------------------------------------------------
// Promote Superfiles
//--------------------------------------------------------------------------
SF_Promote_link            := FileServices.PromoteSuperFileList([InsuranceHeader_Address.files().addr_link_sfname + '::TEST',
                                                 InsuranceHeader_Address.files().addr_link_sfname_father + '::TEST',
																								 InsuranceHeader_Address.files().addr_link_sfname_gfather + '::TEST'],
																								 InsuranceHeader_Address.files().addr_link_fname,,TRUE);
Empty_DS := output(dataset([],InsuranceHeader_Address.Layout_Address_Link),,InsuranceHeader_Address.files().addr_link_fname,thor);
SF_Promote_link_with_empty := FileServices.PromoteSuperFileList([InsuranceHeader_Address.files().addr_link_sfname + '::TEST',
                                                 InsuranceHeader_Address.files().addr_link_sfname_father + '::TEST'],
																								 InsuranceHeader_Address.files().addr_link_fname,,TRUE);
SF_Add := FileServices.AddSuperFile(InsuranceHeader_Address.files().addr_link_sfname + '::TEST',
                                    InsuranceHeader_Address.files().addr_link_fname);



//--------------------------------------------------------------------------
// Finish Super File Transaction
//--------------------------------------------------------------------------
SF_Fin    := FileServices.FinishSuperFileTransaction();

SEQUENTIAL(SF_Start,
           IF(~FileServices.SuperfileExists(InsuranceHeader_Address.files().addr_link_sfname + '::TEST'),
					    SEQUENTIAL(SF_Create_new_link,
							           empty_ds,
												 SF_add,
												 SF_Fin),
							SF_FIN),
           link,
					 SF_Start,
           IF(~FileServices.SuperfileExists(InsuranceHeader_Address.files().addr_link_sfname_Father + '::TEST'),
					    SEQUENTIAL(SF_Create_father_link,
							           SF_Create_gfather_link,
							           SF_Fin,
							           SF_Promote_Link_with_Empty),
							SEQUENTIAL(SF_Fin,SF_Promote_Link)));