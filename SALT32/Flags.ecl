EXPORT Flags := MODULE
  EXPORT Null := ''; // No best value was created for this field
	EXPORT Equal := 'G'; // This field value is equal to the best value for this cluster
	EXPORT Fuzzy := 'F'; // This field value is a fuzzy approximation to the best value for this cluster
	EXPORT Bad := 'B'; // This field value is not even approximately the best value for this cluster
	EXPORT Missing := 'M'; // The field here is blank even though a best value exists
	EXPORT Owns := 'O'; // Is the entity that owns this field value
	EXPORT Relative := 'R'; // It is a relative that owns this field value
	EXPORT Relative_Possible := 'r'; // It is a relative that has the value equal to the best value of her cluster
	EXPORT Relative_Fuzzy := 'Q'; // It is a relative that has the value which is fuzzy approximation to the best value of her cluster
	EXPORT Expand(STRING1 f) := CASE(f,Null=>'No Best Value',Owns=>'Entity owns field value',Equal=>'Is Best Value',Fuzzy=>'Approximately Best Value',Bad=>'Not Best Value',Missing=>'No value, although best available',Relative=>'Relative owns field value',Relative_Possible=>'Relative Has Best Value',Relative_Fuzzy=>'Relative Has Approximately Best Value','Unknown');
  END;
