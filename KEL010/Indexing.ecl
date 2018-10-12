IMPORT KEL010 AS KEL;

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
END;
