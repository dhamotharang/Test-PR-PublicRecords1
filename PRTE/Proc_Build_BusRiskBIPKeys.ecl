import	_control;

export Proc_Build_BusRiskBIPKeys(string pIndexVersion) := function

keyrecord := RECORD
  string2 source;
  string1 sourceclass;
	unsigned8 __internal_fpos__;
END;
//{ string2 source, string1 sourceclass, unsigned8 __internal_fpos__ };

return	sequential(
					parallel(		
						 buildindex(index(dataset([],keyrecord),{source},{dataset([],keyrecord)},'keyname')
						 ,'~prte::key::bip::business_risk::' + pIndexVersion + '::allowedsources',update) 
 																	 ),
						PRTE.UpdateVersion('BusRiskBIPKeys',			         	//	Package name
						  							pIndexVersion,											//	Package version
							  						_control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
														 'B',																//	B = Boca, A = Alpharetta
														 'N',																//	N = Non-FCRA, F = FCRA
														 'N'));															//	N = Do not also include boolean, Y = Include boolean, too
end;
 
