Bank_Routing.Layouts.base xFormRaw(Bank_Routing.Layouts.raw l):=TRANSFORM
  SELF:=l;
	SELF:=[];
END;
EXPORT In_Accuity_Bank_Routing := PROJECT(Bank_Routing.Files.raw,xFormRaw(left));