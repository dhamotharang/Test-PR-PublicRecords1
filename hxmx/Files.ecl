IMPORT ut, hxmx, tools;

EXPORT Files(STRING pVersion = '', BOOLEAN pUseProd = FALSE) := MODULE

   /* Input File Versions */
  EXPORT hx_input  			:= DATASET(hxmx.Filenames(pVersion,pUseProd).hx_lInputTemplate, hxmx.layouts.consolidated.hx_record, csv(separator('|'),quote('')),opt);
  EXPORT mx_input  			:= DATASET(hxmx.Filenames(pVersion,pUseProd).mx_lInputTemplate, hxmx.layouts.consolidated.mx_record, csv(separator('|'),quote('')),opt);
	EXPORT hx_history   	:= DATASET(hxmx.Filenames(pVersion,pUseProd).hx_lInputHistTemplate, hxmx.layouts.input.hx_record, csv(separator('|'),quote('')));
	EXPORT mx_history 		:= DATASET(hxmx.Filenames(pVersion,pUseProd).mx_lInputHistTemplate, hxmx.layouts.input.mx_record, csv(separator('|'),quote('')));

	 /* Base File Versions */
   tools.mac_FilesBase(hxmx.Filenames(pVersion,pUseProd).hx_base, hxmx.layouts.base.hx_record, hx_base);
   tools.mac_FilesBase(hxmx.Filenames(pVersion,pUseProd).mx_base, hxmx.layouts.base.mx_record, mx_base);

END;