import ut;
in_deeds := property.File_Fares_Deeds((integer)recording_date_yyyymmdd>=20080101);

property.Layout_LendingTree_Deeds intoLending(in_deeds L) := transform
 self.prop_zip := l.prop_ace_zip;
 self := l;
end;

export Lending_Tree_Deeds := project(in_deeds,intoLending(left));