import ut;

export fn_Rename_logical_files(string new_date) :=
function

all_personheaderkeys := DATASET([

{'~thor_data400::key::personlinkingadl2v3personheaderaddress3refs_qa','~thor_data400::key::'+new_date+'::personlinkingadl2v3personheaderaddress3refs'}
,{'~thor_data400::key::personlinkingadl2v3personheaderdorefs_qa','~thor_data400::key::'+new_date+'::personlinkingadl2v3personheaderdorefs'}
,{'~thor_data400::key::personlinkingadl2v3personheaderlfzrefs_qa','~thor_data400::key::'+new_date+'::personlinkingadl2v3personheaderlfzrefs'}
,{'~thor_data400::key::personlinkingadl2v3personheaderphrefs_qa','~thor_data400::key::'+new_date+'::personlinkingadl2v3personheaderphrefs'}
,{'~thor_data400::key::personlinkingadl2v3personheadersrefs_qa','~thor_data400::key::'+new_date+'::personlinkingadl2v3personheadersrefs'}
,{'~thor_data400::key::personlinkingadl2v3personheaderssn4refs_qa','~thor_data400::key::'+new_date+'::personlinkingadl2v3personheaderssn4refs'}
,{'~thor_data400::key::personlinkingadl2v3personheaderzprfrefs_qa','~thor_data400::key::'+new_date+'::personlinkingadl2v3personheaderzprfrefs'}
,{'~thor_data400::key::personlinkingadl2v3personheaderflstrefs_qa','~thor_data400::key::'+new_date+'::personlinkingadl2v3personheaderflstrefs'}

], ut.Layout_Superkeynames.inputlayout);

return_this := nothor(ut.fLogicalKeyRenaming(all_personheaderkeys, false));

return return_this;

end;