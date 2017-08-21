import std;
Export GetIndicatorFlags(__src, __LexId = 'did', 
					_fname='fname', _mname='mname', _lname='lname', _sname='name_suffix',
					_city='p_city_name', _state='st'
	) := FUNCTIONMACRO

		srcin := PROJECT(DISTRIBUTE(__src((unsigned6)__LexId<>0), (unsigned6)__LexId), TRANSFORM(Infutor.rIndicatorFlags,
						self.LexId := (unsigned6)left.__LexId;
						self.name := Std.Str.CleanSpaces(left._fname+' '+left._mname+' '+left._lname+' '+left._sname);
						self.city := left._city;
						self.st := left._state;
						self := [];));
						
		result := Infutor.AddIndicatorFlags(srcin);

		return result;

ENDMACRO;

