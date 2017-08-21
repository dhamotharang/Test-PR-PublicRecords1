import header,mdr;

hdr := header.File_Headers;

r1 := record
 hdr.src;
 string30 src_desc := stringlib.stringtouppercase(mdr.sourcetools.translatesource(hdr.src));
end;

ta1 := sort(table(hdr,r1,src,few),src_desc);

export header_sources := output(ta1,all);