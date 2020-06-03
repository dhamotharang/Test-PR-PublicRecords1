IMPORT mdr;

EXPORT Functions := MODULE

  EXPORT SF_suffix (boolean pFastHeader = FALSE) := IF (pFastHeader, '_fheader', '_header');

  EXPORT translateSource(string2 src) := mdr.sourceTools.translateSource(src);
END;
