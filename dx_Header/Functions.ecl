EXPORT Functions := MODULE

  EXPORT SF_suffix (boolean pFastHeader = FALSE) := IF (pFastHeader, '_fheader', '_header');

END;
