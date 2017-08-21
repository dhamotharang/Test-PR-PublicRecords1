
IMPORT AccountMonitoring;

EXPORT document_purge(UNSIGNED1 pseudo_env, DATASET({UNSIGNED6 pid}) purge_pids = DATASET([],{UNSIGNED6 pid})) := MODULE

	SHARED mac_build_purge_fn(in_document_type) := MACRO
		
		EXPORT in_document_type() := FUNCTION

				timestamp := thorlib.wuid();
				document_file := AccountMonitoring.files(pseudo_env).documents.in_document_type.base;
								
				document_file_dist := DISTRIBUTE(document_file,HASH64(pid,rid));
				
				temp_join :=
					JOIN(
						document_file_dist, purge_pids,
						LEFT.pid = RIGHT.pid,
						TRANSFORM(LEFT),
						LEFT ONLY,
						MANY LOOKUP
					);
				
				superfile_stem_name := AccountMonitoring.filenames(pseudo_env).documents.in_document_type.base; 
				logical_file_name   := superfile_stem_name + timestamp;
				DELETE_SUBFILE      := TRUE;
				COPY_FILE_CONTENTS  := TRUE;

				update_superfiles := SEQUENTIAL(
								OUTPUT(temp_join,,logical_file_name,COMPRESSED)
//							 ,Utilities.fn_update_superfiles(superfile_stem_name, logical_file_name, DELETE_SUBFILE, COPY_FILE_CONTENTS) 
				);

				RETURN SEQUENTIAL(
					IF(pseudo_env = AccountMonitoring.constants.pseudo.DEFAULT OR pseudo_env NOT IN AccountMonitoring.constants.all_pseudo,
						FAIL('Must provide valid pseudo-environment.')),
					IF( NOT EXISTS(document_file),
						FAIL('Document file not found.')),
					update_superfiles);
				
				// DEBUG:
				// RETURN TABLE(temp_join, {pid, cnt := COUNT(GROUP)}, pid);
				
			END;
			
	ENDMACRO;
	
	mac_build_purge_fn(bankruptcy);
	mac_build_purge_fn(deceased);
	mac_build_purge_fn(address);
	mac_build_purge_fn(phone);
	mac_build_purge_fn(paw);
	mac_build_purge_fn(property);
	mac_build_purge_fn(litigiousdebtor);
	mac_build_purge_fn(liens);
	mac_build_purge_fn(criminal);
	mac_build_purge_fn(phonefeedback);  
	
END;