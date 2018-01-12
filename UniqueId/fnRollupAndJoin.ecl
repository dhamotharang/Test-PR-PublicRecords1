EXPORT fnRollupAndJoin(list, child, field) := FUNCTIONMACRO
// list must be distributed on primary key
rolledup := ROLLUP(SORT(DISTRIBUTE(PROJECT(child,layout_generic),primarykey),primarykey,LOCAL), primarykey, TRANSFORM(layout_generic,
									SELF.info := LEFT.info + U'¶' + RIGHT.info;
									self.primarykey := LEFT.primarykey;
									), LOCAL);
return JOIN(DISTRIBUTED(list,primarykey), rolledup, LEFT.primarykey=RIGHT.primarykey, TRANSFORM(Layout_Flat,
										SELF.field := RIGHT.info;
										SELF := LEFT;), LEFT OUTER, LOCAL);
ENDMACRO;