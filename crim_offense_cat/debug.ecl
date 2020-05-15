//never run this on prod
 import crim_offense_cat, std;
/*
filename1 := '20191205';
filename2:= '20200220';
seq := crim_offense_cat.MAC_build_all('20191205');
original_input := 'thor::in::crim_offense_cat::offense_classification.csv';
sequential(
    if(std.file.superfileexists(crim_offense_cat.filenames().BaseIn), 
        output('input superfile exists'),
        sequential(std.file.createsuperfile(crim_offense_cat.filenames().BaseIn),
                    std.file.addsuperfile(crim_offense_cat.filenames().basein, original_input)
                    )
        ),
    seq,
    output('starting ' + filename2),
    crim_offense_cat.BWR(filename2)
); */
std.file.AddSuperFile(crim_offense_cat.filenames().ProcessedIn,'~'+
                                                std.file.getsuperfilesubname(crim_offense_cat.filenames().basein,1))
//output(std.file.getsuperfilesubname(crim_offense_cat.filenames().basein,1));