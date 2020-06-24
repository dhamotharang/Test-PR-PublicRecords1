import Address, Advo;

export Advo_Batch_Service_Layouts := module

  // Layout provided by client.
  export Batch_In := record
    string20 acctno;
    string75 addr;
    string25 city;
    string2 state;
    string5 zip;
  end;
  
  // Layout as cleaned for processing.
  export Batch_Post_In := record
    unsigned4 __seq;
    Batch_In;
    Address.Layout_Clean182_fips Clean_Address;
  end;
  
  // Layout as retrieved.
  export Batch_Pre_Out := record
    Batch_Post_In.acctno;
    Batch_Post_In.__seq;
    Advo.Layouts.Layout_Common_Out_k;
  end;
  
  // Layout as presented to user.
  export Batch_Out := record
    Batch_In.acctno;
    Advo.Layouts.Layout_Common_Out_k;
  end;

end;
