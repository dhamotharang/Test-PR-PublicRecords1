IMPORT $;

keyed_fields := RECORD
    $.layouts.geoid.GEOID10_BlkGrp;
END;

payload := RECORD
    $.layouts.geoid;
end;

EXPORT key_BLKGRP(string filepath) :=  
        INDEX ({keyed_fields}, {payload}, filepath, OPT);
