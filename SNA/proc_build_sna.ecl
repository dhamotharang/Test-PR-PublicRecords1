import ut,lib_fileservices;
EXPORT proc_build_sna := module

rel_chk := ut.IsNewProdHeaderVersion('sna','relative_build_version');

export run_chk := if ( rel_chk = false,
                   Sequential(
									             output('Relative build version is in sync with prod version'),FileServices.SendEmail('Sudhir.Kasavajjala@lexisnexis.com; melanie.jackson@lexisnexis.com','SNA Build status '+ut.GetDate,'Relative build version is in sync with prod version and therefore SNA Build will be on hold')),
															 
                   Sequential( FileServices.SendEmail('Sudhir.Kasavajjala@lexisnexis.com; melanie.jackson@lexisnexis.com','SNA Build status '+ut.GetDate,'Relative build version is newer than prod version and therefore SNA Build will be started'),#workunit('name','SNA Build All'); 
									              SNA.proc_build_sna_keys(ut.GetDate),ut.PostDID_HeaderVer_Update('sna','relative_build_version'))
						);
						
end;
						

