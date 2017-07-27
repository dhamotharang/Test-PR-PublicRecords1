IMPORT MDR,progressive_phone,Phone_Shell;

EXPORT HelperFunctions := MODULE

	//Function to determine which version of WaterFall phones/ contact plus is running
	EXPORT FN_GetVersion(STRING25 scoreModel='',boolean callMetronet=false,boolean UsePremiumSource_A=false):= FUNCTION
	  //Note that metronet is an actual GW that we pay for each hit regardless of the phone being returned in final output or not,
		//However, PremiumSource_A (Equifax) is a flat file (not a gateway) so we pay per phones displayed in output and not phones accessed.
		PPC := progressive_phone.Constants;
		CallExternalSources := callMetronet or UsePremiumSource_A;
		Score_Model_Name := StringLib.StringToUpperCase(scoreModel);
		// Running_Version := ENUM(UNSIGNED1,CP_V1=1,CP_V3=2,WFP_V6=3,WFP_V8=4);
		v := MAP(Score_Model_Name IN PPC.WFP_V8_CP_V3_MODEL_NAMES and ~CallExternalSources => PPC.Running_Version.WFP_V8,
						 Score_Model_Name IN PPC.WFP_V8_CP_V3_MODEL_NAMES and  CallExternalSources => PPC.Running_Version.CP_V3,
						 Score_Model_Name = ''                            and ~CallExternalSources => PPC.Running_Version.WFP_V6,
						 Score_Model_Name = ''                            and  CallExternalSources => PPC.Running_Version.CP_V1,0);
		RETURN v;
	END;
	
	//Function to map the version name for output
	v_enum := progressive_phone.Constants.Running_Version;
	EXPORT FN_GetVersionName(v_enum version):= FUNCTION
		// Running_Version := ENUM(UNSIGNED1,CP_V1=1,CP_V3=2,WFP_V6=3,WFP_V8=4);
		v := CASE(version,
											v_enum.CP_V1  => 'CP_V1',
											v_enum.CP_V3  => 'CP_V3',
											v_enum.WFP_V6 => 'WFP_V6',
											v_enum.WFP_V8 => 'WFP_V8',
											'');
		RETURN v;
	END;
	
	//Function that filters out phones per score threshold. This is purposely done here to ensure that Metronet roayalties are tracked before the filter is applied.
	EXPORT FN_FilterPerScore(f_out_) := FUNCTIONMACRO
	
		//filter output per score threshold
		f_out_post_score_threshold_filter := f_out_((INTEGER)phone_score >= Phone_Shell.Constants.Default_PhoneScore);
		//filter output per maxPhoneCount //defaulted to 1000 phones
		f_out_post_maxPhoneCount_filter := TOPN(GROUP(SORT(UNGROUP(f_out_post_score_threshold_filter), acctno, -(INTEGER)phone_score, -subj_date_last, subj_phone10, subj_date_first),acctno),
																			 progressive_phone.waterfall_phones_options.MaxPhoneCount, acctno, -(INTEGER)phone_score, -subj_date_last, subj_phone10, subj_date_first);
		
		RETURN f_out_post_maxPhoneCount_filter;

	ENDMACRO;
	
  //needs to be set after the phones are sorted. Integrator code only displayed in BATCH WFP_V8 and CP_V3 queries
	EXPORT FN_GetIntegratorCode(string1 p_confirmed,integer p_count,string p_relation):= FUNCTION
		position_code := CASE(p_count,
											1=>'1',2=>'2',3=>'3',4=>'4',5=>'5',6=>'6',7=>'7',8=>'8',9=>'9',10=>'A',
											11=>'B',12=>'C',13=>'D',14=>'E',15=>'F',16=>'G',17=>'H',18=>'I',19=>'J',
											20=>'K',21=>'L',22=>'M',23=>'N',24=>'O',25=>'P',26=>'Q',27=>'R',
											28=>'S',29=>'T',30=>'U',31=>'V',32=>'W',33=>'X',34=>'Y',35=>'Z','');
											
		relation_code := CASE(p_relation,
										'ASSOCIATE'=>'A','ASSOCIATE BY ADDRESS'=>'B','ASSOCIATE BY BUSINESS'=>'C','ASSOCIATE BY PROPERTY'=> 'D',
										'ASSOCIATE BY SSN'=>'E','ASSOCIATE BY SHARED ASSOCIATES'=>'F','ASSOCIATE BY VEHICLE'=>'G','BROTHER'=>'H',
										'CHILD'=>'I','DAUGHTER'=>'J','FATHER'=>'K','GRANDDAUGHTER'=>'L','GRANDFATHER'=>'M',
										'GRANDMOTHER'=>'N','GRANDPARENT'=>'O','GRANDSON'=>'P','HUSBAND'=>'Q','MOTHER'=>'R','NEIGHBOR'=>'S',
										'PARENT'=>'T','RELATIVE'=>'U','SIBLING'=>'V','SISTER'=>'W','SON'=>'X','SPOUSE'=>'Y','SUBJECT'=>'Z',
										'SUBJECT AT HOUSEHOLD'=>'1','WIFE'=>'2','GRANDCHILD'=>'3','');

		//dup_phone_flag + phone position + relationship code
		string3 integrator_code:= p_confirmed + position_code + relation_code;

		//to stay within the string3 character limit, we only support integrator codes for the first 35 phones
		RETURN if(p_count<=progressive_phone.Constants.max_integrator,integrator_code,'');
	END;
	
END;