/*2005-05-26T16:01:02Z (Jill_p tolbert)
minor adjustments before going to header
*/
import LN_TU;

LN_TU.Layout_In_Header_UID_SRC asSource(LN_TU.File_In_Base_All_UID_As_Input L) := TRANSFORM
//self.orig_date_reported_mmddccyy := (L.orig_date_reported_mmddccyy[1..6]+ '  ');
self := L
end;

export LN_TU_as_Source := PROJECT(LN_TU.File_In_Base_All_UID_As_Input,asSource(left));
