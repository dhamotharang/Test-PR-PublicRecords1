EXPORT layouts := MODULE
    EXPORT keyed_fields := RECORD
        STRING10 Product;        
        STRING5 Linking_type;    
        STRING20 Linking_ID;     
        STRING15 Document_Type;
        STRING60 Document_ID;
    END;
    EXPORT payload := RECORD
        STRING8 Date_Added;
        STRING25 User;
        STRING25 Compliance_ID;
    END;
END;
