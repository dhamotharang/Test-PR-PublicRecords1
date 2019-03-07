EXPORT MacGraphContextUID(EntityType, UID) := FUNCTIONMACRO
  RETURN '_' + IF(EntityType>9,'','0') + (STRING)EntityType + UID;
ENDMACRO;
