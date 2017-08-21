
/*--SOAP--
<message name="fake_gateway">
	<part name="service_name" type="xsd:string"/>
	<part name="message"      type="xsd:string"/>
	<part name="workunit_id"  type="xsd:string"/>
</message>
*/

/*--INFO-- This service receives a request containing the name of the calling service, message, and a workunit value. These data are then appended to a file.*/

EXPORT fake_gateway() := FUNCTION

	// 1. Create in-memory log record.
	STRING50 service_name := '' : STORED('service_name');
	STRING50 message      := '' : STORED('message');
	STRING16 workunit_id  := '' : STORED('workunit_id');
	
	layout_gateway_log := RECORD
		STRING50 svc_name := '';
		STRING50 msg      := '';
		STRING16 wuid     := '';		
	END;
	
	ds_log_record := DATASET( [ {service_name, message, workunit_id} ], layout_gateway_log );

	// 2. Update the log file.
	superfile_name := '~calbee::fake_gateway::request_log';	
	
	// 2.a. Read the log file into memory. If no file exists, or if the superfile is empty,
	// assign a null dataset. Then, append the new record to the log.
	ds_existing_log_file := 
		IF( FileServices.SuperfileExists(superfile_name) AND FileServices.GetSuperFileSubCount(superfile_name) > 0, 
				DATASET( superfile_name, layout_gateway_log, THOR ),
				DATASET( [], layout_gateway_log )
			);
	
	ds_updated_log_file := SORT( (ds_log_record + ds_existing_log_file), -wuid );
	
	// 3. Write the updated log back to file.
	logical_file_name := superfile_name + '_' + workunit_id;
	DELETE_SUBFILE    := TRUE;

	output_updated_log := OUTPUT(ds_updated_log_file,,logical_file_name,OVERWRITE,EXPIRE);
	create_superfile := 
		IF( NOT FileServices.SuperfileExists(superfile_name), FileServices.CreateSuperFile(superfile_name) );
	
	write_new_log_record :=
		SEQUENTIAL(
			output_updated_log,
			create_superfile,
			FileServices.StartSuperFileTransaction(),
				FileServices.ClearSuperFile(superfile_name, DELETE_SUBFILE),
				FileServices.AddSuperFile(superfile_name, logical_file_name), 
			FileServices.FinishSuperFileTransaction()
		);
		
	RETURN write_new_log_record;
END;