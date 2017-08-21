export layout_attribute_hacks2 :=
record
  string  themodule            ;
  string  theattribute         ;
  string  regex                ;
  string  not_regex            ;
  string  replacement          ;
  string  description          ;
  string  eclcode     := ''    ;
  boolean WillApplyHack := false ;
  string  HackMessage := ''    ;
  unsigned cnt := 0;
end;
