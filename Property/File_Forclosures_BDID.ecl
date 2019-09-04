import ut, header;

export File_Forclosures_BDID :=
function

	//phone, state, did
	src_rec :=
	record 
	 unsigned4	seq := 0;
	 header.Layout_Source_ID;
	 unsigned6	bdid := 0;
	 Property.Layout_Fares_Foreclosure;
	end;

	dFile := dataset('~thor_data400::base::property_forclosures_bdid',src_rec,flat);
  
	ut.mac_suppress_by_phonetype(dFile										,attorney_phone_nbr	,state										,dAttyWAPhoneSuppressed			,false);
	ut.mac_suppress_by_phonetype(dAttyWAPhoneSuppressed		,lender_phone				,lender_beneficiary_state	,dLenderWAPhoneSuppressed		,false);
	ut.mac_suppress_by_phonetype(dLenderWAPhoneSuppressed	,trustee_phone			,trustee_state						,dTrusteeWAPhoneSuppressed	,false);

	dAllSuppressed := dTrusteeWAPhoneSuppressed;

	return dAllSuppressed;
 
end; 