IMPORT bank_routing,Data_Services,Doxie;

file_in := bank_routing.Files.base;

bank_routing_RTN_base	:=	PROJECT(file_in(routing_number_MICR<>'0',address_type='B',current_record='Y'), bank_routing.layouts.base_rtn);

EXPORT key_rtn := INDEX(bank_routing_RTN_base,
                        {routing_number_MICR,state,city_town,zip_code},
                        {bank_routing_RTN_base},
                        bank_routing.thor_cluster + 'key::Bank_Routing::' + Doxie.Version_SuperKey+'::RTN');