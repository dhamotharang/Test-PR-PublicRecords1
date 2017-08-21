IMPORT PRTE2_Workers_Compensation;

EXPORT Files := MODULE

	EXPORT file_in := DATASET(Constants.in_workers_compensation, Layouts.Layout_IN, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );

	EXPORT file_base := DATASET(Constants.base_workers_compensation, Layouts.Layout_Base, FLAT );

	EXPORT file_bdid := PROJECT(file_base(bdid <> 0), Layouts.layout_bdid);
		
	EXPORT file_keybuild := PROJECT(file_base, Layouts.layout_keybuild);
	
	//autokeys
	EXPORT file_autokey := PROJECT
	(file_base, 
	 TRANSFORM(Layouts.layout_autokey,
	 					 SELF := LEFT
						)
	);


END;