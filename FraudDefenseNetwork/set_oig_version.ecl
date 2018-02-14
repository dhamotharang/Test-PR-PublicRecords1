EXPORT set_oig_version(string cert_version) := function

fdn_oig_version := dataset([cert_version],{string version});

ds := dataset('~thor_data400::fdn::oig_version',{string version},thor,opt);

set_fdn_oig := output(fdn_oig_version+ds,,'~thor_data400::fdn::oig_version'+cert_version);

superfile_trans := Sequential ( FileServices.StartSuperfiletransaction(),
                                FileServices.ClearSuperfile('~thor_data400::fdn::oig_version'),
                                FileServices.AddSuperfile( '~thor_data400::fdn::oig_version','~thor_data400::fdn::oig_version'+cert_version),
																FileServices.FinishSuperfiletransaction()
																);
																
																
return Sequential( set_fdn_oig,superfile_trans);
end;
