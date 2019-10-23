IMPORT InsuranceHeader_PostProcess,InsuranceHeader_FCRA,IDL_Header, dops, orbit, _Control,FCRA,IOverrides,ut,InsuranceHeader_Incremental,InsuranceHeader_Incremental_Best,STD;

EXPORT proc_fcra(string version, boolean isIncremental = FALSE) := MODULE

	shared hdr := IF(isIncremental,InsuranceHeader_Incremental.Files.Best_Current_DS,idl_header.files.ds_idl_policy_header_base);
	shared sourceMod := IDL_Header.SourceTools;
	shared buildDate := thorlib.wuid()[2..9];
	// shared version_base := version[1..(STD.str.find(version,'_',1)-1)];

	srcBankruptcy := sourceMod.src_Bankruptcy;
	srcLiens := sourceMod.src_Liens;
	srcFiltered := hdr(sourceMod.SourceIsFCRAHeader(src) and 
														(src NOT IN [srcBankruptcy,srcLiens] OR
															(src = srcBankruptcy AND FCRA.bankrupt_is_ok(buildDate,(string)dt_first_seen)) OR
															(src = srcLiens AND FCRA.lien_is_ok(buildDate,(string)dt_first_seen))));
															
	corrections := PULL(IOverrides.Keys().header_DID.qa);
	corrections_proj := DISTRIBUTE(PROJECT(corrections,TRANSFORM({unsigned8 did},self.did := IF(left.lexid_recent = 0,left.did,left.lexid_recent))),did);
	tab_corrected := TABLE(corrections_proj,{corrections_proj.did},did,local);
	filtered_no_corrections := JOIN(srcFiltered,tab_corrected,LEFT.did=RIGHT.did,TRANSFORM(LEFT),LEFT ONLY,HASH);
	filtered_has_corrections := DISTRIBUTE(JOIN(srcFiltered,tab_corrected,LEFT.did=RIGHT.did,TRANSFORM(LEFT),HASH),did);

	/* Below join lifted from Header.Last_Rollup. To be applied to LexIds that are the subject of corrections/suppressions. */
	filtered_joined := join(filtered_has_corrections,filtered_has_corrections,
													left.did=right.did
													and left.rid < right.rid
													and	left.src        =right.src
													and	left.fname      =right.fname
													and	left.lname      =right.lname
													and	left.prim_range =right.prim_range
													and	left.prim_name  =right.prim_name
													and	left.sec_range  =right.sec_range
													and	left.city  			=right.city
													and	left.st         =right.st
													and	(
																(left.ssn          =right.ssn
															and	left.dob         =right.dob
															and	left.phone       =right.phone
															and	left.mname       =right.mname
															and	left.sname 			 =right.sname
															and	left.zip         =right.zip)
																or (
																		(
																						left.ssn=''
																				or left.ssn=right.ssn 
																				or (
																								ut.nneq(left.ssn, right.ssn)
																							and	(//all dates are populated
																									(left.dt_first_seen>0 and	left.dt_last_seen>0
																							and right.dt_first_seen>0 and right.dt_last_seen>0
																							and	left.dt_vendor_first_reported>0 and	left.dt_vendor_last_reported>0
																							and right.dt_vendor_first_reported>0 and right.dt_vendor_last_reported>0)
																							or // or all dates are zero
																								(left.dt_first_seen=0 and	left.dt_last_seen=0
																							and right.dt_first_seen=0 and right.dt_last_seen=0
																							and	left.dt_vendor_first_reported=0 and	left.dt_vendor_last_reported=0
																							and right.dt_vendor_first_reported=0 and right.dt_vendor_last_reported=0)
																							)// both seen and vendor date ranges overlap respectively
																						and (left.dt_first_seen between right.dt_first_seen and right.dt_last_seen
																								or left.dt_last_seen between right.dt_first_seen and right.dt_last_seen
																								or right.dt_first_seen between left.dt_first_seen and left.dt_last_seen
																								or right.dt_last_seen between left.dt_first_seen and left.dt_last_seen)
																						and (left.dt_vendor_first_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported
																								or left.dt_vendor_last_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported
																								or right.dt_vendor_first_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported
																								or right.dt_vendor_last_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported)
																						)
																				or (//one of the seen dates is missing
																							ut.nneq(left.ssn, right.ssn)
																						and	(left.dt_first_seen=0 or right.dt_first_seen=0 or left.dt_last_seen=0 or right.dt_last_seen=0)
																						and	left.dt_vendor_first_reported>0 and	left.dt_vendor_last_reported>0
																						and right.dt_vendor_first_reported>0 and right.dt_vendor_last_reported>0
																						// and vendor dates ranges overlap
																						and (left.dt_vendor_first_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported
																								or left.dt_vendor_last_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported
																								or right.dt_vendor_first_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported
																								or right.dt_vendor_last_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported)
																						)
																				or (//one of the seen dates and one of the vendor dates are missing
																							ut.nneq(left.ssn, right.ssn)
																						and	(left.dt_first_seen=0 or right.dt_first_seen=0 or left.dt_last_seen=0 or right.dt_last_seen=0)
																						and	(left.dt_vendor_first_reported=0 or right.dt_vendor_first_reported=0 or left.dt_vendor_last_reported=0 or right.dt_vendor_last_reported=0)
																						)
																		)
																and	(
																						left.dob=0
																				or left.dob=right.dob 
																				or (
																								ut.NNEQ_Date(left.dob, right.dob)
																							and	(//all dates are populated or all dates are zero
																									(left.dt_first_seen>0 and	left.dt_last_seen>0
																							and right.dt_first_seen>0 and right.dt_last_seen>0
																							and	left.dt_vendor_first_reported>0 and	left.dt_vendor_last_reported>0
																							and right.dt_vendor_first_reported>0 and right.dt_vendor_last_reported>0)
																							or
																								(left.dt_first_seen=0 and	left.dt_last_seen=0
																							and right.dt_first_seen=0 and right.dt_last_seen=0
																							and	left.dt_vendor_first_reported=0 and	left.dt_vendor_last_reported=0
																							and right.dt_vendor_first_reported=0 and right.dt_vendor_last_reported=0)
																							)// both seen and vendor date ranges overlap respectively
																						and (left.dt_first_seen between right.dt_first_seen and right.dt_last_seen
																								or left.dt_last_seen between right.dt_first_seen and right.dt_last_seen
																								or right.dt_first_seen between left.dt_first_seen and left.dt_last_seen
																								or right.dt_last_seen between left.dt_first_seen and left.dt_last_seen)
																						and (left.dt_vendor_first_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported
																								or left.dt_vendor_last_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported
																								or right.dt_vendor_first_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported
																								or right.dt_vendor_last_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported)
																						)
																				or (
																							ut.NNEQ_Date(left.dob, right.dob)
																						and	(left.dt_first_seen=0 or right.dt_first_seen=0 or left.dt_last_seen=0 or right.dt_last_seen=0)
																						and	left.dt_vendor_first_reported>0 and	left.dt_vendor_last_reported>0
																						and right.dt_vendor_first_reported>0 and right.dt_vendor_last_reported>0
																						// and vendor dates ranges overlap
																						and (left.dt_vendor_first_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported
																								or left.dt_vendor_last_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported
																								or right.dt_vendor_first_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported
																								or right.dt_vendor_last_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported)
																						)
																				or (//one of the seen dates and one of the vendor dates are missing
																							ut.NNEQ_Date(left.dob, right.dob)
																						and	(left.dt_first_seen=0 or right.dt_first_seen=0 or left.dt_last_seen=0 or right.dt_last_seen=0)
																						and	(left.dt_vendor_first_reported=0 or right.dt_vendor_first_reported=0 or left.dt_vendor_last_reported=0 or right.dt_vendor_last_reported=0)
																						)
																	)
														and	ut.nneq(left.phone       ,right.phone)
														and	(
																ut.nneq(left.mname       ,right.mname)
															or (if(left.mname[1]=right.mname[1] and (length(trim(left.mname))=1 or length(trim(right.mname))=1),true,false))
															)
														and	ut.nneq(left.sname ,right.sname)
														and	ut.nneq(left.zip         ,right.zip)
														and	(left.dt_first_seen=right.dt_first_seen or left.dt_first_seen=0 or right.dt_first_seen=0)
														)
													)
												,transform({unsigned8 new_rid,unsigned8 old_rid},self.new_rid := left.rid,self.old_rid := right.rid)
												,local);

	filtered_duped := DEDUP(SORT(DISTRIBUTE(filtered_joined,old_rid),old_rid,new_rid,local),old_rid,local);
	filtered_rejoined := PROJECT(JOIN(DISTRIBUTE(filtered_has_corrections,rid),filtered_duped,LEFT.rid=RIGHT.old_rid,TRANSFORM(recordof(left),self.rid := IF(RIGHT.new_rid=0,LEFT.rid,RIGHT.new_rid);SELF:=LEFT),left outer,local),IDL_Header.Layout_Header_Link);

	dob_score(integer d) := 
	MAP( d = 0 => 0,
         d < 10000 or d % 10000 = 0 or (d < 1000000 and d % 100 = 0)=> 1,
         d < 1000000 or d % 100 = 0 => 2,
         3 );
	
	Vendor_Id_Null(string18 vid) := vid IN ['                  ','                 0','000000000000000000'];

	/*Merge transform taken from Header.TRA_Merge_Headers and updated*/
	IDL_Header.Layout_Header_Link Header_Roll(IDL_Header.Layout_Header_Link l, IDL_Header.Layout_Header_Link r) := transform
		self.rid := ut.Min2(l.rid,r.rid);
		self.source_rid := ut.Min2(l.source_rid,r.source_rid);
		self.dt_first_seen := 
		ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
							ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
		self.dt_last_seen := 
		Max(l.dt_last_seen,r.dt_last_seen);
		self.dt_vendor_last_reported := Max(l.dt_vendor_last_reported,r.dt_vendor_last_reported);
		self.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported,r.dt_vendor_first_reported);
		self.dt_effective_first := ut.EarliestDate(ut.EarliestDate(l.DT_EFFECTIVE_FIRST,r.DT_EFFECTIVE_FIRST),
							ut.EarliestDate(l.DT_EFFECTIVE_FIRST,r.DT_EFFECTIVE_FIRST));
		self.dt_effective_last := Max(l.DT_EFFECTIVE_LAST,r.DT_EFFECTIVE_LAST);
		self.vendor_id                := map(Vendor_Id_Null(l.vendor_id) => r.vendor_id
																					,Vendor_Id_Null(r.vendor_id) => l.vendor_id
																					,l.dt_vendor_last_reported > r.dt_vendor_last_reported => l.vendor_id
																					,r.vendor_id);
		self.phone := if ( length(trim(l.phone,all))<length(trim(r.phone,all)),r.phone,l.phone );
		self.ssn := if(ut.full_ssn(l.ssn),l.ssn,
								if(ut.partial_ssn(l.ssn) and trim(r.ssn)='',l.ssn,
						r.ssn));
		self.ssn_ind := if(ut.full_ssn(l.ssn),l.ssn_ind,
								if(ut.partial_ssn(l.ssn) and trim(r.ssn)='',l.ssn_ind,
						r.ssn_ind));
		self.dob := if ( dob_score(l.dob) < dob_score(r.dob), r.dob, l.dob );
		self.dob_ind := if( dob_score(l.dob) < dob_score(r.dob), r.dob_ind, l.dob_ind );
		self.title := if (l.title = '', r.title, l.title );
		self.fname := if (l.fname = '', r.fname, l.fname );
		self.mname := if (l.mname = '' or l.mname=r.mname[1], r.mname, l.mname );
		self.lname := if (l.lname = '', r.lname, l.lname );
		self.sname := if (l.sname = '' or ut.fGetSuffix(l.sname)=r.sname, r.sname, l.sname );
		self.gender := if (l.gender = r.gender,l.gender,		
											if(l.gender = '' or (l.gender = 'X' and r.gender <> ''), r.gender, 
												if(l.gender NOT IN ['','X'] and r.gender NOT IN ['','X'],'X',l.gender)));
		self.derived_gender := if (l.derived_gender = r.derived_gender,l.derived_gender,
														if(l.derived_gender = '' or (l.derived_gender = 'X' and r.derived_gender <> ''), r.derived_gender, 
															if(l.derived_gender NOT IN ['','X'] and r.derived_gender NOT IN ['','X'],'X',l.derived_gender)));			
		self.prim_range := if (l.prim_range = ''and l.zip4='', r.prim_range, l.prim_range );
		self.predir := if (l.predir = ''and l.zip4='', r.predir, l.predir );
		self.prim_name := if (l.prim_name = ''and l.zip4='', r.prim_name, l.prim_name );
		self.addr_suffix := if (l.addr_suffix = ''and l.zip4='', r.addr_suffix, l.addr_suffix );
		self.postdir := if (l.postdir = ''and l.zip4='', r.postdir, l.postdir );
		self.unit_desig := map(
													l.dt_last_seen<r.dt_last_seen and l.dt_last_seen>0 and l.zip4='' => r.unit_desig
													,l.dt_last_seen>r.dt_last_seen and r.dt_last_seen>0 => l.unit_desig
													,l.dt_last_seen<r.dt_last_seen and l.dt_last_seen>0 => r.unit_desig
													,l.dt_last_seen=r.dt_last_seen and l.unit_desig<>'' => l.unit_desig
													,l.unit_desig<>'' => l.unit_desig
													,r.unit_desig
													);
		self.sec_range := map(
													l.dt_last_seen<r.dt_last_seen and l.dt_last_seen>0 and l.zip4='' => r.sec_range
													,l.dt_last_seen>r.dt_last_seen and r.dt_last_seen>0 => l.sec_range
													,l.dt_last_seen<r.dt_last_seen and l.dt_last_seen>0 => r.sec_range
													,l.dt_last_seen=r.dt_last_seen and l.sec_range<>'' => l.sec_range
													,l.sec_range<>'' => l.sec_range
													,r.sec_range
													);
		self.city := if (l.city = ''and l.zip4='', r.city, l.city );
		self.st := if (l.st = ''and l.zip4='', r.st, l.st );
		self.zip := if (l.zip = ''and l.zip4='', r.zip, l.zip );
		self.zip4 := if (l.zip4 = '', r.zip4, l.zip4 );
		self.addr_ind := if(l.addr_ind = '',r.addr_ind,
										 if(r.addr_ind = '',l.addr_ind,
										 (string)min((unsigned)l.addr_ind,(unsigned)r.addr_ind)));
		self.best_addr_ind := if(l.best_addr_ind = '',r.best_addr_ind,l.best_addr_ind);
		self.addressstatus := if(l.addr_ind = '',r.addressstatus,
													if(r.addr_ind = '',l.addressstatus,
													if((unsigned)l.addr_ind < (unsigned)r.addr_ind,l.addressstatus,
													if((unsigned)r.addr_ind < (unsigned)l.addr_ind,r.addressstatus,
													if(l.addressstatus = '',l.addressstatus,r.addressstatus)))));
		self.addresstype	 := if(l.addresstype = '',r.addresstype,l.addresstype);
		self.ambiguous := map(l.ambiguous = '' and r.ambiguous <> '' => l.ambiguous,
						 l.ambiguous <> '' and r.ambiguous = '' => r.ambiguous,
						 l.ambiguous <> '' and r.ambiguous <> '' and l.ambiguous <> r.ambiguous => 'A',
						 l.ambiguous = '' => r.ambiguous,
						 l.ambiguous);

		self := l;
		end;
	
	filtered_rolled := ROLLUP(SORT(DISTRIBUTE(filtered_rejoined,rid),rid,dt_vendor_last_reported,dt_vendor_first_reported,dt_last_seen,local),left.rid=right.rid,Header_Roll(LEFT,RIGHT),local);
	shared filtered := DISTRIBUTE(filtered_no_corrections + filtered_rolled,rid);
												
	shared filename := IF(isIncremental,
												InsuranceHeader_Incremental.Filenames.FCRA_LF(version,WORKUNIT),
												IDL_Header.files.FILE_FCRA_HEADER + version);
												
	export fcraHeader := OUTPUT(filtered,,filename,compressed);

	createSF := sequential(if( not fileservices.superfileexists(IDL_Header.files.FILE_FCRA_HEADER),
														fileservices.createsuperfile(IDL_Header.files.FILE_FCRA_HEADER)));


	export updateSF := sequential(createSF,
																FileServices.PromoteSuperFileList([IDL_Header.files.FILE_FCRA_HEADER], filename));
	
	createSF_inc := sequential(if( not fileservices.superfileexists(InsuranceHeader_Incremental.Filenames.FCRA_SF.current),
														fileservices.createsuperfile(InsuranceHeader_Incremental.Filenames.FCRA_SF.current)),
														if( not fileservices.superfileexists(InsuranceHeader_Incremental.Filenames.FCRA_SF.father),
														fileservices.createsuperfile(InsuranceHeader_Incremental.Filenames.FCRA_SF.father)),
													if( not fileservices.superfileexists(InsuranceHeader_Incremental.Filenames.FCRA_SF.grandfather),
														fileservices.createsuperfile(InsuranceHeader_Incremental.Filenames.FCRA_SF.grandfather)));
																
	export updateSF_inc := sequential(createSF_inc,InsuranceHeader_Incremental.Superfiles.updateSF(filename,InsuranceHeader_Incremental.Filenames.FCRA_SF));


	shared fcra_hdr := IF(isIncremental,
												InsuranceHeader_Incremental.Files.FCRA_Current_DS,
												IDL_Header.files.DS_FCRA_HEADER);
												
	shared keyMod := InsuranceHeader_FCRA.Keys;

	shared sFileKeyName := keyMod.sFileKeyName;
	shared sFileFatherKeyName := keyMod.sFileFatherKeyName;
	shared fileKeyName := keyMod.keyPrefix + IF(isIncremental,version,buildDate) + '::DID';

	export key_did := INDEX(fcra_hdr, {did}, {fcra_hdr}, fileKeyName);

	export buildKey := SEQUENTIAL(BUILD(key_did,overwrite),
																FileServices.PromoteSuperFileList([sFileKeyName,sFileFatherKeyName],fileKeyName));
	
	shared fcra_unique_addr := IF(isIncremental,
																InsuranceHeader_PostProcess.CreateAddressFile_Expanded(fcra_hdr,,TRUE),
																InsuranceHeader_PostProcess.CreateAddressFile_Expanded(fcra_hdr));
																
	shared in_addr := IF(isIncremental,
											 InsuranceHeader_Incremental_Best.Files.DS_Addresses_Expanded_BASE,
											 IDL_Header.files.DS_Addresses_Expanded_BASE);
											 
	shared j_addr := JOIN(DISTRIBUTE(in_addr,did),DISTRIBUTE(fcra_unique_addr,did), 
														LEFT.did = RIGHT.did and 
														LEFT.addr_ind = RIGHT.addr_ind and 
														LEFT.prim_name = RIGHT.prim_name and 
														LEFT.prim_range = RIGHT.prim_range and 
														LEFT.sec_range = RIGHT.sec_range and 
														LEFT.city = RIGHT.city and 
														LEFT.st = RIGHT.st and 
														LEFT.zip = RIGHT.zip and 
														LEFT.predir = RIGHT.predir and 
														LEFT.postdir = RIGHT.postdir and 
														LEFT.addr_suffix = RIGHT.addr_suffix,
												TRANSFORM(recordof(right),
														SELF.best_addr_rank := LEFT.best_addr_rank;
														SELF.best_addr_ind := LEFT.best_addr_ind;
														SELF:=RIGHT),LOCAL);
	
	shared addressFileName := IF(isIncremental,
															 InsuranceHeader_Incremental_Best.Filenames(version).file_fcra_addr_unique,
															 '~thor_400::insurance_header::unique_addresses_expanded_fcra::' + version);
															 
	export fcraAddress := OUTPUT(j_addr,,addressFileName,compressed);
	
	createAddressSF := sequential(if( not fileservices.superfileexists(IDL_Header.files.FILE_FCRA_Addresses_Expanded_BASE),
														fileservices.createsuperfile(IDL_Header.files.FILE_FCRA_Addresses_Expanded_BASE)),
																if( not fileservices.superfileexists(IDL_Header.files.FILE_FCRA_Addresses_Expanded_FATHER),
														fileservices.createsuperfile(IDL_Header.files.FILE_FCRA_Addresses_Expanded_FATHER)));


	export updateAddressSF := sequential(createAddressSF,
																FileServices.PromoteSuperFileList([IDL_Header.files.FILE_FCRA_Addresses_Expanded_BASE,
																																	 IDL_Header.files.FILE_FCRA_Addresses_Expanded_FATHER], addressFileName,true));
																																	 
 	export updateAddressSF_inc := InsuranceHeader_Incremental_Best.Filenames(version).updateFCRAAddrUniqueBaseSF;
		
	export buildAddressKey := InsuranceHeader_PostProcess.address_keys.proc_build_fcra;
	
	export buildAddressKey_inc := InsuranceHeader_Incremental_Best.AddrUniqueKey(version).build_key_fcra;
	export promoteAddressKey_inc := InsuranceHeader_Incremental_Best.Filenames(version).updateFCRAAddrUniqueSF;
	
	
	//Need to create idops/orbit entries
	shared update_idops		:= dops.updateversion('IHdrFCRAKeys',trim(IF(isIncremental,version,buildDate),left,right),mod_email.emailList,,'F');
	shared update_orbit    	:= orbit.CreateBuild('FCRA IHeader','FCRA Header Build',IF(isIncremental,version,buildDate),'Production FCRA',orbit.GetToken());


	export run_fcra := SEQUENTIAL(fcraHeader,IF(isIncremental,updateSF_inc,updateSF),buildKey,fcraAddress,IF(isIncremental,SEQUENTIAL(updateAddressSF_inc,buildAddressKey_inc,promoteAddressKey_inc),SEQUENTIAL(updateAddressSF,buildAddressKey)))
																	: SUCCESS(mod_email.SendSuccessEmail(,'InsuranceHeader', , 'FCRA Header')), 
																			FAILURE(mod_email.SendFailureEmail(,'InsuranceHeader', failmessage, 'FCRA Header'));

	export run := if(_Control.ThisEnvironment.Name = 'Prod',
											sequential(run_fcra, update_idops,
															if (update_orbit[1].retcode = 'Success', 
																fileservices.sendemail(
																		'Anantha.Venkatachalam@lexisnexis.com,' + InsuranceHeader.mod_email.emailList,																		
																		'Alpharetta InsuranceHeader FCRA Header OrbitI Create Build:'+IF(isIncremental,version,buildDate)+':SUCCESS',
																		'OrbitI Create build successful: ' + IF(isIncremental,version,buildDate)),
																fileservices.sendemail(
																		'Anantha.Venkatachalam@lexisnexis.com,' + InsuranceHeader.mod_email.emailList ,																		
																		'Alpharetta InsuranceHeader FCRA Header OrbitI Create Build:'+IF(isIncremental,version,buildDate)+':FAILED',
																		'OrbitI Create build failed. Reason: ' + update_orbit[1].retdesc )
															)
													 ),
									sequential(output('Not a prod environment'))
									);


END;