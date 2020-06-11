IMPORT STD, Scrubs;

EXPORT Functions := MODULE 

    EXPORT Split_Date(string st) := FUNCTION 

        split := std.str.SplitWords(st, ' ');

        return if
        (
            Scrubs.Fn_Valid_Date((string) std.date.FromStringToDate(split[0], '%Y%m%d')) > 0
            ,1
            ,0
        );

    END;

    EXPORT Check_File(string st) := FUNCTION 

        split := STD.Str.SplitWords(st, '::');

        RETURN IF
        (
            (
                split[0] = 'thor_data400'
                AND split[1] = 'in'
                AND split[2] = 'phonefinderreportdelta'
            ) OR split[0] = ''
            ,1
            ,0
        );

    END;

    EXPORT Risk_Check (string st) := FUNCTION 

        RETURN IF 
        (
            st = 'Phone Association|'
            OR st = 'Phone Criteria|' 
            OR st = 'Phone Activity|'
            ,1
            ,0
        );

    END;

END;