IMPORT STD, eCrash_Services;

EXPORT Constants := MODULE
		EXPORT string Hyphen := '-';
		EXPORT string DIRECT_hit := 'DIRECT';
		EXPORT string POSSIBLE_hit := 'POSSIBLE';
		EXPORT Iyetek_src := ['TM','TF'];
		EXPORT Inhouse_src := ['EA','EN'];
		
		EXPORT groupable_report_codes := ['A','DE'];

		EXPORT ecrash_src_codes:=[Inhouse_src, Iyetek_src];

		no_state_user_set := ['INTERNAL','PDUSERS'];
		EXPORT boolean b_internal_pduser(string user_type) := STD.Str.ToUpperCase(user_type) in no_state_user_set;
																																																															
		EXPORT  boolean no_state_search(eCrash_Services.IParam.searchrecords in_mod) :=/*b_internal_pduser(in_mod.UserType) and */COUNT(in_mod.agencies(JurisdictionState <> '')) = 0;
		EXPORT  boolean no_jurisdiction_search(eCrash_Services.IParam.searchrecords in_mod) :=/*b_internal_pduser(in_mod.UserType) and */COUNT(in_mod.agencies(Jurisdiction <> '')) = 0;


		EXPORT	boolean use_rpt_num(eCrash_Services.IParam.searchrecords in_mod):= in_mod.reportnumber<>'';
		EXPORT	boolean hasDateOfLoss(eCrash_Services.IParam.searchrecords in_mod):= in_mod.dateofloss<>'';
		EXPORT	boolean use_dol_internal(eCrash_Services.IParam.searchrecords in_mod):=in_mod.dateofloss<>''/* and b_internal_pduser(in_mod.UserType)*/;

		EXPORT	boolean use_TX_rule(eCrash_Services.IParam.searchrecords in_mod):=in_mod.JurisdictionState='TX' and	
																														((if(in_mod.dateofloss<>'',1,0)+
																															if(in_mod.lastname<>'',1,0)+
																															if((in_mod.AccidentLocationStreet <>'' or in_mod.AccidentLocationCrossStreet 	<> ''),1,0))>1);
				

		// This is to find records if input matches the data ot input is blank
		export valid_match(string l, string r) := r='' or l=r;

		EXPORT contains_match(string l, string r):=	 /*r='' or*/ l=r or STD.Str.Find(l,r,1)>0 ;

		// W20111121-102256, prod: ~26K for eCrash, ~40K for 'A'
		EXPORT MAX_ACCIDENTS_PER_DAY := 30000; 	
		EXPORT MAX_REPORT_NUMBER := 1000;
		EXPORT MAX_PARTIAL_NUMBER := 10000;
		EXPORT MAX_RAW_PERSON_COUNT := 20000;
		EXPORT MAX_ACCIDENTS_PER_AGENCY_PER_DAY := 2000;
		EXPORT MAX_ACCIDENTS_PER_AGENCY_PER_LOCATION := 7000;
		EXPORT MAX_PERSON_RECORDS := 2000;
		
		//mbsi ids of agencies
		EXPORT REDACTION_AGENCY_LIST := [
			'1611397',
			'1530290',
			'1567990',
			'1589457',
			'1589657',
			'1590317',
			'1571856'
		];
		
		EXPORT searchDateRange(boolean hasInputDOL, STRING UserType) :=	MAP(NOT hasInputDOL => 90,
																				hasInputDOL and b_internal_pduser(UserType) => 30,
																				hasInputDOL and NOT b_internal_pduser(UserType) => 3,
																				0 );
																				
		EXPORT VENDOR_CODES_BYPASS_DELTABASE := ['COPLOGIC'];
		
		EXPORT VENDOR_CRASHLOGIC_ESP := 'CrashLogic';
		EXPORT VENDOR_CRASHLOGIC := 'KYCrashLogic';
		EXPORT DATA_SOURCE_IYETEK := 'IyeTek';
		EXPORT DATA_SOURCE_CRU := 'CRU';
		EXPORT REPORT_CODE_ACCIDENT := 'A';
		EXPORT REPORT_CODE_KY  := 'TM';
		EXPORT AGENCY_FLAG_APPEND := 'AP';
		EXPORT AGENCY_FLAG_OVERWRITE := 'OW';
		
		EXPORT Format_Report_Creation_Date(STRING inDate) := inDate[1..4] + Hyphen + inDate[5..6] + Hyphen + inDate[7..8];
END;

