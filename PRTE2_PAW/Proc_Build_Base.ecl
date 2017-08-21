IMPORT  PRTE2_PAW,PromoteSupers, std;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION

	df_paw_infile := PROJECT(Files.file_paw_IN, TRANSFORM(	layouts.layout_base,
												SELF.company_title := std.str.cleanspaces(left.company_name),
												self.company_name := TRIM(stringlib.StringToUpperCase(left.company_name),left,right),
												self.domain := TRIM(stringlib.StringToUpperCase(regexfind('[@](.*)',left.email_address,1)),left,right),
												SELF := left,
												self := []));

	PromoteSupers.MAC_SF_BuildProcess(df_paw_infile,'~PRTE::BASE::paw', writefile_paw_basefile);

	sequential(writefile_paw_basefile);

	Return 'success';
END;