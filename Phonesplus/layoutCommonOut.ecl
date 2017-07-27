export layoutCommonOut := record

  unsigned2			Initscore := 0;
  string15			InitScoreType := '';
  unsigned2			LnameMatch := 0;
  unsigned2			FnameMatch := 0;
  unsigned2			TDSMatch := 0;
  unsigned2			PortMatch := 0;
  unsigned2			TargusMatch := 0;
  data16   			Phone7IDKey := (data)0;

  Phonesplus.layoutCommonKeys;
end;
