import _Control, doxie, std, ut;

//#workunit('name','Get pphone_build_version');

EXPORT Holiday_Rmv_Logical_From_Super (string build_version):= function

string stripped_b_version := build_version[1..8];

//get prod_version, determine no of days between build_version passed in and current prod version
outrec := RECORD
 STRING Results {xpath('Results')};
END;

prod_version := SOAPCALL(_Control.RoxieEnv.prodvip,'doxie.EnvironmentVariablesService',
                {STRING EnvironmentVariable := 'pphones_build_version'}, outrec, LOG).results;

seconds_diff := ut.SecondsApart (prod_version+'000000', stripped_b_version+'000000');

days_diff := truncate ( (seconds_diff / 86400) );

bversion := output (stripped_b_version);

//end get prod_version, determine no of day since passed in build_version

//find super to clear
super_ds := dataset([
{'thor_data400::key::phones_ported_metadata_delete'},
{'thor_data400::key::phones_ported_metadata_great_grandfather'},
{'thor_data400::key::phones_ported_metadata_grandfather'},
{'thor_data400::key::phones_ported_metadata_father'},
{'thor_data400::key::phones_ported_metadata_built'},
{'thor_data400::key::phones_ported_metadata_qa'}
],{string superfile});

super_logical_recs_lo := record
        string superfile;
        string subfile;
end;

super_logical_recs_lo proj_sup_log(super_ds l) := transform
 self.subfile := fileservices.getsuperfilesubname('~'+l.superfile,1);
        self  := l;
end;

proj_sup_log_out := nothor (project( GLOBAL (super_ds,few),proj_sup_log(left)));
//proj_sup_log_out := project ((super_ds),proj_sup_log(left));

sup_2_log_list := output(proj_sup_log_out,,'~thor400::metadata_super_logical_list', overwrite);

sup_log_ds := dataset('~thor400::metadata_super_logical_list', super_logical_recs_lo, thor);

sup_2_clear := if ( days_diff = 4, sup_log_ds(subfile = 'thor_data400::key::'+prod_version+'::phones_ported_metadata'));

updateSuperFile := sequential(
                              FileServices.StartSuperFileTransaction(),
                              nothor (apply(global(sup_2_clear,few),FileServices.ClearSuperfile('~'+superfile))),
                              FileServices.FinishSuperFileTransaction()
																													);
							  
clear_super := if ( count(sup_2_clear) > 0, sequential (updateSuperfile,
                                                        FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com', 'PhonesInfo Ported & Metadata Key Build Holiday Save Logical', workunit + ' Removing thor_data400::key::'+prod_version+'::phones_ported_metadata From Super')
                                                        ));

process_save_logical := sequential (output (stripped_b_version),
                                            //bversion,
                                            prod_version,
                                            sup_2_log_list,
                                            seconds_diff,
                                            days_diff,
                                            output(sup_2_clear),
                                            clear_super);

return process_save_logical;

end;

