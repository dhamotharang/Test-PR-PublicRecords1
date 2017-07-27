// using http://www.ietf.org/rfc/rfc2396.txt

PATTERN Reserved := ';' | '/' | '?' | ':' | '@' | '&' | '=' | '+' |
                    '$' | ',';
PATTERN Unreserved := Alpha | Digit | '-' | '_' | '.' | '!' | '~' | 
					'*' | '\'' | '(' | ')';
PATTERN Escaped := '%';

PATTERN UrlChars := Reserved | Unreserved | Escaped;

export PATTERN url := ('http://' | 'ftp://' | 'www.' | 'ftp.') UrlChars+;