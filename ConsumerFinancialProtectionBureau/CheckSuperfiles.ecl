import std;
export checkSuperfiles(string filename) := function
    return
        if(std.file.superfileexists(filename + '_father'),
            output(filename + '_father exists'), 
            std.file.createsuperfile(filename + '_father')
            );
end;