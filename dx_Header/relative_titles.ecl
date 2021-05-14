EXPORT relative_titles :=
MODULE

EXPORT num_Subject := 1;
EXPORT num_Husband := 2;
EXPORT num_Wife  := 3;
EXPORT num_Spouse := 4;
EXPORT set_Spouse := [num_Husband, num_Wife, num_Spouse];
EXPORT num_ExHusband := 5;
EXPORT num_ExWife := 6;
EXPORT num_ExSpouse := 7;
EXPORT set_ExSpouse := [num_ExHusband, num_ExWife, num_ExSpouse];
EXPORT num_widow := 8;
EXPORT num_widower := 9;

EXPORT num_Father  := 10;
EXPORT num_Mother  := 11;
EXPORT set_SpecificParent := [num_Father, num_Mother];
EXPORT num_Parent  := 12;

EXPORT num_Grandfather  := 13;
EXPORT num_Grandmother  := 14;
EXPORT num_Grandparent  := 15;

EXPORT num_Brother  := 16;
EXPORT num_Sister  := 17;
EXPORT num_Sibling  := 18;

EXPORT num_Son := 19;
EXPORT num_Daughter := 20;
EXPORT num_Child := 21;

EXPORT num_Grandson  := 22;
EXPORT num_Granddaughter  := 23;
EXPORT num_Gradchild  := 24;

EXPORT num_Inlaw  := 25;
EXPORT num_SisterInlaw := 26;
EXPORT num_BrotherInlaw := 27;
EXPORT num_SiblingInlaw := 28;
EXPORT num_MotherInlaw := 29;
EXPORT num_FatherInlaw := 30;
EXPORT num_ParentInlaw := 31;

EXPORT num_StepFather := 32;
EXPORT num_StepMother := 33;
EXPORT num_StepParent := 34;
EXPORT num_StepBrother := 35;
EXPORT num_StepSister := 36;
EXPORT num_StepSibling := 37;

EXPORT num_aunt := 38;
EXPORT num_auncle := 39;
EXPORT num_niece :=  40;
EXPORT num_nephew := 41;
EXPORT num_cousin := 42;

EXPORT num_relative := 43;
EXPORT num_associate := 44;


EXPORT num_Neighbor := 45;
EXPORT num_Business := 46;
EXPORT num_transactionalAssociate := 47;

EXPORT set_Parent := [num_Father, num_Mother, num_Parent];
EXPORT set_Sibling := [num_Brother, num_Sister, num_Sibling];

EXPORT set_Child := [num_Son, num_Daughter, num_Child];

EXPORT set_FirstDegreeRelative := set_Spouse + set_Parent + set_Sibling + set_Child;

EXPORT fn_get_str_title (unsigned num_title):= function
str_title := map(num_title = num_Subject => 'Subject',
                 num_title = num_Husband => 'Husband',
                 num_title = num_Wife => 'Wife',
                 num_title = num_Spouse => 'Spouse',
                 num_title = num_ExHusband => 'Ex-Husband',
                 num_title = num_ExWife => 'Ex-Wife',
                 num_title = num_ExSpouse => 'Ex-Spouse',
                 num_title = num_widow => 'Widow',
                 num_title = num_widower => 'Widower',
                 num_title = num_Father => 'Father',
                 num_title = num_Mother => 'Mother',
                 num_title = num_Parent => 'Parent',
                 num_title = num_Grandfather => 'Grandfather',
                 num_title = num_Grandmother => 'Grandmother',
                 num_title = num_Grandparent => 'Grandparent',
                 num_title = num_Brother => 'Brother',
                 num_title = num_Sister => 'Sister',
                 num_title = num_Sibling => 'Sibling',
                 num_title = num_Son  => 'Son',
                 num_title = num_Daughter => 'Daughter',
                 num_title = num_Child => 'Child',
                 num_title = num_Grandson => 'Grandson',
                 num_title = num_Granddaughter => 'Granddaughter',
                 num_title = num_Gradchild  => 'Grandchild',
                 num_title = num_Inlaw  => 'In-law',
                 num_title = num_SisterInlaw  => 'Sister-in-law',
                 num_title = num_BrotherInlaw  => 'Brother-in-law',
                 num_title = num_SiblingInlaw  => 'Sibling-in-law',
                 num_title = num_MotherInlaw => 'Mother-in-law',
                 num_title = num_FatherInlaw => 'Father-in-law',
                 num_title = num_ParentInlaw  => 'Parent-in-law',
                 num_title = num_StepFather => 'Stepfather',
                 num_title = num_StepMother => 'Stepmother',
                 num_title = num_StepParent  => 'Stepparent',
                 num_title = num_StepBrother => 'Stepbrother',
                 num_title = num_StepSister  => 'Stepsister',
                 num_title = num_StepSibling   => 'Stepsibling',
                 num_title = num_aunt => 'Aunt',
                 num_title = num_auncle => 'Uncle',
                 num_title = num_niece => 'Niece',
                 num_title = num_nephew  => 'Nephew',
                 num_title = num_cousin  => 'Cousin',
                 num_title = num_relative  => 'Relative',
                 num_title = num_associate  => 'Associate',
                 num_title = num_Neighbor => 'Neighbor',
                 num_title = num_Business  => 'Business',
                 num_title = num_transactionalAssociate  => 'Associate',
                 '');
return str_title;
end;

//TRANSLATION: Use fn_get_str_title to pass the nummberic value and return String translation
/*
1 - Subject
2 - Husband
3 - Wife
4 - Spouse
5 - Ex-Husband
6 - Ex-Wife
7 - Ex-Spouse
8 - Widow
9 - Widower
10 - Father
11 - Mother
12 - Parent
13 - Grandfather
14 - Grandmother
15 - Grandparent
16 - Brother
17 - Sister
18 - Sibling
19 - Son
20 - Daughter
21 - Child
22 - Grandson
23 - Granddaughter
24 - Grandchild
25 - In-law
26 - Sister-in-law
27 - Brother-in-law
28 - Sibling-in-law
29 - Mother-in-law
30 - Father-in-law
31 - Parent-in-law
32 - Stepfather
33 - Stepmother
34 - Stepparent
35 - Stepbrother
36 - Stepsister
37 - Stepsibling
38 - Aunt
39 - Uncle
40 - Niece
41 - Nephew
42 - Cousin
43 - Relative
44 - Associate
45 - Neighbor
46 - Business
*/
END;
