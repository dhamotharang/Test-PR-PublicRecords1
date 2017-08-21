sfOld := '~thor_data400::bipv2::internal_linking::history::old';
sfCurr := '~thor_data400::bipv2::internal_linking::history';
sfNew := '~thor_data400::bipv2::internal_linking::history::rewrite';

// create super to store old history files
makeSf := std.file.createsuperfile(sfOld, allowExist := true);

// promote curr to old, new to current - DO NOT DELETE
PromoteSf := std.file.promoteSuperFileList([sfNew, sfCurr, sfOld], deltail := false);

sequential(
	makeSf;
	promoteSf;
);



