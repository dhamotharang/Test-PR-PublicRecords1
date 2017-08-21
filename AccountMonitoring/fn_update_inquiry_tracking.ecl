// Inquiry tracking is used for auditing purposes.  

IMPORT Inquiry_AccLogs,ut;

EXPORT fn_update_inquiry_tracking( UNSIGNED1 pseudo_environment,
                                   DATASET(layouts.portfolio.base) in_portfolio,
                                   STRING in_ts) := 
   FUNCTION
	
	   STRING in_timestamp := in_ts[2..9] + in_ts[11..16];
	
	   // We're assuming here that the most recent update to the portfolio has taken place.
	   // We're also assuming that the file has been sorted by pid, rid and timestamp.
	
	   // Get the latest two portfolio records for each pid/rid
		//  Dan -- Check out here if the dedup can be removed????
	   last_2 := 
		   DEDUP(
			   SORTED( 
				   DISTRIBUTED( in_portfolio, 
                            HASH32(pid,rid)
				              ),
				pid, rid, -timestamp, LOCAL ),
   		pid, rid, LOCAL, KEEP 2	);

	
	   last_2_mod := PROJECT( last_2,
                             TRANSFORM( {layouts.portfolio.base,UNSIGNED whatsnew,UNSIGNED whatsgone},
                                         SELF.whatsnew := LEFT.product_mask, // for singleton records: we must preserve as 'whats new' the product_mask value
                                         SELF := LEFT,
                                         SELF := []
                                      )
		                     );
	
	whats_changed_all := 
		ROLLUP( 
			last_2_mod,
			LEFT.pid = RIGHT.pid AND
			LEFT.rid = RIGHT.rid,
			TRANSFORM({layouts.portfolio.base,UNSIGNED whatsnew,UNSIGNED whatsgone},
				SELF.whatsnew  := (LEFT.whatsnew ^ RIGHT.product_mask) & LEFT.whatsnew,
				SELF.whatsgone := (LEFT.whatsnew ^ RIGHT.product_mask) & BNOT(LEFT.whatsnew),
				SELF := LEFT ),
			LOCAL);
	
	whats_changed := whats_changed_all(timestamp = in_timestamp);
	
	whats_new_normalized := NORMALIZE(whats_changed,64,
		TRANSFORM({layouts.portfolio.base,BOOLEAN whatsnew},
			SELF.product_mask := IF(ut.bit_test(LEFT.whatsnew,COUNTER-1),ut.bit_set(0,COUNTER-1),SKIP),
			SELF.whatsnew := TRUE;
			SELF := LEFT));
			
	whats_gone_normalized := NORMALIZE(whats_changed,64,
		TRANSFORM({layouts.portfolio.base,BOOLEAN whatsnew},
			SELF.product_mask := IF(ut.bit_test(LEFT.whatsgone,COUNTER-1),ut.bit_set(0,COUNTER-1),SKIP),
			SELF.whatsnew := FALSE;
			SELF := LEFT));

	final_inquiry_tracking_file := PROJECT(whats_new_normalized + whats_gone_normalized,TRANSFORM(Inquiry_AccLogs.Layout.Common,
		SELF.MBS.Company_ID              := (STRING)LEFT.pid;
		SELF.Person_Q.Personal_Phone     := LEFT.phone;
		SELF.Person_Q.DOB                := LEFT.dob;
		SELF.Person_Q.SSN                := LEFT.ssn;
		SELF.Person_Q.fname              := LEFT.name_first;
		SELF.Person_Q.mname              := LEFT.name_middle;
		SELF.Person_Q.lname              := LEFT.name_last;
		SELF.Person_Q.name_suffix        := LEFT.name_suffix;
		SELF.Person_Q.prim_range         := LEFT.prim_range;
		SELF.Person_Q.predir             := LEFT.predir;
		SELF.Person_Q.prim_name          := LEFT.prim_name;
		SELF.Person_Q.addr_suffix        := LEFT.addr_suffix;
		SELF.Person_Q.postdir            := LEFT.postdir;
		SELF.Person_Q.unit_desig         := LEFT.unit_desig;
		SELF.Person_Q.sec_range          := LEFT.sec_range;
		SELF.Person_Q.city               := LEFT.p_city_name;
		SELF.Person_Q.st                 := LEFT.st;
		SELF.Person_Q.zip                := LEFT.z5;
		SELF.Person_Q.zip4               := LEFT.zip4;
		SELF.Person_Q.Appended_ADL       := LEFT.did;
		SELF.Bus_Q.CName                 := LEFT.comp_name;
		SELF.Bus_Q.Company_Phone         := LEFT.phone;
		SELF.Bus_Q.EIN                   := LEFT.fein; // unique id
		SELF.Bus_Q.prim_range            := LEFT.prim_range;
		SELF.Bus_Q.predir                := LEFT.predir;
		SELF.Bus_Q.prim_name             := LEFT.prim_name;
		SELF.Bus_Q.addr_suffix           := LEFT.addr_suffix;
		SELF.Bus_Q.postdir               := LEFT.postdir;
		SELF.Bus_Q.unit_desig            := LEFT.unit_desig;
		SELF.Bus_Q.sec_range             := LEFT.sec_range;
		SELF.Bus_Q.city                  := LEFT.p_city_name;
		SELF.Bus_Q.st                    := LEFT.st;
		SELF.Bus_Q.zip                   := LEFT.z5;
		SELF.Bus_Q.zip4                  := LEFT.zip4;
		SELF.Bus_Q.Appended_BDID         := LEFT.bdid;
		SELF.Search_Info.DateTime        := in_timestamp;
		SELF.Search_Info.Start_Monitor   := IF(LEFT.whatsnew,in_timestamp,'');
		SELF.Search_Info.Stop_Monitor    := IF(NOT LEFT.whatsnew,in_timestamp,'');
		SELF.Search_Info.Transaction_ID  := in_timestamp;
		SELF.Search_Info.Sequence_Number := (STRING)LEFT.pid + '-' + (STRING)LEFT.rid;
		SELF.Search_Info.Method          := 'Monitoring';
		SELF.Search_Info.Product_Code    := (STRING)LEFT.product_mask;
		SELF := []));
	
	superfile_stem_name := filenames(pseudo_environment).inquirytracking;
	logical_file_name   := superfile_stem_name + in_timestamp;
	DELETE_SUBFILE      := TRUE;
	COPY_FILE_CONTENTS  := TRUE;
	ROLLBACK            := COUNT(final_inquiry_tracking_file) = 0;
	
	check_for_superfile := IF( NOT FileServices.SuperfileExists(superfile_stem_name),
	  FileServices.CreateSuperFile(superfile_stem_name) );	

	output_file         := OUTPUT(final_inquiry_tracking_file,,logical_file_name,COMPRESSED);
	file_size           := Utilities.Get_FileRowCount(logical_file_name);
	delete_logical_file := NOTHOR(FileServices.DeleteLogicalFile(logical_file_name));
	update_superfiles   := Utilities.fn_update_superfiles(superfile_stem_name, logical_file_name, DELETE_SUBFILE, COPY_FILE_CONTENTS);
	
	update_inquiry_tracking_file :=
		SEQUENTIAL( output_file,
                  IF( file_size != 0,
                      NOTHOR(SEQUENTIAL( check_for_superfile,
                                  FileServices.StartSuperFileTransaction(),
                                  FileServices.AddSuperFile(superfile_stem_name, logical_file_name), 
                                  FileServices.FinishSuperFileTransaction()
                                )) // end sequential
                    ) // end if
		          ); // end sequential 
	
	RETURN update_inquiry_tracking_file;

END;
