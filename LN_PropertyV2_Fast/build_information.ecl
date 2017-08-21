EXPORT build_information(boolean isFast) := MODULE
			SHARED version_file_name := if(isFast,
																		'~thor_data400::property_fast::qa::version',
																		'~thor_data400::ln_propertyv2::qa::version');

			EXPORT set_qa_version(string9 version) := FUNCTION
					versionSet := dataset([{version}],{string9 version});
					return sequential(
														output(versionSet,,version_file_name+'::'+WORKUNIT,overwrite),
														fileservices.createsuperfile(version_file_name,,true), // just in case it's not there
														fileservices.startsuperfiletransaction(),
														fileservices.clearsuperfile(version_file_name,true), // Delete the content
														fileservices.addsuperfile(version_file_name,version_file_name+'::'+WORKUNIT),
														fileservices.finishsuperfiletransaction()
													 );
			END;
			EXPORT get_qa_version := set(dataset(version_file_name,{string9 version},thor),version)[1];
END;