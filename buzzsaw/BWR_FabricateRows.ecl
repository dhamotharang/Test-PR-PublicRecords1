// BWR_FabricateRows
//
//
//
// This just morphs one octet in the src and dest at a time.
// If more data is needed then I'll need to morph two or three octets at a time.
//
QSTRING15 MorphIP(QSTRING15 IP, INTEGER c) := FUNCTION

	srcoffset1 := StringLib.StringFind(ip,'.',c);
	srcoffsetTest := StringLib.StringFind(ip,'.',c+1);
	UNSIGNED1 sOctet := (UNSIGNED1) ip[srcoffset1+1..];
	QSTRING15 newIp := if(c = 4, ip, 
											if(srcoffsetTest = 0, ip[1..srcoffset1] + (QSTRING) (sOctet ^ 0xff),
																	ip[1..srcoffset1] + (QSTRING) (sOctet ^ 0xff) + ip[srcoffsetTest..]));
	return newIp;
END;

MorphFile(STRING rawFilename, 
					STRING1 wallId,
					INTEGER2 year = 2006) := FUNCTION
		
		STRING cookedFilename := buzzsaw.Mod_data.FN_DAILY_STEM + '::' + year + '_' + wallid + '_raw';
		
		//                            12345678901234567890
		// The data loks like this..."MAY  1 00:00:02.695 " or
		// "APR 30 23:59:57.045 " ...no big need here for regEx
		//
		buzzsaw.Mod_Data.L_Firewall_RawMeatWithYearEtc MorphRows(buzzsaw.Mod_Data.L_Firewall_RawMeatWithYearEtc l, 
																															INTEGER c) := TRANSFORM
				SELF.year := year;
				SELF.firewall := wallid;
				SELF.srcip := MorphIP(l.srcip,c);
				SELF.destip :=  MorphIP(l.destip,c);
				SELF := l;
		END;

		ds_Parsed := NORMALIZE(	DATASET(rawFilename,buzzsaw.Mod_Data.L_Firewall_RawMeatWithYearEtc,CSV)  , 
												4,
												MorphRows(LEFT, COUNTER));
			
		return SEQUENTIAL(
		
							FileServices.StartSuperFileTransaction(),
							IF(NOT FileServices.SuperFileExists(buzzsaw.Mod_Data.FN_F_TestInput_SF), 
								FileServices.CreateSuperFile(buzzsaw.Mod_Data.FN_F_TestInput_SF)),
							FileServices.RemoveSuperFile(buzzsaw.Mod_Data.FN_F_TestInput_SF, cookedFilename),
							FileServices.FinishSuperFileTransaction(), 
							
							FileServices.StartSuperFileTransaction(),
							output(ds_Parsed, , cookedFilename, OVERWRITE);
							FileServices.AddSuperFile(buzzsaw.Mod_Data.FN_F_TestInput_SF, cookedFilename),
							FileServices.FinishSuperFileTransaction()
							
						);
	END;

DupeFiles(year) := macro
	MorphFile(Buzzsaw.Mod_Data.FN_F_wall3,'3', year );
	MorphFile(Buzzsaw.Mod_Data.FN_F_wallsand, 's', year );
	MorphFile(Buzzsaw.Mod_Data.FN_F_walltiger, 't', year );
	MorphFile(Buzzsaw.Mod_Data.FN_F_wallwhale, 'w', year );
ENDmacro;	

DupeFiles(1997);
DupeFiles(1998);
DupeFiles(1999);
DupeFiles(2000);
DupeFiles(2001);
DupeFiles(2002);
DupeFiles(2003);
DupeFiles(2004);
DupeFiles(2005);
DupeFiles(2006);

