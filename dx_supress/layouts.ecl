export layouts := module
    export keyed_fields := RECORD
        STRING10 Product;        
        STRING5 Linking_type;    
        STRING20 Linking_ID;     
        STRING15 Document_Type;
        STRING60 Document_ID;
    end;
    export payload := record
        STRING8 Date_Added;
        STRING25 User;
        STRING25 Compliance_ID;
        STRING255 Comment;
    END;
end;
