import lib_fileservices,_control;

_address	:= lib_fileservices.fileservices.Despray('~thor_data400::out::ixi_address'
					,_control.IPAddress.edata14,'/load01/IXI/desprayed_data/address',,,,TRUE);
_deed		:= lib_fileservices.fileservices.Despray('~thor_data400::out::ixi_deed'
					,_control.IPAddress.edata14,'/load01/IXI/desprayed_data/deed',,,,TRUE);
_people		:= lib_fileservices.fileservices.Despray('~thor_data400::out::ixi_people'
					,_control.IPAddress.edata14,'/load01/IXI/desprayed_data/people',,,,TRUE);
_raw		:= lib_fileservices.fileservices.Despray('~thor_data400::out::ixi_raw'
					,_control.IPAddress.edata14,'/load01/IXI/desprayed_data/raw',,,,TRUE);
_tax		:= lib_fileservices.fileservices.Despray('~thor_data400::out::ixi_tax'
					,_control.IPAddress.edata14,'/load01/IXI/desprayed_data/tax',,,,TRUE);


export despray := sequential(_address,_deed,_people,_raw,_tax);