// This module simplifies the wildcard expressions used by StringLib.StringWildMatch
// by collapsing contiguous blocks of asterisks, and by eliminating logically redundant
// asterisks bracketing contiguous blocks of question marks.
//
// Examples:
// 1234***5678		=> 1234*5678
// 1234*?*5678		=> 1234?*5678
// 1234*?*?*5678	=> 1234??*5678

export mod_WildSimplify := module

	// simplify blocks of contiguous wild characters where possible, and
	shared string	collapse(string pat)	:= regexreplace('\\*+', pat, '*');
	shared string	reduce(string pat) 		:= regexreplace('\\*(\\?+)\\*?', pat, '\\1*');
	export string	do(string pat)				:= reduce(reduce(reduce(collapse(pat))));
	/*
		- "collapse" changes contiguous blocks of asterisks to a single asterisk

		- "reduce" works toward changing contiguous blocks of mixed asterisks and
			question marks into a block of the same number of question marks followed
			by a single asterisk.  This matches "at least N characters", where N is
			the number of question marks.  Unfortunately, I couldn't think of an ECL
			expression to do this reduction in a single step, so we're left calling
			"reduce" multiple times in the "do" method.  Three iterations is sufficient
			to reduce a pattern as complex as '*?*?*?*?*?*?*?*' -- additional iterations
			would of course work with still more complex expressions, but we had to draw
			the line somewhere and the max_asterisks logic below will deal with inputs
			even more absurd than those covered above.
	*/

	// disallow more than three asterisks in a pattern (once simplified)
	shared unsigned	max_asterisks			:= 3;
	export boolean	isBad(string pat) := StringLib.StringFindCount(pat, '*') > max_asterisks;

end;

/*
Demo code:

ds_in := dataset([
	{'1234***5678'},
	{'1234???5678'},
	{'1234?*5678'},
	{'1234?*?5678'},
	{'1234*?5678'},
	{'1234*?*5678'},
	{'1234*?*?*5678'},
	{'12***34**56*?*78'},
	{'*12***34**56*?*78*'},
	{'1234*?*?*?*5678'},
	{'1234?*?*?*?5678'},
	{'1234*?*?*??*?*?*5678'},
	{'1234?*?*?*??*?*?5678'}],
	{string dirty; string clean:=''; boolean bad:=false});

ds_in tr(ds_in L) := transform
	clean				:= ut.mod_WildSimplify.do(L.dirty);
	self.clean	:= clean;
	self.bad		:= ut.mod_WildSimplify.isBad(clean);
	self:= L;
end;

ds_out := project(ds_in, tr(left));

output(ds_out);
*/