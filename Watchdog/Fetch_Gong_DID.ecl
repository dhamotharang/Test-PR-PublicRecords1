rawfile := watchdog.File_Gong_Doxie;

i := key_gong_did;

rawfile xt(rawfile l, i r) := TRANSFORM
                                        SELF := l;
                                 END;

export Fetch_Gong_DID(unsigned8 rdid) := fetch(rawfile, i(did=rdid), RIGHT.fpos, xt(LEFT, RIGHT));