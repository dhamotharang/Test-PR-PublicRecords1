import ut;

equifax := Marketing_Best.file_equifax_base;
Marketing_Best.layout_equifax_base AgeFormat(equifax L) := Transform
Self.Age := If(Length(Trim(L.Age, Left, Right)) = 3, '99', L.Age);
Self.Age_1 := If(Length(Trim(L.Age_1, Left, Right)) = 3, '99', L.Age_1);
Self.Age_2 := If(Length(Trim(L.Age_2, Left, Right)) = 3, '99', L.Age_2);
Self.Age_3 := If(Length(Trim(L.Age_3, Left, Right)) = 3, '99', L.Age_3);
Self.Age_4 := If(Length(Trim(L.Age_4, Left, Right)) = 3, '99', L.Age_4);
Self.Age_5 := If(Length(Trim(L.Age_5, Left, Right)) = 3, '99', L.Age_5);
Self := L;
Self := [];
End;

base_equifax := Project(equifax, AgeFormat(Left));

// macro call to suppresses the Washington cell phone numbers.
ut.mac_suppress_by_phonetype(base_equifax,telephone,st,base_eq_out,true,did);

recordof(base_equifax) suppressRawPhonefileds(base_eq_out l) := transform
    self.Area_CodeAll_Available := if(trim(l.telephone) = '', '', l.Area_CodeAll_Available);
		self.TelephoneAll_Available := if(trim(l.telephone) = '', '', l.TelephoneAll_Available);
    self := l;
end;

export file_equifax_keybuild := project(base_eq_out, suppressRawPhonefileds(left));