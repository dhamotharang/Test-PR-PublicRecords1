import idl_header,InsuranceHeader_Address;

export proc_addrHier(string version) := module
		#workunit('name','Prod AddrHier Build');

hdr     := distribute(IDL_Header.Files.DS_SALT_ITER_OUTPUT,hash(did));
prep    := InsuranceHeader_Address.addr_linking_preprocess(hdr) : persist('persist::for_addrlink_preprocess');;
shared link    := InsuranceHeader_Address.Proc_Iterate(version,prep).DoAll;

shared mod_addrFiles := InsuranceHeader_Address.files(version);

//--------------------------------------------------------------------------
// Start Super File Transaction
//--------------------------------------------------------------------------
SF_Start  := FileServices.StartSuperFileTransaction();

//--------------------------------------------------------------------------
// Create Super Files
//--------------------------------------------------------------------------
SF_Create_new_link     := IF(~FileServices.SuperfileExists(mod_addrFiles.addr_link_sfname), 
                              FileServices.CreateSuperFile(mod_addrFiles.addr_link_sfname));	
SF_Create_father_link  := IF(~FileServices.SuperfileExists(mod_addrFiles.addr_link_sfname_father), 
                              FileServices.CreateSuperFile(mod_addrFiles.addr_link_sfname_father));	
SF_Create_gfather_link := IF(~FileServices.SuperfileExists(mod_addrFiles.addr_link_sfname_gfather), 
                              FileServices.CreateSuperFile(mod_addrFiles.addr_link_sfname_gfather));

//--------------------------------------------------------------------------
// Promote Superfiles
//--------------------------------------------------------------------------
SF_Promote_link            := FileServices.PromoteSuperFileList([mod_addrFiles.addr_link_sfname,
                                                 mod_addrFiles.addr_link_sfname_father,
																								 mod_addrFiles.addr_link_sfname_gfather],
																								 mod_addrFiles.addr_link_fname,,TRUE);
Empty_DS := output(dataset([],InsuranceHeader_Address.Layout_Address_Link),,mod_addrFiles.addr_link_fname,thor);
SF_Promote_link_with_empty := FileServices.PromoteSuperFileList([mod_addrFiles.addr_link_sfname,
                                                 mod_addrFiles.addr_link_sfname_father],
																								 mod_addrFiles.addr_link_fname,,TRUE);
SF_Add := FileServices.AddSuperFile(mod_addrFiles.addr_link_sfname,
                                    mod_addrFiles.addr_link_fname);



//--------------------------------------------------------------------------
// Finish Super File Transaction
//--------------------------------------------------------------------------
SF_Fin    := FileServices.FinishSuperFileTransaction();

export run := SEQUENTIAL(SF_Start,
           IF(~FileServices.SuperfileExists(mod_addrFiles.addr_link_sfname),
					    SEQUENTIAL(SF_Create_new_link,
							           empty_ds,
												 SF_add,
												 SF_Fin),
							SF_Fin),
           link,
					 SF_Start,
           IF(~FileServices.SuperfileExists(mod_addrFiles.addr_link_sfname_Father),
					    SEQUENTIAL(SF_Create_father_link,
							           SF_Create_gfather_link,
							           SF_Fin,
							           SF_Promote_Link_with_Empty),
							SEQUENTIAL(SF_Fin,SF_Promote_Link))); 
							
end;
							