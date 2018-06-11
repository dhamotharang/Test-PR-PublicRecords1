export MAC_Append_Feedback(
				dFileIn,
				dFileOut,
				dFeedback     = 'Feedback', // Feedback dataset name
				fDid 					= 'did',
				fPrimRange 		= 'prim_range',
				fPrimName 		= 'prim_name',				
				fZip 					= 'zip',				
				fSecRange 		= 'sec_range',
				fPredir				= 'predir',
				fPostdir			= 'postdir',
				fAddrSuffix		= 'suffix',
				fUnitDesig		= 'unit_desig',			
				maxFeedback   = AddressFeedback_Services.Constants.Limits.FEEDBACK_PER_ADDRESS
				) :=
macro
#uniquename(isCNSMR)
 %isCNSMR% := ut.IndustryClass.is_Knowx;
 
	// sequence input: designates [prim_range, prim_name, zip, sec_range, did] combination as unique
	#uniquename(lFileInSeq)
	%lFileInSeq% := record
		recordof(dFileIn);
		unsigned _seq := 0;
	end;
	
	#uniquename(dFileInSeq)
	ut.MAC_Sequence_Records_NewRec(dFileIn,%lFileInSeq%,_seq,%dFileInSeq%);

	#uniquename(lFileInPlusFeedback)
	%lFileInPlusFeedback% := record
		%lFileInSeq%;		
		dataset(AddressFeedback_Services.Layouts.feedback_common) _feedback;
		unsigned	feedback_count := 0;
	end;

	#uniquename(xtGetFeedback)
	%lFileInPlusFeedback% %xtGetFeedback%(%lFileInSeq% l, AddressFeedback.Key_AddressFeedback r) := transform		
		self._feedback			:= project(r, transform(AddressFeedback_Services.Layouts.feedback_common, self := left));
		self 								:= l
	end;
	
									
	#uniquename(dFBRecs_temp)
	%dFBRecs_temp% := join(%dFileInSeq%, AddressFeedback.Key_AddressFeedback,
										left.fPrimName <> '' and left.fZip <> '' and left.fPrimRange <> '' and
										keyed(left.fPrimName = right.prim_name) and
										keyed(left.fZip = right.zip) and
										keyed(left.fPrimRange = right.prim_range) and
										keyed(left.fSecRange='' or left.fSecRange = right.sec_range) and
										keyed((unsigned6) left.fDid = right.did) and
										right.address_contact_type in AddressFeedback_Services.Constants.ADDR_FEEDBACK_TYPE_INCLUDES and
										left.fPredir = right.predir and 
										left.fPostdir = right.postdir and 
										left.fAddrSuffix = right.addr_suffix and
										left.fUnitDesig = right.unit_desig,										
										%xtGetFeedback%(left, right),
										left outer, limit(0), keep(AddressFeedback_Services.Constants.Limits.FEEDBACK_PER_ADDRESS));

	#uniquename(dFileInSeq_temp)
	%dFileInSeq_temp% := project(%dFileInSeq%,
									transform(%lFileInPlusFeedback%,self._feedback :=[], self := left));
	
	#uniquename(dFBRecs)
	%dFBRecs% := if(%isCNSMR%, %dFileInSeq_temp%,	%dFBRecs_temp%);
	
	#uniquename(dFBRecsG)											 
	%dFBRecsG% := group(sort(%dFBRecs%, _seq), _seq);

	#uniquename(xtSetFeedbackChild)
	recordof(dFileIn) %xtSetFeedbackChild% (%lFileInPlusFeedback% l, dataset (%lFileInPlusFeedback%) r) := transform
	
		// keep only latest feedbacks from each user (companyid + loginid)
		dFBLatestByUser := dedup(sort(r._feedback(prim_name<>'',zip<>'',prim_range<>''), companyid, loginid, -date_time_added, address_contact_type),
														 companyid, loginid);

		// take the latest of all 	
		dFBLatest := dedup (sort(dFBLatestByUser, -date_time_added), date_time_added);	
		
		self.dFeedback := project(choosen(dFBLatest, maxFeedback),
						transform(AddressFeedback_Services.Layouts.feedback_report,
							self.Last_Feedback_Result_Provided	:= left.date_time_added,
							self.Last_Feedback_Result						:= AddressFeedback_Services.Functions.getFeedbackTypeDescription(left.address_contact_type),
							self.feedback_count 								:= count (dFBLatestByUser ((unsigned6) did = (unsigned6) l.did,	address_contact_type = left.address_contact_type))
							)),
		self := l;
	end;
	dFileOut := rollup(%dFBRecsG%, group, %xtSetFeedbackChild% (left, rows (left)));
	
endmacro;