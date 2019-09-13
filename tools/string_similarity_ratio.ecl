/*
  tools.string_similarity_ratio('IL DEPT TRANSPORTATION'  ,'IL DEPARTMENT TRANSPORTATION');

  gives ratio of similarity of strings as a float from 0.0 to 1.0
*/

IMPORT Python;
EXPORT real8 string_similarity_ratio(STRING s01,STRING s02) := 
EMBED(Python)
  import difflib
  d=difflib.SequenceMatcher(None,s01,s02)
  ratio=d.ratio()
  return ratio
ENDEMBED;