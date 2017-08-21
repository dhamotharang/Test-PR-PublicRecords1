import ut,data_services;

export File_Deconfliction := module

// export version := '';

export outfile := dataset('~thor_data400::out::accurint_acclogs::deconfliction', Accurint_AccLogs.Layout_Deconfliction, thor, opt);

export input := dataset(data_services.foreign_logs + 'thor100_21::in::mbs::deconfliction', Accurint_AccLogs.Layout_Deconfliction, csv(separator('~~')), opt);

export buildfile := sequential(
		output(dedup(outfile + input, record, all),,'~thor_data400::out::accurint_acclogs::'+version+'::deconfliction',overwrite,__compressed__);
		fileservices.startsuperfiletransaction();
		fileservices.promotesuperfilelist(['~thor_data400::out::accurint_acclogs::deconfliction',
										   '~thor_data400::out::accurint_acclogs::deconfliction_father',
										   '~thor_data400::out::accurint_acclogs::deconfliction_grandfather'],
													'~thor_data400::out::accurint_acclogs::'+version+'::deconfliction',true);
		fileservices.finishsuperfiletransaction()
		);


end;
