import header;
EXPORT file_header_quick_skip_PID := project(header_quick.file_header_quick, 
transform(header.Layout_Header, self.persistent_record_id := 0, self := left));
