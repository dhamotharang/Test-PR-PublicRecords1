RelationshipTypesLayout := RECORD
  string AssociationLabel;
  string RelationshipType;
  string AssociationColor;
END;

EXPORT Data_RelationshipTypes :=
DATASET([
  { 'Subject', 'Personal', 'purple #456B87' },
  { 'Husband', 'Relative', 'green #00AF66' },
  { 'Wife', 'Relative', 'green #00AF66' },
  { 'Spouse', 'Relative', 'green #00AF66' },
  { 'Ex-Husband', 'Relative', 'green #00AF66' },
  { 'Ex-Wife', 'Relative', 'green #00AF66' },
  { 'Ex-Spouse', 'Relative', 'green #00AF66' },
  { 'Widow', 'Relative', 'green #00AF66' },
  { 'Widower', 'Relative', 'green #00AF66' },
  { 'Father', 'Relative', 'green #00AF66' },
  { 'Mother', 'Relative', 'green #00AF66' },
  { 'Parent', 'Relative', 'green #00AF66' },
  { 'Grandfather', 'Relative', 'green #00AF66' },
  { 'Grandmother', 'Relative', 'green #00AF66' },
  { 'Grandparent', 'Relative', 'green #00AF66' },
  { 'Brother', 'Relative', 'green #00AF66' },
  { 'Sister', 'Relative', 'green #00AF66' },
  { 'Sibling', 'Relative', 'green #00AF66' },
  { 'Son', 'Relative', 'green #00AF66' },
  { 'Daughter', 'Relative', 'green #00AF66' },
  { 'Child', 'Relative', 'green #00AF66' },
  { 'Grandson', 'Relative', 'green #00AF66' },
  { 'Granddaughter', 'Relative', 'green #00AF66' },
  { 'Grandchild', 'Relative', 'green #00AF66' },
  { 'In-law', 'Relative', 'green #00AF66' },
  { 'Sister-in-law', 'Relative', 'green #00AF66' },
  { 'Brother-in-law', 'Relative', 'green #00AF66' },
  { 'Sibling-in-law', 'Relative', 'green #00AF66' },
  { 'Mother-in-law', 'Relative', 'green #00AF66' },
  { 'Father-in-law', 'Relative', 'green #00AF66' },
  { 'Parent-in-law', 'Relative', 'green #00AF66' },
  { 'Stepfather', 'Relative', 'green #00AF66' },
  { 'Stepmother', 'Relative', 'green #00AF66' },
  { 'Stepparent', 'Relative', 'green #00AF66' },
  { 'Stepbrother', 'Relative', 'green #00AF66' },
  { 'Stepsister', 'Relative', 'green #00AF66' }, 
  { 'Stepsibling', 'Relative', 'green #00AF66' },
  { 'Aunt', 'Relative', 'green #00AF66' },
  { 'Uncle','Relative', 'green #00AF66' },
  { 'Niece', 'Relative', 'green #00AF66' },
  { 'Nephew', 'Relative', 'green #00AF66' },
  { 'Cousin','Relative', 'green #00AF66' },
  { 'Relative', 'Relative', 'green #00AF66' },
  { 'Self', 'Relative', 'green #00AF66' },
  { 'Associate', 'Personal', 'purple #456B87' },
  { 'Neighbor', 'Personal', 'purple #456B87' },  
  { 'Facility', 'Facility', 'blue #5DA2D6'},
  { 'Business', 'Professional', 'orange #FF7E08'},
  { 'In Network', 'Professional', 'orange #FF7E08'},
  { 'Out Network', 'Professional', 'orange #FF7E08'},
  { 'Other', '', '' }
], RelationshipTypesLayout);

