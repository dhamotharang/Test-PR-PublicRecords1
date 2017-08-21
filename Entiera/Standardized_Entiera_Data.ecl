import Address,Ut,_Validate,did_add,header,header_slimsort, didville, did_add,watchdog, lib_StringLib, AID, idl_header;

rPreProcess
 :=
	record,maxlength(Constants.InFileCSVMaxLength)
		Layouts.In_Prepped;
		unsigned8									unique_id;
		unsigned6									did;
		unsigned									did_score;
		address.Layout_Clean_Name	Clean_Name;
		address.Layout_Clean182		Clean_Address;
	end
 ;

fPrepOrigNameField(string pNameInput)
 :=
  function
		string	lNameInputFiltered	:=	regexreplace('[^ a-z-]',trim(pNameInput,left,right),'',nocase);
		string	lNameInputFix_1			:=	if(regexfind('-[a-z]-',lNameInputFiltered,nocase),regexreplace('-',lNameInputFiltered,''),lNameInputFiltered);
		string	lNameInputFix_Final	:=	regexreplace('([-]{2,}|^-|-$)',lNameInputFix_1,'');
		return	lib_StringLib.StringLib.StringToUpperCase(lNameInputFix_Final);
	end
 ;

/*fFixLoginDateForDateSeen(string pDateInput)
 :=
  function
		string		lSQLDateRegEx			:=	'^([0-9]{4})-([0-9]{2})-([0-9]{2}) .*';		// '2009-04-23 14:48:05'
		string		lSQLDateRegExGet	:=	'\\1\\2\\3';
		string		lDateTimeRegEx		:=	'^([0-9]{8})/.*';													// '20090501/05:12:14'
		string		lDateTimeRegExGet	:=	'\\1';

		string8		lDateFromSQLDate	:=	regexreplace(lSQLDateRegEx,pDateInput,lSQLDateRegExGet);
		string8		lDateFromDateTime	:=	regexreplace(lDateTimeRegEx,pDateInput,lDateTimeRegExGet);

		string8		ReturnValue				:=	if(_Validate.Date.fIsValid(pDateInput),
																			 pDateInput,
																			 if(_Validate.Date.fIsValid(lDateFromSQLDate),
																					lDateFromSQLDate,
																					if(_Validate.Date.fIsValid(lDateFromDateTime),
																						 lDateFromDateTime,
																						 ''
																						)
																				 )
																			);
		return		ReturnValue;
	end
	commented-snarra
 ; */
 
fPreProcess(dataset(Layouts.In_Prepped) pRawFileInput)
 :=
	function

		rPreProcess tPreProcessPrep(pRawFileInput l)
		 :=
			transform
				self.orig_first_name	:=	fPrepOrigNameField(l.orig_first_name);
				self.orig_last_name		:=	fPrepOrigNameField(l.orig_last_name);
				self.orig_address			:=	lib_StringLib.StringLib.StringToUpperCase(trim(l.orig_address));
				self.orig_city				:=	lib_StringLib.StringLib.StringToUpperCase(trim(l.orig_city));
				self.orig_state				:=	lib_StringLib.StringLib.StringToUpperCase(trim(l.orig_state));
				self.orig_email				:=	lib_StringLib.StringLib.StringToUpperCase(trim(l.orig_email));
				self.orig_site				:=	lib_StringLib.StringLib.StringToUpperCase(trim(l.orig_site));
				self.clean_name 			:=	[];
				self.clean_address		:=	[];
				self.unique_id				:=	0;
				self.did							:=	0;
				self.did_score				:=	0;
				self									:=l;
			end
		 ;
		dPreProcessPrep	:=	project(pRawFileInput,tPreProcessPrep(left));
		// tkirk:  Not so sure I get this filter.  So, if last name is profane, doesn't matter what email or first name are?  (Confirmed by JBello, 8/14/09)
		dPreProcess			:=	dPreProcessPrep((~fn_profanity(orig_email) and ~fn_profanity(orig_first_name))
																		 or fn_profanity(orig_last_name)
																			 );
		return dPreProcess;
	end
 ;

fStandardizeName(dataset(rPreProcess) pPreProcessInput)
 :=
	function

		ut.MAC_Sequence_Records(pPreProcessInput,unique_id,dSequenced);

		dSequencedNoName		:=	dSequenced(orig_last_name = '' and orig_first_name = '');

		dSequencedHasName		:=	dSequenced(orig_last_name <> '' or orig_first_name <> '');
		dSequencedDistName	:=	distribute(dSequencedHasName,hash(orig_last_name,orig_first_name));
		dSequencedSortName	:=	sort(dSequencedDistName,orig_last_name,orig_first_name,local);
		dSequencedDedupName	:=	dedup(dSequencedSortName,orig_last_name,orig_first_name,local);

		rPreProcess tCleanedDedupName(dSequencedDedupName pInput)
		 :=
			transform
				lAssembledName 		:=	trim(pInput.orig_first_name) + ' ' + trim(pInput.orig_last_name);
				self.clean_name		:=	Address.CleanPersonFML73_fields(lAssembledName).CleanNameRecord;
				self							:=	pInput;
			end
		 ;
		dCleanedDedupName := project(dSequencedDedupName, tCleanedDedupName(left));

		rPreProcess	tPopulatedCleanNames(dSequencedDistName pFull, dCleanedDedupName pClean)
		 :=
		  transform
				self.clean_name		:=	pClean.clean_name;
				self							:=	pFull;
			end
		 ;
		dPopulatedCleanNames	:=	join(dSequencedDistName,dCleanedDedupName,
																	 left.orig_last_name = right.orig_last_name
															 and left.orig_first_name = right.orig_first_name,
																	 tPopulatedCleanNames(left,right),
																	 left outer,		// probably not required
																	 keep(1),				// probably not required
																	 local
																	);
		dStandardizedName			:=	dPopulatedCleanNames + dSequencedNoName;
																	
		return dStandardizedName;
	end
 ;

fStandardizeAddresses(dataset(rPreProcess) pStandardizeNameInput)
 :=
	function

		unsigned4		lAIDAppendFlags	:=	AID.Common.eReturnValues.RawAID 
																| 	AID.Common.eReturnValues.ACECacheRecords;
		
		AID.MacAppendFromRaw_2Line(pStandardizeNameInput, Append_Prep_Address1, Append_Prep_AddressLast, Append_RawAID, dNameAndAddressCleaned, lAIDAppendFlags);

		rPreProcess	tCleancontactAddressAppended(dNameAndAddressCleaned pInput)
		 :=
		  transform
				self.Append_RawAID			:=	pInput.AIDWork_RawAID;
				self.clean_address.zip	:=	pInput.AIDWork_ACECache.zip5;
				self.clean_address			:=	pInput.AIDWork_ACECache;
				self										:=	pInput;
			end
		 ;
		dCleancontactAddressAppended	:=	project(dNameAndAddressCleaned,tCleancontactAddressAppended(left));

		return dCleancontactAddressAppended;
	end
 ;

fRollupDuplicates(dataset(rPreProcess) pCleanContactAddressAppended)
 :=
  function
		dDistributed			:=	distribute(pCleanContactAddressAppended,hash(clean_name.lname, clean_name.fname, clean_address.zip, clean_address.prim_name));

		dSorted						:=	sort(dDistributed,clean_name.fname,
																						clean_name.lname,
																						clean_name.mname,
																						clean_address.prim_range,
																						clean_address.prim_name,
																						clean_address.sec_range,
																						clean_address.zip,
																						orig_email,
																						-append_process_date,
																						local
															)
											;
	
		rPreFinal
		 :=
		  record,maxlength(Constants.PrepFileCSVMaxLength)
				rPreProcess;
			//	string8		date_first_seen;
 		  //	string8		date_last_seen; - commented-snarra
				string8		date_vendor_first_reported;
				string8		date_vendor_last_reported;
			end
		 ;
		
		rPreFinal	tPreFinal(dSorted pInput)
		 :=
			transform
			/*	self.date_first_seen						:=	fFixLoginDateForDateSeen(pInput.orig_login_date);
				self.date_last_seen							:=	fFixLoginDateForDateSeen(pInput.orig_login_date);
				commented-snarra
			*/
				self.date_vendor_first_reported	:=	pInput.Append_Process_Date;
				self.date_vendor_last_reported	:=	pInput.Append_Process_Date;
				self														:=	pInput;
			end
		 ;
		dPreFinal	:=	project(dSorted,tPreFinal(left));

		rPreFinal  tRollupDuplicates(rPreFinal pLeft, rPreFinal pRight)
		 :=
			transform
		/*		self.date_first_seen 						:=	if(pLeft.date_first_seen <> '' and pLeft.date_first_seen < pRight.date_first_seen, 
																							 pLeft.date_first_seen,
																							 pRight.date_first_seen
																							);
				self.date_last_seen  						:=	if(pLeft.date_last_seen > pRight.date_last_seen,
																							 pLeft.date_last_seen,
																							 pRight.date_last_seen
																							);
																							commented-snarra
																							
		*/
				SELF.date_vendor_first_reported	:=	if(pLeft.date_vendor_first_reported <> '' and pLeft.date_vendor_first_reported < pRight.date_vendor_first_reported,
																							 pLeft.date_vendor_first_reported,
																							 pRight.date_vendor_first_reported
																							);
				SELF.date_vendor_last_reported	:=	if(pLeft.date_vendor_last_reported > pRight.date_vendor_last_reported,
																							 pLeft.date_vendor_last_reported,
																							 pRight.date_vendor_last_reported
																							);
				self.orig_login_date 						:=	if(pLeft.orig_login_date <> '', 	pLeft.orig_login_date,		pRight.orig_login_date);	// Should we try to get earliest for actual "orig"?
				self.orig_e360_id 							:=	if(pLeft.orig_e360_id <> '',			pLeft.orig_e360_id, 			pRight.orig_e360_id);
				self.orig_teramedia_id					:=	if(pLeft.orig_teramedia_id <> '',	pLeft.orig_teramedia_id,	pRight.orig_teramedia_id);
				
				self.orig_ip 										:=	if(pLeft.orig_ip <> '',	pLeft.orig_ip,	pRight.orig_ip);
			  self.orig_pmghousehold_id  		  := 	if(pLeft.orig_pmghousehold_id <> '',	pLeft.orig_pmghousehold_id,	pRight.orig_pmghousehold_id);
        self.orig_site 									:=	if(pLeft.orig_site <> '',	pLeft.orig_site,	pRight.orig_site);
				self														:=	pLeft;
		end;

		dRollupDuplicates	:=	rollup(dPreFinal,
																 tRollupDuplicates(left,right),
																 clean_name.fname,
																 clean_name.lname,
																 clean_name.mname,
																 clean_address.prim_range,
																 clean_address.prim_name,
																 clean_address.sec_range,
																 clean_address.zip,
																 orig_email,
																 local
																)
											;		

		return	dRollupDuplicates;
	end
 ;

dPreProcess									:=	fPreProcess(entiera.Files.In_Prepped());
dPreProcessPlusName					:=	fStandardizeName(dPreProcess) : persist('~thor::persist::entiera::cleaned_names');
dPreProcessPlusNameAddresss	:=	fStandardizeAddresses(dPreProcessPlusName) : persist('~thor::persist::entiera::cleaned_names_addresses');
dPreProcessRollupDuplicates	:=	fRollupDuplicates(dPreProcessPlusNameAddresss) : persist('~thor::persist::entiera::rolled_up_duplicates');

fAppendDID_SSN_DOB(typeof(dPreProcessRollupDuplicates) pRolledUp)
 :=
  function
		rSlimForDID
		 :=
		  record
				string20		fname;
				string20		mname;
				string20		lname;
				string10		prim_range;
				string28		prim_name;
				string5			name_suffix;
				string8			sec_range;
				string2			st;
				string5			zip;
				unsigned6 	did;
				unsigned		did_score;
				string9			best_ssn;
				unsigned4		best_dob;
				unsigned8		unique_id;
			end
		 ;
		rSlimForDID	tSlimForDID(pRolledUp pInput)
		 :=
		  transform
				self						:=	pInput.clean_name;
				self						:=	pInput.clean_address;
				self.best_ssn		:=	'';
				self.best_dob		:=	0;
				self						:=	pInput;
			end
		 ;
		dSlimForDID	:=	project(pRolledUp,tSlimForDID(left));

		//------------Apply Name Flipping Macro--------------------
		ut.mac_flipnames(dSlimForDID,fname,mname,lname,dSlimForDIDNameFlipped);

		matchset		:=	['A','Z'];
		did_add.MAC_Match_Flex(dSlimForDIDNameFlipped, matchset,					
													 '', '', fname, mname, lname, name_suffix, 
													 prim_range, prim_name, sec_range, zip, st,'', 
													 did, rSlimForDID, true, did_score,
													 75, dSlimPostDID
													);

		dSlimPostDID_With			:=	dSlimPostDID(did <> 0);
		dSlimPostDID_Without	:=	dSlimPostDID(did = 0);
		
		DID_Add.MAC_Add_SSN_By_DID(dSlimPostDID_With, did, best_ssn, dSlimPostDID_SSN);

		rSlimForDID tAppendBestDOB(rSlimForDID pSlimDID, recordof(watchdog.File_Best) pBest)
		 :=
			transform
				self.best_dob :=	pBest.dob;
				self 					:=	pSlimDID;
			end
		 ;
		dSlimPostDID_SSN_DOB	:=	join(dSlimPostDID_SSN, Watchdog.File_Best,
																	 left.did = right.did,
																	 tAppendBestDOB(left,right),
																	 left outer,
																	 local
																	);	// Already distributed from previous SSN append

		dSlimPostDIDComplete	:=	dSlimPostDID_SSN_DOB + dSlimPostDID_Without;

		Layouts.Base	tAppendDID_SSN_DOB(pRolledUp pBase, dSlimPostDIDComplete pDIDSSNDOB)
		 :=
		  transform
				self.did						:=	pDIDSSNDOB.did;
				self.did_score			:=	pDIDSSNDOB.did_score;
				self.best_ssn				:=	pDIDSSNDOB.best_ssn;
				self.best_dob				:=	pDIDSSNDOB.best_dob;
				self.process_date		:=	'';
				self.date_first_seen  := '';	
				self.date_last_seen  	:= '';
				self.ln_login_date	:=	'';
				self								:=	pBase;
			end
		 ;
		dAppendDID_SSN_DOB	:=	join(pRolledUp, dSlimPostDIDComplete,
																 left.unique_id = right.unique_id,
																 tAppendDID_SSN_DOB(left,right),
																 left outer
																);
																
		//orig_login_date formatted to CCYYMMDD (Bug# 51741)											
		Layouts.Base	tformatOrig_login_date(dAppendDID_SSN_DOB pInput)
			:=
				TRANSFORM
					self.ln_login_date		:=	MAP(
																			REGEXFIND('(([0-1])?[0-9])/(([0-3])?[0-9])/((19|20)[0-9]{2})', TRIM(pInput.orig_login_date)) => REGEXFIND('(([0-1])?[0-9])/(([0-3])?[0-9])/((19|20)[0-9]{2})', TRIM(pInput.orig_login_date), 3)
																								+(string2)INTFORMAT((unsigned1)REGEXFIND('(([0-1])?[0-9])/(([0-3])?[0-9])/((19|20)[0-9]{2})', TRIM(pInput.orig_login_date), 2), 2, 1)
																								+(string2)INTFORMAT((unsigned1)REGEXFIND('(([0-1])?[0-9])/(([0-3])?[0-9])/((19|20)[0-9]{2})', TRIM(pInput.orig_login_date), 1), 2, 1),
																			REGEXFIND('^(19|20)[0-9][0-9](0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])$', TRIM(pInput.orig_login_date)[1..8]) =>	TRIM(pInput.orig_login_date)[1..8],
																		'');
					self									:=	pInput;
		END;

		dAppendDID_SSN_DOB_ln_login_date	:=	PROJECT(dAppendDID_SSN_DOB, tformatOrig_login_date(left));
																
		return	dAppendDID_SSN_DOB_ln_login_date;
	end
 ;

dToFinalLayout	:=	fAppendDID_SSN_DOB(dPreProcessRollupDuplicates);

export Standardized_Entiera_Data := dToFinalLayout	:	persist('~thor::persist::entiera::standardized_entiera_data');
