IMPORT $;

keyed_fields := RECORD
    $.layouts.namecensus.name;
END;

payload := RECORD
    $.layouts.namecensus;
end;

EXPORT key_census_surnames(string filepath) := 
        INDEX ({keyed_fields}, {payload}, filepath, OPT);
