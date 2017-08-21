import	_control, PRTE_CSV;

export	Proc_Build_IRS_Keys(string pIndexVersion)	:=
function

	rKeyIRS__irs5500_bdid_null	:=
	record
		PRTE_CSV.IRS.rthor_data400__key__irs5500_bdid_null;
	end;

	rKeyIRS__irs5500_linkids :=
	record
		PRTE_CSV.IRS.rthor_data400__key__irs5500_linkids;
	end;
	
	dKeyIRS__irs5500_bdid_null		:= 	project(PRTE_CSV.IRS.dthor_data400__key__irs5500_bdid_null, rKeyIRS__irs5500_bdid_null);
	dKeyIRS__irs5500_linkids			:= 	project(PRTE_CSV.IRS.dthor_data400__key__irs5500_linkids, rKeyIRS__irs5500_linkids);
	
	kKeyIRS__irs5500_bdid_null		:=	index(dKeyIRS__irs5500_bdid_null, {bdid}, {dKeyIRS__irs5500_bdid_null}, '~prte::key::irs5500::' + pIndexVersion + '::bdid'); // Has to match logical file naming
	kKeyIRS__irs5500_linkids			:=	index(dKeyIRS__irs5500_linkids, {ultid, orgid, seleid, proxid, powid, empid, dotid}, {dKeyIRS__irs5500_linkids}, '~prte::key::irs5500::' + pIndexVersion + '::linkids');

	return sequential(parallel(build(kKeyIRS__irs5500_bdid_null, update),
														 build(kKeyIRS__irs5500_linkids, update)),
									  PRTE.UpdateVersion('IRSKeys',														//	Package name
																			 pIndexVersion,												//	Package version
																			 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																			 'B',																	//	B = Boca, A = Alpharetta
																			 'N',																	//	N = Non-FCRA, F = FCRA
																			 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																		  ));

end;