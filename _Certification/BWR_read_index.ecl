string10 lnamein_value := 'BRYANT';

raw := _Certification.DataFile;
i   := _Certification.IndexFile;

typeof(raw) xt(raw l, i r) := TRANSFORM
  self.__filepos := r.__filepos;
  SELF := l;
END;

o := fetch(raw, i(lname = StringLib.StringToUpperCase(lnamein_value)), RIGHT.__filepos, xt(LEFT, RIGHT));
output(choosen(o,100))