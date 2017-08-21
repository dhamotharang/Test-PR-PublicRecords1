export layout_attribute_hacks :=
record
  string  regex                ;
  string  not_regex            ;
  string  replacement          ;
  string  description          ;
  string  eclcode     := ''    ;
  boolean AppliedHack := false ;
  string  HackMessage := ''    ;
  unsigned cnt := 0;
end;
