import std;
export checkSuperfiles(string filename) := function
    create_missing_superfiles := parallel(
        if(std.file.superfileexists(filename + '_father'), output(filename +' has father'),std.file.createsuperfile(filename + '_father')),
        if(std.file.superfileexists(filename), output(filename +' exists'), std.file.createsuperfile(filename))
        );
    return create_missing_superfiles;
end;