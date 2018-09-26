EXPORT getGraphContextUIDType(STRING EntityContextUID) := FUNCTION
  RETURN (UNSIGNED)EntityContextUID[2..3];
END;

