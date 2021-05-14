IMPORT Ut; 
  
	//////////////////////////////
	//Map Input to Common Layout//	
	//////////////////////////////
	
	//Reformat Range Files
	dCL 			:= Phone_TCPA._Functions.fn_Expand_Phone_Range(Phone_TCPA.File_TCPA_Phone.In_Wireless_to_Wireline, 'CL');
	dLC 			:= Phone_TCPA._Functions.fn_Expand_Phone_Range(Phone_TCPA.File_TCPA_Phone.In_Wireline_to_Wireless, 'LC');
			
	//Reformat No Range Files
	dCL_NR		:= Phone_TCPA._Functions.fn_Map_Phone_NoRange(Phone_TCPA.File_TCPA_Phone.In_Wireless_to_Wireline_NoRange, 'CL');
	dLC_NR		:= Phone_TCPA._Functions.fn_Map_Phone_NoRange(Phone_TCPA.File_TCPA_Phone.In_Wireline_to_Wireless_NoRange, 'LC');

	//Concat Results
	ccRange		:= dCL + dLC;
	ccNoRange	:= dCL_NR + dLC_NR;

	////////////////////////////
	//Find All CURRENT Records//
	////////////////////////////
	
	srtRange	:= sort(distribute(ccRange, hash(expand_phone, phone_type)), expand_phone, phone_type, local);
	srtNoRange:= sort(distribute(ccNoRange, hash(expand_phone, phone_type)), expand_phone, phone_type, local);
	
		//Pull No Range Records First
		Phone_TCPA.Layout_TCPA.Main nrTr(srtNoRange l, srtRange r):= transform
			self := l;
		end;
	
		keepNR		:= join(srtNoRange, srtRange,
											left.expand_phone = right.expand_phone and
											left.phone_type = right.phone_type,
											nrTr(left, right), left outer, local);
	
		ddKeepNR	:= dedup(sort(distribute(keepNR, hash(expand_phone)), record, local), record, local);
	
		//Pull Range Records Next
		Phone_TCPA.Layout_TCPA.Main rTr(srtNoRange l, srtRange r):= transform
			self := r;
		end;
	
		keepR			:= join(srtNoRange, srtRange,
											left.expand_phone = right.expand_phone and
											left.phone_type = right.phone_type,
											rTr(left, right), right only, local);
	
		ddKeepR		:= dedup(sort(distribute(keepR, hash(expand_phone, phone_type)), record, local), record, local);	
	
	////////////////////////////////////////////////////////
	//Compare with Existing Base File - Set Dates & Status//
	////////////////////////////////////////////////////////
	
		//Concat CURRENT Results
		ccUpdate	:= sort(distribute(ddKeepNR + ddKeepR, hash(expand_phone, phone_type)), expand_phone, phone_type, local);
		
		//Pull CURRENT Base Records
		currBase	:= sort(distribute(Phone_TCPA.File_TCPA_Phone.Main(is_current=TRUE), hash(expand_phone, phone_type)), expand_phone, phone_type, local);
		
		//Find Same Records & Update Dates
		Phone_TCPA.Layout_TCPA.Main appDtTr(ccUpdate l, currBase r) := transform
			self.dt_first_seen 	:= ut.min2(l.dt_first_seen, r.dt_first_seen);
			self.dt_last_seen 	:= max(l.dt_last_seen, r.dt_last_seen);
			self 								:= l;
		end;

		appUpdate := join(ccUpdate, currBase,
											left.expand_phone = right.expand_phone and 
											left.phone_type = right.phone_type,
											appDtTr(left, right), left outer, local);

		//Find Dropped Records
		Phone_TCPA.Layout_TCPA.Main appDrTr(currBase l, ccUpdate r) := transform
			self.is_current  := FALSE;
			self 							:= l;
		end;

		appDrop 	:= join(currBase, ccUpdate,
											left.expand_phone = right.expand_phone and 
											left.phone_type = right.phone_type,
											appDrTr(left, right), left only, local);
	
	///////////////////////////////////////////////
	//Concat Final Results - Create New Base File//
	///////////////////////////////////////////////
	
	newBase		:= appUpdate + appDrop + Phone_TCPA.File_TCPA_Phone.Main(is_current=FALSE);
		
EXPORT Map_TCPA_Phone_History:= newBase;