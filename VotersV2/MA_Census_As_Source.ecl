IMPORT header, MDR;

Layout_in := VotersV2.Layouts_Voters.Layout_Voters_Base_new;

EXPORT MA_Census_As_Source(DATASET(Layout_in) pMA_Census_data = DATASET([], Layout_in), BOOLEAN pForHeaderBuild = FALSE) := FUNCTION
	
  dSourceData := IF(pForHeaderBuild, DATASET('~thor_data400::base::Census_Header_Building', Layout_in, FLAT), pMA_Census_data);

  src_rec := header.layouts_SeqdSrc.VO_src_rec;

  header.Mac_Set_Header_Source(dSourceData, Layout_in, src_rec, MDR.Sourcetools.src_MA_Census, withUID);

  RETURN withUID;

END;