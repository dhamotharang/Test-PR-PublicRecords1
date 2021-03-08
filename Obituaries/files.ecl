EXPORT files := MODULE

EXPORT newspaper_raw_xml := dataset('~thor_data400::raw::tributes_newspaper_xml', layouts.newspaper_raw_xml, xml('Objects/Object'));
EXPORT newspaper_raw     := dataset('~thor_data400::raw::tributes_newspaper',layouts.newspaper_raw,csv(SEPARATOR(','),quote('"'),TERMINATOR('\n')));

EXPORT newspaper_in      := dataset('~thor_data400::in::tributes_newspaper',Obituaries.layouts.layout_reor_tribute,thor);
EXPORT tributes_in       := dataset('~thor_data400::in::tributes_raw',Obituaries.layouts.layout_reor_tribute,thor);


END;