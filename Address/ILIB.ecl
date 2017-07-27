export ILIB := MODULE

  export ICleaningInput := INTERFACE
    export string address_line_1;
    export string address_line_2;
    export string1 lang; // used in cleaning Canadian addresses

    export string name;
    export string dualname;

    export string zip9;
  end; 

  export ICleaningResults (ICleaningInput args) := INTERFACE
    export string182 cleaned_address_182;
    export string183 cleaned_address_183;

    export string109 cleaned_address_canada;

    export string73 cleaned_person_73;
    export string73 cleaned_person_FML73;
    export string73 cleaned_person_LFM73;

    export string140 cleaned_dualname_140; 
    export string140 cleaned_dualname_LFM140;

    export string34 geo_34;
  end; 

end;