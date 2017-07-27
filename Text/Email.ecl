// using http://www.ietf.org/rfc/rfc2396.txt
// don't think reserved words or escape char % should be included
// see Text.url
PATTERN Unreserved := Alpha | Digit | '-' | '_' | '.' | '!' | '~' | 
					'*' | '\'' | '(' | ')';

export PATTERN email := (Alpha | Digit) Unreserved+  '@' Unreserved+ '.' Unreserved+ (Alpha | Digit);