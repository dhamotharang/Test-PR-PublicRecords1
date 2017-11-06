IMPORT bank_routing,Data_Services,Doxie;

file_in := bank_routing.Files.base;

bank_routing_RTN_base	:=	PROJECT(file_in(routing_number_MICR<>'0'), bank_routing.layouts.base_rtn);

EXPORT key_rtn := INDEX(bank_routing_RTN_base,
                        {routing_number_MICR,state,city_town,zip_code},
                        {bank_routing_RTN_base},
                        Data_Services.Data_location.Prefix('bank_routing')+'thor_data400::key::Bank_Routing::' + Doxie.Version_SuperKey+'::RTN');