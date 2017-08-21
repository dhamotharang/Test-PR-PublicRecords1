export STRING Decompress(STRING str1) := BEGINC++
                                                #option pure
                                                #include <zlib.h>
                                                #include <stdio.h>
                                                #include "string.h"
                                                #include <stdlib.h>
                                                
                                                // Error values
                                                // Left for internal documentation
                                                /*
                                                #define Z_OK            0
                                                #define Z_STREAM_END    1
                                                #define Z_NEED_DICT     2
                                                #define Z_ERRNO        (-1)
                                                #define Z_STREAM_ERROR (-2)
                                                #define Z_DATA_ERROR   (-3)
                                                #define Z_MEM_ERROR    (-4)
                                                #define Z_BUF_ERROR    (-5)
                                                #define Z_VERSION_ERROR (-6)
                                                */

                                                #body                   
                                                                                int err;
                                                                                uLong uncompLen;
                                                                                Byte *comp; 
                                                                                Byte *uncomp;

                                                                                // If blank, then return nothing
                                                                                if (lenStr1 == 0){
                                                                                                __lenResult = 0;
                                                                                                return;
                                                                                }
                                                                                comp = (Byte *) str1;
                                                                                // MySQL prepends the first 4 bytes with the length of the uncompressed string
                                                                                uncompLen = (uLong) (comp[3]<<24) + (comp[2]<<16) + (comp[1]<<8) + (comp[0]);
                                                                                const char* charPayload = str1 + 4;
                                                                                uncomp = (Byte*)rtlMalloc(uncompLen);
                                                                                if ( !uncomp )
                                                                                {
                                                                                                rtlFail(-1,"MySqlZlib.uncompress failed: unable to allocate memory");
                                                                                } else
                                                                                {
                                                                                                err = uncompress(uncomp, &uncompLen, (const Bytef*)charPayload, lenStr1-4);
                                                                                                if ( Z_OK==err ) 
                                                                                                {
                                                                                                                __lenResult = uncompLen;
                                                                                                                __result    = (char *)uncomp;
                                                                                                                return;
                                                                                                }
                                                                                                rtlFree(uncomp);
                                                                                }
                                                                                __lenResult = 0;
                                ENDC++;