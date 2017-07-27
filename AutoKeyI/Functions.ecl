import NID;

export Functions := module

	export PrefFirstMatch(string20 l, string20 r) :=
		NID.mod_PFirstTools.SubLinPFR(l, r) or l[1..length(trim(r))]=r;
end;
