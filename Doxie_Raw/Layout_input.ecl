//===========================================================
//Layout of input dataset for Doxie.HeaderSource_Service.
//Right now, I assume there is only one record in the input dataset.
//Later, we might need to support taking 2 ids at the same time.
//===========================================================

export Layout_input := RECORD
    string8 idtype; //did, rid, bdid.
    string id;    //can this be unsigned6 instead of string?
    string25 section := '';
    Doxie_Raw.Layout_address_input;
END;
