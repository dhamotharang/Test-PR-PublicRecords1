EXPORT GraphData := MODULE

rchild := RECORD
    INTEGER uid;
    STRING Name;
END;

EXPORT trec := RECORD
    INTEGER TreeId;
    INTEGER uid;
    STRING Name;
    DATASET(rchild) children;
END;

EXPORT tree := dataset([{1, 1, 'Parent1', [{2, 'Child1'}, {5, 'Child2'}]},
												{1, 2, 'Child1', [{3, 'Grand Child1'},{4, 'Grand Child2'}]},
												{1, 5, 'Child2', [{6, 'Grand Child3'},{7, 'Grand Child4'}]},
												{1, 3, 'Grand Child1', []},
												{1, 4, 'Grand Child2', []},
												{1, 6, 'Grand Child3', []},
												{1, 7, 'Grand Child4', []},
                        {2, 10, 'Parent1', [{11, 'Child1'}, {12, 'Child2'}]},
												{2, 11, 'Child1', [{13, 'Grand Child1'},{14, 'Grand Child2'}]},
												{2, 12, 'Child2', [{15, 'Grand Child3'},{16, 'Grand Child4'}]},
												{2, 13, 'Grand Child1', []},
												{2, 14, 'Grand Child2', []},
												{2, 15, 'Grand Child3', []},
												{2, 16, 'Grand Child4', []}												
												], trec);


EXPORT forest := dataset([{1, 1, 'Parent1', [{2, 'Child1'}, {5, 'Child2'}]},
                          {1, 2, 'Child1', [{3, 'Grand Child1'},{4, 'Grand Child2'}]},
  												{1, 3, 'Grand Child1', []},
	  											{1, 4, 'Grand Child2', []},
                          {1, 5, 'Child2', [{6, 'Grand Child3'},{7, 'Grand Child4'}]},
												  {1, 6, 'Grand Child3', []},
												  {1, 7, 'Grand Child4', []},
												  {1, 10, 'Grand Child5', []},
                          {1, 8, 'Parent2', [{9, 'Child3'}, {12, 'Child4'}]},
                          {1, 9, 'Child3', [{10, 'Grand Child5'},{11, 'Grand Child6'}]},
                          {1, 12, 'Child4', [{13, 'Grand Child7'},{14, 'Grand Child8'}]},
  												{1, 14, 'Grand Child8', []},
                          {2, 1, 'Parent1', [{0, 'Child1'}, {23, 'Child2'}]},
                          {2, 20, 'Child1', [{21, 'Grand Child1'},{22, 'Grand Child2'}]},
  												{2, 21, 'Grand Child1', []},
	  											{2, 22, 'Grand Child2', []},
                          {2, 23, 'Child2', [{24, 'Grand Child3'}]},
												  {2, 24, 'Grand Child3', []},
                          {2, 27, 'Parent2', [{28, 'Child3'}, {29, 'Child4'}]},
                          {2, 28, 'Child3', [{24, 'Grand Child5'}]},
                          {2, 29, 'Child4', [{30, 'Grand Child8'}]},
  												{2, 30, 'Grand Child8', []}
                         ], trec);

rdagchild := RECORD
  INTEGER uid;
END;

tdagrec := RECORD
    INTEGER uid;
    STRING Label;
    DATASET(rdagchild) children;
END;

EXPORT Dag := dataset([{1, 'Parent1', 
                 [
                                 {2},
                                 {3},
                                     {4}
                               ]
                               },
                {2, 'Parent1', 
                 [
                                 {3},
                                 {4}
                               ]
                               },                                 
                {3, 'Parent1', 
                 [
                                 {5},
                                 {6}
                               ]
                               },                                 
                {4, 'Parent1', 
                 [
                                 {5},
                                 {8}
                               ]
                               },                                 
                {5, 'Parent1', 
                 [
                                 {8},
                                 {9}
                               ]
                               },                                 
                {6, 'Parent1', 
                 [
                                 {8},
                                 {9}
                               ]
                               },                                 
                {7, 'Parent1', 
                 [
                                 {8},
                                     {6}
                               ]
                               },                                 
                {8, 'Parent1', 
                 [
                                  {9}
                               ]
                               },                                 
                {9, 'Parent1', 
                 [
                               ]
                               }                                 
                              ], tdagrec);
END;