﻿IMPORT Citizenship;



EXPORT fn_modelValidation(indicators, model) := FUNCTIONMACRO

  fullModelValidation := JOIN(indicators, model,
                              LEFT.seq = RIGHT.seq,
                              TRANSFORM({RECORDOF(LEFT), RECORDOF(RIGHT)},
                                          SELF := LEFT;
                                          SELF := RIGHT;));

  RETURN fullModelValidation;

ENDMACRO;