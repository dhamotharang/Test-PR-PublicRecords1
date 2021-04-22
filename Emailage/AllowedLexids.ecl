
uniq_address_lexids := dedup($.address, lexid, all);
uniq_names_lexids 	:= dedup($.names, lexid, all);

EXPORT AllowedLexids := distribute(join(uniq_address_lexids, uniq_names_lexids, left.lexid = right.lexid, transform({unsigned6 lexid}, self := left;), local), hash(lexid));
