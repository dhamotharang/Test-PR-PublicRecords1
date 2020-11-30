import Data_Services;

export	file_fedex_in	:=
module

	export	Main					:=	dataset('~thor400_20::in::fedex::nohit::20201117',
										//dataset(Data_Services.foreign_prod+	'thor_200::in::fedex::nohit',
																			FedEx.Layout_FedEx.Clean,
																		xml('addressupdate/records/record')
																	);
																		
	
	export	Corrections		:=	dataset(		'~thor_200::in::fedex::nohit::corrections',
																			FedEx.Layout_FedEx.Clean,
																			csv(separator(','),terminator(['\r\n','\n']),quote('"')),
																			opt
																		)(record_id	!=	'record id');
	
end;