EXPORT MAC_Normalize_Child (out_layout, child_layout, parent_ds, child_ds, normed_out):= macro
#uniquename(t_norm)
out_layout %t_norm% (parent_ds pParent, child_layout pChild) := transform
self := pChild;
self := pParent;
self := [];
end;

normed_out := normalize(parent_ds,left.child_ds,%t_norm%(left, right));
endmacro;
