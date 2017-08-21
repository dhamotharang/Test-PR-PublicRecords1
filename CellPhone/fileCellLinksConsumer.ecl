export fileCellLinksConsumer := 
	dataset('~thor_dell400::in::cellphones::Kroll::20060530::cell_links_consumer',
	CellPhone.layoutCellLinksConsumer,csv(terminator('\r\n'), separator('","') , quote('')));
