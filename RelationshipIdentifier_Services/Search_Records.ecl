IMPORT Address, BIPV2, didville, doxie, dx_header, iesp, MDR, RelationshipIdentifier_Services,
         TopBusiness_Services, STD, Suppress;

EXPORT  Search_Records(
								        RelationshipIdentifier_Services.Layouts.Local_tRelationshipIdentifierSearch ds_dataInSearch
                ,RelationshipIdentifier_Services.Layouts.OptionsLayout options
                ,DATASET(RelationshipIdentifier_Services.Layouts.Batch.Input_Processed) tmpds_BatchIn
                ,RelationshipIdentifier_Services.iParam.BatchParams               inMod
							) :=
 // FUNCTION  //leaving this function ecl cmd in here in case debugging is needed.
 MODULE

  SHARED mod_access := PROJECT (inMod, doxie.IDataAccess); // BatchParams inherits from IDataAccess

  // Module does
	//  1) Non-batch searching for the Relationship Identifier Project.
	//
	// and then does the batch search processing respectively.
	//
	// taking in person related search criteria and trying to resolve to a paricular did.
	// The same thing is done for the Business searching as the input for business data
	// attempts to resolve to a particular  BIP linkid combination. (ult/org/seleid)
	// Each search entity can be named by the user (outside customer) a particular name
	// and this is the 'role' field.
	//
	// batch :
	// There are some extra fields in the layouts for the batch in order to keep the search
	// results pertaining to the particular acctno from which they came from.
	// But its mostly the same as regular online but in batch we can't
	// can't return the results back to user for entity resolution from a picklist.
	// so product wanted to go with the  best entity that is returned in batch search.
	//
	// Note: all attrs pertaining to batch searching have substring 'batch' in them
	//       All attrs pertaining to Business Data have the substring BIP or Business in them
	//
	//
	// params DS_dataInSearch -- set of input recs (non batch)
	//        options - settings used for non batch search
	//        tmpDs_batchIn -- set of batch input recs
	//        InMod - setting used for batch search
	//
	//
	SHARED integer CurDate := STD.Date.today();
	SHARED unsigned4 endDateTmp := (unsigned4) options.asOfDate;
	SHARED unsigned4 endDate := if (endDateTmp = 0, (unsigned4) curDate, endDateTmp);
 SHARED unsigned4 endDatetmpBatch := (unsigned4) inmod.endDate;
	SHARED unsigned4 enddatebatch := if (endDateTmpBatch = 0, (unsigned4) curDate, endDateTmpBatch);
 SHARED ssnMaskVal := mod_access.ssn_mask;
	SHARED application_type_value := mod_access.Application_type;

	SHARED DRM := mod_access.dataRestrictionMask;
	SHARED DPM := mod_access.DataPermissionMask;
 SHARED dppa_ok := mod_access.isValidDppa();
 SHARED glb_ok := mod_access.isValidGlb();
 SHARED is_consumer := mod_access.isConsumer();

	// will contain both person and business INPUT stuff
	//
	// seqence the recs and then need to join back to
	// this DS after searches are run on person and business
	// in order to keep input metadata and grp recs by acctno correctly.
	//
	UNSIGNED1 region := address.Components.Country.US; // default
 
 /*
    D2C Relationship Connection project requirements
    If the user inputs a business entity treat it as an individual entity
    So companyName entered by user is treated as person full name
 */
 ds_searchData := PROJECT(DS_dataInSearch.SearchBy, 
                           TRANSFORM(iesp.RelationshipIdentifierSearch.t_RelationshipIdentifierSearchBy,
                             SELF.Name.Full := IF(is_consumer and LEFT.Name.Full = '',LEFT.companyName, LEFT.Name.Full),
                             SELF.IndividualOrBusiness := IF(is_consumer and LEFT.IndividualOrBusiness = 'B', 'I', LEFT.IndividualOrBusiness),
                             SELF := LEFT
                         ));
 
	ds_inDataSearchBys := PROJECT(ds_searchData, 
                               TRANSFORM({string20 acctno; unsigned4 seq; iesp.RelationshipIdentifierSearch.t_RelationshipIdentifierSearchBy;},
									                        SELF.acctno := (STRING20) counter,
									                        SELF.seq := 0,
									                        SELF.entityNo := LEFT.entityNo,
                                 
									                        addr2 := Address.Addr2FromComponents(LEFT.Address.City, LEFT.Address.STATE, LEFT.Address.zip5);
                                 
									                        in_streetaddr := address.Addr1FromComponents(LEFT.Address.streetNumber,LEFT.Address.StreetPreDirection,
		                                                                            LEFT.Address.streetName,LEFT.Address.StreetSuffix,
																								                                                      LEFT.Address.StreetPostDirection,'',LEFT.Address.UnitNumber);
									                        string60 in_streetAddress1 := IF( LEFT.Address.StreetAddress1='',in_streetAddr,LEFT.Address.StreetAddress1);

									                        tmpAddr := if (LEFT.Address.streetNumber = '' and LEFT.Address.StreetPreDirection = ''
									                                       AND LEFT.Address.streetName  = '' AND LEFT.Address.StreetSuffix = ''
																	                               AND LEFT.Address.StreetPostDirection = '' and LEFT.Address.UnitNumber = '' AND
																	                               LEFT.Address.StreetAddress1 <> '', in_streetAddress1, '');

                                 clean_addr := Address.GetCleanAddress(TmpAddr, addr2, region).results;

		                               SELF.Address.StreetNumber         := IF (LEFT.Address.StreetNumber        <> '', LEFT.Address.StreetNumber, clean_addr.prim_range),
										                      SELF.Address.StreetPreDirection   := IF (LEFT.Address.StreetPreDirection  <> '', LEFT.Address.StreetPreDirection, clean_addr.preDir),
										                      SELF.Address.StreetName           := IF (LEFT.Address.StreetName          <> '', LEFT.Address.StreetName, clean_addr.prim_name),
										                      SELF.Address.StreetSuffix         := IF (LEFT.Address.StreetSuffix        <> '', LEFT.Address.StreetSuffix, clean_addr.suffix),
										                      SELF.Address.StreetPostDirection  := IF (LEFT.Address.StreetPostDirection <> '', LEFT.Address.StreetPostDirection,clean_addr.postdir),
										                      SELF.Address.UnitNumber           := IF (LEFT.Address.UnitNumber          <> '', LEFT.Address.UnitNumber, clean_addr.sec_range),
										                      SELF.Address.zip5                 := IF (LEFT.Address.zip5                <> '', LEFT.Address.Zip5, clean_addr.zip),
										                      SELF.Address.State                := IF (LEFT.Address.State               <> '', LEFT.Address.State, clean_addr.state),
										                      SELF.Address.city                 := IF (LEFT.Address.City                <> '', LEFT.Address.City,  clean_addr.v_city),
                                 
                                 name                              := Address.GetCleanNameAddress.fnCleanName(LEFT.Name);
                                 
                                 SELF.Name.First                   := IF (LEFT.Name.First                  <> '', LEFT.Name.First, name.fname),
                                 SELF.Name.Middle                  := IF (LEFT.Name.Middle                 <> '', LEFT.Name.Middle, name.mname),
                                 SELF.Name.Last                    := IF (LEFT.Name.Last                   <> '', LEFT.Name.last, name.lname),
                                 SELF.Name.Suffix                  := IF (LEFT.Name.Suffix                 <> '', LEFT.Name.Suffix, name.name_suffix),
                                 SELF.Name.Prefix                  := IF (LEFT.Name.Prefix                 <> '', LEFT.Name.Prefix, name.title),
		                               SELF := LEFT
			                            ));

	ds_inDataBIP := PROJECT(ds_inDataSearchBys(IndividualOrBusiness = RelationshipIdentifier_Services.Constants.BUSINESS),
             TRANSFORM(BIPV2.IDfunctions.rec_SearchInput,
						           // set this as an identifier for each row of input
											 //
										   SELF.ACCTNO := LEFT.ACCTNO;
											 SELF.inseleid := (string) LEFT.InSELEID;
											 SELF.company_name := LEFT.companyName;
											 SELF.city := LEFT.address.city;
											 SELF.state := LEFT.address.state;
											 SELF.zip5 := LEFT.address.zip5;
											 SELF.sec_range := LEFT.address.UnitNumber;
											 SELF.prim_name := LEFT.address.StreetName;
											 SELF.prim_range := LEFT.address.StreetNumber;
											 SELF.phone10 := LEFT.phone10;
											 SELF.fein := LEFT.Tin;
											 SELF.email := '';
											 SELF.URL := '';
											 SELF.contact_SSN := LEFT.SSN;
											 SELF.Contact_fname := LEFT.Name.First;
											 SELF.Contact_mname := LEFT.Name.Middle;
											 SELF.Contact_lname := LEFT.Name.Last;
											 SELF.HSORT := TRUE;
                       SELF := LEFT;
											 ));

	ds_bestBIPInfoTmpAll := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(ds_inDataBIP).SeleBest(company_name <> '');

	 // 1.  Use all linkids returned from SELEBEST call to left only join against just rows from search results
	//     that are source = D only contributing.
	// 2.  so that resulting DS (ds_best_info)Tmp is only rows with Source D (possibly) AND other sources contributing
	//     this way we lose the results that are source = D only.

	ds_bestBIPKfetchSourceDResults := 	ds_BestBIPInfoTmpAll(COUNT(company_name_sources) = 1 AND
	                                  company_name_sources[1].source = MDR.sourceTools.src_Dunn_Bradstreet);

  ds_bestBIPInfoTmp := join(ds_BestBIPInfoTmpAll, ds_bestBIPKfetchSourceDResults,
														 BIPV2.IDmacros.mac_JoinTop3Linkids(),
														 TRANSFORM(LEFT), LEFT ONLY);

  	// sort by -record_score
  ds_bestBIPInfoTmpSorted := sort(ds_BestBIPInfoTmp,acctno,-record_score, record);

	// filter out the business BIP search results records here by enddate
	ds_bestBIPInfoTmpUnGrouped := UNGROUP(PROJECT(GROUP(ds_bestBIPInfoTmpSorted, Acctno), TRANSFORM(
	                                           {UNSIGNED2 seq; RECORDOF(LEFT);},
																						 SELF.seq := COUNTER;
																						 SELF := LEFT)
																						 )
																			)(dt_first_seen <= enddate);
  // need to resequence this recs after grouping them by acctno in case any were filtered out
	// by the date filter
  ds_bestBIPInfoTmpUnGrouped2 := UNGROUP(PROJECT(GROUP(ds_bestBIPInfoTmpUnGrouped , Acctno), TRANSFORM(
	                                      RECORDOF(LEFT),
																				 SELF.seq := COUNTER;
																				 SELF := LEFT)));
	// *******************************
	// join back in the initial input with search results to maintain the roles
	//  make join left outer cause some of the inputs maybe person searches.
	// and thus will contain empty rows.
	// ds_indataSearchbys contains the input info
	// LEFT outer is needed in case anyof the right recs are filtered out
	// in attr directly above this

	ds_businessBestRecsWithRoles := JOIN(ds_indataSearchBys, ds_bestBIPInfoTmpUnGrouped2,
	                             LEFT.Acctno = RIGHT.Acctno,
															 TRANSFORM(iesp.RelationshipIdentifierSearch.t_RelationshipIdentifierSearchMatchRecord,
															 // will contain both B and I
															 SELF.IndividualOrBusiness := LEFT.IndividualOrBusiness;
															 self.AccountNumber := LEFT.acctno;
															 SElF.SequenceNumber := RIGHT.seq;
															 SELF.Role := LEFT.Role;
															 SELF.uniqueID := '';
															 SELF.MidexlicenseTypes := DATASET([],IESP.share.t_stringarrayItem); // set later
															 SELF.companyName := RIGHT.company_name;
															 SELF.TinInfo.tin := RIGHT.company_fein;
															 SELF.address.unitDesignation := right.unit_desig;
															 SELf.Address.UnitNumber := right.sec_range;
															 SELF.Address.StreetNumber := RIGHT.prim_range;
															 SELF.Address.StreetName   := RIGHT.prim_name;
															 SELF.Address.StreetPredirection := RIGHT.predir;
															 SELF.Address.StreetPostdirection := RIGHT.postdir;
															 SELF.address.StreetSuffix := RIGHT.addr_suffix;
															 SELF.Address.city := RIGHT.v_city_name;
															 SELF.address.state := RIGHT.st;
															 SELF.Address.zip5 := RIGHT.zip;
															 SELF.address.zip4 := right.zip4;
															 sELF.address.streetaddress1 := '';
															 SELF.address.streetAddress2 := '';
															 self.address.county := right.County_name;
															 SELF.address.postalCode := '';
															 self.address.statecityZip := '';
															 d := right.dt_first_seen;
															 self.FromDate := row ({d DIV 10000, (d % 10000) DIV 100, 0}, iesp.share.t_Date);
															                                     //       note the 0 here for day field
															 t := right.dt_last_seen;
															 SELF.toDate := row ({t DIV 10000, (t % 10000) DIV 100, 0}, iesp.share.t_Date);
															                                       //     not the 0 here for day field
																																		 // to match person header dt_last_seen field that is build
																																		 // once a month
															 SELF.phoneInfo.phone10 := right.company_phone;
															 SELF.businessIds.ULTid := RIGHT.ultid;
															 SELF.businessIds.orgid := RIGHT.orgid;
															 SELF.BusinessIds.seleid := RIGHT.seleid;
															 SELF.businessIds.proxid := 0;
															 SELF.businessIds.powid := 0;
															 SELF.businessIds.empid := 0;
															 SELF.businessIds.dotid := 0;
															 SELF.NeedsResolution := FALSE;
															 SELF := RIGHT;
															 SElf := [];
															 ), LEFT OUTER, limit(0), keep (RelationshipIdentifier_Services.Constants.KEEPLIMIT)
															 );

	ds_inDataSearchBysIndividual := ds_inDataSearchBys(individualOrbusiness = RelationshipIdentifier_Services.Constants.INDIVIDUAL);
	// will need to join back to this ds_inDataSearcyBysIndividualBatch after didville call is made.
	//
	// 1.  LEFT OUTER Join this DS to the person info results.
	//  no precidence of PII over did values on input.
  // now go get person info recs

  // OLD WAY
	ds_personSearchInput := PROJECT(ds_inDataSearchBysIndividual, TRANSFORM(DidVille.Layout_Did_OutBatch,
	                SELF.seq := (unsigned4)LEFT.Acctno;
									SELF.did := (unsigned6) LEFT.uniqueID;
                  SELF.ssn := LEFT.SSN;
									SELF.DOB := iesp.ecl2esp.t_DateToString8(left.dob); // dob is qstring8 type
								  SELF.phone10 := LEFT.phone10;
	                SELF.fname := LEFT.name.first;
	                SELF.mname := LEFT.Name.middle;
	                SELF.lname := LEFT.Name.last;
	                SELF.prim_range := LEFT.address.streetNumber;
	                SELF.predir := LEFT.address.streetpredirection;
	                SELF.prim_name := LEFT.Address.StreetName;
                  SELF.addr_suffix := LEFT.address.streetsuffix;
	                SELF.postdir := LEFT.address.streetpostdirection;
	                SELF.unit_desig := LEFT.Address.Unitdesignation;
	                SELF.sec_range := LEFT.address.unitNumber;
	                SELF.p_city_name := LEFT.address.City;
									SELF.st := LEFT.address.state;
									SELF.z5 := LEFT.address.zip5;
									SELF.zip4 := LEFT.address.zip4;
									SELF.email := '';
	                SELF := []
									 ));
     PersonSearchInputDidandOtherSTuffTmp := ds_personSearchInput(did <> 0 and
		                               (ssn <> '' OR dob <> '' OR
										               phone10 <> '' OR title <> '' OR
																	 fname <> '' OR mname <> '' OR
																	 lname <> '' OR suffix <> '' OR
																	 prim_range <> '' OR predir <> '' OR
																	 prim_name <> '' OR addr_suffix <> '' OR
																	 postdir <> '' OR unit_desig <> '' OR
																	 sec_range <> '' OR p_city_name <> '' OR
																	 st <> '' OR z5 <> '' OR zip4 <> '')); // took out email cause its always blank
																	 // per Bug # jira RQ 12745 they want DID if it exists in input
																	 // to override ALL other PII input fields.
																	 // thus this project.
     PersonSearchInputDidAndOtherSTuff := PROJECT(PersonSearchInputDidandOtherSTuffTmp, TRANSFORM(RECORDOF(LEFT),
		                                              SELF.DID := LEFT.DID,
																									SELF.SEQ := LEFT.Seq,
																									SELF := []));

		 personSearchInputJustDID := ds_personSearchInput(did <> 0 and
		                               ssn = '' and dob ='' and
										               phone10 = '' and title = '' and
																	 fname = '' and mname = '' and
																	 lname = '' and suffix = '' and
																	 prim_range = '' and predir = '' and
																	 prim_name = '' and addr_suffix = '' and
																	 postdir = '' and unit_desig = '' and
																	 sec_range = '' and p_city_name = '' and
																	 st = '' and z5 = '' and zip4 = '');

		 personSearchInputPII := ds_personSearchInput(did = 0 and (
		                                 ssn <> '' OR dob  <> '' OR
										               phone10 <> '' OR title <> '' OR
																	 fname <> '' OR mname <> '' OR
																	 lname <> '' OR suffix <> '' OR
																	 prim_range <> '' OR predir <> '' OR
																	 prim_name <> '' OR addr_suffix <> '' OR
																	 postdir <> '' OR unit_desig <> '' OR
																	 sec_range <> '' OR p_city_name <> '' OR
																	 st <> '' OR z5 <> '' OR zip4 <> ''));

		 ds_PersonSearchresultsNoDID := RelationshipIdentifier_services.functions.PersonSearch(sort (personSearchInputPII, seq));
		 // all recs in this DS have a Seq and possibly a 'did' value in them.
		 ds_personSearchResultWIthDIDCOmbined := sort (ds_personSearchresultsNoDID + personSearchInputJustDID + PersonSearchInputDidAndOtherSTuff, Seq);
		 ds_personSearchResultsDID := PROJECT( ds_personSearchResultWIthDIDCOmbined,
		                                    TRANSFORM(DidVille.Layout_Did_OutBatch,
																				           // ^^^^ this is output layout of
																									 // this call : RelationshipIdentifier_services.functions.PersonSearch
																				SELF.DID := LEFT.DID;
																				SELF.seq := LEFT.SEQ;
																				SELF := []));
     // now call this to get best records name/address/phone/dob info for only subset of person input recs that have
		 // just a did as input.
		 // this macro drops the SEQ # thus the next join adds it back in.
		    doxie.mac_best_records(ds_personSearchResultsDID, did,
												    ds_personSearchResultsDIDOut,dppa_ok,glb_ok,,DRM);
         ds_personSErachResultsDidOutDedup := dedup(ds_personSearchResultsDIDOut, all);
     //  join to get any 'best' info for the DS of non repeating seq values
		 // This also sets phone #'s info so that can be populated with phone metadata later.
     ds_personSearchResultsDIDOut2 := JOIN(ds_personSearchResultsDID, ds_personSErachResultsDidOutDedup,
		                                         LEFT.DID = RIGHT.DID,
																						 TRANSFORM(DidVille.Layout_Did_OutBatch,
																							  SELF.seq := LEFT.SEQ; // need to keep this one for sorting later
																							  SELF.z5 := RIGHT.ZIp;
																								SELF.addr_suffix := RIGHT.suffix;
																								SELF.phone10 := RIGHT.phone;
																								self.p_city_name := RIGHT.city_name;
																								SELF.DOB := (STRING8) RIGHT.DOB;
																							  SELF := RIGHT;
																								SELF := [];
																							),
																							limit(0), keep (RelationshipIdentifier_Services.Constants.KEEPLIMITBATCH)
																						);

		 DS_personSearchResults := 	SORT( ds_personSearchResultsDIDOUT2, seq);
		 // ds_personSearchResults contains person results
		 // ds_BestInfoTmp contains business best results

		// take seq number which is like rid to separate multiple inputs so that one can match output
		// results with input results and assign it to acctno so that DS can be then grouped.

		ds_personSearchResultsWAcctno := PROJECT(ds_PersonSearchresults, TRANSFORM({STRING20 acctno;
		                                                                            RECORDOF(LEFT);},
		                      SELF.acctno := (STRING20) LEFT.seq; // seq # is what is assigned on output.
													SELF := LEFT));
    // once grouped then assign a counter 1 to N to each particular set of recs grouped by acctno so that that seqNo can be
		// stored within the 'group' this will be used later to determine unsolved groupings etc and set other booleans
		//
		 ds_personSearchResultsWAcctnoGrouped := UNGROUP(PROJECT(GROUP(ds_personSearchResultsWAcctno,acctno),
		                                                               TRANSFORM({RECORDOF(LEFT);},
																																	    SELF.SEQ := COUNTER;
																																			SELF := LEFT)
																																	)
																														);

		ds_personSearchResultsWdateRange_all := JOIN(ds_personSearchResultsWAcctnoGrouped,
		                                           dx_header.Key_Header(),
																							 KEYED(LEFT.did = RIGHT.s_did),
																							 TRANSFORM(RIGHT), limit(0), KEEP(RelationshipIdentifier_Services.Constants.KEEPLIMIT));

		ds_personSearchResultsWdateRange := Suppress.MAC_SuppressSource(ds_personSearchResultsWdateRange_all, mod_access, s_did);

    	ds_personSearchResultsFirstSeenSorted := SORT(ds_personSearchResultsWdateRange(dt_first_seen <> 0 and
			                                              (LENGTH((STRING) dt_first_seen) = RelationshipIdentifier_Services.Constants.SIZEOFPERSONHEADERDATE)),
			                                               s_did, dt_first_seen, RECORD);

    	ds_personSearchResultsFirstSeenSorted personRollit(ds_personSearchResultsFirstSeenSorted l,
			                                             ds_personSearchResultsFirstSeenSorted r) := TRANSFORM
																									 SELF := l;
																									 SELF := r;
																									 END;

			// this attr used to get dt_first_seen dt_last_seen for filtering later.
    ds_personSearchResultsFirstSeenRolled := ROLLUP(ds_personSearchResultsFirstSeenSorted,
																						LEFT.s_did = RIGHT.s_did,
		                                        personRollit(LEFT,RIGHT));

  // now get dateRangeEND results
   ds_personSearchResultslastSeenSorted :=
	                  SORT(ds_personSearchResultsWdateRange(dt_last_seen <> 0 and
										 (LENGTH((STRING) dt_last_seen) = RelationshipIdentifier_Services.Constants.SIZEOFPERSONHEADERDATE)),
													s_did, -dt_last_seen, RECORD);

    ds_personSearchResultslastSeenSorted personRollitEND(ds_personSearchResultslastSeenSorted l,
			                                                   ds_personSearchResultslastSeenSorted r) := TRANSFORM
																									        SELF := l;
																									        SELF := r;
																									      END;

			// this attr used to get dt_last_seen for filtering later.
    ds_personSearchResultsLastSeenRolled := ROLLUP(ds_personSearchResultslastSeenSorted,
																						LEFT.s_did = RIGHT.s_did,
		                                        personRollitEND(LEFT,RIGHT));
   // END	additions

	 doxie.mac_best_records(ds_personSearchResultsWAcctnoGrouped,did,
												ds_personSearchResultsWAcctnoGroupedoutfile,dppa_ok,glb_ok,,DRM);

  // get best results from key to get person info given a did as input
		layout_personWithNameData := RECORD
		   recordof(ds_personSearchResultsWAcctnoGrouped);
		   iesp.share.t_name Name;
			 iesp.share.t_phoneInfoEx PhoneInfo;
			 iesp.share.t_SSNInfoEx ssnInfo;
			 unsigned4 dt_first_seen;
			 unsigned4 dt_last_seen;
			 string18 countyName;
    END;
 		ds_personSearchResultsWAcctnoGroupedoutfileDedup := dedup(ds_personSearchResultsWAcctnoGroupedoutfile, all);
		ds_personSearchResultsWNameData := JOIN(ds_personSearchResultsWAcctnoGrouped,
																						ds_personSearchResultsWAcctnoGroupedoutfileDedup,
		                                              LEFT.DID = RIGHT.DID,
																									TRANSFORM(layout_personWithNameData,
																									SELF.name.Prefix := RIGHT.TITLE;
																									SELF.Name.First := RIGHT.fname;
																									SELF.Name.Middle := RIGHT.mname;
																									SELF.Name.Last := RIGHT.lname;
																									SELF.Name.suffix := RIGHT.name_suffix;
																									SELF.DOB := (QSTRING8) RIGHT.DOB;
																									SELF.PhoneInfo.Phone10 := RIGHT.phone;
																									SELF.ssnInfo.ssn := RIGHT.SSN;
																								  SELF := LEFT,
																									SELF := []), limit(0),keep(RelationshipIdentifier_Services.Constants.KEEPLIMIT));
    // Join by left outer here in order to ensure that all person related recs are kept
    ds_personSearchResultsWNameDateAndDtFirstSeenTmp := JOIN(ds_personSearchResultsWNameData,
		                                                      ds_personSearchResultsFirstSeenRolled,
																													LEFT.DID = RIGHT.s_DID,
																													TRANSFORM(RECORDOF(LEFT),
																													// since date is 6 length in length multiply by 100
																													// to make it 8 chars.
																													self.dt_first_seen := right.dt_first_seen * 100;
																													self.dt_last_seen := 0; // set in next join
																													SELF.countyName := if (Std.Str.ToUpperCase(LEFT.st) = Std.Str.ToUpperCase(RIGHT.st),RIGHT.county_name, '');
																													                      // ^^ this logic done to ensure county is correct
																																								// as best doesn't provide county name
																													SELF := LEFT), LEFT OUTER, limit(0), keep (RelationshipIdentifier_Services.Constants.KEEPLIMIT)
																													);
   ds_personSearchResultsWNameDateAndDtFirstSeen := JOIN(ds_personSearchResultsWNameDateAndDtFirstSeenTmp,
	                                                     ds_personSearchResultsLastSeenRolled,
																											 LEFT.DID = RIGHT.s_DID,
																											 TRANSFORM(RECORDOF(LEFT),
																											    SELF.dt_last_seen := RIGHT.dt_last_seen * 100;
																													SELF := LEFT), LEFT OUTER, limit(0), keep (RelationshipIdentifier_Services.Constants.KEEPLIMIT)
																													);

		// filter out the person results by endDate here.
		ds_personResultsWithRoles := JOIN(ds_inDataSearchBys, ds_personSearchResultsWNameDateAndDtFirstSeen,
		                             LEFT.acctno = RIGHT.acctno,
										             TRANSFORM( {STRING1 individualOrBusiness;
																               STRING50 ROLE;
																							 RECORDOF(RIGHT);},
										               SELF.acctno := LEFT.acctno;
																	 SELF.individualOrBusiness := RelationshipIdentifier_Services.Constants.INDIVIDUAL;
										               SELF.Role := LEFT.Role;
																	 SELF.seq := RIGHT.Seq;
											             SELF := RIGHT)
											             )(dt_first_seen <= endDate);
  // this logic added in case date filters out recs we need to resequence recs by seq #
	// after grouped by acctno.  Already did this above for business recs
   ds_personResultsWithRoles2 := UNGROUP(PROJECT(GROUP(ds_personResultsWithRoles,acctno),
	                                             TRANSFORM(RECORDOF(LEFT),
	                                              SELF.seq := COUNTER;
																								SELF := LEFT)));

   // ****
	 // FUTURE maybe need to resequence person results here after grouping by acctno
	 // ****
   // left side of join(ds_businessBestRecsWithRoles) has all possible
	 // entitys (all possible inputs up to 8 cause started with left outer when
	 // ds_businessBestRecsWithRoles is created )
	 tmpds_Results := JOIN(ds_businessBestRecsWithRoles, ds_personResultsWithRoles2,
													 LEFT.AccountNumber = RIGHT.acctno,
													TRANSFORM(iesp.RelationshipIdentifierSearch.t_RelationshipIdentifierSearchMatchRecord,
													        // set flag
																  isBusiness := LEFT.individualOrBusiness  = RelationshipIdentifier_Services.Constants.BUSINESS;
																	SELF.SequenceNumber := If (isBusiness, LEFT.sequenceNumber, RIGHT.seq);
                                  SELF.UniqueID := (STRING16) RIGHT.DID;
																  SELF.ContactInfo.UniqueId    := (STRING16) RIGHT.DID;
																	SELF.ContactInfo.SSNInfo.SSN := RIGHT.SSNInfo.SSN;
																	SELF.ContactInfo.Name := RIGHT.Name;
																	ultid := LEFT.businessIds.ULTid;
																  orgid := LEFT.businessIds.orgid;
																  seleid := LEFT.BusinessIds.seleid;

																	 BIPV2.IDlayouts.l_xlink_ids l_xlink_idsMIDEX_XFORM() := TRANSFORM
																	                         SELF.ultid := ultid;
																													 SELF.orgid := orgid;
																													 SELF.seleid := seleid;
																													 self := [];
																		END;

                                    l_xlink_ids := DATASET([l_xlink_idsMIDEX_XFORM()]);

																		inputDID := (UNSIGNED6) RIGHT.DID;
																	PossibleMidexSearchStructures :=
																			RelationshipIdentifier_Services.Functions.getMidexLicenseType(
														                   inputDID,l_xlink_ids,mod_access);

														      SELF.MidexlicenseTypes :=  choosen(dedup(PROJECT(PossibleMidexSearchStructures,
																									 TRANSFORM(IESP.share.t_stringarrayItem,
																									    SELF := LEFT)),all), iesp.constants.RelationshipIdentifier.MAX_COUNT_RELATIONSHIP_MIDEX_LICENSES);

																  SELF.Role := If (Isbusiness, LEFT.ROLE, RIGHT.ROLE);
	                                SELF.Address.StreetNumber := IF (isBusiness, LEFT.address.StreetNumber,RIGHT.prim_range);
																	SELF.Address.StreetName :=  IF (IsBusiness, LEFT.Address.StreetName,RIGHT.prim_name);
																	SELF.Address.StreetSuffix := If (IsBusiness, LEFT.address.StreetSuffix, RIGHT.Addr_suffix);
																	SELF.Address.City := IF (IsBusiness, LEFT.address.City, RIGHT.p_city_name);
																	SELF.Address.state := IF (IsBusiness, LEFT.address.state, RIGHT.st);
																	SELf.Address.zip5 := IF (IsBusiness, LEFT.address.zip5, RIGHT.z5);
																	SELF.Address.zip4 := IF (isBusiness, LEFT.address.zip4, RIGHT.zip4);
																	SELF.Address.StreetPostDirection := IF (isBusiness, LEFT.address.streetPostdirection, RIGHT.postdir);
																	SELF.Address.UnitNumber := IF (IsBusiness, LEFT.Address.unitNumber, RIGHT.sec_range);
																	SELF.Address.UnitDesignation := IF (IsBusiness, LEFT.address.UnitDesignation,RIGHT.unit_desig);
																	SELF.Address.County := IF (IsBusiness, LEFT.address.County,RIGHT.CountyName);
																	SELF.FromDate := If (isBusiness, left.FromDate, iesp.ecl2esp.toDate(right.dt_first_seen));
																	SELF.ToDate := If (isBusiness, left.toDate, iesp.ecl2esp.toDate(right.dt_last_seen));
																	SELF.PhoneInfo.Phone10 := IF (IsBusiness, LEFT.PhoneInfo.Phone10, Right.phone10);
	                                SELF := LEFT;
														      ), LEFT OUTER
																	);

    // add phone metadata here:
		tmpPhoneAddmetadata := RelationshipIdentifier_Services.Functions.AddPhoneMetadata(tmpds_Results, mod_access);
		tmpPhoneAddMetadataWireless := project(tmpPhoneAddmetadata,transform({recordof(left);
		                                                                        string3 timeZone;
		                                                                        },
		                                          self.wirelessIndicator := '';
																							self.TimeZone := '';
		                                          self := left));

    TopBusiness_Services.Macro_AppendWirelessIndicator(tmpPhoneAddMetadataWireless,
		                                                   tmpPhoneAddMetadataWirelessOut,phoneInfo.phone10);
    tmpds_resultsWireless := PROJECT(tmpPhoneAddMetadataWirelessOut, iesp.RelationshipIdentifierSearch.t_RelationshipIdentifierSearchMatchRecord);
		// end phone metadata add
    // call function to remove some recs add in boolean indentifiers etc

		 tmpds_resultsWBoolean := RelationshipIdentifier_Services.Functions.ResolveResults(tmpds_resultsWireless);

		// create t_RelationshipIdentifierSearchRecord here
		 // assumes tmpds_resultsWBoolean is sorted by acctno and then by seqNo

		 // Do the suppression here before the rollup.
		 // ********** do suppression and mask of SSN. note how to put shared keyword within macro call.
		  Suppress.MAC_Suppress(tmpds_resultsWBoolean,
			  tmpds_resultsWBoolean_pulled,application_type_value,Suppress.Constants.LinkTypes.SSN,contactInfo.ssnInfo.SSN);
		// suppress by DID (aka uniqueID)...otherwise known as UniqueID in this layout

		Suppress.MAC_Suppress(tmpds_resultsWBoolean_pulled,
		  tmpds_resultsWBoolean_pulled2,application_type_value,Suppress.Constants.LinkTypes.DID,UniqueID);

			Suppress.MAC_Mask(tmpds_resultsWBoolean_pulled2,
			  tmpds_resultsWBoolean_masked, contactInfo.ssnInfo.SSN, null, true, false, maskVal:=ssnMaskVal);

		 // need to slim the search results for any particular entity (i.e. acctno) to max of 5
		SHARED
		 tmpds_resultsWBooleanGrouped := TOPN(GROUP(tmpds_resultsWBoolean_masked,accountNumber),
					iesp.Constants.RelationshipIdentifier.MAX_COUNT_MATCH_RECORDS,accountNumber);
		// this rollup puts the search results into 'best' xml block if there is not resolution needed
		// on the search results (meaning doesn't resolve to a single particular DID or BIP linkid (ult/org/sele)
		// Otherwise it gets put into the 'matches' xml block.
   SHARED
		iesp.RelationshipIdentifierSearch.t_RelationshipIdentifierSearchRecord
			rollupByAcctnoTR( iesp.RelationshipIdentifierSearch.t_RelationshipIdentifierSearchMatchRecord le,
			          dataset(iesp.RelationshipIdentifierSearch.t_RelationshipIdentifierSearchMatchRecord) ri)
								:= TRANSFORM
								SELF.matches := ri;
								bestTmp := PROJECT(le, TRANSFORM(iesp.RelationshipIdentifierSearch.t_RelationshipIdentifierSearchBestRecord,
																		SELF := LEFT,
																		SELF := []));
                justAcctno := PROJECT(le, TRANSFORM(iesp.RelationshipIdentifierSearch.t_RelationshipIdentifierSearchBestRecord,

																		 SELF.accountNumber := LEFT.accountNumber;
																		SELF.role := LEFT.role;
																		SELF.individualOrbusiness := LEFT.IndividualOrBusiness;
																		SELF := []));

								SELF.Best := if (~(Le.NeedsResolution), BestTmp,justAcctno);
		            END;

		SHARED
		tmpds_resultsWBooleanRolled := ROLLUP(tmpds_resultsWBooleanGrouped, GROUP,
 		                                              rollupByAcctnoTR(LEFT, ROWS(LEFT)));

    /////////////////
		// END NON BATCH
		///////////////////

		////////////////////////////
		// START OF BATCH PROCESSING
		/////////////////////////////
		ds_BatchIn := PROJECT(tmpds_BatchIn,TRANSFORM( {unsigned4 rid; RECORDOF(LEFT);},
	                     SELF.RID := (UNSIGNED4) COUNTER;
											 SELF := LEFT));

		BIPV2.IDfunctions.rec_SearchInput
	      tFormat2SearchInput(RECORDOF(ds_batchIn) pInput) :=
		TRANSFORM
			SELF.acctno := (STRING30) pInput.rid;  // important to keep this as RID and not ACCTNO.
			SELF.company_name     := pInput.comp_name;
			SELF.fein             := pInput.tin;
			SELF.city             := pInput.p_city_name;
			SELF.state            := pInput.st;
			SELF.zip5             := pInput.z5;
			SELF.phone10          := pInput.workphone;
			SELF.Contact_ssn      := pInput.ssn;
			SELF.Contact_fname    := pInput.name_first;
			SELF.Contact_mname    := pInput.name_middle;
			SELF.Contact_lname    := pInput.name_last;
			// PII takes presidence over SELEID values on input.
			// as per requirement 4.15
			SELF.inseleid         := if (pInput.comp_name = '' and pInput.p_city_name = '' and pInput.st = '' and
		                             pInput.z5 = '' and pInput.prim_range = '' and pInput.predir = '' and
																 pInput.prim_name = '' and pInput.addr_suffix = '' and pInput.postdir = '' and
																 pInput.sec_range = '' and pInput.tin = '' and pInput.Workphone = '' and
																 pInput.inseleid <> 0,
																 (string) pINput.Inseleid,
																 '');

			SELF.zip_radius_miles := 0; // not used in this project.
			SELF.Hsort            := TRUE; // this boolean only affect the proxid level returns not SELEID level.
		                              // always set to true.
			SELF.url := '';
			SELF.email := '';
			SELF                  := pInput;
		END;

	ds_BatchInBusiness := PROJECT(ds_batchIn(IndividualOrBusiness = RelationshipIdentifier_Services.Constants.BUSINESS),
																		tFormat2SearchInput(LEFT));

  	// Get the seleid best information for the search criteria
	// filter on source <> '' gets rid of source = D info.
	// this is for the batch call.
	ds_BestInfoTmpBatchAll := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(ds_BatchInBusiness).SeleBest(company_name <> '');

  // 1.  Use all linkids returned from SELEBEST call to left only join against just rows from search results
	//     that are source = D only contributing.
	// 2.  so that resulting DS (ds_best_infotmpBatch) is only rows with Source D (possibly) AND other sources contributing
	//     this way we lose the results that are source = D only.
	ds_bestKfetchSourceDResultsBatch := ds_BestInfoTmpBatchAll(COUNT(company_name_sources) = 1 AND
	                                  company_name_sources[1].source = MDR.sourceTools.src_Dunn_Bradstreet);

  ds_bestInfoTmpBatch := join(ds_BestInfoTmpBatchAll, ds_bestKfetchSourceDResultsBatch,
	                           BIPV2.IDmacros.mac_JoinTop3Linkids(),
														 TRANSFORM(LEFT), LEFT ONLY);

	// sort by -record_score to get best to top as rollup happens farther down.
  ds_bestInfoTmpBatchSorted := sort(ds_BestInfoTmpBatch,acctno,-record_score);

	ds_BestInfoTmpBatchGrouped := PROJECT(GROUP(ds_BestInfoTmpBatchSorted,acctno),TRANSFORM({INTEGER rowid; UNSIGNED4 AcctnoIntValue;
	                                                                       RECORDOF(LEFT);},
	                                     SELF.rowid := counter; // counts number of results for each row of input (acctno).
																			                   // acctno field in this result set identifies the
																												 // row of input that the result row is a result for.
                                       // added field to join with since orig rows of input
																			 // is unsigned4
                                       SELF.AcctnoIntValue := (UNSIGNED4) LEFT.acctno;
																			 SELF := LEFT));

	ds_bestInfoTmpBatchUngrouped := (UNGROUP(ds_BestInfoTmpBatchGrouped))(dt_first_seen <= endDateBatch);

	// join batch input back to initial input:
	// acctno field in DsBestInfoTmpBatch is a sequence Number from the different recs on input.
	ds_BusinessBestBatchRecsWithRoles := JOIN(ds_BatchIn, ds_bestInfoTmpBatchUngrouped,
	                                         LEFT.rid = RIGHT.acctnoIntValue,
																					 TRANSFORM({STRING1 IndividualOrBusiness;
																											STRING20 orig_acctno;
																											INTEGER seqNum;
															                        STRING50 Role;
																										  UNSIGNED4 AsOfDate;
																					            RECORDOF(RIGHT);},
																				// reattach the original input fields from LEFT
																				 SELF.acctno   := LEFT.acctno;
																				 SELF.orig_acctno := LEFT.orig_acctno;
																				 SELF.seqNum := 0;
																				 SELF.Role     := LEFT.Role;
																				 SELF.asOfDate := RIGHT.dt_first_seen;
																				 SELF.individualOrBusiness := LEFT.IndividualorBusiness;
																				 SELF.RowID := RIGHT.ROWID; // seq number of the result set for each row of Input.
																				                            // TODO : can check this later
																																		// to see if count of recs is over 8
																																		// and return error message if so.
																				 SELF := RIGHT;
																				 ), LEFT OUTER,limit(0), keep (RelationshipIdentifier_Services.Constants.KEEPLIMITBATCH));

  ds_buinessBestBatchRecsWithRolesGrouped := PROJECT(GROUP(ds_BusinessBestBatchRecsWithRoles, orig_acctno),
	                                                  TRANSFORM(RECORDOF(LEFT),
																										  SELF.seqNum := COUNTER;
																											SELF := LEFT));

	 ds_buinessBestBatchRecsWithRolesUNGROUPED := UNGROUP(ds_buinessBestBatchRecsWithRolesGrouped);

   ds_buinessBestBatchRecsWithRolesSorted := sort(ds_buinessBestBatchRecsWithRolesUNGROUPED, orig_acctno,seqnum);
	// *****************************

		// ds_batch_in has a rid for each row of input.
		// which gets turned into seq number and then SEQ can be used to take result set and join
		// back to ds_inDataSearchBysIndividualBatch to get initial metadata (role, input info etc).
		ds_inDataSearchBysIndividualBatch := ds_BatchIn(individualOrBusiness = RelationshipIdentifier_Services.Constants.INDIVIDUAL);
		// 1.  LEFT OUTER Join this DS to the person info results.
    // now go get person info recs


		ds_personSearchInputBatch := PROJECT(ds_inDataSearchBysIndividualBatch, TRANSFORM(DidVille.Layout_Did_OutBatch,
	                SELF.seq := (unsigned4)LEFT.rid;// this RID value is later used to join back the results
									                               // of person search to this ds_inDataSearchBysIndividualBatch
																								 // in order to get back acctno/seq number.
                  SELF.ssn := LEFT.SSN;
									SELF.DOB := LEFT.dob;
								  SELF.phone10 := LEFT.homephone;
	                SELF.fname := LEFT.name_first;
	                SELF.mname := LEFT.Name_middle;
	                SELF.lname := LEFT.Name_last;
	                SELF.prim_range := LEFT.prim_range;
	                SELF.predir := LEFT.predir;
	                SELF.prim_name := LEFT.prim_name;
                  SELF.addr_suffix := LEFT.addr_suffix;
	                SELF.postdir := LEFT.postdir;
	                SELF.unit_desig := LEFT.unit_desig;
	                SELF.sec_range := LEFT.sec_range;
	                SELF.p_city_name := LEFT.p_city_name;
									SELF.st := LEFT.st;
									SELF.z5 := LEFT.z5;
									SELF.zip4 := LEFT.zip4;
									SELF.email := ''; //LEFT.email;
									// PII takes presidence over DID values on input.
									// as per requirement 4.15
									SELF.DID   := if (LEFT.SSN = '' AND LEFT.DOB = '' AND LEFT.homephone = '' AND
									                  LEFT.name_first = '' and LEFT.name_middle = '' and LEFT.name_last = '' AND
																		LEFT.prim_range = '' and LEFT.predir = '' and LEFT.prim_name = '' AND
																		LEFT.addr_suffix = '' and LEFT.postdir = '' AND LEFT.unit_desig = '' AND
																		LEFT.sec_range = '' AND LEFT.p_city_name = '' AND LEFT.st = '' and
																		LEFT.z5 = '' AND left.zip4 = ''
																		, LEFT.DID,0);
	                SELF := []
									 ));
        // THIS IS NOT needed in batch per requirement 4.15 but leaving here for readability
       // PersonSearchInputDidandOtherStuffBatch := ds_personSearchInputBatch (did <> 0 and
		                               // (ssn <> '' OR dob <> '' OR
										               // phone10 <> '' OR title <> '' OR
																	 // fname <> '' OR mname <> '' OR
																	 // lname <> '' OR suffix <> '' OR
																	 // prim_range <> '' OR predir <> '' OR
																	 // prim_name <> '' OR addr_suffix <> '' OR
																	 // postdir <> '' OR unit_desig <> '' OR
																	 // sec_range <> '' OR p_city_name <> '' OR
																	 // st <> '' OR z5 <> '' OR zip4 <> ''));

		 personSearchInputJustDIDBatch := ds_personSearchInputBatch(did <> 0 and
		                               ssn = '' and dob ='' and
										               phone10 = '' and title = '' and
																	 fname = '' and mname = '' and
																	 lname = '' and suffix = '' and
																	 prim_range = '' and predir = '' and
																	 prim_name = '' and addr_suffix = '' and
																	 postdir = '' and unit_desig = '' and
																	 sec_range = '' and p_city_name = '' and
																	 st = '' and z5 = '' and zip4 = '');

		 personSearchInputPIIBatch := ds_personSearchInputBatch(did = 0 and (
		                                 ssn <> '' OR dob  <> '' OR
										               phone10 <> '' OR title <> '' OR
																	 fname <> '' OR mname <> '' OR
																	 lname <> '' OR suffix <> '' OR
																	 prim_range <> '' OR predir <> '' OR
																	 prim_name <> '' OR addr_suffix <> '' OR
																	 postdir <> '' OR unit_desig <> '' OR
																	 sec_range <> '' OR p_city_name <> '' OR
																	 st <> '' OR z5 <> '' OR zip4 <> ''));

		 // this function hits the didville macro
		 ds_personSearchResultsNODIDBatch := RelationshipIdentifier_services.functions.PersonSearch(personSearchInputPIIBatch);
		 // after this one the value of seq = rid from ds_personSearchInputBatch
		 // and then the new value : rowID is a counter of recs within each grouping of SEQ

		  ds_personSearchResultsDIDBatch := PROJECT(personSearchInputJustDIDBATCH,
		                                    TRANSFORM(DidVille.Layout_Did_OutBatch,
																				           // ^^^^ this is output layout of
																     // this call : RelationshipIdentifier_services.functions.PersonSearch
																				SELF.DID := LEFT.DID;
																				SELF.seq := LEFT.SEQ;
																				SELF := []));

		 DS_personSearchResultsBatch :=
		     SORT(ds_PersonSearchresultsNoDIDBatch + ds_personSearchResultsDIDBatch, seq);
		 ds_personSearchResultsBatchGrouped := PROJECT(GROUP(ds_PersonSearchResultsBatch, seq),
		                                 TRANSFORM({integer rowid; RECORDOF(LEFT)},
		                                   SELF.rowid := COUNTER;
																			 SELF := LEFT));

		 ds_personSearchResultsBatchUnGrouped := UNGROUP(ds_personSearchResultsBatchGrouped);

		 layout_tmp := RECORD
		     RECORDOF(ds_personSearchResultsBatchUnGrouped) - [did, ssn, dob, prim_range, predir, prim_name, addr_suffix, postdir, unit_desig,
				                                         sec_range, p_city_name, st, z5, zip4];
     end;

		 ds_personSearchResultsBatchWACCTNO_Roles := JOIN(ds_inDataSearchBysIndividualBatch, ds_personSearchResultsBatchUnGrouped,
		                                            LEFT.rid = RIGHT.SEQ,
																								TRANSFORM({unsigned4 seqNum; RECORDOF(LEFT); layout_tmp;},
																									SELF.Acctno := LEFT.acctno;
																									SELF.orig_acctno := LEFT.orig_acctno;
																									SELF.SeqNum := 0; // set later LEFT.SeqNum;// can be thought of as each person/bus row of input
																									SELF.ROLE := LEFT.ROLE;
																									SELF.individualOrBusiness := LEFT.individualOrBusiness;
																								// this field is row ID per each role within each acctno.
																									SELF.RowID := RIGHT.ROWID; // a counter for each row of input will be
																									                        // greater than 1 if mult results for each input row.
                                                  SELF.DID := RIGHT.DID;
																									SELF := LEFT,
																									SELF := RIGHT), LEFT OUTER, limit(0), keep (RelationshipIdentifier_Services.Constants.KEEPLIMITBATCH)
																									);

      ds_personSearchResultsBatchWAcctNo_rolesGrouped := PROJECT(GROUP(ds_personSearchResultsBatchWACCTNO_Roles, orig_acctno),
			                                                     TRANSFORM(RECORDOF(LEFT),
																													 SELF.seqNum := Counter;
																													 SELf := LEFT));

      ds_personSearchRsultsBatchWAcctNo_rolesUngrped := ungroup(ds_personSearchResultsBatchWAcctNo_rolesGrouped);

			ds_personSearchResultsBatchWAcctno_rolesSorted := SORT(ds_personSearchRsultsBatchWAcctNo_rolesUngrped,orig_acctno, seqNum);

			// this is just getting dt_first_seen for header for all dids in the input of acctno's.
			// so no need to sort by orig_acctno or anything else.

			ds_personSearchResultsBatchWdateRange_all := SORT(JOIN(ds_personSearchResultsBatchWAcctno_rolesSorted,
		                                           dx_header.Key_Header(),
																							 keyed(LEFT.did = RIGHT.s_did),
																							 TRANSFORM(RIGHT), limit(0), keep(RelationshipIdentifier_Services.Constants.KEEPLIMITBATCH))
																							   (dt_first_seen <> 0),
																							   s_did, dt_first_seen, record);

			ds_personSearchResultsBatchWdateRange := Suppress.MAC_SuppressSource(ds_personSearchResultsBatchWdateRange_all, mod_access, s_did);

    	ds_personSearchResultsBatchWdateRange personRollitBatch(ds_personSearchResultsBatchWdateRange l,
			                                             ds_personSearchResultsBatchWdateRange r) := TRANSFORM
																									 SELF := l;
																									 SELF := r;
																									 END;

			// this attr used to get dt_first_seen dt_last_seen for filtering later.
    ds_personSearchResultsBatchWdateRangeRolled := ROLLUP(ds_personSearchResultsBatchWdateRange,
																						LEFT.s_did = RIGHT.s_did,
		                                        personRollitBatch(LEFT,RIGHT));

    // filter off any search results by enddateBatch here as per requirements.
	   ds_personSearchResultsBatchWAcctno_rolesSortedWithDateRange := JOIN(
		                           ds_personSearchResultsBatchWAcctno_rolesSorted,
		                            ds_personSearchResultsBatchWdateRangeRolled,
																  LEFT.DID = RIGHT.S_DID,
																	TRANSFORM({unsigned4 dt_first_seen; RECORDOF(LEFT);},
																	   SELF.dt_first_seen := RIGHT.dt_first_seen * 100;
																		                       // ^^^^^^^^^^^^^^^^^^^^^^^
																													 // multiply by 100 here to match
																													 // the string8 type of date
																													 // since dates from header data are YYYYMM
																													 //
																		 SELF := LEFT))(dt_first_seen <= EndDateBatch);
		// NOW DO BATCH COMBINING BUSINESS AND PERSON Datasets.
		// project each row through
    // BATCH output
		// this assume BOTH SIDE have all acctno's not sure if this a good assumption possibly LEFT OUTER Join here.
		//
		//  ds_BusinessBestBatchRecsWithRolesSorted has all original info since started with batch input.
		//            thus left outer join here in order to keep any business data.
		//            that doesn't necessarily have person data in it
		//
		// REST OF THIS IS BATCH FROM HERE DOWN
	  SHARED
		tmpds_results_batchNoNames := JOIN(ds_buinessBestBatchRecsWithRolesSorted,
														ds_personSearchResultsBatchWAcctno_rolesSortedWithDateRange,
		                      LEFT.ACCTNO = RIGHT.ACCTNO,

													TRANSFORM(RelationshipIdentifier_Services.Layouts.Batch.interMediateLayout,
														SELF.acctno := LEFT.acctno;
														SELF.orig_acctno := LEFT.orig_acctno;
														SELF.seqNum := LEFT.seqNum;
														SELF.RoleNum := 0; // SET LATER AFTER we know we have an individual DID or LINKID combo
														SELF.IndividualOrBusiness := LEFT.individualOrBusiness;
														SELF.did := IF (RIGHT.IndividualOrBusiness = RelationshipIdentifier_Services.Constants.INDIVIDUAL, RIGHT.did, 0);
														SELF.DOb := '';
														SELF.ultid  := LEFT.ultid;
														SELF.orgid  := LEFT.orgid;
														SELF.seleid := LEFT.SELEID;
														SELF.proxid := LEFT.proxid;
														SELF.powid  := LEFT.powid;
														SELF.empid  := LEFT.empid;
														SELF.dotid  := LEFT.dotid;
														SELF.Role   := LEFT.ROLE;
														SELF.AsOfDate := IF (LEFT.INdividualOrbusiness = RelationshipIdentifier_Services.Constants.BUSINESS, LEFT.AsOfDate,
																	                      IF (RIGHT.individualOrBusiness = RelationshipIdentifier_Services.Constants.INDIVIDUAL, RIGHT.dt_first_seen,
																											  0));
                            SELF.comp_Name :=	LEFT.company_Name;
														SELF.tin        := LEFT.company_fein;

														SELF.prim_name   := IF (LEFT.INdividualOrbusiness = RelationshipIdentifier_Services.Constants.BUSINESS, LEFT.prim_name,
																	                     IF (RIGHT.individualOrBusiness = RelationshipIdentifier_Services.Constants.INDIVIDUAL, RIGHT.prim_name,
																											 ''));
														self.Prim_range  := IF (LEFT.INdividualOrbusiness = RelationshipIdentifier_Services.Constants.BUSINESS, LEFT.prim_range,
																	                     IF (RIGHT.individualOrBusiness = RelationshipIdentifier_Services.Constants.INDIVIDUAL, RIGHT.prim_range,
																											 ''));
														SELF.predir      := IF (LEFT.INdividualOrbusiness = RelationshipIdentifier_Services.Constants.BUSINESS, LEFT.predir,
																	                     IF (RIGHT.individualOrBusiness = RelationshipIdentifier_Services.Constants.INDIVIDUAL, RIGHT.predir,
																											 ''));
														SELF.postdir     := IF (LEFT.INdividualOrbusiness = RelationshipIdentifier_Services.Constants.BUSINESS, LEFT.postdir,
																	                     IF (RIGHT.individualOrBusiness = RelationshipIdentifier_Services.Constants.INDIVIDUAL, RIGHT.postdir,
																											 ''));
														SELF.addr_suffix := IF (LEFT.INdividualOrbusiness = RelationshipIdentifier_Services.Constants.BUSINESS, LEFT.addr_suffix,
																	                     IF (RIGHT.individualOrBusiness = RelationshipIdentifier_Services.Constants.INDIVIDUAL, RIGHT.addr_suffix,
																											 ''));
														SELF.p_city_name := IF (LEFT.INdividualOrbusiness = RelationshipIdentifier_Services.Constants.BUSINESS, LEFT.v_city_name,
																	                     IF (RIGHT.individualOrBusiness = RelationshipIdentifier_Services.Constants.INDIVIDUAL, RIGHT.p_city_name,
																											 ''));
														SELF.st := IF (LEFT.INdividualOrbusiness = RelationshipIdentifier_Services.Constants.BUSINESS, LEFT.st,
																	                     IF (RIGHT.individualOrBusiness = RelationshipIdentifier_Services.Constants.INDIVIDUAL, RIGHT.st,
																											 ''));
														SELF.z5 := IF (LEFT.INdividualOrbusiness = RelationshipIdentifier_Services.Constants.BUSINESS, LEFT.zip,
																	                     IF (RIGHT.individualOrBusiness = RelationshipIdentifier_Services.Constants.INDIVIDUAL, RIGHT.z5,
																											 ''));
                            SELF.zip4 := IF (LEFT.INdividualOrbusiness = RelationshipIdentifier_Services.Constants.BUSINESS, LEFT.zip4,
																	                     IF (RIGHT.individualOrBusiness = RelationshipIdentifier_Services.Constants.INDIVIDUAL, RIGHT.zip4,
																											 ''));
                            SELF.unit_desig := IF (LEFT.INdividualOrbusiness = RelationshipIdentifier_Services.Constants.BUSINESS, LEFT.unit_desig,
																	                     IF (RIGHT.individualOrBusiness = RelationshipIdentifier_Services.Constants.INDIVIDUAL, RIGHT.unit_desig,
																											 ''));
														SELF.sec_range := IF (LEFT.INdividualOrbusiness = RelationshipIdentifier_Services.Constants.BUSINESS, LEFT.sec_range,
																	                     IF (RIGHT.individualOrBusiness = RelationshipIdentifier_Services.Constants.INDIVIDUAL, RIGHT.sec_range,
																											 ''));
														SELF.HomePhone := IF (RIGHT.individualOrBusiness = RelationshipIdentifier_Services.Constants.INDIVIDUAL, RIGHT.phone10, '');
														Self.workphone := IF (LEFT.INdividualOrbusiness = RelationshipIdentifier_Services.Constants.BUSINESS, LEFT.company_phone, '');

	                          SELF.ssn   := IF (RIGHT.individualOrBusiness = RelationshipIdentifier_Services.Constants.INDIVIDUAL, RIGHT.SSN,''); // not masked TODO : mask/suppress later.
	                          self.name_first := RIGHT.fname;
														self.name_middle := RIGHT.mname;
														self.name_last := RIGHT.lname;
														self.name_suffix := RIGHT.suffix;
														SELF.inseleid := 0;
														// This is the rowid field from either bus or people data set
														// needed for batch
														SELF.rid := IF (LEFT.individualOrBusiness = RelationshipIdentifier_Services.Constants.BUSINESS, LEFT.ROWID,
														               IF (RIGHT.individualOrBusiness = RelationshipIdentifier_Services.Constants.INDIVIDUAL, RIGHT.ROWID,0));
														), LEFT OUTER,  limit(0), keep (RelationshipIdentifier_Services.Constants.KEEPLIMITBATCH)
														);

		 doxie.mac_best_records(tmpds_results_batchNoNames,did,shared tmpds_results_batchNoNamesOut,dppa_ok,glb_ok,,DRM);
		SHARED
		tmpds_results_batchWithNames := JOIN(tmpds_results_batchNoNames, tmpds_results_batchNoNamesOut,
		                                              LEFT.DID = RIGHT.DID,
																									TRANSFORM({STRING30 fname; STRING30 mname; STRING30 lname;RECORDOF(LEFT);},
																									    SELF.Fname := RIGHT.fname;
																											SELF.mname := RIGHT.mname;
																											SELF.lname := RIGHT.lname;
																											SELF := LEFT;
																											), LEFT OUTER);
		SHARED
    tmpds_results_batchWithNames  rollupTR(tmpds_results_batchWithNames l,
		                                       tmpds_results_batchWithNames r) := TRANSFORM
														SELF := l;
														SELF := r;
														END;
														// acctno value is identifer for search results for each entity
														// so rollup to only keep the top result (i.e. best) for each entity.
		SHARED
    ds_results_Batch_good := rollup(tmpds_results_batchWithNames, LEFT.acctno = RIGHT.acctno,
		                               rollupTR(LEFT,RIGHT));
		// no removal of acctno's just
		// use 'best' result at the top of each acctno
		// this DS ds_resuls_batch_good already sorted by orig_acctno and by seqNum
		SHARED
		ds_results_batchSequencedByOrigAcctno := UNGROUP(PROJECT(GROUP(ds_results_batch_good, orig_acctno), TRANSFORM(RECORDOF(LEFT),
		                                    // this field is set and kept for rest of query
																				// and output with batch so that each entity can be identified
																				// and any necessary linkages can be determined based on this ID.
		                                     SELF.RoleNum := COUNTER;
																				 SELF := LEFT)));
	//output(ds_batchIN, named('DS_batchIN'));\
	//output(endDate, named('endDate'));
	//output(enddatebatch, named('enddatebatch'));
	// output(ds_BestInfoTmpBatch, named('ds_BestInfoTmpBatch'));
	// output(ds_bestInfoTmpBatchSorted, named('ds_bestInfoTmpBatchSorted'));
	 // output(ds_bestInfoTmpBatchUngrouped, named('ds_bestInfoTmpBatchUngrouped'));
	 // output(ds_bestBIPInfoTmpUnGrouped, named('ds_bestBIPInfoTmpUnGrouped'));
	 // output(ds_bestBIPInfoTmpUnGrouped2, named('ds_bestBIPInfoTmpUnGrouped2'));
	// output(ds_inDataSearchBysIndividualBatch, named('ds_inDataSearchBysIndividualBatch'));
	// output(ds_inDataSearchBys, named('ds_inDataSearchBys'));

	// output(ds_personSearchResultsNEW, named('ds_personSearchResultsNEW'));
	// output(ds_personSearchResultsNewFinal, named('ds_personSearchResultsNewFinal'));
	// output(ds_personSearchResultsNewWAcctnoGrouped, named('ds_personSearchResultsNewWAcctnoGrouped'));
	//output(ds_personSearchResultsNewWithSeq, named('ds_personSearchResultsNewWithSeq'));
	// output(ds_personSearchResultsNewWithSeqOUT, named('ds_personSearchResultsNewWithSeqOUT'));
	//output(ds_personSearchResultsNEWwayWAcctno, named('ds_personSearchResultsNEWwayWAcctno'));

	// output(ds_personSearchResultsBatch, named('ds_personSearchResultsBatch'));
	// output(ds_personSearchResultsBatchGrouped, named('ds_personSearchResultsBatchGrouped'));
	//output(ds_personSearchResultsBatchUngrouped, named('ds_personSearchResultsBatchUngrouped'));
	//output(ds_personSearchResultsBatchWacctnoRoles, named('ds_personSearchResultsBatchWacctnoRoles'));
	// output(ds_personSearchResultsBatchWACCTNO_Roles, named('ds_personSearchResultsBatchWACCTNO_Roles'));
	// output(ds_BusinessBestBatchRecsWithRoles, named('ds_BusinessBestBatchRecsWithRoles'));
	// output(ds_buinessBestBatchRecsWithRolesUNGROUPED,named('ds_buinessBestBatchRecsWithRolesUNGROUPED'));
	// output(ds_personSearchRsultsBatchWAcctNo_rolesUngrped, named('ds_personSearchRsultsBatchWAcctNo_rolesUngrped'));
	// output(ds_buinessBestBatchRecsWithRolesSorted, named('ds_buinessBestBatchRecsWithRolesSorted'));
	// output(ds_personSearchResultsBatchWAcctno_rolesSorted, named('ds_personSearchResultsBatchWAcctno_rolesSorted'));
	//output(ds_personSearchResultsBatchWAcctno_rolesSortedWithDateRange, named('ds_personSearchResultsBatchWAcctno_rolesSortedWithDateRange'));
	//tmpds_results_batchNoNames
	 //output(tmpds_results_batchNoNames, named('tmpds_results_batchNoNames'));
	// output(ds_personSearchInput, named('ds_personSearchInput'));
	//output(ds_inDataSearchBys, named('ds_inDataSearchBys'));
	// output(ds_inDataBIP, named('ds_inDataBIP'));
	//output(ds_bestInfoTmp, named('ds_bestInfoTmp'));
	//output(ds_bestInfo, named('ds_bestInfo'));
	// output(ds_personSearchResultsWAcctno, named('ds_personSearchResultsWAcctno'));
	// output(ds_personSearchResultsWNameData, named('ds_personSearchResultsWNameData'));
	// output(ds_bestInfoTmpUnGrouped, named('ds_bestInfoTmpUnGrouped'));
	// output(tmpds_results_batch, named('tmp_results_batch'));
	// output(ds_personSearchInput, named('ds_personSearchInput'));
	// output(ds_personSearchResults, named('ds_personSearchResults'));
	// output(ds_inDataSearchBys, named('ds_inDataSearchBys'));
	// output(PersonSearchInputDidandOtherSTuff, named('PersonSearchInputDidandOtherSTuff'));
	// output(personSearchInputJustDID, named('personSearchInputJustDID'));
	// output(personSearchInputPII, named('personSearchInputPII'));
	 // output(ds_personSearchResultsDID, named('ds_personSearchResultsDID'));
	// output(ds_personSearchResultsNoDID, named('ds_personSearchResultsNoDid'));
	// output(DS_personSearchResults, named('DS_personSearchResults'));
	// output(ds_personSearchResultsWAcctno, named('ds_personSearchResultsWAcctno'));
	 // output(ds_personSearchResultsWAcctnoGrouped, named('ds_personSearchResultsWAcctnoGrouped'));
	  // output(ds_personSearchResultsWNameDateAndDtFirstSeen, named('ds_personSearchResultsWNameDateAndDtFirstSeen'));
	 //output(ds_personResultsWithRoles, named('ds_personResultsWithRoles'));

	// output(ds_businessBestRecsWithRoles, named('ds_businessBestRecsWithRoles'));
	// output(tmpds_results, named('tmpds_results'));
	// output(tmpds_resultsWBoolean, named('tmpds_resultsWBoolean'));
	// output(tmpds_resultsWBooleanRolled, named('tmpds_resultsWBooleanRolled'));
	// output(ds_results_batchSequenced, named('ds_results_batchSequenced'));
	// output(ds_personSearchInputBatchNew, named('ds_personSearchInputBatchNew'));
	// output(ds_personSearchResultsNEWBatch, named('ds_personSearchResultsNEWBatch'));
	// output(ds_personSearchResultsNEWBATCHOUT, named('ds_personSearchResultsNEWBATCHOUT'));
  // output(ds_personSearchResultsNEWBatchFinal, named('ds_personSearchResultsNEWBatchFinal'));
	// output(ds_personSearchResultsNEWBatchlarge, named('ds_personSearchResultsNEWBatchLarge'));
	// output(ds_personSearchResultsNewBatchGrouped, named('ds_personSearchResultsNewBatchGrouped'));
	// output(ds_personSearchResultWIthDIDCOmbined, named('ds_personSearchResultWIthDIDCOmbined'));
	//   output(ds_personSearchResultsDIDOut, named('ds_personSearchResultsDIDOut'));
	// output(ds_personSErachResultsDidOutDedup, named('ds_personSErachResultsDidOutDedup'));
	// output(ds_personSearchResultsWAcctnoGroupedoutfileDedup, named('ds_personSearchResultsWAcctnoGroupedoutfileDedup'));
	//***************
	// main export
	EXPORT ds_results := tmpds_resultsWBooleanRolled;
	// main export
	EXPORT ds_results_batch := ds_results_batchSequencedByOrigAcctno;
	// ***********************
	//
	//return(ds_results_batchSequencedByOrigAcctno);
	//return(tmpds_resultsWBooleanRolled);
	END;
