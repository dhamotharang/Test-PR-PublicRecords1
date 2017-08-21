
IMPORT ut;

fnm_mktg_pspcts := cluster+'base::USAA::marketing_prospects';
fnm_dir_mktg := cluster+'base::USAA::direct_marketing';

ut.MAC_SF_BuildProcess(USAA.proc_build_file_marketing_prospects, fnm_mktg_pspcts, outf_mktg_pspcts, 2);
ut.MAC_SF_BuildProcess(USAA.proc_build_file_direct_marketing, fnm_dir_mktg, outf_fnm_dir_mktg, 2);

EXPORT make_all_files := SEQUENTIAL( outf_mktg_pspcts,
                                     outf_fnm_dir_mktg);
