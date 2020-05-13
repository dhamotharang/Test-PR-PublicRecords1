import CollateralAnalytics,std;

export PostFuzzyFunctions:=Module

    export MLS_Parking_TYPE_PostFuzzy(string Code='',String Value,String PreProcess,String Field):=Function
    trimmedCode:=trim(Code,left,right);
    trimmedValue:=trim(Value,left,right);
    trimmedPreprocess:=trim(PreProcess,left,right);
    trimmedField:=trim(Field,left,right);
    cleaned:=map(
        trimmedCode='UD1' AND std.str.find(trimmedPreprocess,'ATT',1)<>0 AND trimmedField='DESC'=>'ATTACHED 1 CAR GARAGE',
        trimmedCode='UD1' AND std.str.find(trimmedPreprocess,'DET',1)<>0 AND trimmedField='DESC'=>'DETACHED 1 CAR GARAGE',
        trimmedCode='UD2' AND std.str.find(trimmedPreprocess,'ATT',1)<>0 AND trimmedField='DESC'=>'ATTACHED 2 CAR GARAGE',
        trimmedCode='UD2' AND std.str.find(trimmedPreprocess,'DET',1)<>0 AND trimmedField='DESC'=>'DETACHED 2 CAR GARAGE',
        trimmedCode='UD3' AND std.str.find(trimmedPreprocess,'ATT',1)<>0 AND trimmedField='DESC'=>'ATTACHED 3 CAR GARAGE',
        trimmedCode='UD3' AND std.str.find(trimmedPreprocess,'DET',1)<>0 AND trimmedField='DESC'=>'DETACHED 3 CAR GARAGE',
        trimmedCode='UD4' AND std.str.find(trimmedPreprocess,'ATT',1)<>0 AND trimmedField='DESC'=>'ATTACHED 4 CAR GARAGE',
        trimmedCode='UD4' AND std.str.find(trimmedPreprocess,'DET',1)<>0 AND trimmedField='DESC'=>'DETACHED 4 CAR GARAGE',
        trimmedCode='UD1' AND std.str.find(trimmedPreprocess,'ATT',1)<>0 AND trimmedField='CODE'=>'AT1',
        trimmedCode='UD1' AND std.str.find(trimmedPreprocess,'DET',1)<>0 AND trimmedField='CODE'=>'DT1',
        trimmedCode='UD2' AND std.str.find(trimmedPreprocess,'ATT',1)<>0 AND trimmedField='CODE'=>'AT2',
        trimmedCode='UD2' AND std.str.find(trimmedPreprocess,'DET',1)<>0 AND trimmedField='CODE'=>'DT2',
        trimmedCode='UD3' AND std.str.find(trimmedPreprocess,'ATT',1)<>0 AND trimmedField='CODE'=>'AT3',
        trimmedCode='UD3' AND std.str.find(trimmedPreprocess,'DET',1)<>0 AND trimmedField='CODE'=>'DT3',
        trimmedCode='UD4' AND std.str.find(trimmedPreprocess,'ATT',1)<>0 AND trimmedField='CODE'=>'AT4',
        trimmedCode='UD4' AND std.str.find(trimmedPreprocess,'DET',1)<>0 AND trimmedField='CODE'=>'DT4',
        trimmedCode='BN1' AND trimmedField='DESC'=>'BUILT IN 1 CAR GARAGE',
		trimmedCode='BN2' AND trimmedField='DESC'=>'BUILT IN 2 CAR GARAGE',   
		trimmedCode='UF1' AND trimmedField='DESC'=>'UNFINISHED 1 CAR GARAGE',
		trimmedCode='UF2' AND trimmedField='DESC'=>'UNFINISHED 2 CAR GARAGE',
		trimmedCode='UF3' AND trimmedField='DESC'=>'UNFINISHED 3 CAR GARAGE',
		trimmedCode='CAP' AND trimmedField='DESC'=>'COVERED/ASSIGNED SPACE(S)',
		trimmedCode='UD1' AND trimmedField='DESC'=>'UNDEFINED TYPE 1 CAR GARAGE',
		trimmedCode='UD2' AND trimmedField='DESC'=>'UNDEFINED TYPE 2 CAR GARAGE',
		trimmedCode='UD3' AND trimmedField='DESC'=>'UNDEFINED TYPE 3 CAR GARAGE',
		trimmedCode='UD4' AND trimmedField='DESC'=>'UNDEFINED TYPE 4 CAR GARAGE',
		trimmedCode='UD5' AND trimmedField='DESC'=>'UNDEFINED TYPE 5 CAR GARAGE',
		trimmedCode='UD6' AND trimmedField='DESC'=>'UNDEFINED TYPE 6 CAR GARAGE',
		trimmedCode='UDA' AND trimmedField='DESC'=>'UNDEFINED TYPE 10 CAR GARAGE',
		trimmedCode='AT1' AND trimmedField='DESC'=>'ATTACHED 1 CAR GARAGE',
		trimmedCode='AT2' AND trimmedField='DESC'=>'ATTACHED 2 CAR GARAGE',
		trimmedCode='AT3' AND trimmedField='DESC'=>'ATTACHED 3 CAR GARAGE',
		trimmedCode='AT4' AND trimmedField='DESC'=>'ATTACHED 4 CAR GARAGE',
		trimmedCode='DT1' AND trimmedField='DESC'=>'DETACHED 1 CAR GARAGE',
		trimmedCode='DT2' AND trimmedField='DESC'=>'DETACHED 2 CAR GARAGE',
		trimmedCode='DT3' AND trimmedField='DESC'=>'DETACHED 3 CAR GARAGE',
		trimmedCode='DT4' AND trimmedField='DESC'=>'DETACHED 4 CAR GARAGE',
		trimmedCode='CR1' AND trimmedField='DESC'=>'CARPORT 1 CAR',
		trimmedCode='CR2' AND trimmedField='DESC'=>'CARPORT 2 CAR',
		trimmedCode='CR3' AND trimmedField='DESC'=>'CARPORT 3 CAR',
		trimmedCode='CR4' AND trimmedField='DESC'=>'CARPORT 4 CAR',
		trimmedCode='CR5' AND trimmedField='DESC'=>'CARPORT 5 CAR',
		trimmedCode='CR6' AND trimmedField='DESC'=>'CARPORT 6 CAR',
		trimmedCode='ASP' AND trimmedField='DESC'=>'ASSIGNED SPACE(S)',
		trimmedCode='GAC' AND trimmedField='DESC'=>'GARAGE/CARPORT',
		trimmedCode='OFP' AND trimmedField='DESC'=>'OFF STREET',
		trimmedCode='DTG' AND trimmedField='DESC'=>'DETACHED GARAGE',
		trimmedCode='PAP' AND trimmedField='DESC'=>'PAVED',
		trimmedCode='OTP' AND trimmedField='DESC'=>'ON SITE',
		trimmedCode='ATG' AND trimmedField='DESC'=>'ATTACHED GARAGE',
		trimmedCode='OUP' AND trimmedField='DESC'=>'OPEN/UNASSIGNED SPACE(S)',
        trimmedCode='BN1' AND trimmedField='CODE'=>'BN1',
		trimmedCode='BN2' AND trimmedField='CODE'=>'BN2',   
		trimmedCode='UF1' AND trimmedField='CODE'=>'UF1',
		trimmedCode='UF2' AND trimmedField='CODE'=>'UF2',
		trimmedCode='UF3' AND trimmedField='CODE'=>'UF3',
		trimmedCode='CAP' AND trimmedField='CODE'=>'CAP',
		trimmedCode='UD1' AND trimmedField='CODE'=>'UD1',
		trimmedCode='UD2' AND trimmedField='CODE'=>'UD2',
		trimmedCode='UD3' AND trimmedField='CODE'=>'UD3',
		trimmedCode='UD4' AND trimmedField='CODE'=>'UD4',
		trimmedCode='UD5' AND trimmedField='CODE'=>'UD5',
		trimmedCode='UD6' AND trimmedField='CODE'=>'UD6',
		trimmedCode='UDA' AND trimmedField='CODE'=>'UDA',
		trimmedCode='AT1' AND trimmedField='CODE'=>'AT1',
		trimmedCode='AT2' AND trimmedField='CODE'=>'AT2',
		trimmedCode='AT3' AND trimmedField='CODE'=>'AT3',
		trimmedCode='AT4' AND trimmedField='CODE'=>'AT4',
		trimmedCode='DT1' AND trimmedField='CODE'=>'DT1',
		trimmedCode='DT2' AND trimmedField='CODE'=>'DT2',
		trimmedCode='DT3' AND trimmedField='CODE'=>'DT3',
		trimmedCode='DT4' AND trimmedField='CODE'=>'DT4',
		trimmedCode='CR1' AND trimmedField='CODE'=>'CR1',
		trimmedCode='CR2' AND trimmedField='CODE'=>'CR2',
		trimmedCode='CR3' AND trimmedField='CODE'=>'CR3',
		trimmedCode='CR4' AND trimmedField='CODE'=>'CR4',
		trimmedCode='CR5' AND trimmedField='CODE'=>'CR5',
		trimmedCode='CR6' AND trimmedField='CODE'=>'CR6',
		trimmedCode='ASP' AND trimmedField='CODE'=>'ASP',
		trimmedCode='GAC' AND trimmedField='CODE'=>'GAC',
		trimmedCode='OFP' AND trimmedField='CODE'=>'OFP',
		trimmedCode='DTG' AND trimmedField='CODE'=>'DTG',
		trimmedCode='PAP' AND trimmedField='CODE'=>'PAP',
		trimmedCode='OTP' AND trimmedField='CODE'=>'OTP',
		trimmedCode='ATG' AND trimmedField='CODE'=>'ATG',
		trimmedCode='OUP' AND trimmedField='CODE'=>'OUP',
        if(trimmedField='CODE',trimmedCode,trimmedValue)
    );
    return cleaned;
    end;

    export MLS_Garage_PostFuzzy(string Code='',String Value,String PreProcess,String Field):=Function
        trimmedCode:=trim(Code,left,right);
        trimmedValue:=trim(Value,left,right);
        trimmedPreprocess:=trim(PreProcess,left,right);
        trimmedField:=trim(Field,left,right);
        cleaned:=map(
        trimmedCode='UD1' AND std.str.find(trimmedPreprocess,'ATT',1)<>0 AND trimmedField='DESC'=>'ATTACHED 1 CAR', 
        trimmedCode='UD1' AND std.str.find(trimmedPreprocess,'DET',1)<>0 AND trimmedField='DESC'=>'DETACHED 1 CAR',
        trimmedCode='UD1' AND std.str.find(trimmedPreprocess,'CARPORT',1)<>0 AND trimmedField='DESC'=>'CARPORT 1 CAR',
        trimmedCode='UD2' AND std.str.find(trimmedPreprocess,'ATT',1)<>0 AND trimmedField='DESC'=>'ATTACHED 2 CAR', 
        trimmedCode='UD2' AND std.str.find(trimmedPreprocess,'DET',1)<>0 AND trimmedField='DESC'=>'DETACHED 2 CAR',
        trimmedCode='UD2' AND std.str.find(trimmedPreprocess,'CARPORT',1)<>0 AND trimmedField='DESC'=>'CARPORT 2 CAR',
        trimmedCode='UD3' AND std.str.find(trimmedPreprocess,'ATT',1)<>0 AND trimmedField='DESC'=>'ATTACHED 3 CAR', 
        trimmedCode='UD3' AND std.str.find(trimmedPreprocess,'DET',1)<>0 AND trimmedField='DESC'=>'DETACHED 3 CAR',
        trimmedCode='UD3' AND std.str.find(trimmedPreprocess,'CARPORT',1)<>0 AND trimmedField='DESC'=>'CARPORT 3 CAR',
        trimmedCode='UD4' AND std.str.find(trimmedPreprocess,'ATT',1)<>0 AND trimmedField='DESC'=>'ATTACHED 4 CAR', 
        trimmedCode='UD4' AND std.str.find(trimmedPreprocess,'DET',1)<>0 AND trimmedField='DESC'=>'DETACHED 4 CAR',
        trimmedCode='UD4' AND std.str.find(trimmedPreprocess,'CARPORT',1)<>0 AND trimmedField='DESC'=>'CARPORT 4 CAR',
        trimmedCode='UD5' AND std.str.find(trimmedPreprocess,'CARPORT',1)<>0 AND trimmedField='DESC'=>'CARPORT 5 CAR',
        trimmedCode='UD6' AND std.str.find(trimmedPreprocess,'CARPORT',1)<>0 AND trimmedField='DESC'=>'CARPORT 6 CAR',
        trimmedCode='UD1' AND std.str.find(trimmedPreprocess,'ATT',1)<>0 AND trimmedField='CODE'=>'AT1',
        trimmedCode='UD1' AND std.str.find(trimmedPreprocess,'DET',1)<>0 AND trimmedField='CODE'=>'DT1',
        trimmedCode='UD1' AND std.str.find(trimmedPreprocess,'CARPORT',1)<>0 AND trimmedField='CODE'=>'CR1',
        trimmedCode='UD2' AND std.str.find(trimmedPreprocess,'ATT',1)<>0 AND trimmedField='CODE'=>'AT2',
        trimmedCode='UD2' AND std.str.find(trimmedPreprocess,'DET',1)<>0 AND trimmedField='CODE'=>'DT2',
        trimmedCode='UD2' AND std.str.find(trimmedPreprocess,'CARPORT',1)<>0 AND trimmedField='CODE'=>'CR2',
        trimmedCode='UD3' AND std.str.find(trimmedPreprocess,'ATT',1)<>0 AND trimmedField='CODE'=>'AT3',
        trimmedCode='UD3' AND std.str.find(trimmedPreprocess,'DET',1)<>0 AND trimmedField='CODE'=>'DT3',
        trimmedCode='UD3' AND std.str.find(trimmedPreprocess,'CARPORT',1)<>0 AND trimmedField='CODE'=>'CR3',
        trimmedCode='UD4' AND std.str.find(trimmedPreprocess,'ATT',1)<>0 AND trimmedField='CODE'=>'AT4',
        trimmedCode='UD4' AND std.str.find(trimmedPreprocess,'DET',1)<>0 AND trimmedField='CODE'=>'DT4',
        trimmedCode='UD4' AND std.str.find(trimmedPreprocess,'CARPORT',1)<>0 AND trimmedField='CODE'=>'CR4',
        trimmedCode='UD5' AND std.str.find(trimmedPreprocess,'CARPORT',1)<>0 AND trimmedField='CODE'=>'CR5',
        trimmedCode='UD6' AND std.str.find(trimmedPreprocess,'CARPORT',1)<>0 AND trimmedField='CODE'=>'CR6',
		trimmedCode='UD1' AND trimmedField='DESC'=>'UNDEFINED TYPE 1 CAR',
		trimmedCode='UD2' AND trimmedField='DESC'=>'UNDEFINED TYPE 2 CAR',
		trimmedCode='UD3' AND trimmedField='DESC'=>'UNDEFINED TYPE 3 CAR',
		trimmedCode='UD4' AND trimmedField='DESC'=>'UNDEFINED TYPE 4 CAR',
		trimmedCode='UD5' AND trimmedField='DESC'=>'UNDEFINED TYPE 5 CAR',
		trimmedCode='UD6' AND trimmedField='DESC'=>'UNDEFINED TYPE 6 CAR',
		trimmedCode='UDA' AND trimmedField='DESC'=>'UNDEFINED TYPE 10 CAR',
		trimmedCode='AT0' AND trimmedField='DESC'=>'ATTACHED',
		trimmedCode='UD1' AND trimmedField='CODE'=>'UD1',
		trimmedCode='UD2' AND trimmedField='CODE'=>'UD2',
		trimmedCode='UD3' AND trimmedField='CODE'=>'UD3',
		trimmedCode='UD4' AND trimmedField='CODE'=>'UD4',
		trimmedCode='UD5' AND trimmedField='CODE'=>'UD5',
		trimmedCode='UD6' AND trimmedField='CODE'=>'UD6',
		trimmedCode='UDA' AND trimmedField='CODE'=>'UDA',
		trimmedCode='AT0' AND trimmedField='CODE'=>'AT0',
        if(trimmedField='CODE',trimmedCode,trimmedValue)
    );
    return cleaned;
    end;

    export MLS_AC_TYPE_PostFuzzy(string Code='',String Value):=Function
        trimmedCode:=trim(Code,left,right);
        trimmedValue:=trim(Value,left,right);
        cleaned:=map(
        trimmedCode='CEN'=>'CENTRAL',
        trimmedCode='DUL'=>'DUAL UNIT',
        trimmedCode='FAN'=>'FAN COOLING/VENTILATION',
        trimmedCode='REF'=>'REFRIGERATION',
        trimmedCode='UNK'=>'TYPE UNKNOWN',
        trimmedCode='WAU'=>'WALL UNIT',
        trimmedCode='WIU'=>'WINDOW UNIT',
        trimmedCode='WNU'=>'WALL/WINDOW UNIT',
        trimmedValue
    );
    return cleaned;
    end;

    export MLS_Roof_Cover_PostFuzzy(string Code='',String Value):=Function
        trimmedCode:=trim(Code,left,right);
        trimmedValue:=trim(Value,left,right);
        cleaned:=map(
        trimmedCode='REL'=>'RUBBER/ELASTOMERIC',
        trimmedCode='SHI'=>'SHINGLE',
        trimmedCode='COM'=>'COMPOSITION',
        trimmedCode='COS'=>'COMPOSITION SHINGLE',
        trimmedValue
    );
    return cleaned;
    end;

    export MLS_Pool_Type_PostFuzzy(string Code='',String Value):=Function
        trimmedCode:=trim(Code,left,right);
        trimmedValue:=trim(Value,left,right);
        cleaned:=map(
        trimmedCode='ING'=>'INGROUND',
        trimmedCode='AGP'=>'ABOVE GROUND',
        trimmedCode='POO'=>'POOL',
        trimmedValue
    );
    return cleaned;
    end;

    export MLS_Prop_Style_PostFuzzy(string Code='',String Value):=Function
        trimmedCode:=trim(Code,left,right);
        trimmedValue:=trim(Value,left,right);
        cleaned:=map(
        trimmedCode='RAN'=>'RANCH/RAMBLER',
        trimmedCode='MLF'=>'MULTI FAMILY',
        trimmedCode='TWN'=>'TOWNHOUSE',
        trimmedValue
    );
    return cleaned;
    end;

    export MLS_Fireplace_PostFuzzy(string Code='',String Value):=Function
        trimmedCode:=trim(Code,left,right);
        trimmedValue:=trim(Value,left,right);
        cleaned:=map(
        trimmedCode='FPL'=>'FIREPLACE',
        trimmedCode='0C0'=>'COAL/WOOD',
        trimmedCode='0G0'=>'GAS/LOG',
        trimmedValue
    );
    return cleaned;
    end;

    export MLS_Construction_PostFuzzy(string Code='',String Value):=Function
        trimmedCode:=trim(Code,left,right);
        trimmedValue:=trim(Value,left,right);
        cleaned:=map(
        trimmedCode='SID'=>'SIDING (ALUM/VINYL)',
        trimmedValue
    );
    return cleaned;
    end;

    export MLS_Foundation_PostFuzzy(string Code='',String Value):=Function
        trimmedCode:=trim(Code,left,right);
        trimmedValue:=trim(Value,left,right);
        cleaned:=map(
        trimmedCode='RAS'=>'CRAWL/RAISED',
        trimmedCode='UBM'=>'TYPE UNKNOWN WITH BASEMENT',
        trimmedValue
    );
    return cleaned;
    end;

    export MLS_Sewer_PostFuzzy(string Code='',String Value):=Function
        trimmedCode:=trim(Code,left,right);
        trimmedValue:=trim(Value,left,right);
        cleaned:=map(
        trimmedCode='UNK'=>'TYPE UNKNOWN',
        trimmedValue
    );
    return cleaned;
    end;

    export MLS_Property_Condition_PostFuzzy(string Code='',String Value):=Function
        trimmedCode:=trim(Code,left,right);
        trimmedValue:=trim(Value,left,right);
        cleaned:=map(
        trimmedCode='EXC'=>'EXCELLENT',
        trimmedValue
    );
    return cleaned;
    end;

    export MLS_Property_Type_PostFuzzy(string Code='',String Value):=Function
        trimmedCode:=trim(Code,left,right);
        trimmedValue:=trim(Value,left,right);
        cleaned:=map(
        trimmedCode='CON'=>'CONDOMINIUM (RESIDENTIAL)',
        trimmedCode='MUF'=>'MULTI-FAMILY PROPERTY',
        trimmedCode='RNT'=>'RENTAL PROPERTY',
        trimmedCode='MOH'=>'MANUFACTURED OR MOBILE HOME PROPERTY',
        trimmedCode='SFR'=>'SINGLE FAMILY RESIDENCE / TOWNHOUSE',
        trimmedValue
    );
    return cleaned;
    end;
end;