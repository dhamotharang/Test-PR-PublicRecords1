/*
  tools.string_similarity_ratio('IL DEPT TRANSPORTATION'  ,'IL DEPARTMENT TRANSPORTATION');

  gives ratio of similarity of strings as a float from 0.0 to 1.0
*/

import STD;
EXPORT real8 string_similarity_ratio(STRING s01,STRING s02) := 
function
  
  edit_distance := STD.Str.EditDistance( s01, s02 );
  
  //calculation the levenshtein similarity ratio
  len1 := length(trim(s01));
  len2 := length(trim(s02));

  ratio := ((len1 + len2) - edit_distance) / (len1 + len2);

  return ratio;

END;