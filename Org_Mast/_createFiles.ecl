pVer := '20151012';


	EXPORT npi_in := record
		STRING10		LNFID;    								//NO00950944 100% 10  
		STRING10		NPI;        								//1992999890 100% 10  
		STRING1 		NPI_STATUS; 								//Y 100% 1 
	END;

myTestDataNpi := DATASET([
		{ 'N0','npi_0000', 'npi_St0'},
		{ 'N1','npi_1111', 'npi_St1'},
		{ 'N2','npi_2222', 'npi_St2'},
		{ 'N3','npi_3333', 'npi_St3'},
		{ 'N6','npi_6666', 'npi_St6'}
		], npi_in);

myInFileNpi := '~thor400_data::in::org_master::org_master_npi::' + pVer;
OUTPUT(myTestDataNpi, , myInFileNpi, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ), COMPRESSED, OVERWRITE);

	EXPORT pos_in := record
		STRING10		LNFID;           //NO00993054 100% 10  
		STRING10		POS_ID;            //793834 100% 10 Medicare POS Facility Identifier 
	END;

myTestDataPos := DATASET([
		{ 'N0','Pos_IDN000'},
		{ 'N1','Pos_IDN111'},
		{ 'N2','Pos_IDN222'},
		{ 'N3','Pos_IDN333'},
		{ 'N7','Pos_IDN777'}
		], Pos_in);

myInFilePos := '~thor400_data::in::org_master::org_master_Pos::' + pVer;
OUTPUT(myTestDataPos, , myInFilePos, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ), COMPRESSED, OVERWRITE);

	EXPORT dea_in := record
		STRING10		LNFID;             			//NO01025441 100% 10  
		STRING9 		DEA;                 			//RZ0462200 100% 9 DEA Number 
		STRING8 		DEA_SCHEDULE;        			//2 33N 93.42% 15 DEA Number 
		STRING8 		DEA_EXPIRATION_DATE; 			//20160531 93.42% 8 DEA Number 
		STRING1			DEA_BUSINESS_ACT_CODE;    //G 93.42% 1 DEA Number 
		STRING1			DEA_BUSINESS_ACT_SUBCODE;  //2 93.42% 1 DEA Number 
	END;

myTestDataDea := DATASET([
		{ 'N0','DEA_N0000', 'DEA_SCD0', 'DEA_EXP0', '0', '0'},
		{ 'N1','DEA_N1111', 'DEA_SCD1', 'DEA_EXP1', '1', '1'},
		{ 'N2','DEA_N2222', 'DEA_SCD2', 'DEA_EXP2', '2', '2'},
		{ 'N3','DEA_N3333', 'DEA_SCD3', 'DEA_EXP3', '3', '3'},
		{ 'N8','DEA_N8888', 'DEA_SCD8', 'DEA_EXP8', '8', '8'}
		], dea_in);

myInFileDea := '~thor400_data::in::org_master::org_master_dea::' + pVer;
OUTPUT(myTestDataDea, , myInFileDea, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ), COMPRESSED, OVERWRITE);


EXPORT aha_in := RECORD
  STRING10 LNFID;
	STRING49 AHA_ID;
END;

myTestDataAha := DATASET([
		{ 'N0','This is my AHA ID  0 -- ABCDEFGHIJKLMNOPQRSTUVWXYZ'},
		{ 'N1','This is my AHA ID  1 -- ABCDEFGHIJKLMNOPQRSTUVWXYZ'},
		{ 'N2','This is my AHA ID  2 -- ABCDEFGHIJKLMNOPQRSTUVWXYZ'},
		{ 'N3','This is my AHA ID  3 -- ABCDEFGHIJKLMNOPQRSTUVWXYZ'},
		{ 'N9','This is my AHA ID  9 -- ABCDEFGHIJKLMNOPQRSTUVWXYZ'}
		], aha_in);

myInFileAha := '~thor400_data::in::org_master::org_master_aha::' + pVer;
OUTPUT(myTestDataAha, , myInFileAha, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ), COMPRESSED, OVERWRITE);


EXPORT affiliations_in := RECORD
  STRING10 LNFID;
	STRING10 HMS_PIID;
	STRING13 FACTYPE;
END;

myTestDataAffs := DATASET([
		{ 'N0','hms_piid0','factype0'},
		{ 'N1','hms_piid1','factype1'},
		{ 'N2','hms_piid2','factype2'},
		{ 'N3','hms_piid3','factype3'},
		{ 'N10','hms_piid10','factype10'}
		], affiliations_in);

myInFileAffs := '~thor400_data::in::org_master::org_master_affiliations::' + pVer;
OUTPUT(myTestDataAffs, , myInFileAffs, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ), COMPRESSED, OVERWRITE);


	EXPORT organization_in := record
		STRING10		LNFID;                    //NO01036469 100% 10  
		STRING86		NAME;                       //AFTEROURS HOUSTON PA 100% 86  
		STRING55		ADDRESS1;                   //7545 S BRAESWOOD BLVD 100% 55 Address Line 1 
		STRING19		ADDRESS2;                   //STE B 34.27% 19 Address Line 2 
		STRING28		CITY;                       //HOUSTON 100% 28 City 
		STRING30		STATE;                      //TX 99.99% 30 State 
		STRING12		ZIP;                        //77071 99.99% 12 Zip Code 5 
		STRING4 		ZIP4;                       //1423 96.15% 4 Zip Code Plus-4 
		STRING17		PHONE1;                     //7137776515 97.65% 17 Phone number 1 
		STRING17		PHONE2;                     //??            0% 0 Phone number 2 
		STRING17		FAX;                        //7137775544 41.17% 17 Fax number 
		STRING9 		LID;                        //5713126 100% 9  
		STRING9 		AGID;                       //5713121 100% 9  
		STRING5 		CBSA_CODE;                  //26420 95.25% 5  
		STRING10		LATITUDE;                   //29.674736 100% 10  
		STRING11		LONGITUDE;                  //-95.512017 100% 11  
		STRING19		FACTYPE;                    //OUTPATIENT FACILITY 98.05% 19 Facility Type 
		STRING7 		ORG_TYPE_CODE;              //1016010 98.05% 7  
		STRING60		ORGTYPE;                    //Outpatient Facility, Urgent Care Center 98.05% 60 Organization Type 
		STRING42		LN_GP_SPEC1;                //Family Practice 6.514% 42  
		STRING42		LN_GP_SPEC2;                //??             0% 0  
		STRING7 		NCPDP;                      //2135956 5.269% 7  
		STRING1 		VENDIBILITY;                //N 100% 1  
	END;                         

  myTestDataOrgzn := DATASET([
		{ 'N0','name0','addr10','addr20','city0','st0','zip0','zip40','ph10','ph20','fax0','lid0','agid0','cbsa0','lat0','lon0','facty0','orgtc0','org type 0','sp10','sp20','ncpdp0','0'},
		{ 'N1','name1','addr11','addr21','city1','st1','zip1','zip41','ph11','ph21','fax1','lid1','agid1','cbsa1','lat1','lon1','facty1','orgtc1','org type 1','sp11','sp21','ncpdp1','a'},
		{ 'N2','name2','addr12','addr22','city2','st2','zip2','zip42','ph12','ph22','fax2','lid2','agid2','cbsa2','lat2','lon2','facty2','orgtc2','org type 2','sp12','sp22','ncpdp2','b'},
		{ 'N3','name3','addr13','addr23','city3','st3','zip3','zip43','ph13','ph23','fax3','lid3','agid3','cbsa3','lat3','lon3','facty3','orgtc3','org type 3','sp13','sp23','ncpdp3','c'},
		{ 'N4','name4','addr14','addr24','city4','st4','zip4','zip44','ph14','ph24','fax4','lid4','agid4','cbsa4','lat4','lon4','facty4','orgtc4','org type 4','sp14','sp24','ncpdp4','d'},
		{ 'N5','name5','addr15','addr25','city5','st5','zip5','zip45','ph15','ph25','fax5','lid5','agid5','cbsa5','lat5','lon5','facty5','orgtc5','org type 5','sp15','sp25','ncpdp5','e'},
		{ 'N11','name11','addr111','addr211','city11','st11','zip11','zip411','ph111','ph211','fax11','lid11','agid11','cbsa11','lat11','lon11','facty11','orgtc11','org type 11','sp111','sp211','ncpdp11','f'}
		], organization_in);

myInFileOrgzn := '~thor400_data::in::org_master::org_master_organization::' + pVer;
OUTPUT(myTestDataOrgzn, , myInFileOrgzn, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ), COMPRESSED, OVERWRITE);


	EXPORT crosswalk_in := record
		STRING10		LNFID;    								//NO01036838  
		STRING10		SOURCE;      								//NPI  
		STRING10 		PRIMARY_ID; 								//1265419428
	END;

myTestDataCrosswalk := DATASET([
		{ 'N0',	'src_0000', 'prim_id0'},
		{ 'N1',	'src_1111', 'prim_id1'},
		{ 'N2',	'src_2222', 'prim_id2'},
		{ 'N3',	'src_3333', 'prim_id3'},
		{ 'N12','src_1212', 'prim_id12'}
		], crosswalk_in);

myInFileCrosswalk := '~thor400_data::in::org_master::org_master_crosswalk::' + pVer;
OUTPUT(myTestDataCrosswalk, , myInFileCrosswalk, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ), COMPRESSED, OVERWRITE);
