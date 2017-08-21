 'todo';

import	_control, BadAddresses;

Export Proc_Build_BadAddresses := Function
pversion := '20140821'; // Change this date when building new PRTE Keys.
KeyAddress_Lay:= RECORD
			BadAddresses.Layouts.Lay_KeyAddress;
			unsigned8 __internal_fpos__;
 END;
 
ds_badAddr_Address := dataset([],KeyAddress_Lay); 
 
BadAddrs_AddressKey := buildindex(index(ds_badAddr_Address,{Address, City, State},{ds_badAddr_Address},'keyname'),'~prte::key::BadAddresses::'+ pVersion +'::Address',update);

 Result := Sequential( BadAddrs_AddressKey,
												PRTE.UpdateVersion('BadAddressesKeys',		//	Package name
																pVersion,					//	Package version
																'uma.pamarthy@lexisnexis.com',	//	Who to email with specifics
																'B',									//	B = Boca, A = Alpharetta
																'N',									//	N = Non-FCRA, F = FCRA
																'N'									//	N = Do not also include boolean, Y = Include boolean, too
															));
															
Return Result;
End;