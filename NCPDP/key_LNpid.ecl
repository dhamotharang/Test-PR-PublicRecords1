IMPORT doxie, NCPDP, data_services;

KeyBase := NCPDP.Files().final_base.Built(NCPDP_provider_id != '' AND lnpid > 0);

slim_layout	:= record
			unsigned8	lnpid;
			string7		ncpdp_provider_id;
end;

lnpid_base	:= dedup(sort(distribute(project(keybase, slim_layout), hash(lnpid)), lnpid, ncpdp_provider_id, local), lnpid, ncpdp_provider_id, local);

EXPORT key_LNpid := INDEX(lnpid_base,
												{lnpid},
											  {lnpid_base},
							          Data_services.data_location.prefix('DEFAULT') + 'thor_data400::key::NCPDP::' + doxie.Version_SuperKey + '::lnpid');
												