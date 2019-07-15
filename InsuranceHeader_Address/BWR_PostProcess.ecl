import idl_header;

hdr  := distribute(idl_header.files.DS_IDL_POLICY_HEADER_BASE,hash(did));
version := workunit;
mod_files := InsuranceHeader_Address.files(version);

post     := InsuranceHeader_Address.addr_linking_postprocess(hdr);
postout  := output(post,,mod_files.addr_post_fname,thor);
hier     := InsuranceHeader_Address.addr_hier_validities(post).records;
hierout  := output(hier,,mod_files.addr_hier_fname,thor);

//--------------------------------------------------------------------------
// Start Super File Transaction
//--------------------------------------------------------------------------
SF_Start  := FileServices.StartSuperFileTransaction();

//--------------------------------------------------------------------------
// Create Super Files
//--------------------------------------------------------------------------
SF_Create_new      := IF(~FileServices.SuperfileExists(mod_files.addr_post_sfname), 
                          FileServices.CreateSuperFile(mod_files.addr_post_sfname));
SF_Create_father   := IF(~FileServices.SuperfileExists(mod_files.addr_post_sfname_father), 
                          FileServices.CreateSuperFile(mod_files.addr_post_sfname_father));	
SF_Create_gfather  := IF(~FileServices.SuperfileExists(mod_files.addr_post_sfname_gfather), 
                          FileServices.CreateSuperFile(mod_files.addr_post_sfname_gfather));
SF_Create_new_Hier := IF(~FileServices.SuperfileExists(mod_files.addr_hier_sfname), 
                          FileServices.CreateSuperFile(mod_files.addr_hier_sfname));

//--------------------------------------------------------------------------
// Add logical files to Superfiles
//--------------------------------------------------------------------------
SF_Promote  := FileServices.PromoteSuperFileList([mod_files.addr_post_sfname,
                                                  mod_files.addr_post_sfname_father,
																						      mod_files.addr_post_sfname_gfather],
																						      mod_files.addr_post_fname,,TRUE);
SF_Clear    := FileServices.ClearSuperFile(mod_files.addr_hier_sfname);
SF_Add      := FileServices.AddSuperFile(mod_files.addr_hier_sfname,
                                         mod_files.addr_hier_fname);

//--------------------------------------------------------------------------
// Finish Super File Transaction
//--------------------------------------------------------------------------
SF_Fin    := FileServices.FinishSuperFileTransaction();

SEQUENTIAL(postout,hierout,
           sf_start,PARALLEL(sf_Create_new,sf_create_father,sf_create_gfather,sf_create_new_hier),sf_fin,					 
					 sf_promote,
					 sf_start,sf_clear,sf_add,sf_fin);

