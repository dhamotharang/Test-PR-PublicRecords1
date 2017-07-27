import gong;

//	starting point of most recent build
ds := dataset(header.Filename_Header,header.Layout_Header,flat);

export file_headers := IF(thorlib.nodes() = 400, ds,distribute(ds,hash(did)));