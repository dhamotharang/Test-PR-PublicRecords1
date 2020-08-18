IMPORT STD;
EXPORT utils := MODULE
  // making sure xml is surrounded by <Row> tag, or else FROMXML fails.
  EXPORT wrapXML(UTF8 xml) := FUNCTION
    RETURN IF (TRIM(STD.STR.ToLowerCase((STRING) xml))[1..5] = '<row>', xml, '<Row>' + xml + '</Row>');
  END;

  // making sure xml is surrounded by <Row> tag, or else FROMXML fails.
  EXPORT wrapTOXML(rec) := FUNCTIONMACRO
    RETURN '<Row>'+TOXML(rec)+'</Row>';
  ENDMACRO;
END;
