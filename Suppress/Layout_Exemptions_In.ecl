EXPORT Layout_Exemptions_In := RECORD

	STRING      typ;                                        //Dataset,BuildTemplate
	UNSIGNED    master_build_id;                            //numeric dataset master build id
    STRING      name;                                       //name of the build in Orbit
	STRING      act;                                        //CCPA,Massachusetts Law,mypae,piesept2019_2,sbfe1,SBFE3 ...
    UNSIGNED4   global_sid;                                 //global_sid associated with the dataset
    STRING      external_source_code;                       //
    STRING      source_code;                                //
    STRING      source_type;                                //NAPP|PRCOD,SBFEC, GTWL, etc
    STRING      professional_flag;                          //Contains Professional Information and not consumer only information will available at  PIE and PAE
    STRING      data_based_exemptions;                      //DDPA|FCRA|NONE, FCRA|GLBA, HIPAA, etc
    STRING      usage_based_exemptions;                     //DPPA,FCRA,btpae,GLBA|utbws,DPPA |PRQA, etc

END;