/* 
DONE:
     1. See TBD comments in TBS.EBRSource_records.
     2. Temp add/chg EBR section in iesp to use iesp.bizcredit with chgs.  
        Sent email of changes needed to Jiafu on 08/20.  He passed it on to Ken on 08/22.
     3. Revised EBRSource_Records for the iesp temp chgs. Done 08/22.
TBD:
     1. Deploy this section only to dev roxie 1-way to check all the EBR files used by 
        this section and then make sure they are out on the oss roxie via 
        the EBRKeys in the BIP package or if needed have some more copied there.
     2. Have this section added to "Guts" and have this one and revised "Guts" migrated to 
        oss roxie.
     3. Removed commented out coding.
     4. Research/resolve open issues (search for '???') and removed commented out coding.
*/
IMPORT AutoStandardI, BIPV2, iesp, MDR;

EXPORT EBRSection := MODULE;

 // *********** Main function to return BIPV2 format business report results
 export fn_FullView(
 	dataset(TopBusiness_Services.Layouts.rec_input_ids) ds_in_ids_wacctno
	,Layouts.rec_input_options  in_options
	,AutoStandardI.DataRestrictionI.params in_mod
	                 ):= function

  FETCH_LEVEL := in_options.BusinessReportFetchLevel; // pass on to EBRSource_Records???


  // Use the new TopBusiness_Services.EBRSource_Records to get the data already in the iesp EBR  
	// format. (i.e. iesp.bizcredit)
	//
  // First will need to build a dataset of records in the layout expected by EBRSource_Records???
	// Also when recs retruned from EBRSource_Records, will need to sort/dedup to only keep
	// the 1 most current/recent rec per file_number???

  ds_ebr_keyrecs_proj := project(ds_in_ids_wacctno, 
	                               transform(Layouts.rec_input_ids_wSrc,
		                               self.acctno  := left.acctno, //???
		                               //BIPV2.IDlayouts.l_header_ids;
		                               self.IdType  := '', 
		                               self.IdValue := '', // no specific file_number value(s)
		                               self.Section := '', // n/a
		                               self.Source  := MDR.sourceTools.src_EBR,
																   self         := left, // to store all linkids
														    ));

  // Build EBRSource_Records input options layout from 2(?) BusinessReportComprehensive 
	// input options???
	// !!! First will need to add <part name="ApplicationType" type="xsd:string"/> to 
	//     TopBusiness_Services.BusinessReportComprehensive service                       ??? 
	TopBusiness_Services.SourceService_Layouts.OptionsLayout tf_options() := TRANSFORM
		self.app_type  := AutoStandardI.GlobalModule().ApplicationType;
		self.ssn_mask  := AutoStandardI.GlobalModule().ssnmask;
		self.fetch_level := FETCH_LEVEL;
    self.IncludeVendorsourceB := in_options.IncludeVendorsourceB;
    self.includeassignmentsandreleases :=  in_options.IncludeAssignmentsAndReleases;
	end;
	
	row_in_options := row(tf_options());

  // Call the appropriate EBRSource_records module export to get the EBR source document records
	// in iesp output layout.
	ds_ebr_srcdocs_out := CHOOSEN(EBRSource_Records(ds_ebr_keyrecs_proj,row_in_options,
                                                  false).SourceView_Recs,
											         iesp.Constants.TOPBUSINESS.MAX_COUNT_EBR_RECORD);

  // Sort/dedup iesp formatted EBR source docs to only keep the 1 (current?) most recent      ???
  // record per set of linkids/file_number.
  ds_ebr_srcdocs_deduped := dedup(sort(ds_ebr_srcdocs_out,
	                                     //#expand(BIPV2.IDmacros.mac_ListAllLinkids())
																			 // create new macro for these with iesp BusinessIds appended???
																			 BusinessIds.UltId,
																			 BusinessIds.OrgId,
																			 BusinessIds.SeleId,
																			 //BusinessIds.ProxId  //v--- ???
																			 //BusinessIds.PowId, 
																			 //...EmpId, 
																			 //...DotId,  
	  																   FileNumber,
																			 BusinessHeader.RecordType, //to put "C"(Current) before "H"(Historical) just in case???
                                       -BusinessHeader.DateLastSeen  //most recent first
				                               ),
	                                //#expand(BIPV2.IDmacros.mac_ListAllLinkids())
																	// create new macro for these with iesp BusinessIds appended???
																	BusinessIds.UltId,
																	BusinessIds.OrgId,
																	BusinessIds.SeleId,
																	//BusinessIds.ProxId, //v--- ???
																	//BusinessIds.PowId, 
																	//...EmpId, 
																	//...DotId
	  															FileNumber
                                 //,???
	                               );

  // Attach input acctnos back to the linkids.
  ds_all_wacctno_joined := join(ds_in_ids_wacctno,
                                ds_ebr_srcdocs_deduped, //???
                                  //BIPV2.IDmacros.mac_JoinAllLinkids(),
																	// create new macro for these (---v) with iesp BusinessIds appended???
																	left.UltId  = right.Businessids.UltId  and
																	left.OrgId  = right.Businessids.OrgId  and
																	left.SeleId = right.Businessids.SeleId //and ??? ---v
																	//left.ProxId = right.Businessids.ProxId and
																	//left.PowId  = right.Businessids.PowId  and
																	//left.EmpId  = right.Businessids.EmpId  and
																	//left.DotId  = right.Businessids.DotId
																	,
														    transform(EBRSection_Layouts.rec_ids_plus_EbrSecRec,
														      self.acctno                  := left.acctno,
																	// create macro for these(---v) ??? 
																	self.UltId  := left.UltId,
																	self.OrgId  := left.OrgId,
																	self.SeleId := left.SeleId,
																	// ---v ???
																	self.ProxId := left.ProxId,
																	self.PowId  := left.PowId,
																	self.EmpId  := left.EmpId,
																	self.DotId  := left.DotId,
																	self.ExperianBusinessReports := right,
															    self                         := right),
														    left outer); // 1 out rec for every left (input ds) rec

	// Roll up all recs for the acctno.   Is this needed???
	ds_final_results := rollup(group(sort(ds_all_wacctno_joined,acctno),acctno),
	                           group,
		                         transform(EBRSection_Layouts.rec_Final,
			                         self := left));


  // Uncomment for debugging
  // output(ds_in_ids_wacctno,           named('ds_in_ids_wacctno'));
	// output(ds_ebr_keyrecs_proj,         named('ds_ebr_keyrecs_proj'));
	// output(row_in_options,              named('row_in_options'));
	// output(ds_ebr_srcdocs_out,          named('ds_ebr_srcdocs_out'));
  // output(ds_ebr_srcdocs_deduped,      named('ds_ebr_srcdocs_deduped'));
  // output(ds_all_wacctno_joined,       named('ds_all_wacctno_joined'));
	// output(ds_final_results,            named('ds_final_results'));

	return ds_final_results;

 end; //end of FullView function

END; //end of module

/*  to test, in a builder window use this: 
IMPORT AutoStandardI;

  // Input options for all report sections (except UCCs, see UCC section testing below)
	// Just 2 booleans & 1 char for now: lnbranded , internal_testing and fetch_level
  ds_options := dataset([{false, false, 'P'} //3rd parm=BusinessReportFetchLevel, default='P' ???
                        ],topbusiness_services.Layouts.rec_input_options);

// input dataset layout= acctno,DotID,EmpID,POWID,ProxID,SeleID,OrgID,UltID

  // Report section input params.  
	tempmod := module(AutoStandardI.DataRestrictionI.params)
		export boolean AllowAll := false;
		export boolean AllowDPPA := false;
		export boolean AllowGLB := false;
		export string DataRestrictionMask := '000' : stored('DataRestrictionMask'); //pos 3=0 to use EBR
		export unsigned1 DPPAPurpose := 0 : stored('DPPAPurpose');
		export unsigned1 GLBPurpose := 0 : stored('GLBPurpose');
		export boolean ignoreFares := false;
		export boolean ignoreFidelity := false;
		export boolean includeMinors := false;
	end;

ebr_sec := TopBusiness_Services.DNBSection.fn_FullView(
             dataset([
                       //{'ebr1p', 0, 0, 0, 97, 97, 97, 97} // Ice Cream Shoppe
											 //{'ebr2p', 0, 0, 0, 165, 165, 165, 165} // Jean Michaels Salon
                     ],topbusiness_services.Layouts.rec_input_ids)
 						,ds_options[1]
					  ,tempmod
           );
output(ebr_sec);
*/
