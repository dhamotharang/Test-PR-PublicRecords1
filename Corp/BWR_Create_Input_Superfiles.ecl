#workunit('name', 'Corporate Create All Input Superfiles');

apply(corp.Filenames().input_superfiles, fileservices.createsuperfile(trim(superfile)));
