IMPORT STD;

EXPORT fn_uncompressXML(dataset(score_logs.Layouts.Input) input_file) := function

uncompress_out := project(input_file, transform(score_logs.Layouts.Input, 
self.inputxml := if(left.input_recordtype = 'B64CMPXML', score_logs.Decompress((STRING)Std.Str.DecodeBase64(left.inputxml)),left.inputxml),
self.outputxml := if(left.output_recordtype = 'B64CMPXML',score_logs.Decompress((STRING)Std.Str.DecodeBase64(left.outputxml)),left.outputxml),
self := left));

return uncompress_out;

end;
