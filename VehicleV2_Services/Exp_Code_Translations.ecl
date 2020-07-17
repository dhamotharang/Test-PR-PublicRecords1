IMPORT STD;
EXPORT Exp_Code_Translations := MODULE

  EXPORT dppaRec := RECORD
    STRING2 useCode;
    STRING1 subCategoryCode;
  END;

  EXPORT get_dppa(STRING RealTimePermissibleUse) := FUNCTION
    RTPermissibleUse := TRIM(STD.STR.ToUpperCase(RealTimePermissibleUse));
    STRING2 useCode :=
    MAP(RTPermissibleUse = 'GOVERNMENT' => '1',
        RTPermissibleUse = 'LAWENFORCEMENT' => '1',
        RTPermissibleUse = 'PARKING' => '1',
        RTPermissibleUse = 'VERIFYFRAUDORDEBT' => '3',
        RTPermissibleUse = 'LITIGATION' => '4',
        RTPermissibleUse = 'INSURANCECLAIMS' => '6',
        RTPermissibleUse = 'INSURANCEUNDERWRITING' => '6',
        RTPermissibleUse = 'TOWEDANDIMPOUNDED' => '7',
        RTPermissibleUse = 'PRIVATEINVESTIGATIVE' => '8',
        RTPermissibleUse = 'PRIVATEINVESTIGATIVELITIGATION' => '8',
        RTPermissibleUse = 'EMPLOYERVERIFY' => '9',
        RTPermissibleUse = 'PRIVATETOLL' => '10',
        '');
    STRING1 subCategoryCode :=
    MAP(RTPermissibleUse = 'GOVERNMENT' => 'N',
        RTPermissibleUse = 'LAWENFORCEMENT' => 'L',
        RTPermissibleUse = 'PARKING' => 'P',
        RTPermissibleUse = 'VERIFYFRAUDORDEBT' => 'U',
        RTPermissibleUse = 'LITIGATION' => 'U',
        RTPermissibleUse = 'INSURANCECLAIMS' => 'C',
        RTPermissibleUse = 'INSURANCEUNDERWRITING' => 'W',
        RTPermissibleUse = 'TOWEDANDIMPOUNDED' => 'U',
        RTPermissibleUse = 'PRIVATEINVESTIGATIVE' => '3',
        RTPermissibleUse = 'PRIVATEINVESTIGATIVELITIGATION' => '4',
        RTPermissibleUse = 'EMPLOYERVERIFY' => 'U',
        RTPermissibleUse = 'PRIVATETOLL' => 'U',
        '');
    RETURN DATASET([{useCode,subCategoryCode}],dppaRec);
  END;

  EXPORT errCdMsg := RECORD
    STRING1 code;
    STRING64 msg;
  END;

  EXPORT errorIndicator(STRING code) := FUNCTION
    STRING64 msg :=
    MAP(code = 'I' => 'Invalid Password/ID',
        code = 'Q' => 'Missing Quoteback',
        code = 'U' => 'Invalid DPPA Usage Request',
        code = 'P' => 'Invalid Process Type',
        code = 'G' => 'Gateway Exception',
        code = 'R' => 'Invalid Request Exception',
        code = 'S' => 'Sql Exception',
        code = 'E' => 'General Exception',
        code = 'V' => 'Invalid IP Exception',
        'Unknown('+code+')');
    RETURN DATASET([{code,msg}],errCdMsg);
  END;

  EXPORT noDataCode(STRING code) := FUNCTION
    STRING64 msg :=
    MAP(code = 'D' => 'No VIN match',
        code = 'E' => 'No plate match',
        code = 'T' => 'Too many addresses',
        code = 'N' => 'No data',
        code = 'O' => 'No address match',
        code = 'R' => 'Total vehicle restriction',
        code = 'S' => 'Missing apartment number',
        'Unknown('+code+')');
    RETURN DATASET([{code,msg}],errCdMsg);
  END;

  // VIN Gateway Use Matrix by State - LN 4 0 - FINAL 05-12-2010.doc
  EXPORT get_permittedUse(STRING state, DATASET(dppaRec) in_dppa) := FUNCTION
    STRING3 dppa := TRIM(TRIM(in_dppa[1].useCode)+in_dppa[1].subCategoryCode);
    BOOLEAN permitted := MAP(
    state='AK'=>CASE(dppa,'83'=>FALSE,'84'=>FALSE, TRUE),
    state='AL'=>CASE(dppa,'83'=>FALSE,'84'=>FALSE,'9U'=>FALSE,TRUE),
    state='AR'=>CASE(dppa,'1N'=>FALSE,'1L'=>FALSE,'7U'=>FALSE,'9U'=>FALSE,'10U'=>FALSE,TRUE),
    state='AZ'=>CASE(dppa,'4U'=>FALSE,'7U'=>FALSE,'83'=>FALSE,'84'=>FALSE,'9U'=>FALSE,TRUE),
    state='CA'=>FALSE,
    state='CT'=>CASE(dppa,'1N'=>FALSE,'1L'=>FALSE,'1P'=>FALSE,'7U'=>FALSE,'83'=>FALSE,'84'=>FALSE,'9U'=>FALSE,'10U'=>FALSE,TRUE),
    state='DE'=>CASE(dppa,'83'=>FALSE,'84'=>FALSE,TRUE),
    state='FL'=>CASE(dppa,'83'=>FALSE,'84'=>FALSE,TRUE),
    state='GA'=>CASE(dppa,'7U'=>FALSE,'83'=>FALSE,'84'=>FALSE,'9U'=>FALSE,'10U'=>FALSE,TRUE),
    state='HI'=>FALSE,
    state='IA'=>CASE(dppa,'9U'=>FALSE,'10U'=>FALSE,TRUE),
    state='IN'=>CASE(dppa,'4U'=>FALSE,'7U'=>FALSE,'83'=>FALSE,'84'=>FALSE,'9U'=>FALSE,'10U'=>FALSE,TRUE),
    state='KS'=>CASE(dppa,'3U'=>FALSE,'4U'=>FALSE,'7U'=>FALSE,'83'=>FALSE,'84'=>FALSE,'9U'=>FALSE,'10U'=>FALSE,TRUE),
    state='KY'=>CASE(dppa,'9U'=>FALSE,TRUE),
    state='MD'=>CASE(dppa,'83'=>FALSE,'84'=>FALSE,'9U'=>FALSE,TRUE),
    state='MO'=>CASE(dppa,'83'=>FALSE,'84'=>FALSE,'9U'=>FALSE,TRUE),
    state='MT'=>CASE(dppa,'83'=>FALSE,'84'=>FALSE,'9U'=>FALSE,'10U'=>FALSE,TRUE),
    state='NC'=>CASE(dppa,'7U'=>FALSE,'83'=>FALSE,'84'=>FALSE,'9U'=>FALSE,'10U'=>FALSE,TRUE),
    state='NH'=>FALSE,
    state='NJ'=>CASE(dppa,'83'=>FALSE,'84'=>FALSE,TRUE),
    state='NM'=>CASE(dppa,'83'=>FALSE,'84'=>FALSE,'9U'=>FALSE,TRUE),
    state='NV'=>CASE(dppa,'1P'=>FALSE,'3U'=>FALSE,'10U'=>FALSE,TRUE),
    state='NY'=>FALSE,
    state='OH'=>CASE(dppa,'83'=>FALSE,'84'=>FALSE,TRUE),
    state='OK'=>CASE(dppa,'3U'=>FALSE,'4U'=>FALSE,'6C'=>FALSE,'6W'=>FALSE,'7U'=>FALSE,'83'=>FALSE,'84'=>FALSE,'9U'=>FALSE,TRUE),
    state='OR'=>CASE(dppa,'1N'=>FALSE,'1L'=>FALSE,'1P'=>FALSE,'3U'=>FALSE,'4U'=>FALSE,'7U'=>FALSE,'83'=>FALSE,'84'=>FALSE,'9U'=>FALSE,'10U'=>FALSE,TRUE),
    state='PA'=>FALSE,
    state='SC'=>CASE(dppa,'7U'=>FALSE,'83'=>FALSE,'84'=>FALSE,'9U'=>FALSE,'10U'=>FALSE,TRUE),
    state='SD'=>CASE(dppa,'9U'=>FALSE,TRUE),
    state='TX'=>CASE(dppa,'7U'=>FALSE,'83'=>FALSE,'84'=>FALSE,TRUE),
    state='UT'=>CASE(dppa,'7U'=>FALSE,'83'=>FALSE,'84'=>FALSE,'9U'=>FALSE,'10U'=>FALSE,TRUE),
    state='VA'=>FALSE,
    state='WA'=>CASE(dppa,'6C'=>TRUE,'6W'=> TRUE,FALSE),
    TRUE);
    RETURN permitted;
  END;

  
  EXPORT plate_type_description(STRING code) := MAP(
    code = 'AG' => 'Agriculture',
    code = 'ANQ' => 'Antique',
    code = 'AR' => 'Amateur Radio',
    code = 'BOT' => 'Boat',
    code = 'CLG' => 'Clergy',
    code = 'CML' => 'Commercial',
    code = 'DAV' => 'Disabled Veteran',
    code = 'DE' => 'Driver Education',
    code = 'DLR' => 'Dealer',
    code = 'EA' => 'Educational Affiliation',
    code = 'EMR' => 'Emergency',
    code = 'ENV' => 'Environmental',
    code = 'EXT' => 'Exempt',
    code = 'FGV' => 'Federal Government',
    code = 'FNL' => 'Funeral',
    code = 'FOR' => 'Forestry',
    code = 'HCP' => 'Handicapped',
    code = 'LGV' => 'Local Government',
    code = 'LIV' => 'Livery',
    code = 'MFG' => 'Manufacturer',
    code = 'MH' => 'Military Honor',
    code = 'MIL' => 'Military',
    code = 'MOT' => 'Motorcycle',
    code = 'MUB' => 'Municipal Bus',
    code = 'OFF' => 'Official Representaive',
    code = 'OTH' => 'Other',
    code = 'PRV' => 'Private',
    code = 'RV' => 'Recreational Vehicle',
    code = 'SCB' => 'School Bus',
    code = 'SGV' => 'State Government',
    code = 'TAX' => 'Taxi',
    code = 'TRL' => 'Trailer',
    code = 'UNK' => 'Unknown',
    code = 'VAN' => 'Vanity',
    '');

  EXPORT get_brandType(STRING code) := MAP(
    code = 'ABN' => ' Abandoned',
    code = 'ASM' => ' Assembled',
    code = 'BRK' => ' Broken Odometer',
    code = 'CTV' => ' Crash Test Vehicle',
    code = 'DMG' => ' Damaged',
    code = 'DSC' => ' Discrepancy',
    code = 'EML' => ' Exceeds Mechanical Limits',
    code = 'FDM' => ' Fire Damage',
    code = 'JNK' => ' Junk',
    code = 'KIT' => ' Kit',
    code = 'LMN' => ' Lemon',
    code = 'LSS' => ' Insurance Loss',
    code = 'MBB' => ' Manufacturer Buyback',
    code = 'NAM' => ' Not Actual Miles',
    code = 'ONC' => ' Odometer Reading Not Certified',
    code = 'ORP' => ' Odometer Replacement',
    code = 'PAB' => ' Formerly Abandoned',
    code = 'PIL' => ' Prior Insurance Loss Claim',
    code = 'PSV' => ' Prior Salvage',
    code = 'RAL' => ' Reported as Lemon',
    code = 'RAM' => ' Reported as Manufacturer Buyback',
    code = 'RBT' => ' Rebuilt/Rebuildable',
    code = 'RCN' => ' Reconstructed',
    code = 'RCV' => ' Theft Recovered',
    code = 'REC' => ' Reconditioned',
    code = 'REP' => ' Repossessed',
    code = 'SCD' => ' Storm Crush Damaged',
    code = 'SDM' => ' Reported as Storm Damaged',
    code = 'SLC' => ' Salvage Correction',
    code = 'SLV' => ' Salvage',
    code = 'SML' => ' Suspect Mileage',
    code = 'SRP' => ' Scrapped/Destroyed',
    code = 'TSR' => ' Traded-in under Cash for Clunkers Program',
    code = 'UNR' => ' Unrebuildable',
    code = 'WDM' => ' Water Damage',
    ''
    );

  EXPORT name_source_cd_description(STRING code) := MAP(
    code = 'T' => 'Title',
    code = 'R' => 'Registration',
    code = 'B' => 'Both Title and Registration',
    '');

END;
