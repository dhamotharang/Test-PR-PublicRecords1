import	_control, PRTE_CSV, ut;

import CustomBankTransaction;

EXPORT Proc_Build_CustombankTransaction_keys(string pIndexVersion) := 

function

rKeyCustombanktransaction__did	:=
	record
		CustomBankTransaction.layouts.base;
	end;
	
dKeyCustombanktransaction__did		:= 	dataset([], rKeyCustombanktransaction__did);

//build index 
	kKeyCustombanktransaction__did		:=	index(dKeyCustombanktransaction__did(did > 0), {did}, {dKeyCustombanktransaction__did}, 
		                                    '~prte::key::chase::' + pIndexVersion + '::did');	
	return	sequential( 
											build(kKeyCustombanktransaction__did, update),
											PRTE.UpdateVersion('CustombanktransactionKeys',												//	Package name
											pIndexVersion,												//	Package version
											_control.MyInfo.EmailAddressNormal,	//	Whom to email with specifics
											'B',																	//	B = Boca, A = Alpharetta
											'N',																	//	N = Non-FCRA, F = FCRA
											'N'																	//	N = Do not also include boolean, Y = Include boolean, too
										 ));

end;		