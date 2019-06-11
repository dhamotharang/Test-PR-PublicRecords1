IMPORT	NeustarWireless, NeustarWireless_IngestMain, NeustarWireless_IngestActivityStatus, ut, AID, AID_Support, DID_Add, address, NID, STD, PromoteSupers, PRTE2; //using a cleaning function in this repository;
// This process takes one vendor file and splits it into two base files.  
// 1) The "Main" base file is the vendor file normalized to split dual names (ie, "Bob and Ann Smith") into one one record for each phone/individual name.
// 		It contains all the fields the vendor provides and tracks changes by phone, fname, lname, aptno, latitude, longitude, and nid (from name cleaner).  
// 		Main has the lastest values received for all other fields.  
// 2) The "Activity Stautus" file tracks changes to the ActivityStatus field by phone number.

EXPORT proc_build_base(STRING pVersion) := FUNCTION

	//BEGIN MAIN
		//prep and ingest new vendor raw file into base
		IngestModMain	:= NeustarWireless_IngestMain.Ingest();
		
		//Project output of ingest process to base an populate current_rec based the _typ tag added by the ingest process
		//Unknown = 1 Ancient = 2 Old = 3 Unchanged = 4 Updated = 5 New = 6
		dsBaseMain	:= Project(IngestModMain.AllRecords, TRANSFORM(NeustarWireless.Layouts.Base.Main, self.ingest_tpe := LEFT.__Tpe; self.current_rec := IF(LEFT.__Tpe in [2,3],FALSE,TRUE); self := LEFT; SELF:= [];));
		
		//AID process
		dsHasAddress := dsBaseMain(trim(append_prep_address_1)<>'' and trim(append_prep_address_2)<>'');	  
		dsMissingAddress:= dsBaseMain(not(trim(append_prep_address_1)<>'' and trim(append_prep_address_2)<>''));		
		
		UNSIGNED4	lFlags := AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

		AID.MacAppendFromRaw_2Line(dsHasAddress, append_prep_address_1, append_prep_address_2, RawAID, dsAppendAID, lFlags);
		
		//base layout plus some fields needed for the did macro since it won't recognize clean_address.prim_range as valid
		layout_prep_for_did := RECORD
			NeustarWireless.Layouts.Base.Main,
			qstring10  			clean_phone;
			string10        clean_prim_range;
			string28        clean_prim_name;
			string8         clean_sec_range;
			string2         clean_st;
			string5         clean_zip;
		END;
		

		dsBaseWithAID := PROJECT(dsAppendAID,
										 TRANSFORM(layout_prep_for_did,
															 SELF.AceAID    		:= LEFT.aidwork_acecache.aid;
															 SELF.RawAID    		:= LEFT.aidwork_rawaid;
															 SELF.clean_address.zip	:= LEFT.aidwork_acecache.zip5;
															 SELF.clean_address	:= LEFT.aidwork_acecache;
															 SELF.clean_prim_range := LEFT.aidwork_acecache.prim_range;
															 SELF.clean_prim_name := LEFT.aidwork_acecache.prim_name;
															 SELF.clean_sec_range := LEFT.aidwork_acecache.sec_range;
															 SELF.clean_st := LEFT.aidwork_acecache.st;
															 SELF.clean_zip := LEFT.aidwork_acecache.zip5;
															 SELF.clean_phone := (qstring10) LEFT.phone;
															 SELF := LEFT;))
											+ PROJECT(dsMissingAddress, TRANSFORM(layout_prep_for_did, SELF.clean_phone := (qstring10) LEFT.phone; SELF := LEFT; SELF := [];));
		
	
  	//DID process (Address, Phone, Zip code
		matchset:=['A','D','P','Z'];
		did_Add.MAC_Match_Flex(dsBaseWithAID, matchset,
														foo, cln_dob, cln_fname, cln_mname, cln_lname, cln_suffix, 
														clean_prim_range, clean_prim_name, clean_sec_range, clean_zip, clean_st, clean_phone,
														did,   			
														layout_prep_for_did, 
														true, did_score,	
														75,	  //dids with a score below here will be dropped 
														dsBaseAIDandDID);

		PromoteSupers.Mac_SF_BuildProcess(PROJECT(dsBaseAIDandDID, TRANSFORM(NeustarWireless.Layouts.Base.Main, SELF:=LEFT)) , NeustarWireless.Files.Names.Main,build_base_main,3,,true,pVersion);
	//END MAIN
	
	//BEGIN ACTIVITY STATUS
		IngestModActivityStatus	:= NeustarWireless_IngestActivityStatus.Ingest();	
		//Project output of ingest process to base an populate current_rec based the _typ tag added by the ingest process
		//Unknown = 1 Ancient = 2 Old = 3 Unchanged = 4 Updated = 5 New = 6
		dsBaseActivityStatus := Project(IngestModActivityStatus.AllRecords, TRANSFORM(NeustarWireless.Layouts.Base.Activity_Status, self.ingest_tpe := LEFT.__Tpe; self.current_rec := IF(LEFT.__Tpe in [2,3],FALSE,TRUE); self := LEFT; SELF:= [];));
		PromoteSupers.Mac_SF_BuildProcess(dsBaseActivityStatus, NeustarWireless.Files.Names.Activity_Status,build_base_activity_status,3,,true,pVersion);
	//END ACTIVITY STATUS


	RETURN SEQUENTIAL(
											IngestModMain.DoStats,
											IngestModMain.ValidityStats,
											build_base_main,
											IngestModActivityStatus.DoStats,
											IngestModActivityStatus.ValidityStats,
											build_base_activity_status
											);

	
END;
	
	