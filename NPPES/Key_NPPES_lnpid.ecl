Import Data_Services, doxie;

base := NPPES.File_NPPES_Base(lnpid > 0);	

slim_layout	:= record
			String10		NPI;
			unsigned8	lnpid;
end;

lnpid_base	:= dedup(sort(distribute(project(base, slim_layout), hash(lnpid)),lnpid,npi,local),lnpid,npi,local);

EXPORT Key_NPPES_lnpid := index(lnpid_base,
							  {lnpid},
							  {lnpid_base},
							  // Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::NPPES::'+doxie.Version_SuperKey+'::lnpid');
								Data_Services.Data_location.Prefix('Provider')+'thor_data400::key::NPPES::'+doxie.Version_SuperKey+'::lnpid');