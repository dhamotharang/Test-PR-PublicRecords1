import Address,Ut,_Validate, did_add, didville, did_add,watchdog, AID, AID_Support, STD, NID, Data_Services;

// #CONSTANT(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);
// #STORED('did_add_force','thor');

rPreProcess	:=	RECORD,MAXLENGTH(Constants.InFileCSVMaxLength)
		Layouts.Base;
		unsigned8									unique_id;
	END;

fPrepOrigNameField(string pNameInput)
 :=
  function
		string	lNameInputFiltered	:=	regexreplace('[^ a-z-]',trim(pNameInput,left,right),'',nocase);
		string	lNameInputFix_1			:=	if(regexfind('-[a-z]-',lNameInputFiltered,nocase),regexreplace('-',lNameInputFiltered,''),lNameInputFiltered);
		string	lNameInputFix_Final	:=	regexreplace('([-]{2,}|^-|-$)',lNameInputFix_1,'');
		return	STD.Str.ToUpperCase(lNameInputFix_Final);
	end
 ;
 
fPreProcess(dataset(Layouts.In_Prepped) pRawFileInput) := FUNCTION

		rPreProcess tPreProcessPrep(pRawFileInput l) := TRANSFORM
				self.orig_first_name	:=	fPrepOrigNameField(l.orig_first_name);
				self.orig_last_name		:=	fPrepOrigNameField(l.orig_last_name);
				self.orig_address			:=	STD.Str.ToUpperCase(trim(l.orig_address));
				self.orig_city				:=	STD.Str.ToUpperCase(trim(l.orig_city));
				self.orig_state				:=	STD.Str.ToUpperCase(trim(l.orig_state));
				self.orig_email				:=	STD.Str.ToUpperCase(trim(l.orig_email));
				self.orig_site				:=	STD.Str.ToUpperCase(trim(l.orig_site));
				SELF.process_date			:= 	l.append_process_date;
				SELF.date_vendor_first_reported	:=	l.Append_Process_Date;
				SELF.date_vendor_last_reported	:=	l.Append_Process_Date;
				SELF.current_rec			:= TRUE;
				// self.clean_name 			:=	[];
				// self.clean_address		:=	[];
				self.unique_id				:=	0;
				self.did							:=	0;
				self.did_score				:=	0;
				self									:=	l;
				self									:= [];
			end
		 ;
		dPreProcessPrep	:=	PROJECT(pRawFileInput,tPreProcessPrep(left));
		// tkirk:  Not so sure I get this filter.  So, if last name is profane, doesn't matter what email or first name are?  (Confirmed by JBello, 8/14/09)
		dPreProcess			:=	dPreProcessPrep((~fn_profanity(orig_email) and ~fn_profanity(orig_first_name))
																		 or fn_profanity(orig_last_name)
																			 );
		RETURN dPreProcess;
	END;
	
	dPreProcess			:=	fPreProcess(entiera.Files.In_Prepped(Data_Services.foreign_prod + 'thor_200::in::entiera::20180528::email_addresses'));

	//Send names to cleaner
	NID.Mac_CleanParsedNames(dPreProcess, FileClnName, 
													firstname:=orig_first_name, lastname:=orig_last_name, middlename := clean_name.mname, namesuffix := clean_name.name_suffix
													,includeInRepository:=false, normalizeDualNames:=false, useV2 := true);
	
	//Name flags
	person_flags := ['P', 'D'];
	business_flags := ['B'];
	InvName_flags	:= ['I']; //Invalid Name
	
	ClnName	:= PROJECT(FileClnName, TRANSFORM(rPreProcess,
																						BOOLEAN IsName	:=	LEFT.nametype IN person_flags OR
																																(LEFT.nametype = 'U' AND trim(LEFT.cln_fname) != '' AND TRIM(LEFT.cln_lname) != '');
																						SELF.clean_name.title				:=	IF(IsName, LEFT.cln_title, '');
																						SELF.clean_name.fname				:=	IF(IsName, LEFT.cln_fname, LEFT.orig_first_name);
																						SELF.clean_name.mname				:=	IF(IsName, LEFT.cln_mname, '');
																						SELF.clean_name.lname				:=	IF(IsName, LEFT.cln_lname, LEFT.orig_last_name);
																						SELF.clean_name.name_suffix	:=	IF(IsName, LEFT.cln_suffix, '');
																						SELF := LEFT));

		//AID process
	unsigned4 lAIDFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

	rPreProcess tProjectAIDClean_prep(rPreProcess pInput) := TRANSFORM
		SELF.Append_Prep_Address1			:=	Address.fn_addr_clean_prep(pInput.orig_address, 'first');
		SELF.Append_Prep_AddressLast	:=	Address.fn_addr_clean_prep(pInput.orig_city
																							+	IF(pInput.orig_city <> '',', ','') + pInput.orig_state
																							+	' ' + TRIM(pInput.orig_zip)+TRIM(pInput.orig_zip4), 'last');
		SELF := pInput;
	END;

	rsAIDCleanName	:= PROJECT(ClnName ,tProjectAIDClean_prep(LEFT)) : persist('~thor::persist::entiera::cleaned_names');
	
	rsAID_NoAddr		:=	rsAIDCleanName(TRIM(Append_Prep_Address1) = '' OR TRIM(orig_city) = '' OR TRIM(orig_state) = '' OR TRIM(orig_zip) = '');
	rsAID_Addr			:=	rsAIDCleanName(TRIM(Append_Prep_Address1) != '' AND TRIM(orig_city) != '' AND TRIM(orig_state) != '' AND TRIM(orig_zip) != '');
	
	AID.MacAppendFromRaw_2Line(rsAID_Addr,Append_Prep_Address1, Append_Prep_AddressLast, Append_RawAID, rsCleanAID, lAIDFlags);
																											
	rPreProcess tProjectClean(rsCleanAID pInput) := TRANSFORM
	  SELF.Clean_Address.prim_range   := pInput.aidwork_acecache.prim_range;
    SELF.Clean_Address.predir       := pInput.aidwork_acecache.predir;
    SELF.Clean_Address.prim_name    := pInput.aidwork_acecache.prim_name;
    SELF.Clean_Address.addr_suffix  := pInput.aidwork_acecache.addr_suffix;
    SELF.Clean_Address.postdir      := pInput.aidwork_acecache.postdir;
    SELF.Clean_Address.unit_desig   := pInput.aidwork_acecache.unit_desig;
    SELF.Clean_Address.sec_range    := pInput.aidwork_acecache.sec_range;
    SELF.Clean_Address.p_city_name  := pInput.aidwork_acecache.p_city_name;
    SELF.Clean_Address.v_city_name  := pInput.aidwork_acecache.v_city_name;
    SELF.Clean_Address.st           := pInput.aidwork_acecache.st;
    SELF.Clean_Address.zip          := pInput.aidwork_acecache.zip5;
    SELF.Clean_Address.zip4         := pInput.aidwork_acecache.zip4;
    SELF.Clean_Address.cart         := pInput.aidwork_acecache.cart;
    SELF.Clean_Address.cr_sort_sz   := pInput.aidwork_acecache.cr_sort_sz;
    SELF.Clean_Address.lot          := pInput.aidwork_acecache.lot;
    SELF.Clean_Address.lot_order    := pInput.aidwork_acecache.lot_order;
    SELF.Clean_Address.dbpc         := pInput.aidwork_acecache.dbpc;
    SELF.Clean_Address.chk_digit    := pInput.aidwork_acecache.chk_digit;
    SELF.Clean_Address.rec_type     := pInput.aidwork_acecache.rec_type;
    SELF.Clean_Address.county       := pInput.aidwork_acecache.county;
    SELF.Clean_Address.geo_lat      := pInput.aidwork_acecache.geo_lat;
    SELF.Clean_Address.geo_long     := pInput.aidwork_acecache.geo_long;
    SELF.Clean_Address.msa          := pInput.aidwork_acecache.msa;
    SELF.Clean_Address.geo_blk      := pInput.aidwork_acecache.geo_blk;
    SELF.Clean_Address.geo_match    := pInput.aidwork_acecache.geo_match;
    SELF.Clean_Address.err_stat     := pInput.aidwork_acecache.err_stat;
    SELF.Append_RawAID        			:= pInput.aidwork_rawaid;
    SELF  													:= pInput;
		SELF														:=	[];
	END;

	rPreProcess tProjectNoAddrClean(rsAID_NoAddr pInput) := TRANSFORM
		cl_addr			:= Address.CleanAddress182(TRIM(pInput.orig_address), TRIM(pInput.orig_city) + ' ' + TRIM(pInput.orig_state) + ' ' + TRIM(pInput.orig_zip));
		SELF.Clean_Address.prim_range  	:=  cl_addr[1..10];
		SELF.Clean_Address.predir  			:=  cl_addr[11..12];
		SELF.Clean_Address.prim_name  	:=  cl_addr[13..40];
		SELF.Clean_Address.addr_suffix  :=  cl_addr[41..44];
		SELF.Clean_Address.postdir  		:=  cl_addr[45..46];
		SELF.Clean_Address.unit_desig  	:=  cl_addr[47..56];
		SELF.Clean_Address.sec_range  	:=  cl_addr[57..64];
		SELF.Clean_Address.p_city_name  :=  cl_addr[65..89];
		SELF.Clean_Address.v_city_name  :=  cl_addr[90..114];
		SELF.Clean_Address.st  					:=  cl_addr[115..116];
		SELF.Clean_Address.zip  				:=  cl_addr[117..121];
		SELF.Clean_Address.zip4  				:=  cl_addr[122..125];
		SELF.Clean_Address.cart  				:=  cl_addr[126..129];
		SELF.Clean_Address.cr_sort_sz  	:=  cl_addr[130];
		SELF.Clean_Address.lot  				:=  cl_addr[131..134];
		SELF.Clean_Address.lot_order  	:=  cl_addr[135];
		SELF.Clean_Address.dbpc  				:=  cl_addr[136..137];
		SELF.Clean_Address.chk_digit  	:=  cl_addr[138];
		SELF.Clean_Address.rec_type  		:=  cl_addr[139..140];
		SELF.Clean_Address.county  			:=  cl_addr[141..145];
		SELF.Clean_Address.geo_lat  		:=  cl_addr[146..155];
		SELF.Clean_Address.geo_long  		:=  cl_addr[156..166];
		SELF.Clean_Address.msa  				:=  cl_addr[167..170];
		SELF.Clean_Address.geo_blk  		:=  cl_addr[171..177];
		SELF.Clean_Address.geo_match  	:=  cl_addr[178];
		SELF.Clean_Address.err_stat  		:=  cl_addr[179..182];
	  SELF  													:= 	pInput;
		SELF														:=	[];
	END;	
	
	rsCleanAIDGoodAddr		:= PROJECT(rsCleanAID, tProjectClean(LEFT));
	rsCleanAIDGoodNoAddr	:= PROJECT(rsAID_NoAddr, tProjectNoAddrClean(LEFT));
	
	rsCleanAIDGood	:=	rsCleanAIDGoodAddr + rsCleanAIDGoodNoAddr : persist('~thor::persist::entiera::cleaned_names_addresses');

	//Set Base current_rec = false. Only records in recent file are current
	ResetBase		:= PROJECT(Entiera.Files.Base, TRANSFORM(rPreProcess, SELF.unique_id := 0; SELF.current_rec := false; SELF := LEFT));
	BasePlusIn	:=	rsCleanAIDGood + ResetBase;
	
	ut.MAC_Sequence_Records(BasePlusIn,unique_id,dSequenced);
	
	dDistributed		:=	DISTRIBUTE(dSequenced,HASH(clean_name.lname, clean_name.fname, clean_address.zip, clean_address.prim_name));

	dSorted					:=	SORT(dDistributed,clean_name.fname,
																				clean_name.lname,
																				clean_name.mname,
																				clean_address.prim_range,
																				clean_address.prim_name,
																				clean_address.sec_range,
																				clean_address.zip,
																				orig_email,
																				-process_date,
																				LOCAL
															);
	
		// rPreFinal
		 // :=
		  // record,maxlength(Constants.PrepFileCSVMaxLength)
				// rPreProcess;
				// string8		date_first_seen;
 		  	// string8		date_last_seen; - commented-snarra
				// string8		date_vendor_first_reported;
				// string8		date_vendor_last_reported;
			// end
		 // ;
		
		// rPreFinal	tPreFinal(dSorted pInput)
		 // :=
			// transform
			// /*	self.date_first_seen						:=	fFixLoginDateForDateSeen(pInput.orig_login_date);
				// self.date_last_seen							:=	fFixLoginDateForDateSeen(pInput.orig_login_date);
				// commented-snarra
			// */
				// self.date_vendor_first_reported	:=	pInput.Append_Process_Date;
				// self.date_vendor_last_reported	:=	pInput.Append_Process_Date;
				// self														:=	pInput;
			// end
		 // ;
		// dPreFinal	:=	project(dSorted,tPreFinal(left));

		rPreProcess  tRollupDuplicates(dSorted pLeft, dSorted pRight)	:=	TRANSFORM
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
				SELF.Process_Date    						:=	IF(pLeft.Process_Date > pRight.Process_Date, pLeft.Process_Date, pRight.Process_Date);
				SELF.Date_Vendor_First_Reported :=	IF(pLeft.Date_Vendor_First_Reported > pRight.Date_Vendor_First_Reported, pRight.Date_Vendor_First_Reported, pLeft.Date_Vendor_First_Reported);
				SELF.Date_Vendor_Last_Reported  :=	IF(pLeft.Date_Vendor_Last_Reported  < pRight.Date_Vendor_Last_Reported,  pRight.Date_Vendor_Last_Reported, pLeft.Date_Vendor_Last_Reported);
				SELF.orig_login_date 						:=	IF(pLeft.orig_login_date <> '', 	pLeft.orig_login_date,		pRight.orig_login_date);	// Should we try to get earliest for actual "orig"?
				SELF.orig_e360_id 							:=	IF(pLeft.orig_e360_id <> '',			pLeft.orig_e360_id, 			pRight.orig_e360_id);
				SELF.orig_teramedia_id					:=	IF(pLeft.orig_teramedia_id <> '',	pLeft.orig_teramedia_id,	pRight.orig_teramedia_id);
				
				SELF.orig_ip 										:=	IF(pLeft.orig_ip <> '',	pLeft.orig_ip,	pRight.orig_ip);
			  SELF.orig_pmghousehold_id  		  := 	IF(pLeft.orig_pmghousehold_id <> '',	pLeft.orig_pmghousehold_id,	pRight.orig_pmghousehold_id);
        SELF.orig_site 									:=	IF(pLeft.orig_site <> '',	pLeft.orig_site,	pRight.orig_site);
				self.current_rec        				:=  IF(pLeft.Process_Date > pRight.Process_Date, pLeft.current_rec, pRight.current_rec);
				SELF														:=	pLeft;
		END;

		dRollupDuplicates	:=	ROLLUP(dSorted,
																 tRollupDuplicates(LEFT,RIGHT),
																 clean_name.fname,
																 clean_name.lname,
																 clean_name.mname,
																 clean_address.prim_range,
																 clean_address.prim_name,
																 clean_address.sec_range,
																 clean_address.zip,
																 orig_email,
																 LOCAL
																): persist('~thor::persist::entiera::rolled_up_duplicates');		

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
		rSlimForDID	tSlimForDID(dRollupDuplicates pInput)
		 :=
		  transform
				self						:=	pInput.clean_name;
				self						:=	pInput.clean_address;
				self.best_ssn		:=	'';
				self.best_dob		:=	0;
				self						:=	pInput;
			end
		 ;
		dSlimForDID	:=	project(dRollupDuplicates,tSlimForDID(left));

		//------------Apply Name Flipping Macro--------------------
		ut.mac_flipnames(dSlimForDID,fname,mname,lname,rsAIDCleanFlipNames);

		matchset		:=	['A','Z'];
		did_add.MAC_Match_Flex(rsAIDCleanFlipNames, matchset,					
													 '', '', fname, mname, lname, name_suffix, 
													 prim_range, prim_name, sec_range, zip, st,'', 
													 did,
													 rSlimForDID,
													 true, did_score,
													 75,
													 rsCleanAID_DID
													);

		dPostDID_With			:=	rsCleanAID_DID(did <> 0);
		dPostDID_Without	:=	rsCleanAID_DID(did = 0);
		
		DID_Add.MAC_Add_SSN_By_DID(dPostDID_With, did, best_ssn, dPostDID_SSN);

		rSlimForDID tAppendBestDOB(dPostDID_SSN pDID, RECORDOF(watchdog.File_Best) pBest) :=	TRANSFORM
				SELF.best_dob :=	pBest.dob;
				SELF 					:=	pDID;
		END;
			
		dPostDID_SSN_DOB	:=	JOIN(dPostDID_SSN, Watchdog.File_Best,
															left.did = right.did,
															tAppendBestDOB(left,right),
															left outer,local
																);	// Already distributed from previous SSN append

		dPostDIDComplete	:=	dPostDID_SSN_DOB + dPostDID_Without;

		Entiera.Layouts.Base	tAppendDID_SSN_DOB(dRollupDuplicates pBase, dPostDIDComplete pDIDSSNDOB)
		 :=
		  transform
				self.did						:=	pDIDSSNDOB.did;
				self.did_score			:=	pDIDSSNDOB.did_score;
				self.best_ssn				:=	pDIDSSNDOB.best_ssn;
				self.best_dob				:=	pDIDSSNDOB.best_dob;
				self.process_date		:=	pBase.process_date;
				self.date_first_seen  := pBase.date_first_seen;	
				self.date_last_seen  	:= pBase.date_last_seen;
				self.ln_login_date	:=	'';
				self								:=	pBase;
				self								:= [];
			end
		 ;
		dAppendDID_SSN_DOB	:=	join(dRollupDuplicates, dPostDIDComplete,
																 left.unique_id = right.unique_id,
																 tAppendDID_SSN_DOB(left,right),
																 left outer
																);
																
		//orig_login_date formatted to CCYYMMDD (Bug# 51741)											
		Layouts.Base	tformatOrig_login_date(dAppendDID_SSN_DOB pInput):= TRANSFORM
					self.ln_login_date		:=	MAP(
																			REGEXFIND('(([0-1])?[0-9])/(([0-3])?[0-9])/((19|20)[0-9]{2})', TRIM(pInput.orig_login_date)) => REGEXFIND('(([0-1])?[0-9])/(([0-3])?[0-9])/((19|20)[0-9]{2})', TRIM(pInput.orig_login_date), 3)
																								+(string2)INTFORMAT((unsigned1)REGEXFIND('(([0-1])?[0-9])/(([0-3])?[0-9])/((19|20)[0-9]{2})', TRIM(pInput.orig_login_date), 2), 2, 1)
																								+(string2)INTFORMAT((unsigned1)REGEXFIND('(([0-1])?[0-9])/(([0-3])?[0-9])/((19|20)[0-9]{2})', TRIM(pInput.orig_login_date), 1), 2, 1),
																			REGEXFIND('^(19|20)[0-9][0-9](0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])$', TRIM(pInput.orig_login_date)[1..8]) =>	TRIM(pInput.orig_login_date)[1..8],
																		'');
					self									:=	pInput;
		END;

		dAppendDID_SSN_DOB_ln_login_date	:=	PROJECT(dAppendDID_SSN_DOB, tformatOrig_login_date(left));															

EXPORT Standardized_Entiera_Data := dAppendDID_SSN_DOB_ln_login_date;//	:	persist('~thor::persist::entiera::standardized_entiera_data');
