import _control,versioncontrol;

export DeSpray_compID(
			string pVersion				=	Version
			,string pDestinationpath	=	'/hds_180/cid/'
			,string pSource				=	'~thor_data400::out::alpharetta::compid'
			,string pDestinationIP		=	_Control.IPAddress.edata12
			) := function

	Destinationpath	:=	if(Mode.IsWeekly	,pDestinationpath+'weekly/out/'
							,pDestinationpath+'monthly/out/');

	Source	:=	if(Mode.IsWeekly	,'~thor_data400::out::weekly::alpharetta::compid'
							,'~thor_data400::out::monthly::alpharetta::compid');

	myfilestodespray:=dataset(	[
							{Source+'::nm::'+pVersion,pDestinationIP,Destinationpath+'LN_NM.OUT'}
							,{Source+'::nh::'+pVersion,pDestinationIP,Destinationpath+'LN_NH.OUT'}
							,{Source+'::ca::'+pVersion,pDestinationIP,Destinationpath+'LN_CA.OUT'}
							,{Source+'::nc::'+pVersion,pDestinationIP,Destinationpath+'LN_NC.OUT'}
							,{Source+'::nj::'+pVersion,pDestinationIP,Destinationpath+'LN_NJ.OUT'}
							,{Source+'::ny::'+pVersion,pDestinationIP,Destinationpath+'LN_NY.OUT'}
							,{Source+'::mo::'+pVersion,pDestinationIP,Destinationpath+'LN_MO.OUT'}
							,{Source+'::in::'+pVersion,pDestinationIP,Destinationpath+'LN_IN.OUT'}
							,{Source+'::va::'+pVersion,pDestinationIP,Destinationpath+'LN_VA.OUT'}
							,{Source+'::fl::'+pVersion,pDestinationIP,Destinationpath+'LN_FL.OUT'}
							,{Source+'::il::'+pVersion,pDestinationIP,Destinationpath+'LN_IL.OUT'}
							,{Source+'::pa::'+pVersion,pDestinationIP,Destinationpath+'LN_PA.OUT'}
							,{Source+'::tx::'+pVersion,pDestinationIP,Destinationpath+'LN_TX.OUT'}
							,{Source+'::ga::'+pVersion,pDestinationIP,Destinationpath+'LN_GA.OUT'}
							,{Source+'::mi::'+pVersion,pDestinationIP,Destinationpath+'LN_MI.OUT'}
							,{Source+'::oh::'+pVersion,pDestinationIP,Destinationpath+'LN_OH.OUT'}
							,{Source+'::md::'+pVersion,pDestinationIP,Destinationpath+'LN_MD.OUT'}
							,{Source+'::tn::'+pVersion,pDestinationIP,Destinationpath+'LN_TN.OUT'}
							,{Source+'::wa::'+pVersion,pDestinationIP,Destinationpath+'LN_WA.OUT'}
							,{Source+'::nv::'+pVersion,pDestinationIP,Destinationpath+'LN_NV.OUT'}
							,{Source+'::al::'+pVersion,pDestinationIP,Destinationpath+'LN_AL.OUT'}
							,{Source+'::id::'+pVersion,pDestinationIP,Destinationpath+'LN_ID.OUT'}
							,{Source+'::ri::'+pVersion,pDestinationIP,Destinationpath+'LN_RI.OUT'}
							,{Source+'::ne::'+pVersion,pDestinationIP,Destinationpath+'LN_NE.OUT'}
							,{Source+'::ma::'+pVersion,pDestinationIP,Destinationpath+'LN_MA.OUT'}
							,{Source+'::de::'+pVersion,pDestinationIP,Destinationpath+'LN_DE.OUT'}
							,{Source+'::sd::'+pVersion,pDestinationIP,Destinationpath+'LN_SD.OUT'}
							,{Source+'::or::'+pVersion,pDestinationIP,Destinationpath+'LN_OR.OUT'}
							,{Source+'::ky::'+pVersion,pDestinationIP,Destinationpath+'LN_KY.OUT'}
							,{Source+'::sc::'+pVersion,pDestinationIP,Destinationpath+'LN_SC.OUT'}
							,{Source+'::wv::'+pVersion,pDestinationIP,Destinationpath+'LN_WV.OUT'}
							,{Source+'::ut::'+pVersion,pDestinationIP,Destinationpath+'LN_UT.OUT'}
							,{Source+'::mt::'+pVersion,pDestinationIP,Destinationpath+'LN_MT.OUT'}
							,{Source+'::nd::'+pVersion,pDestinationIP,Destinationpath+'LN_ND.OUT'}
							,{Source+'::wy::'+pVersion,pDestinationIP,Destinationpath+'LN_WY.OUT'}
							,{Source+'::ks::'+pVersion,pDestinationIP,Destinationpath+'LN_KS.OUT'}
							,{Source+'::ct::'+pVersion,pDestinationIP,Destinationpath+'LN_CT.OUT'}
							,{Source+'::az::'+pVersion,pDestinationIP,Destinationpath+'LN_AZ.OUT'}
							,{Source+'::ms::'+pVersion,pDestinationIP,Destinationpath+'LN_MS.OUT'}
							,{Source+'::me::'+pVersion,pDestinationIP,Destinationpath+'LN_ME.OUT'}
							,{Source+'::ok::'+pVersion,pDestinationIP,Destinationpath+'LN_OK.OUT'}
							,{Source+'::dc::'+pVersion,pDestinationIP,Destinationpath+'LN_DC.OUT'}
							,{Source+'::ak::'+pVersion,pDestinationIP,Destinationpath+'LN_AK.OUT'}
							,{Source+'::vt::'+pVersion,pDestinationIP,Destinationpath+'LN_VT.OUT'}
							,{Source+'::wi::'+pVersion,pDestinationIP,Destinationpath+'LN_WI.OUT'}
							,{Source+'::hi::'+pVersion,pDestinationIP,Destinationpath+'LN_HI.OUT'}
							,{Source+'::co::'+pVersion,pDestinationIP,Destinationpath+'LN_CO.OUT'}
							,{Source+'::la::'+pVersion,pDestinationIP,Destinationpath+'LN_LA.OUT'}
							,{Source+'::mn::'+pVersion,pDestinationIP,Destinationpath+'LN_MN.OUT'}
							,{Source+'::ia::'+pVersion,pDestinationIP,Destinationpath+'LN_IA.OUT'}
							,{Source+'::ar::'+pVersion,pDestinationIP,Destinationpath+'LN_AR.OUT'}
							],	versioncontrol.Layout_DKCs.Input);

	return versioncontrol.fDesprayFiles(myfilestodespray,,,'DesprayListInfo',true);

END;