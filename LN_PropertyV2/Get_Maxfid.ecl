EXPORT Get_Maxfid(string assessorfid,string deedfid) := module

integer newassessorfid := (integer) assessorfid[3..];
integer newdeedfid  := (integer) deedfid[3..];
//Take Couple of assesor fares id's
Set of string Assesfid_sample := ['RA'+ (newassessorfid + 1),'RA'+(newassessorfid + 2),'RA'+(newassessorfid +3 ) ,'RA'+ (newassessorfid +4) ];
Set of string Deedfid_sample := [ 'RD'+(newdeedfid + 1),'RD'+(newdeedfid + 2),'RD'+(newdeedfid +3 ),'RD'+(newdeedfid +4) ];

output(Assesfid_sample);
output(Deedfid_sample);
//Check if that exists in Input files

Valid_Asses := if ( count( LN_PropertyV2.File_Fares_assessor_in( fares_id in Assesfid_sample)) > 0, FAIL('Duplicate_Fares_Assements_Found'),Output('No_Duplicate_Fares_Assesments'));

Valid_Deed := if ( count( LN_PropertyV2.File_Fares_Deeds_in( fares_id in Deedfid_sample)) > 0, FAIL('Duplicate_Fares_Deeds_Found'),Output('No_Duplicate_Fares_Deeds'));


export dupsfid := Parallel(Valid_Asses,Valid_Deed);

end;

