import ut;
// export file_vina_infile := dataset(ut.foreign_prod+'thor_data400::in::vina::processed::vin_infile',VINA.layout_vina_infile,thor);
// New VINtelligence file
EXPORT file_vina_infile := PROJECT(VINA.file_vina_base, TRANSFORM(VINA.layout_vina_infile,SELF.CRLF:='\n';SELF:=LEFT));
