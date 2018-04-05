import header,Data_Services,header_quick;

/*

NOTE ON DATA USAGE RESTRICTION:
---------------------------

LN must use the most current feed of Equifax Fraud Flag data
 as a TOTAL REPLACEMENT of any prior feeds of such data.

 LN may maintain historical Equifax Fraud Flags for analytic purposes 
(Including scoring, models and attributes, white papers, R&D)
 but not for display in current LN end user client solutions
 or for any other purpose. 

More details on the restriction can be found in:
Orbit -> Item Management -> Fraud Alert Flags 

*/


dummy_dataset := dataset([],
                        {header_quick.layout_fraud_flag_eq.key});

EXPORT key_fraud_flag_eq := 

    index(
            dummy_dataset,
            {did},
            {dummy_dataset},
            Data_Services.Data_location.Prefix('header_quick')+
            'thor_data400::key::HeaderQuick::fraud_flag::qa::eq'
          );
            