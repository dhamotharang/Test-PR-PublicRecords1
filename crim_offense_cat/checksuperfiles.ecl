import std;
export checkSuperfiles(string filename) := function
    create_missing_superfiles := parallel(
        if(std.file.superfileexists(filename), output(filename +' exists'), std.file.createsuperfile(filename)),
        if(std.file.superfileexists(filename + '::processed'), output(filename+'::processed exists'), std.file.createsuperfile(filename+'::processed'))
        );
    return create_missing_superfiles;
end;
