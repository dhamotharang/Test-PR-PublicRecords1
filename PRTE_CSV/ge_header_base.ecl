import address,ut,lib_addrclean, PRTE2, PRTE2_Common;

export ge_header_base := module

	// when running in dev the files simply are not there or are old layouts and don't work.
	// If running in prod this is a no-op, just returns '' -- new approach we need to do.
	EXPORT Add_Foreign_prod					:= PRTE2_Common.Constants.Add_Foreign_prod; // a function

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20110527';
	shared	lCSVVersion1				:=	'20120131';
	shared	lCSVVersion2				:=	'20120208';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.NewDataFilesBaseName + lSubDirName;
	export unsigned6 GE_INIT_DID := 888800000000;
	export unsigned6 Excelon_INIT_DID :=  888805000000;
	export unsigned6 Santander_INIT_DID :=  888806000000;
	export unsigned6 test_seed_INIT_DID :=  888807000000;
	export unsigned6 Alpharetta_Ins_INIT_DID := 888809000000;  // thru 888908999999
	export unsigned6 RBS_INIT_DID := 888909000000;
	export unsigned6 AMEX_INIT_DID := 888910000000;
	export unsigned6 captone_INIT_DID := 888920000000;
	export unsigned6 citi_INIT_DID := 888930000000;
	// as of 2/4/2014 we decided it was more important to keep single DID for foreclosure/LNP
	// export unsigned6 LNProperty_INIT_DID := 888810000000;		
	// keeping it commented in case we decide later to code to offset differently but we'd have to
	// do something to handle what offset to use if a DID is in BOTH foreclosures and LNP.

	EXPORT rCustSeed := record,MAXLENGTH(10000)
			string fname;
			string lname;
			string mname;
			string addr;
			string filler1;
			string filler2;
			string city;
			string st;
			string zip;
			string phone;
			string dob;
			string ssn;
	END;

	EXPORT file_captone_prct := dataset(Add_Foreign_prod('~prte::in::header::captone'), rCustSeed,flat);
	EXPORT file_amex_prct := dataset(Add_Foreign_prod('~prte::in::header::amex'), rCustSeed,flat);
	EXPORT file_rbs_prct := dataset(Add_Foreign_prod('~prte::in::header::rbs'), rCustSeed,flat);
	EXPORT file_citi_prct := dataset(Add_Foreign_prod('~prte::in::header::citi'), rCustSeed,flat);

	export rheader_file_on_lz	:=
	record
		string fname;
		string lname;
		string mname;
		string addr;
		unsigned3 dt_first_seen;
		unsigned3 dt_last_seen;
		string city;
		string st;
		string zip;
		string phone;
		string dob;
		string ssn;
		
	end;

	export dheader_file_on_lz := dataset(Add_Foreign_prod('~prte::in::header::ge'), rheader_file_on_lz,flat);

	export rExcelon_file_on_lz	:=
	record
		string fname;
		string lname;
		string mname;
		string addr;
		string filler1;
		string filler2;
		string city;
		string st;
		string zip;
		string phone;
		string dob;
		string ssn;
		string dt_first_seen;
		string dt_last_seen;
		
	end;
	export dExcelon_file_on_lz := dataset(Add_Foreign_prod('~prte::in::header::excelon'),rExcelon_file_on_lz,flat);

	export rSantander_file_on_lz	:=
	record
		string fname;
		string lname;
		string addr1;
		string addr2;
		string st;
		string zip;
		string ssn;
		string hPhone;
		string cPhone;
	end;

	export dSantander_file_on_lz := dataset(Add_Foreign_prod('~prte::in::header::santander'), rSantander_file_on_lz, flat);


	ds := dataset([
    {'joseosky', 'bellosky', '', '101 memory lane', '', '', 'grandcity', 'IL', '59981', '9998887777', '', '9998887776', '201001', '201203'}
    ,{'sharonsky', 'bellosky', '', '102 memory lane', '', '', 'grandcity', 'IL', '59981', '9998887777', '', '9998887776', '201001', '201203'}
    ,{'jordano', 'belloski', '', '1021 memory lane', '', '', 'grandcity', 'IL', '59981', '9998887476', '', '591680000', '201001', '201203'}
    ,{'devina', 'jacksonia', '', '227 parket ln', '', '', 'littleville', 'GA', '59981', '9993887776', '', '592680000', '198201', '199912'}
    ,{'berbera', 'hersey', '', '3891 ambrosia place', '', '', 'fullertowne', 'AL', '59981', '7998287726', '', '592640000', '190001', '190012'}
    ,{'jonah', 'pedroster', '', '1323 cemetery way', '', '', 'payneful', 'TX', '59981', '9993887776', '', '595720000', '190101', '190112'}
    ,{'della', 'mcconnery', '', '74522 destiny street', '', '', 'duality city', 'FL', '59981', '9298887976', '', '592700000', '190201', '190212'}
    ,{'jendo', 'belloski', '', '1105 memory lane', '', '', 'grandcity', 'IL', '59981', '9998887775', '', '590700000', '190301', '190312'}
    ,{'sharona', 'osboard', '', '12 watcher st', '', '', 'flinton', 'MI', '59981', '9998881774', '', '595700000', '201001', '201203'}
    ,{'carmon', 'jeffers', '', '1612 barton dr', '', '', 'grandon hills', 'OK', '59981', '9998887276', '', '594680000', '191301', '195712'}
    ,{'randel', 'rellosky', '', '139 equity lane', '', '', 'danderville', 'FL', '59981', '9998887876', '', '595740000', '201001', '201012'}
    ,{'sheldon', 'torobalmer', '', '9104 pembrooke ave', '', '', 'landerton', 'MT', '59981', '9998187176', '', '590720000', '190201', '190212'}
    ,{'hellow', 'yellow', '', '153 nw 17th pl', '', '', 'bustem downs', 'SC', '59981', '9999887776', '', '591680000', '190001', '190303'}
	], rExcelon_file_on_lz)
;
	export dTest_seed_file_on_lz := ds;



	export layout_payload := PRTE_CSV.Header.rthor_data400__key__header__data_new2;	
	
	// *************************************************************************************************
	// **************************** Alpharetta Customer Test data additions  ***************************
	// *************************************************************************************************

	Lindas300Foreclosure_file_on_lz := PRTE2_Common.Cross_Module_Files.Lindas300Foreclosure_file_on_lz;
	Brads50kForeclosure_file_on_lz := PRTE2_Common.Cross_Module_Files.Brads50kForeclosure_file_on_lz;
	// ===================================================================================================
	// LCAIN300 - USE THIS IF WE WANT TO KEEP LINDA's 300 test records at first. Else use just Brad50k
	// EXPORT Foreclosure_file_on_lz := Brads50kForeclosure_file_on_lz + Lindas300Foreclosure_file_on_lz;
	EXPORT Foreclosure_file_on_lz := Brads50kForeclosure_file_on_lz;
	// ===================================================================================================
	
	Lindas300LNP_DS_on_lz		:= PRTE2_Common.Cross_Module_Files.Lindas300LNP_DS_on_lz;
	Brads50kLNP_DS_on_lz := PRTE2_Common.Cross_Module_Files.Brads50kLNP_DS_on_lz;
	// ===================================================================================================
	// LCAIN300 - USE THIS IF WE WANT TO KEEP LINDA's 300 test records at first. Else use just Brads50kLNP_DS_on_lz
	// HOWEVER - LNP data was never used in the build by Linda's code, so the 300 were never placed into the header file
	// EXPORT LNProperty_file_on_lz := Brads50kLNP_DS_on_lz + Lindas300LNP_DS_on_lz;
	EXPORT LNProperty_file_on_lz := Brads50kLNP_DS_on_lz;
	// ===================================================================================================
	// ===================================================================================================
	AlphaDIDsHeaderBaseName := PRTE2_Common.Cross_Module_Files.AlphaDIDsHeaderBaseName;
	EXPORT AlphaDIDsHeaderDS := DATASET(AlphaDIDsHeaderBaseName,layout_payload,THOR);	//smaller, faster DID Lookups, no relationships
	AlphaFinalHeaderName := PRTE2_Common.Cross_Module_Files.AlphaFinalHeaderBaseName;
	EXPORT AlphaFinalHeaderDS := DATASET(AlphaFinalHeaderName,layout_payload-rtitle,THOR);		//DIDs plus relationships
	// ===================================================================================================

	// Danny's file ???  Any purpose for this file ???  It was commented out in Linda's last version
  // Export Foreclosure_file_on_lz := DATASET(ut.foreign_prod +'~thor_data400::in::foreclosure_addresses_083112.csv',prte2.layouts.foreclosure_batch_in,CSV(HEADING(1),QUOTE('"'),MAXLENGTH(32768)));
  // Export Foreclosure_file_on_lz := DATASET('~thor_data400::in::foreclosure_addresses_083112.csv',prte2.layouts.foreclosure_batch_in,CSV(HEADING(1),QUOTE('"'),MAXLENGTH(32768)));
	
end;