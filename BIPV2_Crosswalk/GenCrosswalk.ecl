import BIPV2;
import PAW;
import BIPV2_Build;

export GenCrosswalk( 
                    string  pVersion    = BIPV2.KeySuffix
			    ,boolean promoteToQA = false) := function
			    
     outputFileName := Files(trim(pVersion),false).FILE_LOGICAL;
     b2cKeyName     := Keys(trim(pVersion),false).KEY_LOGICAL_B2C;
     c2bKeyName     := Keys(trim(pVersion),false).KEY_LOGICAL_C2B;
	
     contactKeyDs   := distribute(pull(BIPV2_Build.key_contact_linkids.keybuilt), hash32(seleid));
     // contactSources := set(dedup(contactKeyDs, source, all, hash), source);

     bipBase        := BIPV2.CommonBase.DS_Built;
	bipDates       := dedup(project(bipBase(dt_first_seen>0 and dt_last_seen>0), Layouts.DateWorkRec), ultid, orgid, seleid, dt_first_seen, dt_last_seen, all, hash);

	bipContacts    := bipBase(empId>0 or contact_did>0 and lname!='');
     // bipSources     := set(dedup(bipContacts, source, all, hash), source);

	pawContacts    := PAW.Key_LinkIDs.Key(seleid>0 and lname!='' and from_hdr='N');
	// pawSources     := set(dedup(pawContacts, source, all, hash), source);
	
	poeContacts    := PoeAppend([]);

     currentDate    := (integer) thorlib.wuid()[2..9];
     TwoYearsAgo    := currentDate - 20000;
     SevenYearsAgo  := currentDate - 70000;

     /*******Put All Datasets in a Common format*******************/
	contactKeyRecs := project(contactKeyDs(contact_name.lname!=''), 
	                           transform(Layouts.CrossWalkWorkRec1,
							       self                             := left.contact_name,
								  self                             := left.company_address,
								  self.jobTitleOrder               := map(left.dt_last_seen > TwoYearsAgo   => 1,
								                                          left.dt_last_seen > SevenYearsAgo => 2,
																  3);								  
								  self.job_title                   := if(left.executive_ind_order > 0, left.contact_job_title_derived, ''),
								  self.sourceGroup                 := 'CONTACT_KEYS',
								  self.dt_first_seen_at_business   := left.dt_first_seen_contact;
								  self.dt_last_seen_at_business    := left.dt_last_seen_contact;
								  self.dt_first_seen               := if(left.company_incorporation_date > 0, left.company_incorporation_date, left.dt_first_seen),
                                          self                             := left
								  ));

	bipRecs := project(bipContacts(lname!=''), 
	                   transform(Layouts.CrossWalkWorkRec1,
				              self.job_title                     := '',
				              self.executive_ind_order           := 0,
				              self.jobTitleOrder                 := 0,
					         self.sourceGroup                   := 'BIP',
						    self.dt_first_seen_at_business     := left.dt_first_seen_contact;
						    self.dt_last_seen_at_business      := left.dt_last_seen_contact;
						    self.dt_first_seen                 := if(left.company_incorporation_date > 0, left.company_incorporation_date, left.dt_first_seen),
						    self                               := left,
					));
																   
																   
	pawRecs := project(pawContacts(lname!=''), 
	                   transform(Layouts.CrossWalkWorkRec1,
						    self.contact_did               := left.did,
						    self.job_title                 := '',
						    self.contact_email             := left.email_address,
						    self.contact_phone             := left.phone,
						    self.v_city_name               := left.city,
						    self.st                        := left.state,
						    self.executive_ind_order       := 0,
						    self.jobTitleOrder             := 0,
						    self.dt_first_seen             := (integer) left.dt_first_seen,
						    self.dt_last_seen              := (integer) left.dt_last_seen,
						    self.dt_first_seen_at_business := (integer) left.dt_first_seen,
						    self.dt_last_seen_at_business  := (integer) left.dt_last_seen,
						    self.contact_ssn               := '',
						    self.contact_dob               := 0,
						    self.vl_id                     := '',
						    self.sourceGroup               := 'PAW',
						    self                           := left
				    ));	

								   
	poeRecs := project(poeContacts(subject_name.lname!=''), 
	                    transform(Layouts.CrossWalkWorkRec1,
				               self.contact_did               := left.did,
						     self.job_title                 := '',
						     self.contact_email             := '',
						     self.vl_id                     := '',
						     self.contact_phone             := (string) left.subject_phone,
							self.contact_ssn               := (string) left.subject_ssn,
							self.contact_dob               := left.subject_dob,
						     self.v_city_name               := left.subject_address.city_name,
						     self.executive_ind_order       := 0,
							self.jobTitleOrder             := 0,
						     self.dt_first_seen             := (integer) left.dt_first_seen,
						     self.dt_last_seen              := (integer) left.dt_last_seen,
						     self.dt_first_seen_at_business := (integer) left.dt_first_seen,
						     self.dt_last_seen_at_business  := (integer) left.dt_last_seen,
						     self.sourceGroup               := 'POE',
							self                           := left.subject_name;
						     self                           := left.subject_address,
						     self                           := left,
				    ));										

     /*******Combine All Inputs into one dataset*******************/
     combineRecs   := contactKeyRecs + bipRecs + pawRecs + poeRecs;
	
	/**
	 Break up into the 3 categories:
	      1. Contacts That have dids.
		 2. Contacts that have EmpIDs but not DIDS
		 3. Contacts that have No IDs
	**/
	recsWithLexID := combineRecs(contact_did > 0);
	recsWithEmpID := combineRecs(contact_did = 0 and empId>0);
	recsWithNoID  := dedup(combineRecs(contact_did = 0 and empId=0)
	                      ,ultid,orgid,seleid,proxid
	                      ,title,fname,mname,lname,name_suffix, contact_ssn, contact_dob
					  ,contact_email, contact_phone, prim_range, predir, prim_name
					  ,addr_suffix, postdir, unit_desig,sec_range,v_city_name
					  ,st,zip,zip4,source, all,hash);


      /**
	      Find the business start/end date by SeleID
	 **/
      groupDates              := group(sort(distribute(bipDates, hash32(seleid)), ultid, orgid, seleid, local), ultid, orgid, seleid, local);
      rollDates               := ungroup(rollup(groupDates,
	                                    true,
	                                    transform(Layouts.DateWorkRec,
								           self.dt_first_seen := if(left.dt_first_seen<right.dt_first_seen,
										                          left.dt_first_seen,
															 right.dt_first_seen),
								           self.dt_last_seen  := if(left.dt_last_seen>right.dt_last_seen,
										                          left.dt_last_seen,
															 right.dt_last_seen),				                           
										 self               := left,
										 self               := [])));

      /**
	     Rollup Contact Info at the proxid/source/sourceGroup Level. This will allow for filtering at search time for:
		 1. entitlements
		 2. source
		 3. sourceGroup (BIP, Contacts Key, POE, PAW)
		 
		 Also no need to provide PII for contacts with DID - they will be provided using LexID Best Service
	 **/
	 lexIDContactInfoRec     := project(dedup(recsWithLexID, ultid,orgid,seleid,proxid,contact_did,source,sourceGroup,all,hash),
	                                    transform(Layouts.BipToConsumerCrossWalkRec,
								           permits               := BIPV2.mod_sources.src2bmap(left.source, left.vl_id);
						                     self.contactNames     := dataset([{'','','','','',left.sourceGroup,left.source,permits,left.dt_first_seen_at_business,left.dt_last_seen_at_business}],Layouts.ContactNameRec),
						                     self.contactSSNs      := dataset([{'',left.sourceGroup,left.source,permits}],Layouts.ContactSSNRec),
						                     self.contactDOBs      := dataset([{0,left.sourceGroup,left.source,permits}],Layouts.ContactDOBRec),
						                     self.contactEmails    := dataset([{'',left.sourceGroup,left.source,permits}],Layouts.ContactEmailRec),
						                     self.contactPhones    := dataset([{'',left.sourceGroup,left.source,permits}],Layouts.ContactPhoneRec),
						                     self.contactAddresses := dataset([{'','','','','','','','','','','',left.sourceGroup,left.source,permits}],Layouts.ContactAddressRec),
						                     self.jobTitles        := dataset([],Layouts.JobTitleRec),
										 self.global_sid       := 0,
										 self.record_sid       := 0,
										 self                  := left));
										
	 finalNoIDRecs          := project(recsWithNoID,
	                                    transform(Layouts.BipToConsumerCrossWalkRec,
								           permits               := BIPV2.mod_sources.src2bmap(left.source, left.vl_id);
						                     self.contactNames     := dataset([{left.title,left.fname,left.mname,left.lname,left.name_suffix,left.sourceGroup,left.source,permits,left.dt_first_seen_at_business,left.dt_last_seen_at_business}],Layouts.ContactNameRec),
						                     self.contactSSNs      := dataset([{left.contact_ssn,left.sourceGroup,left.source,permits}],Layouts.ContactSSNRec),
						                     self.contactDOBs      := dataset([{0,left.sourceGroup,left.source,permits}],Layouts.ContactDOBRec),
						                     self.contactEmails    := dataset([{left.contact_email,left.sourceGroup,left.source,permits}],Layouts.ContactEmailRec),
						                     self.contactPhones    := dataset([{left.contact_phone,left.sourceGroup,left.source,permits}],Layouts.ContactPhoneRec),
						                     self.contactAddresses := dataset([{left.prim_range,left.predir,left.prim_name,left.addr_suffix,left.postdir,left.unit_desig,left.sec_range,left.v_city_name,left.st,left.zip,left.zip4,left.sourceGroup,left.source,permits}],Layouts.ContactAddressRec),
						                     self.jobTitles        := dataset([],Layouts.JobTitleRec),
										 self.global_sid       := 0,
										 self.record_sid       := 0,
										 self                  := left));

      /**
	     Rollup Contact Info at the proxid/source/sourceGroup Level. This will allow for filtering at search time for:
		 1. entitlemetns
		 2. source
		 3. sourceGroup (BIP, Contacts Key, POE, PAW)
		 
		 Since we want to ensure that we piece all of the information together each piece of PII will be maintained in a child dataset
		 for EmpID.
		 
	 **/
      empIDNamesRec           := project(dedup(recsWithEmpID,ultid,orgid,seleid,proxid,empid,source,sourceGroup,all,hash),
	                                    transform(Layouts.BipToConsumerCrossWalkRec,
								           permits               := BIPV2.mod_sources.src2bmap(left.source, left.vl_id);
						                     self.contactNames     := dataset([{left.title,left.fname,left.mname,left.lname,left.name_suffix,left.sourceGroup,left.source,permits,left.dt_first_seen_at_business,left.dt_last_seen_at_business}],Layouts.ContactNameRec),
										 self                  := left,
										 self                  := []));	                                   
  
      empIDSSNRec            := project(dedup(recsWithEmpID(contact_ssn!=''),ultid,orgid,seleid,proxid,empid,source,sourceGroup,all,hash),
	                                    transform(Layouts.BipToConsumerCrossWalkRec,
								           permits               := BIPV2.mod_sources.src2bmap(left.source, left.vl_id);
						                     self.contactSSNs      := dataset([{left.contact_ssn,left.sourceGroup,left.source,permits}],Layouts.ContactSSNRec),
										 self                  := left,
										 self                  := []));	   
										 
      empIDDOBRec           := project(dedup(recsWithEmpID(contact_dob!=0),ultid,orgid,seleid,proxid,empid,source,sourceGroup,all,hash),
	                                    transform(Layouts.BipToConsumerCrossWalkRec,
								 		 permits               := BIPV2.mod_sources.src2bmap(left.source, left.vl_id);
								           self.contactDOBs      := dataset([{left.contact_dob,left.sourceGroup,left.source,permits}],Layouts.ContactDOBRec),
										 self                  := left,
										 self                  := []));
										 
      empIDEmailRec         := project(dedup(recsWithEmpID(contact_email!=''),ultid,orgid,seleid,proxid,empid,source,sourceGroup,all,hash),
	                                    transform(Layouts.BipToConsumerCrossWalkRec,
								           permits               := BIPV2.mod_sources.src2bmap(left.source, left.vl_id);
						                     self.contactEmails    := dataset([{left.contact_email,left.sourceGroup,left.source,permits}],Layouts.ContactEmailRec),
										 self                  := left,
										 self                  := []));	      
										 
      empIDPhoneRec         := project(dedup(recsWithEmpID(contact_phone!=''),ultid,orgid,seleid,proxid,empid,source,sourceGroup,all,hash),
	                                    transform(Layouts.BipToConsumerCrossWalkRec,
								           permits               := BIPV2.mod_sources.src2bmap(left.source, left.vl_id);
						                     self.contactPhones    := dataset([{left.contact_phone,left.sourceGroup,left.source,permits}],Layouts.ContactPhoneRec),
										 self                  := left,
										 self                  := []));                                   

      empIDAddressRec       := project(dedup(recsWithEmpID(zip!=''),ultid,orgid,seleid,proxid,empid,source,sourceGroup,all,hash),
	                                    transform(Layouts.BipToConsumerCrossWalkRec,
								           permits               := BIPV2.mod_sources.src2bmap(left.source, left.vl_id);
						                     self.contactAddresses := dataset([{left.prim_range,left.predir,left.prim_name,left.addr_suffix,left.postdir,left.unit_desig,left.sec_range,left.v_city_name,left.st,left.zip,left.zip4,left.sourceGroup,left.source,permits}],Layouts.ContactAddressRec),
										 self                  := left,
										 self                  := []));	                                   

      /****
	    Add all Child Datasets into one dataset and rollup bpased on empid.
	    No need to maintain source/sourceGroup info at this level as it is maintained in the child datasets.
	 ****/
	 empIdCombined           := empIDNamesRec + empIDSSNRec + empIDDOBRec + empIDEmailRec + empIDPhoneRec + empIDAddressRec;
	 
	 groupEmpId              := group(sort(distribute(empIdCombined, hash32(empId)),ultid,orgid,seleid,proxid,empid,local),ultid,orgid,seleid,proxid,empid,local);
	 
	 rollupEmpId             := rollup(groupEmpId, true,
	                                   transform(Layouts.BipToConsumerCrossWalkRec,
								          self.contactNames     := left.contactNames + right.contactNames,
								          self.contactSSNs      := left.contactSSNs + right.contactSSNs,
								          self.contactPhones    := left.contactPhones + right.contactPhones,
								          self.contactDOBs      := left.contactDOBs + right.contactDOBs,
								          self.contactEmails    := left.contactEmails + right.contactEmails,
								          self.contactAddresses := left.contactAddresses + right.contactAddresses ,
										self                  := left));
	

       /**
	      Rollup Job Titles at the SeleID level. This will allow an individual that is found at a ProxID level to maintain
		 all job titles regardless of which location the job title was associatd with the contact.
	  **/
	  dedupLexIDJobTitleRecs    := dedup(recsWithLexID(job_title!=''),ultid,orgid,seleid,contact_did,job_title,source,sourceGroup,all,hash);
	  sortLexIDJobTitleRecs     := sort(distribute(dedupLexIDJobTitleRecs, hash32(contact_did)), ultid,orgid,seleid,contact_did,jobTitleOrder,executive_ind_order,-dt_last_seen,local);
			
	  createJobTitles           := project(sortLexIDJobTitleRecs,
								    transform(Layouts.CrossWalkWorkRec2,
								              permits        := BIPV2.mod_sources.src2bmap(left.source, left.vl_id);
								              self.jobTitles := dataset([{left.job_title,left.executive_ind_order,left.sourceGroup, left.source,permits }],Layouts.JobTitleRec),
										    self           := left));
	
	  rollJobTitles             := rollup(createJobTitles,
	                                      left.ultid=right.ultid and left.orgid=right.orgid and left.seleid=right.seleid and left.contact_did=right.contact_did,
								   transform(Layouts.CrossWalkWorkRec2,
								             self.jobTitles := left.jobTitles + right.jobTitles,
								             self           := left));
 
 	  dedupEmpIDJobTitleRecs    := dedup(recsWithEmpID(job_title!=''),ultid,orgid,seleid,empid,job_title,source,sourceGroup,all,hash);
	  sortEmpIDJobTitleRecs     := sort(distribute(dedupEmpIDJobTitleRecs, hash32(empid)), ultid,orgid,seleid,empid,jobTitleOrder,executive_ind_order,-dt_last_seen,local);
			
	  createEmpJobTitles        := project(sortEmpIDJobTitleRecs,
								    transform(Layouts.CrossWalkWorkRec2,
								              permits        := BIPV2.mod_sources.src2bmap(left.source, left.vl_id);
								              self.jobTitles := dataset([{left.job_title,left.executive_ind_order,left.sourceGroup, left.source,permits }],Layouts.JobTitleRec),
										    self           := left));
	
	  rollEmpJobTitles          := rollup(createEmpJobTitles,
	                                      left.ultid=right.ultid and left.orgid=right.orgid and left.seleid=right.seleid and left.empid=right.empid,
								   transform(Layouts.CrossWalkWorkRec2,
								             self.jobTitles := left.jobTitles + right.jobTitles,
								             self           := left));
										   

	  combinedEmpIDRecs         := ungroup(rollupEmpId);
	  

       /**
	    Add Job Titles
	  **/
 	  addJobTitleEmpIds         := join(combinedEmpIDRecs, rollEmpJobTitles,
	                                    left.ultid=right.ultid and
								 left.orgid=right.orgid and
								 left.seleid=right.seleid and
								 left.empid=right.empid,
								 transform(Layouts.BipToConsumerCrossWalkRec,
								           self.jobTitles := right.jobTitles,
										 self           := left), left outer, hash);

	  addJobTitleLexIds         := join(lexIDContactInfoRec, rollJobTitles,
	                                    left.ultid=right.ultid and
								 left.orgid=right.orgid and
								 left.seleid=right.seleid and
								 left.contact_did=right.contact_did,
								 transform(Layouts.BipToConsumerCrossWalkRec,
								           self.jobTitles := right.jobTitles,
										 self           := left), left outer, hash);
										 
       /**
	    Recombine the Contacts with LexIDs, EmpIDs, and noIDs and add business dates.
	  **/
	  combinedRecs            := addJobTitleEmpIds + finalNoIDRecs + addJobTitleLexIds;
	 
	  addDates                := join(combinedRecs, rollDates,
	                                  left.ultid = right.ultid and
							    left.orgid = right.orgid and 
	                                  left.seleid = right.seleid,
							    transform(Layouts.CrossWalkRec,
							              self.dt_first_seen := right.dt_first_seen,
							              self.dt_last_seen  := right.dt_last_seen,
									    self := left), left outer, hash);

      /**
	  Transform To Final Layout
	 */
	 bip2ConsumerKey := project(addDates,transform(Layouts.BipToConsumerCrossWalkRec, self := left, self.global_sid := 0, self.record_sid := 0));
	 consumer2BipKey := project(addDates(contact_did>0),transform(Layouts.ConsumerToBipCrossWalkRec, self := left, self.global_sid := 0, self.record_sid := 0));
	 
      /**
	 Build the indexes and update the super files
	 **/
	 buildFiles := parallel(
          output(addDates,,outputFileName,overwrite,compressed) 
         ,buildindex(Keys(trim(pVersion),false).BipToConsumerKey(b2cKeyName,bip2ConsumerKey))
         ,buildindex(Keys(trim(pVersion),false).ConsumerToBipKey(c2bKeyName,consumer2BipKey))
	 );
	
      go := sequential(
	     buildFiles
	    ,Promote(pVersion).new2built
	    ,if(promoteToQA,Promote(pVersion).built2QA)
      );
	
      return go;
	 
end;