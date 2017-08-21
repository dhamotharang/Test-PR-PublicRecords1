import	_control, PRTE_CSV;

export Proc_Build_CA_Sales_Tax_Keys(string pIndexVersion) := function
			
	rKeyCA_Sales_Tax__bdid	:=
	record
		PRTE_CSV.CA_Sales_Tax.rthor_data400__key__ca_sales_tax_bdid;
	end;
			
	rKeyCA_Sales_Tax__linkids	:=
	record
		PRTE_CSV.CA_Sales_Tax.rthor_data400__key__ca_sales_tax_linkids;
	end;			
			
	dKeyCA_Sales_Tax__bdid		:= 	project(PRTE_CSV.CA_Sales_Tax.dthor_data400__key__ca_sales_tax_bdid, rKeyCA_Sales_Tax__bdid);	
	dKeyCA_Sales_Tax__linkids	:= 	project(PRTE_CSV.CA_Sales_Tax.dthor_data400__key__ca_sales_tax_linkids, rKeyCA_Sales_Tax__linkids);	
													
	kKeyCA_Sales_Tax__bdid		:=	index(dKeyCA_Sales_Tax__bdid, {bdid}, {dKeyCA_Sales_Tax__bdid}, '~prte::key::salestax::' + pIndexVersion + '::ca::bdid');
	kKeyCA_Sales_Tax__linkids	:=	index(dKeyCA_Sales_Tax__linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dKeyCA_Sales_Tax__linkids}, '~prte::key::salestax::' + pIndexVersion + '::ca::linkids');

	return	sequential(
											parallel(																																
																build(kKeyCA_Sales_Tax__bdid						    	, update),
																build(kKeyCA_Sales_Tax__linkids					    	, update)
																																																
															 ),
											PRTE.UpdateVersion('GovdataKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;
