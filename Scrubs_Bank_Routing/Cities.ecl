IMPORT Text;
pattern city_word := ((Text.AlphaUpper Text.alpha+) not in nocase(Text.state));
pattern city1 := city_word;
pattern city2 := city_word opt('.') Text.ws city_word;
pattern city3 := city_word opt('.') Text.ws city_word Text.ws city_word;
export pattern Cities := (city1 | city2 | city3) AFTER Front BEFORE Back; 
