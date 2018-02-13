EXPORT set_crim_version(string cert_version) := function

fdn_crim_version := dataset([cert_version],{string version});

ds := distribute(dataset('~thor_data400::fdn::crim_version',{string version},thor,opt),hash(version));

set_fdn_crim := output(dedup(sort(fdn_crim_version+ds,version,local),version,local),,'~thor_data400::fdn::crim_version_'+cert_version);

superfile_trans := Sequential ( FileServices.StartSuperfiletransaction(),
                                FileServices.ClearSuperfile( '~thor_data400::fdn::crim_version'),
                                FileServices.AddSuperfile( '~thor_data400::fdn::crim_version','~thor_data400::fdn::crim_version_'+cert_version),
																FileServices.FinishSuperfiletransaction()
																);
																
																
return Sequential( set_fdn_crim,superfile_trans);
end;
