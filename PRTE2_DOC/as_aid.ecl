

Export as_aid :=project(prte2_doc.files.file_offenders_base_plus(rawaid !=0),
Transform(Layouts.rfinal,
self.county:= left.ace_fips_county;
self.dbpc := left.dpbc;
Self:=Left;
));