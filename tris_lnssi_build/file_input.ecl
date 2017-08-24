IMPORT tris_lnssi_build;

EXPORT file_input := dataset(
                             tris_lnssi_build.constants.input_filename,
                             tris_lnssi_build.layout_input,
                             
                             csv(heading(1),separator(','),quote('')))
                             (Contrib_Risk_field<>'Contrib_Risk_field');