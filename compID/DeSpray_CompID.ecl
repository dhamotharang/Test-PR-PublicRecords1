import _control,versioncontrol;

export DeSpray_compID(
			string pVersion				=	Version
			,string pDestinationpath	=	'/hds_180/cid/'
			,string pSource				=	'~thor_data400::out::alpharetta::compid'
			,string pDestinationIP		=	_Control.IPAddress.edata12
			) := function

	Source	:=	if(IsWeekly	,'~thor_data400::out::weekly::alpharetta::compid'
							,'~thor_data400::out::monthly::alpharetta::compid');

	myfilestodespray:=dataset(	[
							{Source+'::nm::'+pVersion,pDestinationIP,pDestinationpath+'LN_NM.OUT'}
							,{Source+'::nh::'+pVersion,pDestinationIP,pDestinationpath+'LN_NH.OUT'}
							,{Source+'::ca::'+pVersion,pDestinationIP,pDestinationpath+'LN_CA.OUT'}
							,{Source+'::nc::'+pVersion,pDestinationIP,pDestinationpath+'LN_NC.OUT'}
							,{Source+'::nj::'+pVersion,pDestinationIP,pDestinationpath+'LN_NJ.OUT'}
							,{Source+'::ny::'+pVersion,pDestinationIP,pDestinationpath+'LN_NY.OUT'}
							,{Source+'::mo::'+pVersion,pDestinationIP,pDestinationpath+'LN_MO.OUT'}
							,{Source+'::in::'+pVersion,pDestinationIP,pDestinationpath+'LN_IN.OUT'}
							,{Source+'::va::'+pVersion,pDestinationIP,pDestinationpath+'LN_VA.OUT'}
							,{Source+'::fl::'+pVersion,pDestinationIP,pDestinationpath+'LN_FL.OUT'}
							,{Source+'::il::'+pVersion,pDestinationIP,pDestinationpath+'LN_IL.OUT'}
							,{Source+'::pa::'+pVersion,pDestinationIP,pDestinationpath+'LN_PA.OUT'}
							,{Source+'::tx::'+pVersion,pDestinationIP,pDestinationpath+'LN_TX.OUT'}
							,{Source+'::ga::'+pVersion,pDestinationIP,pDestinationpath+'LN_GA.OUT'}
							,{Source+'::mi::'+pVersion,pDestinationIP,pDestinationpath+'LN_MI.OUT'}
							,{Source+'::oh::'+pVersion,pDestinationIP,pDestinationpath+'LN_OH.OUT'}
							,{Source+'::md::'+pVersion,pDestinationIP,pDestinationpath+'LN_MD.OUT'}
							,{Source+'::tn::'+pVersion,pDestinationIP,pDestinationpath+'LN_TN.OUT'}
							,{Source+'::wa::'+pVersion,pDestinationIP,pDestinationpath+'LN_WA.OUT'}
							,{Source+'::nv::'+pVersion,pDestinationIP,pDestinationpath+'LN_NV.OUT'}
							,{Source+'::al::'+pVersion,pDestinationIP,pDestinationpath+'LN_AL.OUT'}
							,{Source+'::id::'+pVersion,pDestinationIP,pDestinationpath+'LN_ID.OUT'}
							,{Source+'::ri::'+pVersion,pDestinationIP,pDestinationpath+'LN_RI.OUT'}
							,{Source+'::ne::'+pVersion,pDestinationIP,pDestinationpath+'LN_NE.OUT'}
							,{Source+'::ma::'+pVersion,pDestinationIP,pDestinationpath+'LN_MA.OUT'}
							,{Source+'::de::'+pVersion,pDestinationIP,pDestinationpath+'LN_DE.OUT'}
							,{Source+'::sd::'+pVersion,pDestinationIP,pDestinationpath+'LN_SD.OUT'}
							,{Source+'::or::'+pVersion,pDestinationIP,pDestinationpath+'LN_OR.OUT'}
							,{Source+'::ky::'+pVersion,pDestinationIP,pDestinationpath+'LN_KY.OUT'}
							,{Source+'::sc::'+pVersion,pDestinationIP,pDestinationpath+'LN_SC.OUT'}
							,{Source+'::wv::'+pVersion,pDestinationIP,pDestinationpath+'LN_WV.OUT'}
							,{Source+'::ut::'+pVersion,pDestinationIP,pDestinationpath+'LN_UT.OUT'}
							,{Source+'::mt::'+pVersion,pDestinationIP,pDestinationpath+'LN_MT.OUT'}
							,{Source+'::nd::'+pVersion,pDestinationIP,pDestinationpath+'LN_ND.OUT'}
							,{Source+'::wy::'+pVersion,pDestinationIP,pDestinationpath+'LN_WY.OUT'}
							,{Source+'::ks::'+pVersion,pDestinationIP,pDestinationpath+'LN_KS.OUT'}
							,{Source+'::ct::'+pVersion,pDestinationIP,pDestinationpath+'LN_CT.OUT'}
							,{Source+'::az::'+pVersion,pDestinationIP,pDestinationpath+'LN_AZ.OUT'}
							,{Source+'::ms::'+pVersion,pDestinationIP,pDestinationpath+'LN_MS.OUT'}
							,{Source+'::me::'+pVersion,pDestinationIP,pDestinationpath+'LN_ME.OUT'}
							,{Source+'::ok::'+pVersion,pDestinationIP,pDestinationpath+'LN_OK.OUT'}
							,{Source+'::dc::'+pVersion,pDestinationIP,pDestinationpath+'LN_DC.OUT'}
							,{Source+'::ak::'+pVersion,pDestinationIP,pDestinationpath+'LN_AK.OUT'}
							,{Source+'::vt::'+pVersion,pDestinationIP,pDestinationpath+'LN_VT.OUT'}
							,{Source+'::wi::'+pVersion,pDestinationIP,pDestinationpath+'LN_WI.OUT'}
							,{Source+'::hi::'+pVersion,pDestinationIP,pDestinationpath+'LN_HI.OUT'}
							,{Source+'::co::'+pVersion,pDestinationIP,pDestinationpath+'LN_CO.OUT'}
							,{Source+'::la::'+pVersion,pDestinationIP,pDestinationpath+'LN_LA.OUT'}
							,{Source+'::mn::'+pVersion,pDestinationIP,pDestinationpath+'LN_MN.OUT'}
							,{Source+'::ia::'+pVersion,pDestinationIP,pDestinationpath+'LN_IA.OUT'}
							,{Source+'::ar::'+pVersion,pDestinationIP,pDestinationpath+'LN_AR.OUT'}
							],	versioncontrol.Layout_DKCs.Input);

	return versioncontrol.fDesprayFiles(myfilestodespray,,,'DesprayListInfo');

END;