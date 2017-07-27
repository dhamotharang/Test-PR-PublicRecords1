import doxie_cbrs, Business_Header;

export ultimate_parent_information(dataset(doxie_cbrs.layout_references) in_bdids) := FUNCTION

bdids := choosen(in_bdids,1);
rec := doxie_cbrs.layout_references;
rec joinrec(Business_Header.Key_BH_SuperGroup_BDID l) := transform
  self.bdid := l.group_id;
end;

thebdid := join(bdids,Business_Header.Key_BH_SuperGroup_BDID,left.bdid=right.bdid,joinrec(right),limit(2));

return choosen(join(thebdid,doxie_cbrs.fn_best_information(thebdid,true),left.bdid=(unsigned6)right.bdid),1);

end;