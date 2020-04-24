IMPORT dx_PhonesInfo;

EXPORT Map_Exception_List(string version) := FUNCTION

	//Force the Exception List records to use the Carrier Info in the Lerg1 File (not Comp_Code)
	//Use the existing Indicator Flags/Spid/Serv/Line types from the Exception List
	//Keep only the OCNs that are still in the Lerg1

	dsExcept 		:= PhonesInfo.File_Source_Reference.MainException(is_current=TRUE);
	dsLergAid		:= PhonesInfo.File_Lerg.Lerg1PrepClean;

	srtExcept		:= sort(distribute(dsExcept, hash(ocn)), ocn, local);
	srtLergAid	:= sort(distribute(dsLergAid, hash(ocn)), ocn, local);
	
	//Update Exception List records that still exist in the Lerg1
		dx_PhonesInfo.Layouts.sourceRefBase combTr(srtLergAid l, srtExcept r):= transform
			self.dt_first_reported			:= version;
			self.dt_last_reported				:= version;
			self.dt_end									:= if(l.dt_end='', '0', l.dt_end);		
			//Append OCN/Spid Information////////////////////////////////////////////////////////////////
			self.ocn										:= PhonesInfo._Functions.fn_standardName(if(r.ocn<>'', r.ocn, l.ocn));
			self.carrier_name						:= l.carrier_name;
			self.name										:= PhonesInfo._Functions.fn_standardName(l.name);
			self.spid										:= r.spid;
			self.operator_full_name			:= l.carrier_name;
			self.serv										:= r.serv;
			self.line										:= r.line;
			self.high_risk_indicator		:= r.high_risk_indicator;
			self.prepaid								:= r.prepaid;
	    //////////////////////////////////////////////////////////////////////////////////////////// 
			self.is_current							:= TRUE;
			self 												:= l;
		end;

		joinUpdate 				:= join(srtLergAid, srtExcept,
															left.ocn = right.ocn,
															combTr(left, right), local);
															
	//Populate Carrier City/State Info in the Contact File (Not Needed for Original Carrier Ref Records)
		
			//Override_File Field Translation:
				//A = Carrier Record
				//B = Contact Record
																
		srtCarrier 				:= sort(distribute(joinUpdate(override_file='A'), hash(ocn)), ocn, local);		//Carrier Records - Lerg1 File
		srtContact				:= sort(distribute(joinUpdate(override_file='B'), hash(ocn)), ocn, local);		//Contact Records - Lerg1Con
		dsOther						:= joinUpdate(override_file not in ['A','B']);																//Previous Carrier Reference Records																															
		
		dx_PhonesInfo.Layouts.sourceRefBase addCarrInfo(srtContact l, srtCarrier r):= transform
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
										
		concatRec					:= srtCarrier + ddUpdContact + dsOther;													
			
	//Update Exception List records that no longer exist in the Lerg1
		dx_PhonesInfo.Layouts.sourceRefBase combTr2(srtLergAid l, srtExcept r):= transform
			self.dt_end									:= version;		
	    //////////////////////////////////////////////////////////////////////////////////////////// 
			self.is_current							:= FALSE;
			self 												:= r;
		end;

		joinDrop 					:= join(srtLergAid, srtExcept,
															left.ocn = right.ocn and
															left.name = right.name,
															combTr2(left, right), right only, local);
		
		combRec						:= concatRec + joinDrop;	
		
		ddCombRec					:= dedup(sort(distributed(combRec, hash(ocn)), record, local), record, local);
			
		buildFile					:= output(ddCombRec,,'~thor_data400::base::phones::source_reference_main_exception_' + version, overwrite, __compressed__);	

		RETURN buildFile;

END;