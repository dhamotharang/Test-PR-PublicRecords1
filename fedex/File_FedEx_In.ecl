import	ut;
export	file_fedex_in	:=	dataset(	ut.foreign_prod+'~thor_200::in::fedex::nohit',
																		FedEx.Layout_FedEx.Prepped,
																		xml('addressupdate/records/record')
																	);