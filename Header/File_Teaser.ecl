import mdr;
	// start with the nonGLB header data
	hdrNonGLB := Header.File_Headers_NonGLB;

	Header.File_Teaser_Macro(hdrNonGLB, hdrFileTeaser);

export File_Teaser := hdrFileTeaser : persist('persist::file_teaser');
