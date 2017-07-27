// initial stab at this, just use string similar until we do more research with real customer apps
import ut, LN_PropertyV2;

export DLscore(STRING20 dl, STRING20 dl2, string2 state, string2 state2) := FUNCTION

s := stringlib.stringtouppercase(state);
s2 := stringlib.stringtouppercase(state2);

// trim them both, and strip the leading zeros from both before comparing
d := LN_PropertyV2.fn_strip_pnum(dl);
d2 := LN_PropertyV2.fn_strip_pnum(dl2);

sim := 100 - MAX(ut.StringSimilar100(d, d2), ut.StringSimilar100(d2, d));

scr := map(d='' or d2='' or s='' or s2='' => 255,
					 s<>s2 => 12,
					 sim);
												
RETURN scr;

END;