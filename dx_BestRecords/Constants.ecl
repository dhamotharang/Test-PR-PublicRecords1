EXPORT Constants := MODULE

  // defines permissions required for accessing individual best record or fields
  EXPORT PERM_TYPE := ENUM(UNSIGNED4,
    GLB                                 = 1b,
    GLB_NONBLANK                        = 10b,
    GLB_NONUTIL                         = 100b,
    GLB_NONUTIL_NONBLANK                = 1000b,
    GLB_NONEXPERIAN                     = 10000b, //would "glb_nonexp" be better?
    GLB_NONEXPERIAN_NONBLANK            = 100000b,
    GLB_NONEQUIFAX                      = 1000000b,
    GLB_NONEQUIFAX_NONBLANK             = 10000000b,
    GLB_NONEXPERIAN_NONEQUIFAX          = 100000000b,
    GLB_NONEXPERIAN_NONEQUIFAX_NONBLANK = 1000000000b,
    NONGLB                              = 10000000000b,
    NONGLB_NONBLANK                     = 100000000000b,
    NONGLB_PREGLB                       = 1000000000000b,
    NONGLB_NONBLANK_PREGLB              = 10000000000000b,
    MARKETING                           = 100000000000000b,
    MARKETING_PREGLB                    = 1000000000000000b,
    INFUTOR                             = 10000000000000000b);
end;
