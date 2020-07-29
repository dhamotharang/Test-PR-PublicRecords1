IMPORT business_header, TopBusiness_BIPV2, Cortera, PRTE2_Cortera, PRTE2;
EXPORT Files := MODULE

  //Base
  EXPORT Hdr_Out := dataset(PRTE2_cortera.Constants.base_prefix +'HEADER', PRTE2_cortera.Layouts.base, thor);
  EXPORT Key_hdr := project(HDR_Out, transform(Layouts.header_out, self := left, self := []));  
   
	
  EXPORT Attributes := dataset(PRTE2_cortera.Constants.base_prefix +'Attributes', PRTE2_Cortera.Layouts.Attributes_out, thor);
  EXPORT Key_attr   := project(Attributes, transform(Layouts.attributes_out, self := left, self := []));  
  
  //Input Files
  EXPORT Input_Boca := dataset('~prte::in::cortera::boca', PRTE2_Cortera.Layouts.rlayout, CSV(HEADING(3), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')))(link_id >0); 
  EXPORT Input_INS  := dataset('~prte::in::cortera::Insurance', PRTE2_Cortera.Layouts.rlayout, CSV(HEADING(3), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')))(link_id >0); 

  Export execlinkid := proc_createExecLinkID(hdr_out);
END;