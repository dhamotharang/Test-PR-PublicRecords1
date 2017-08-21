import Scrubs_LN_PropertyV2_Assessor;
F := Scrubs_LN_PropertyV2_Assessor.In_Property_Assessor;
none :=Scrubs_LN_PropertyV2_Assessor.Scrubs.FromNone(F);
OUTPUT( none.BitmapInfile,,'~thor_data::prop_scrubs_bits' , overwrite, compressed); // long term storage

S :=Scrubs_LN_PropertyV2_Assessor.Scrubs; // My scrubs module
DS := DATASET('~thor_data::prop_scrubs_bits',S.Bitmap_Layout,FLAT); // Read in my data (which has bitmap appended
T := S.FromBits(DS);     // Use the FromBits module; makes my bitmap datafile easier to get to
output(T);

N := S.FromNone(F); // Generate the error flags
U := S.FromExpanded(N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

U.SummaryStats; // Show errors by field and type
U.AllErrors; // Just eyeball some errors
U.BadValues; // See my nastiest field values
output(U.OrbitStats(), all);
