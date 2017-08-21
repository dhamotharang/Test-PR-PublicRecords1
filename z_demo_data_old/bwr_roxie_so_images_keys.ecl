import Images;

export bwr_roxie_so_images_keys(string filedate) := function

rec  := record,maxlength(Images.MaxLength_FullImage)
	Images.layout_common;

end;

ds := output(dataset([], rec),,'~images::base::matrix::demo',overwrite);

result := sequential(
																		fileservices.clearsuperfile('~images::base::matrix_images'),
																		ds,
																		fileservices.addsuperfile('~images::base::matrix_images','~images::base::matrix::demo'),
																		Images.proc_build_keys(filedate)
																		);

return result;

end;