IMPORT $;

keyed_fields := RECORD
    $.layouts.geoidOver18.GeoInd;
END;

payload := RECORD
    $.layouts.geoidOver18;
end;

EXPORT key_BLKGRP_attr_over18(string filepath) := 
         INDEX ({keyed_fields}, {payload}, filepath, OPT);
