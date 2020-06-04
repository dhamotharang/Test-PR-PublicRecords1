EXPORT Layout_Exemptions_Base := RECORD

	UNSIGNED4	dt_vendor_first_reported;
	UNSIGNED4	dt_vendor_last_reported;
	UNSIGNED4	process_date;
	STRING1		history_flag;								//blank: current, H: Historical
    STRING20    domain_id;                                  //Derived from input file, it can be PR_NPD, PR_PD, HC, INS
    STRING1     professional_flag;                          //professional data and not consumer only - Y|N| ,
	STRING30    typ;                                        //Dataset,BuildTemplate
	UNSIGNED    master_build_id;                            //numeric dataset master build id
    STRING100   name;                                       //name of the build in Orbit
	STRING30    act;                                        //CCPA,Massachusetts Law,mypae,piesept2019_2,sbfe1,SBFE3 ...
    UNSIGNED4   global_sid;                                 //global_sid associated with the dataset
    STRING50    external_source_code;                       //
    STRING50    source_code;                                //
    STRING50    source_type;                                //NAPP|PRCOD,SBFEC, GTWL, etc
    STRING50    opt_out_category;                           //For future use
    STRING50    data_based_exemptions;                      //DDPA|FCRA|NONE, FCRA|GLBA, HIPAA, etc
    STRING50    usage_based_exemptions;                     //DPPA,FCRA,btpae,GLBA|utbws,DPPA |PRQA, etc
    STRING50    category;                                   //CAT1..CAT11 where CAT9 is professional flag
    UNSIGNED8   rcid;
END;