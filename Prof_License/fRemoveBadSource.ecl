import misc;

EXPORT fRemoveBadSource(pDs) := functionmacro
			BadSources:=table(pDs,{vendor,cnt:=count(group)},vendor,merge,few)( cnt<=10 );
			return join(pDs, BadSources
										,left.vendor=right.vendor
										,transform(left)
										,left only
										,lookup);
endMacro;