EXPORT Flags := MODULE
  EXPORT Null := ''; // No best value was created for this field
	EXPORT Equal := 'G'; // This field value is equal to the best value for this cluster
	EXPORT Fuzzy := 'F'; // This field value is a fuzzy approximation to the best value for this cluster
	EXPORT Bad := 'B'; // This field value is not even approximately the best value for this cluster
	EXPORT Missing := 'M'; // The field here is blank even though a best value exists
	EXPORT Owns := 'O'; // Is the entity that owns this field value
	EXPORT Expand(STRING1 f) := CASE(f,Null=>'No Best Value',Owns=>'Entity owns field value',Equal=>'Is Best Value',Fuzzy=>'Approximately Best Value',Bad=>'Not Best Value',Missing=>'No value, although best available','Unknown');
  END;
