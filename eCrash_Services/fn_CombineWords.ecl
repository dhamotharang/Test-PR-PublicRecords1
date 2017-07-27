// copied from HPCC-Platform/plugins/stringlib/stringlib.cpp source on git hub
// seems like roxie does not have this function available in string lib for the 
// version of roxie.  Once roxie is updated, this can be removed and the referecnes
// can point to the string lib version.

// STRINGLIB_API void STRINGLIB_CALL slCombineWords(size32_t & __lenResult, void * & __result, bool isAllSrc, size32_t lenSrc, const char * src, size32_t lenSeparator, const char * separator, bool allowBlankItems)
// STRING CombineWords(set of string src, const string _separator) : c, pure,entrypoint='slCombineWords';
EXPORT STRING fn_CombineWords(SET OF STRING src, CONST STRING separator) := BEGINC++
    #include <assert.h>
    static unsigned countWords(size32_t lenSrc, const char * src)
    {
        unsigned count = 0;
        unsigned offset = 0;
        while (offset < lenSrc)
        {
            size32_t len;
            memcpy(&len, src+offset, sizeof(len));
            offset += sizeof(len) + len;
            count++;
        }
        return count;
    }

    #body
    if (lenSrc == 0)
    {
        __lenResult = 0;
        __result = NULL;
        return;
    }

    const char *csrc = (const char *)src;
    unsigned numWords = countWords(lenSrc, csrc);
    size32_t sizeRequired = lenSrc - numWords * sizeof(size32_t) + (numWords-1) * lenSeparator;
    char * const result = static_cast<char *>(rtlMalloc(sizeRequired));
    __lenResult = sizeRequired;
    __result = result;

    char * target = result;
    unsigned offset = 0;
    while (offset < lenSrc)
    {
        if ((offset != 0) && lenSeparator)
        {
            memcpy(target, separator, lenSeparator);
            target += lenSeparator;
        }

        size32_t len;
        memcpy(&len, csrc+offset, sizeof(len));
        offset += sizeof(len);
        memcpy(target, csrc+offset, len);
        target += len;
        offset += len;
    }
    assert(target == result + sizeRequired);
ENDC++;