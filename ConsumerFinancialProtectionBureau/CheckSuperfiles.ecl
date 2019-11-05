import std;
export checkSuperfiles(string filename) := function
    create_missing_superfiles := sequential(
        if(std.file.superfileexists(filename + '_father'), output(filename +' Has father'),std.file.createsuperfile(filename + '_father')),
        if(std.file.superfileexists(filename), output(filename +' Has existed'), std.file.createsuperfile(filename))
    );
    return create_missing_superfiles;
end;