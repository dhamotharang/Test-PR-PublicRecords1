IMPORT PhonesPlus_v2, STD, Scrubs;

EXPORT FUNCTIONS := MODULE 

    EXPORT Fn_Valid_Date(string date) := FUNCTION 

        is_Valid_Date := Scrubs.fn_valid_pastDate(date) > 0;
        
        RETURN IF(
            is_Valid_Date 
            ,1
            ,0
        );

    END;

    EXPORT Fn_Valid_Addr(string addr) := FUNCTION 

        cleanAddr := TRIM(addr,all);
        isMoreThanNum := STD.str.filterout(CleanAddr,'0123456789') <> '';
        isBlank := cleanAddr = '';

        RETURN if(
            isBlank OR isMoreThanNum
            ,1
            ,0
        );

    END;

    EXPORT fn_Valid_Phone(string no) := FUNCTION 
        cNo := TRIM(no,ALL);
        isPhoneValid := LENGTH(STD.str.filter(cNo,'0123456789')) = 10
                AND STD.str.findCount(cNo[LENGTH(cNo)-6..LENGTH(cNo)],cNo[LENGTH(cNo)-6]) < 7
                AND cNo[LENGTH(cNo)-3..LENGTH(cNo)] NOT IN ['0000','9999']
                AND cNo[LENGTH(cNo)-6] NOT IN ['0','1']
                AND cNo[..3] NOT IN ['800','811','822','833','844','855','866','877','888','899'];
        isBlank := no = '';

        RETURN IF(
            isPhoneValid OR isBlank,
            1,
            0
        );

    END;

    EXPORT fn_Valid_DL(string dl, boolean isExpectingDefault = false) := FUNCTION 

        trimmedDL := Trim(dl,all);
        cleanDL := STD.str.filterout(trimmedDL, '-');
        doesHaveNums := STD.str.filter(cleanDL,'0123456789') <> '';
        isRightLength := LENGTH(cleanDL) > 3 AND LENGTH(cleanDL) < 13;
        isDefault := cleanDL = 'DL' or cleanDL[1..7] = 'DRIVERS';
        isBlank := trimmedDL = '';

        RETURN IF(
                    (doesHaveNums AND isRightLength) OR (isExpectingDefault AND isDefault) OR isBlank
                    ,1
                    ,0
                );
    END;

    EXPORT fn_valid_email(string em) := FUNCTION

        cleanEm         := TRIM(em,ALL);
        rgxEmail        := '^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$';
        isValidEmail    := REGEXFIND(rgxEmail, cleanEm);
        isBlank         := LENGTH(cleanEm) = 0;

        RETURN if(
                    isValidEmail OR isBlank
                    ,1
                    ,0
                );

    END;

    EXPORT fn_valid_IP(string ip) := FUNCTION

        cleanIp      := TRIM(ip,whitespace);
        isIPV4      := STD.str.filterOut(cleanIp, '0123456789') = '...';
        isMinLength := LENGTH(cleanIp) > 6 AND LENGTH(cleanIP) < 16;
        isBlank     := LENGTH(cleanIp) = 0;

        RETURN if(
                    (isIPV4 AND isMinLength) or isBlank
                    ,1
                    ,0
                );
    END;
    
END;