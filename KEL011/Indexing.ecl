IMPORT KEL011 AS KEL;

EXPORT Indexing := MODULE

    EXPORT FKey(__x) := FUNCTIONMACRO
        RETURN #EXPAND(REGEXREPLACE('^(.*)\\. *([^.]*)$', #TEXT(__x), '$1.__$2_Key'));
    ENDMACRO;

    EXPORT HKey(__x) := FUNCTIONMACRO
        RETURN HASH32(__x);
    ENDMACRO;

    EXPORT VKey(__x) := FUNCTIONMACRO
        RETURN __x;
    ENDMACRO;

    EXPORT Key(__x) := FUNCTIONMACRO
        RETURN __x;
    ENDMACRO;

    EXPORT SHKey(__x) := FUNCTIONMACRO
        {UNSIGNED4 hashVal} xm({TYPEOF(__x) s} le,INTEGER ind):=TRANSFORM
            SELF.hashVal:=IF(COUNT(le.s)>0, HASH32(IF(COUNT(le.s )>0, le.s, ['@@@@'])[ind]),0);
        END;
        RETURN SET(NORMALIZE(DATASET([{__x}],{TYPEOF(__x) s}),COUNT(LEFT.s),xm(LEFT,COUNTER)),hashVal);
    ENDMACRO;
END;
