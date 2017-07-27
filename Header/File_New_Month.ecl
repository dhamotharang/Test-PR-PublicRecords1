export File_New_Month(boolean pFastHeader=false) := function
header.layout_new_records t_remove_did(header.layout_new_records le) := transform
 self.did := 0;
 self     := le;
end;

return project(header.preprocess(pFastHeader),t_remove_did(left));
end;