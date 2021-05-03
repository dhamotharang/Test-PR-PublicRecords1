IMPORT Strata, STD;

EXPORT Mac_Strata_Check(csvName = 'strataCheck') := MACRO
    
    inp     := scrubs_ida.rawinput_in_ida;
    uniTab  := strata.macf_Uniques(inp);
    perTab  := strata.macf_Percent_Pops(inp);
    
    Check(t, fn, uniqueper, popper) := FUNCTIONMACRO

        ty          := STD.Str.ToLowerCase(t);
        UniqueName := 'uniTab[1].' + fn + '_unique';
        PopName    := 'perTab[1].' + fn + '_countnon' + if(ty[1]='s','blank','zero');
        UniCount   := #EXPAND(UniqueName);
        Percent    := #EXPAND(PopName);

        popCount   := ROUND(perTab[1].countgroup * (percent / 100));
        uniquePerc := ROUND(uniCount / popCount * 100);

        result1     := if(Percent >= popper, '', fn + ' population % below ' + popper + '% (' + ROUND(percent) +'%),');
        result2     := if(uniquePerc >= uniqueper, '', fn + ' unique % below ' + uniqueper + '% (' + uniquePerc +'%),');
        RETURN      result1 + result2;

    ENDMACRO;

    Result := 
    //      fieldtype       fieldname       unique  population   
    Check('STRING20',   'firstname',        10,     80) +
    Check('STRING20',   'middlename',       0,      30) +
    Check('STRING25',   'lastname',         10,     80) +
    Check('STRING3',    'suffix',           0,      10) +
    Check('STRING50',   'addressline1',     25,     80) +
    Check('STRING20',   'addressline2',     25,     80) +
    Check('STRING35',   'city',             25,     80) +
    Check('STRING2',    'state',            25,     80) +
    Check('UNSIGNED3',  'zip',              25,     80) +
    Check('UNSIGNED4',  'dob',              25,     80) +
    Check('STRING12',   'ssn',              25,     80) +
    Check('STRING12',   'dl',               25,     80) +
    Check('STRING5',    'dlstate',          25,     80) +
    Check('STRING10',   'phone',            25,     80) +
    Check('UNSIGNED8',  'clientassigneduniquerecordid',  25, 80) +
    Check('STRING50',   'emailaddress',     25,     40) +
    Check('STRING15',   'ipaddress',        25,     40);


    SEQUENTIAL(
        OUTPUT(uniTab),
        OUTPUT(perTab),
    );

    if(result <> '', FAIL('Process stopped before base build due to strata check: ' + result + ' send back file or change thresholds in Mac_Strata_Check'));
ENDMACRO;