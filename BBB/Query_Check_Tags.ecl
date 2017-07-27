d := DATASET('~thor_data400::in::bbbdata_xml_20050726',

             {string line{xpath('<>')}},XML('listings/listing'));

 

pattern alpha := pattern('[-A-Za-z0-9]');

pattern word := alpha+;

pattern opentag := '</';

pattern endtag := '>';

pattern fieldtag := opentag word endtag;

 

outrec := record

  string tagname := matchtext(fieldtag/word);

          end;

 

x := parse(d,line,fieldtag,outrec,all);

 

output(sort(dedup(x,all),tagname));

