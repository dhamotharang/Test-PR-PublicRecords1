IMPORT PublicRecords_KEL;
// For FDC Mode, KEL needs a Dataset in the correct layout to compile correctly.
// At runtime, we will correctly populate this Dataset.
EXPORT Dataset_FDC := DATASET([], PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC);