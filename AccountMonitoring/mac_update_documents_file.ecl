
/* The folowing macro updates a Product-Specific Documents (PSD) base file based on 
   the addition of an Update file provided by Kettle.
	 1. Retrieve PSD update file.
	 2. Project into 'base' layout, adding timestamp based on current WUID.
	 3. Union with existing PSD base file; sort, dedup.
	 4. Get PSD file base name; append timestamp value to it.
	 5. Update PSD superfiles.
*/
EXPORT mac_update_documents_file(in_pseudo_environment,in_product,spray_ip_address,spray_path,remote_filename,out_name) := macro

	NOTHOR(SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
			IF( NOT FileServices.SuperfileExists(AccountMonitoring.filenames(in_pseudo_environment).documents.in_product.base),
					FileServices.CreateSuperFile(AccountMonitoring.filenames(in_pseudo_environment).documents.in_product.base) );
			IF( NOT FileServices.SuperfileExists(AccountMonitoring.filenames(in_pseudo_environment).documents.in_product.update),
					FileServices.CreateSuperFile(AccountMonitoring.filenames(in_pseudo_environment).documents.in_product.update) );
		FileServices.FinishSuperFileTransaction()
	));
	
	#uniquename(ROLLBACK)	
	%ROLLBACK% := 
		NOTHOR(FileServices.GetSuperFileSubCount( AccountMonitoring.filenames(in_pseudo_environment).documents.in_product.update ) = 0
					 OR
					 NOT EXISTS(FileServices.RemoteDirectory(spray_ip_address,spray_path,remote_filename))
					 OR
					 FileServices.RemoteDirectory(spray_ip_address,spray_path,remote_filename)[1].size = 0);
	
	#uniquename(update_file)
	%update_file% := 
		IF( NOT %ROLLBACK%,
		    DISTRIBUTE(AccountMonitoring.files(in_pseudo_environment).documents.in_product.update, HASH32(pid,rid,hid) ) ); 
	
	#uniquename(current_documents)
	%current_documents% := DISTRIBUTE(AccountMonitoring.files(in_pseudo_environment).documents.in_product.base,HASH32(pid,rid,hid));
	
	#uniquename(latest_documents)
	%latest_documents% := DEDUP(SORT(%current_documents%,pid,rid,hid,-timestamp,LOCAL),pid,rid,hid,LOCAL);
	
	#uniquename(projected_documents)
	%projected_documents% := PROJECT(
		%update_file%(action_code = AccountMonitoring.constants.actions.MODIFY),
		TRANSFORM(AccountMonitoring.layouts.documents.in_product.base,
			SELF.timestamp := time_stamp[2..9] + time_stamp[11..16],
			SELF := LEFT));
	
	#uniquename(delete_updates)
	%delete_updates% := JOIN(
		%update_file%(action_code = AccountMonitoring.constants.actions.DELETE),
		%latest_documents%,
		LEFT.pid = RIGHT.pid AND
		LEFT.rid = RIGHT.rid AND
		LEFT.hid = RIGHT.hid,
		TRANSFORM(AccountMonitoring.layouts.documents.in_product.base,
			SELF.timestamp := time_stamp[2..9] + time_stamp[11..16],
			SELF.action_code := AccountMonitoring.constants.actions.DELETE,
			SELF := RIGHT),
		LOCAL);

	#uniquename(combined_documents)
	%combined_documents% :=
		%current_documents% + %projected_documents% + %delete_updates%;
	
	#uniquename(sorted_documents)
	%sorted_documents% :=
		SORT(%combined_documents%,pid,rid,hid,-timestamp);

	#uniquename(deduped_documents)
	%deduped_documents% :=
		DEDUP(%sorted_documents%,pid,rid,hid);

	#uniquename(stem_name)
	%stem_name% := AccountMonitoring.filenames(in_pseudo_environment).documents.in_product.base;
	
	#uniquename(logical_name)
	%logical_name% := %stem_name% + time_stamp;
	
	#uniquename(DELETE_SUBFILE);
	#uniquename(COPY_FILE_CONTENTS);
	%DELETE_SUBFILE%      := TRUE;
	%COPY_FILE_CONTENTS%  := TRUE;
	
	out_name := IF( NOT %ROLLBACK%,
		             SEQUENTIAL( OUTPUT(%deduped_documents%,,%logical_name%,COMPRESSED),
			                       Utilities.fn_update_superfiles(%stem_name%, %logical_name%, %DELETE_SUBFILE%, %COPY_FILE_CONTENTS%)
			                    )
	              );

ENDMACRO;
