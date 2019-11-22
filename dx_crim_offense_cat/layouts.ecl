EXPORT layouts := module
    export keyed_fields := RECORD
        string150 offensecharge;
    end;
     export payload := RECORD
        keyed_fields;
        string category;
        string id;
    end;
end;
