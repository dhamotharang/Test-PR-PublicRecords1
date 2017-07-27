import lib_stringlib, ut;
export AlphasOnly(string strIn) := stringlib.stringfilter(strIn, ut.alphabet):DEPRECATED('Too trivial to record as an attribute');