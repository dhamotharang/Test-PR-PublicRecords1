IMPORT business_header, TopBusiness_BIPV2, Cortera, PRTE2_Cortera, PRTE2;
EXPORT Files := MODULE

  //Base
  EXPORT Hdr_Out    := dataset(PRTE2_cortera.Constants.base_prefix +'HEADER', PRTE2_cortera.Layouts.base, thor);
  EXPORT Attributes := dataset(PRTE2_cortera.Constants.base_prefix +'Attributes', PRTE2_Cortera.Layouts.Attributes_out, thor);
  
  //Input Files
  EXPORT Input_Boca := dataset('~prte::in::cortera::boca', PRTE2_Cortera.Layouts.rlayout, CSV(HEADING(3), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));	 
  EXPORT Input_INS  := dataset('~prte::in::cortera::Insurance', PRTE2_Cortera.Layouts.rlayout, CSV(HEADING(3), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));	

END;