EXPORT Constants := MODULE

  // defines permissions required for accessing individual best record or fields
  EXPORT PERM_TYPE := ENUM(unsigned4,
    GLB                        = 1b,
    GLB_NONBLANK               = 10b,
    GLB_NONUTIL                = 100b,
    GLB_NONUTIL_NONBLANK       = 1000b,
    GLB_NONEN                  = 10000b, //would "glb_nonexp" be better?
    GLB_NONEN_NONBLANK         = 100000b,
    GLB_NONEQ                  = 1000000b,
    GLB_NONEQ_NONBLANK         = 10000000b,
    GLB_NONEN_NONEQ            = 100000000b,
    GLB_NONEN_NONEQ_NONBLANK   = 1000000000b,
    NONGLB                     = 10000000000b,
    NONGLB_NONBLANK            = 100000000000b,
    NONGLB_NONEQ               = 1000000000000b,
    NONGLB_NONEQ_NONBLANK      = 10000000000000b,
    MARKETING                  = 100000000000000b, 
    MARKETING_PREGLB           = 1000000000000000b, 
    INFUTOR                    = 10000000000000000b,
    NONGLB_TEASER              = 100000000000000000b,
    NONGLB_NONEQ_TEASER        = 1000000000000000000b,
    GLB_D2C_FILTERED           = 10000000000000000000b );

end;
