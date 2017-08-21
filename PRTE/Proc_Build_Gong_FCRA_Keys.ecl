import	_control, PRTE_CSV, gong, risk_indicators;
previousVersion := '20130109';		

EXPORT Proc_Build_Gong_FCRA_Keys(string pIndexVersion) := function

dKeyGong__key__history__address	:= dataset([],PRTE_CSV.Gong.rthor_data400__key__gong_history__address);

kKeyGong__key__history__address := index(dKeyGong__key__history__address, 
             {prim_name,
		    st,    z5, prim_range,    sec_range,
			current_flag, business_flag},
		    {dKeyGong__key__history__address},
			'~prte::key::gong_history::fcra::' + pIndexVersion + '::address');
// **********************************

dKeyGong__key__history__phone	:= dataset([],PRTE_CSV.Gong.rthor_data400__key__gong_history__phone);	

kKeyGong__key__history__phone := index(dKeyGong__key__history__phone, 
			  {p7, p3, st, current_flag, business_flag},
		    {dKeyGong__key__history__phone},
			'~prte::key::gong_history::fcra::' + pIndexVersion + '::phone');
// **********************************

dKeyGong__key__history__did	:= dataset([],PRTE_CSV.Gong.rthor_data400__key__gong_history__did);	

kKeyGong__key__history__did := index(dKeyGong__key__history__did, 
						  {l_did, current_flag, business_flag},
						  {dKeyGong__key__history__did},
			'~prte::key::gong_history::fcra::' + pIndexVersion + '::did');
// **********************************
rPhoneTable := RECORD
	STRING10	phone10;
	BOOLEAN 	isCurrent;
	unsigned3 dt_first_seen;
	STRING20 	lname;
	string28 	prim_name;
	STRING10 	prim_range;
	string25 	city;
	string2  	state;
	STRING5  	zip5;
	STRING4  	zip4;
	boolean  	potDisconnect := false;
	BOOLEAN  	isaCompany := false;
	STRING1  	company_type := '';
	BOOLEAN  	company_type_A := false;
	string4  	sic_code := '';
	string120 company_name := '';
	unsigned3 hri_dt_first_seen := 0;
	STRING2 	nxx_type := '';
	integer did_ct;
	integer did_ct_c6;	
END;
dPhoneTable := dataset([], rPhoneTable);
Key_FCRA_Business_Header_Phone_Table_Filtered_V2 := index(dPhoneTable, {phone10}, {dPhoneTable},
		'~prte::key::business_header::filtered::fcra::' + pIndexVersion + '::hri::phone10_v2');

	return	sequential(
				parallel(
				// Gong history keys
					build(kKeyGong__key__history__address, update),
					build(kKeyGong__key__history__phone, update),
					build(kKeyGong__key__history__did, update),
					build(Key_FCRA_Business_Header_Phone_Table_Filtered_V2, update)
				)
				//,CopyMissingKeys('GongKeys',pIndexVersion,previousVersion)
				,PRTE.UpdateVersion('FCRA_GongKeys',		//	Package name
					 pIndexVersion,												//	Package version
					 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
					'B',		//	B = Boca, A = Alpharetta
					'F',		//	N = Non-FCRA, F = FCRA
					'N'			//	N = Do not also include boolean, Y = Include boolean, too
					)
				);


END;