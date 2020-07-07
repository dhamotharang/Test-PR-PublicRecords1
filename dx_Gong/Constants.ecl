IMPORT contactCard;

EXPORT Constants := MODULE

  //TODO: is "listing_type" better than "phone_type"?
  export PTYPE := module
    export unsigned1 UNKNOWN := 0;
    export unsigned1 RESIDENTIAL := 1;
    export unsigned1 BUSINESS    := 2;
    export unsigned1 GOVERNMENT  := 4;
  end;

  export string STR_UNLISTED := contactCard.constants.str_unlisted; //'UNPUB'

END;
