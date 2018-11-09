IMPORT header,Data_Services,header_quick;

EXPORT file_fraud_flag_eq := 

    dataset(Data_Services.Data_location.Prefix('header_quick')+
            'thor_data400::base::headerquick::fraud_flag::eq',
            header_quick.layout_fraud_flag_eq.base,
            thor);