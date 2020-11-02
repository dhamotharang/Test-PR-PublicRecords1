#OPTION('multiplePersistInstances',FALSE);
IMPORT aid, aid_support, dx_phonesinfo, std, ut;

//DF-28036: Convert 6-Digit Spids to 4-Character Spids

/*
	REGULAR BUILD PROCESS:
	======================
	STEP 1: Remap cleaned results to prep layout.
	STEP 2: Join the carrier records (override_type='A') to the contact records (override_type='B') by ocn.  
					Matched current (is_current=TRUE) records will use the city/state values from the carrier file.
	STEP 3: Concat the carrier, contact, and other record results together.
	STEP 4: Join these records to the latest carrier reference file by ocn, carrier name (name), and spid.
					Matched records will use the serv, line, prepaid, high_risk_indicator, activation_dt, and number_in_service values from the carrier reference file.
					Unmatched records will have their is_current status changed to FALSE, and the dt_end field will be populated with the latest filedate. 
	STEP 5: Split the current/non-current records by complete (serv<>'' and line<>'' and spid<>'') and incomplete (serv='' or line='' or spid='').
	STEP 6: The complete records will be used to update the carrier reference file.
					The incomplete records will be used to generate the record review file.
					The dropped records will be added to a review file.
*/

EXPORT Map_Carrier_Reference(string version) := FUNCTION

	//Run Build Update Whenever There Is A Change Made to the Lerg1 and Lerg1Con Files
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	//STEP 1: PULL COMP_CODE SPIDS INFO////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		//Pull Lerg1Prep Clean Address Results
		cleanAddr					:= PhonesInfo.File_Lerg.Lerg1PrepClean;
			
		//Combine LergComb
		PhonesInfo.Layout_Lerg.LergPrep combTr(cleanAddr l):= transform
			self.dt_first_reported			:= version;
			self.dt_last_reported				:= version;
			self.dt_end									:= if(l.dt_end='', '0', l.dt_end);		
			self.ocn										:= PhonesInfo._Functions.fn_standardName(l.ocn);	
			self.name										:= PhonesInfo._Functions.fn_standardName(l.name);
			self.is_current							:= TRUE;
			self.rec_update							:= '';
			self 												:= l;
		end;

		updLergPrep				:= project(cleanAddr, combTr(left));
		
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	//STEP 2: POPULATE SPECIFIC CARRIER INFO FIELDS TO THE CONTACT FILE////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		//Populate Carrier City/State Info in the Contact File (Not Needed for Original Carrier Ref Records)
		
			//Override_File Field Translation:
				//A = Carrier Record
				//B = Contact Record
			
		srtCarrier 				:= sort(distribute(updLergPrep(override_file='A'), hash(ocn)), ocn, local);		//Carrier Records - Lerg1 File
		srtContact				:= sort(distribute(updLergPrep(override_file='B'), hash(ocn)), ocn, local);		//Contact Records - Lerg1Con
		dsOther						:= updLergPrep(override_file not in ['A','B']);																//Previous Carrier Reference Records																															
		
		PhonesInfo.Layout_Lerg.LergPrep addCarrInfo(srtContact l, srtCarrier r):= transform
			self.data_type							:= l.data_type;
			self.category								:= r.category;
			self.carrier_city						:= r.carrier_city;
			self.carrier_state					:= r.carrier_state;
			self 												:= l;
		end;
		
		updContact				:= join(srtContact, srtCarrier,
															left.ocn = right.ocn,
															addCarrInfo(left, right), left outer, local);									
		
		ddUpdContact			:= dedup(sort(distribute(updContact, hash(ocn)), record, local), record, local); 		
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	//STEPS 3-4: APPEND EXISTING CARRIER REFERENCE INFO - Serv/Line Types//////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		//Combine Lerg Files + Existing Carrier Reference Tables
		appRec						:= srtCarrier + ddUpdContact + dsOther;		
		srtComb						:= sort(distribute(appRec, hash(ocn, name)), ocn, name, override_file, local);	
		
		//Reformat Existing Carrier Reference to Lerg Prep Layout	
		PhonesInfo.Layout_Lerg.LergPrep addF2(dx_PhonesInfo.Layouts.sourceRefBase l):= transform
		  self.ocn										:= PhonesInfo._Functions.fn_standardName(l.ocn);
			self.name										:= PhonesInfo._Functions.fn_standardName(l.name);
			self.is_new									:= '';
			self.rec_update							:= '';
			self.address1								:= '';
			self.address2								:= '';
			self.country								:= if(PhonesInfo._Functions.fn_isUSStateTerr(l.ocn_state),
																				'US',
																			if(PhonesInfo._Functions.fn_isCanTerr(l.ocn_state),
																				'CA',
																				l.ocn_state));
			self.opname									:= PhonesInfo._Functions.fn_standardName(l.name);
			self 												:= l;
		end;
			
		carrR							:= project(PhonesInfo.File_Source_Reference.Main, addF2(left)); 
		carrRef						:= carrR(is_current=TRUE and override_file <>'Y'); 	
		
		dsCarrRef					:= sort(distribute(carrRef, hash(ocn, name)), ocn, name, serv, line, local); //Active Carrier Reference Records
		
		//Append Reference Table Info (Excluding Overrides) to CURRENT Records
		
		//////////////////////////////////////////////////////////////////////////////
		//Match by Carrier Name///////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////
		PhonesInfo.Layout_Lerg.LergPrep combRefTr(PhonesInfo.Layout_Lerg.LergPrep l, PhonesInfo.Layout_Lerg.LergPrep r):= transform
			self.ocn 										:= if(trim(l.ocn, left, right)<>'', l.ocn, r.ocn);	
			self.name										:= PhonesInfo._Functions.fn_standardName(if(l.name<>'', l.name, r.name));
			self.dt_first_reported 			:= (string)ut.min2((unsigned)l.dt_first_reported,(unsigned)r.dt_first_reported);
			self.dt_last_reported				:= (string)MAX((unsigned)l.dt_last_reported,(unsigned)r.dt_last_reported);
			self.dt_start								:= (string)ut.min2((unsigned)l.dt_start,(unsigned)r.dt_start);
			self.dt_end									:= (string)MAX((unsigned)l.dt_end,(unsigned)r.dt_end);
			//Use Original Carrier Reference Value
			self.serv										:= if(l.serv<>'', l.serv, r.serv);												
			self.line										:= if(l.line<>'', l.line, r.line);												
			self.is_new									:= if(r.serv='' or r.line='', 'Y', '');								//Records With Missing Serv/Line Types are Flagged "New"
			self.prepaid								:= if(l.prepaid not in ['','0'], l.prepaid, r.prepaid);	
			self.high_risk_indicator		:= if(l.high_risk_indicator not in ['','0'], l.high_risk_indicator, r.high_risk_indicator); 
			self.activation_dt					:= r.activation_dt;
			self.number_in_service			:= r.number_in_service;
			////////////////////////////////////////////////////////////////////////////////////////////
			self.spid										:= if(l.spid<>'', l.spid, r.spid);
			self.operator_full_name			:= l.operator_full_name;
			self.is_current							:= l.is_current;
			self												:= l;
		end;
		
		joinCurr 					:= join(srtComb, dsCarrRef,
															left.ocn = right.ocn and
															left.name = right.name,
															combRefTr(left, right), left outer, local);
		
		//Separate Current Records by Complete and Incomplete Results
		currComp					:= joinCurr(serv<>'' and line<>'');
		currIncomp				:= joinCurr(serv='' and line='');
														
		//////////////////////////////////////////////////////////////////////////////												
		//Match by OCN////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////	
		
		srtCurrIncomp2		:= sort(distribute(currIncomp, hash(ocn)), ocn, serv, line, local); 
		srtCarrRef2				:= dedup(sort(distribute(carrRef, hash(ocn)), ocn, serv, line, -dt_last_reported, local), ocn, serv, line, local); //Keep Latest Carrier Reference Record For Append
		
		joinCurr2 				:= join(srtCurrIncomp2, srtCarrRef2,
															left.ocn = right.ocn,
															combRefTr(left, right), left outer, local);
											
		//Concat CURRENT Results
		concatCurr				:= currComp + joinCurr2;
		currRec						:= dedup(sort(distribute(concatCurr, hash(ocn, name)), ocn, name, serv, line, local), record, local);			
		
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	//STEP 5: SPLIT RECORDS BY CURRENT/NONCURRENT & COMPLETE/INCOMPLETE////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
				
		currCompRec				:= currRec(~(serv='' or line='' or spid=''));																				//COMPLETE Current Records
		currIncompRec			:= currRec(serv='' or line='' or spid='' or is_new='Y');														//INCOMPLETE or New Current Records
		
		srtCurrCompRec		:= sort(distribute(currCompRec, hash(ocn, name)), ocn, name, serv, line, local);
		
		//Find NONCURRENT Records
		PhonesInfo.Layout_Lerg.LergPrep combRefTr2(PhonesInfo.Layout_Lerg.LergPrep l, PhonesInfo.Layout_Lerg.LergPrep r):= transform
			self.dt_end									:= if(PhonesInfo._Functions.fn_maxHistFileDt(trim(r.override_file, left, right))<>'',
																				PhonesInfo._Functions.fn_maxHistFileDt(trim(r.override_file, left, right)),
																				version);	//Set dt_end to last filedate (Lerg1 or Lerg1ConOverride)
			self.is_current							:= FALSE;	
			self.country								:= if(r.country<>'', r.country, r.ocn_state);
			self												:= r;
		end;
		
		//Find NONCURRENT Records by Operator Name				
		joinNonCurr 			:= join(srtCurrCompRec, dsCarrRef,
															left.ocn = right.ocn and
															left.name = right.name and
															left.serv = right.serv and
															left.line = right.line,
															combRefTr2(left, right), right only, local);		
		
		nonCurrRec				:= dedup(sort(distributed(joinNonCurr + carrR(is_current=FALSE), hash(ocn, spid, name, carrier_address1, contact_function)), record, local), record, local); //NonActive Carrier Reference Records
		
		nonCurrCompRec		:= nonCurrRec(~(serv='' or line='' or spid=''));	//COMPLETE NonCurrent Records		
		nonCurrIncompRec	:= nonCurrRec(serv='' or line='' or spid='');			//INCOMPLETE NonCurrent Records

	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	//STEP 6: OUTPUT RESULTS///////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////

		//Pull COMPLETE CURRENT/NONCURRENT Records for Base 
		concatAll 				:= project(currCompRec + nonCurrCompRec, dx_PhonesInfo.Layouts.sourceRefBase);
		ddConcatAll				:= dedup(sort(distribute(concatAll, hash(ocn, spid, name)), record, local), record, local);	
		
		//Pull INCOMPLETE/MISSING New Records for Review 
		concatRev					:= currIncompRec + nonCurrIncompRec;
		ddConcatRev				:= dedup(sort(distribute(concatRev, hash(ocn, spid, operator_full_name)), ocn, spid, operator_full_name, -serv, -data_type, local), ocn, name, spid, operator_full_name, local);

		//Pull NONCURRENT Records That Have Dropped Off, Since Last Update
		current_all				:= concatAll(override_file in ['', 'A'] and contact_function='' and is_current=TRUE);
		prevCurrent_all		:= carrRef(override_file in ['', 'A'] and contact_function='' and is_current=TRUE);
		
			srt_curr_all		:= sort(distribute(current_all, hash(ocn, spid)), ocn, spid, serv, line, local);
			srt_prevCurr_all:= sort(distribute(prevCurrent_all, hash(ocn, spid)), ocn, spid, serv, line, local);
			
			dx_PhonesInfo.Layouts.sourceRefBase prevTr(srt_prevCurr_all l, srt_curr_all r) := transform
				self := l;
			end;
			
			dropRec					:= join(srt_prevCurr_all, srt_curr_all,
															left.ocn = right.ocn and
															left.spid = right.spid and 
															left.serv = right.serv and
															left.line = right.line,
															prevTr(left, right), left only, local);
		
		ddDropRec					:= dedup(sort(distribute(dropRec, hash(ocn, spid)), record, local), record, local);	

		//Output Results
		ddResults					:= sequential(output(ddConcatAll,,'~thor_data400::base::phones::source_reference_main_'+version, overwrite, __compressed__), 				//Carrier Ref: Complete Record Base File
																		output(ddConcatRev,,'~thor_data400::base::phones::source_reference_main_review_'+version, overwrite, __compressed__),	//Carrier Ref: Incomplete/New Records Review File
																		output(ddDropRec,,'~thor_data400::base::phones::source_reference_dropped_main_review', overwrite, __compressed__));		//Carrier Ref: Dropped Records for Review File
	
	RETURN ddResults;		
		
END;