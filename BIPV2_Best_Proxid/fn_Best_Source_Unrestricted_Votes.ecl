import MDR;
export fn_Best_Source_Unrestricted_Votes(STRING source,INTEGER Dups) :=
if(MDR.sourceTools.SourceIsDunn_Bradstreet    (trim(source[..2], all)), 0 * dups,
fn_Best_Name_Source_Votes(source, dups)
);