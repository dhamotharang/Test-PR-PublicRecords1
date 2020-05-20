//IMPORT:KEL12.Permits
IMPORT KEL12 AS KEL;
EXPORT Permits := MODULE

    EXPORT DATA32 BitOrHelper(DATA a, DATA b, INTEGER size) := BEGINC++
        #define RESULT_SIZE 32
        for (int i = 0; i < size; i++)
            ((unsigned char*) __result)[i] = ((unsigned char*) a)[i] | ((unsigned char*) b)[i];
        for (int i = size; i < RESULT_SIZE; i++)
            ((unsigned char*) __result)[i] = 0;
    ENDC++;

    EXPORT BitOr(a,b) := FUNCTIONMACRO
      RETURN (TYPEOF(a)) KEL.Permits.BitOrHelper(a,b,SIZEOF(a));
    ENDMACRO;


    EXPORT DATA32 BitAndHelper(DATA a, DATA b, INTEGER size) := BEGINC++
        #define RESULT_SIZE 32
        for (int i = 0; i < size; i++)
            ((unsigned char*) __result)[i] = ((unsigned char*) a)[i] & ((unsigned char*) b)[i];
        for (int i = size; i < RESULT_SIZE; i++)
            ((unsigned char*) __result)[i] = 0;
    ENDC++;

    EXPORT BitAnd(a,b) := FUNCTIONMACRO
      RETURN (TYPEOF(a)) KEL.Permits.BitAndHelper(a,b,SIZEOF(a));
    ENDMACRO;

END;