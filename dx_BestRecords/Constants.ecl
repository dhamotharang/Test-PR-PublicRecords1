EXPORT Constants := MODULE

  // defines permissions required for accessing individual best record or fields
  EXPORT PERM_TYPE := ENUM(unsigned4,
    glb                      = 1b,
    glb_nonblank             = 10b,
    glb_nonutil              = 100b,
    glb_nonutil_nonblank     = 1000b,
    glb_nonen                = 10000b, //would "glb_nonexp" be better?
    glb_nonen_nonblank       = 100000b,
    glb_noneq                = 1000000b,
    glb_noneq_nonblank       = 10000000b,
    glb_nonen_noneq          = 100000000b,
    glb_nonen_noneq_nonblank = 1000000000b,
    nonglb                   = 10000000000b,
    nonglb_nonblank          = 100000000000b,
    nonglb_noneq             = 1000000000000b,
    nonglb_noneq_nonblank    = 10000000000000b,
    marketing                = 100000000000000b, 
    marketing_preglb         = 1000000000000000b, 
    infutor                  = 10000000000000000b);
end;
