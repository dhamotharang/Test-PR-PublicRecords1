EXPORT MAC_HomesteadExemption_SearchService := MACRO

  #WEBSERVICE(FIELDS(
    /*---- Gateways ----*/
    'Gateways',
    /*---- Inputs ----*/
    'HomesteadExemptionSearchRequest'
  ));

ENDMACRO;
