import doxie, AutoKeyI, AutoHeaderI, BatchShare, suppress, FCRA;

doxie.MAC_Header_Field_Declare()

export input := module

	// MD Keys
	export unsigned6	id									:= 0 : stored('RecordID');
	export unsigned6	did									:= (unsigned6)did_value;
	
	shared string50		fnum_r							:= FilingNumber_value;
	shared string50		fnum_m							:= '' : stored('filing_num');
	export string50		fnum								:= if(fnum_r<>'',fnum_r,fnum_m);
	
	export string1		filing_type					:= '' : stored('FilingType');
	export string15		filing_subtype			:= '' : stored('FilingSubType');
	export string2		state_origin				:= state_value;
	export string35		county							:= county_value;
	
	export string8		fdBegin							:= FilingDateBegin_value;
	export string8		fdEnd								:= FilingDateEnd_value;
 
	// MD Tuning
	export unsigned2	pThresh							:= 10 : stored('PenaltThreshold');
	export boolean		incDeepDive					:= not noDeepDive;
	
	export gm(boolean isFCRA = false) := AutoStandardI.GlobalModule(isFCRA);
	
	export params := interface(
		AutoKeyI.AutoKeyStandardFetchBaseInterface,
		AutoHeaderI.LIBIN.FetchI_Hdr_Indv.base,
		AutoHeaderI.LIBIN.FetchI_Hdr_Biz.base)
	end;

	export batch_params := INTERFACE (BatchShare.IParam.BatchParamsV2,FCRA.iRules)
		export integer1 non_subject_suppression := suppress.Constants.NonSubjectSuppression.doNothing;
	end;

end;