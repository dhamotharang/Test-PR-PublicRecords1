import std;
export checkSuperfiles(string filename) := function
    create_missing_superfiles := parallel(
        if(std.file.superfileexists(filename), output(filename +' exists'), std.file.createsuperfile(filename)),
        if(std.file.superfileexists(filename + '_father'), output(filename+'_father exists'), std.file.createsuperfile(filename+'_father')),
        if(std.file.superfileexists(filename + '_grandfather'), output(filename+'_grandfather exists'), std.file.createsuperfile(filename+'_grandfather'))
        );
    return create_missing_superfiles;
end;
