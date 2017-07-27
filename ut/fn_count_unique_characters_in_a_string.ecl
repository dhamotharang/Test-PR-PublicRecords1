/**
 * Returns the number of unique characters in a string. 
 */
EXPORT UNSIGNED4 fn_count_unique_characters_in_a_string(STRING s) := BEGINC++
  
    byte            countMap[256];
    unsigned int    charCount = 0;
    
    memset(countMap, 0, sizeof(countMap));
    
    for (unsigned int x = 0; x < lenS; x++)
    {
        byte    ch = s[x];
        
        if (ch != ' ')
        {
            countMap[ch] = 1;
        }
    }
    
    for (unsigned int x = 0; x < 256; x++)
    {
        charCount += countMap[x];
    }
    
    return charCount;
    
ENDC++;
  
