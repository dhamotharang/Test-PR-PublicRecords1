import std, crim_offense_cat;
export spray_input(string new_input, boolean pUseProd = false) := function
    new_file_name := crim_offense_cat.filenames(pUseProd).BaseIn+ '::'+ new_input;
     return  STD.File.SprayDelimited('10.121.149.193',
                                '/data/stub_cleaning/court/offense_category/output/' + new_input+ '/*',
                                ,'^|^',,'',
                                STD.System.Thorlib.Group(), 
                                new_file_name);
end;