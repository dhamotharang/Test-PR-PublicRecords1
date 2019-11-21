export layouts := module
    export base_layout := record
        string offensecharge;
        string category;
        string id;
    end;
    export offense_layout := record
        string75 offense_desc,
        integer8 rcount
    end;
end;