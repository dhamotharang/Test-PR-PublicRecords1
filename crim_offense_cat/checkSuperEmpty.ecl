import crim_offense_cat, std;
export checkSuperEmpty(string supername) := function
    return count(nothor(STD.File.SuperFileContents(supername))) < 1;
end;