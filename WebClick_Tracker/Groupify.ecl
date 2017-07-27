export string Groupify(string Str) := //put parentheses around groups
		regexreplace('(\\b\\w+\\b)',Str,'\\($1\\)');
