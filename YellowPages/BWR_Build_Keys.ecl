#workunit('name', 'Build Yellow Pages Keys ' + yellowpages.YellowPages_Build_Date);

build_keys	:= yellowpages.Proc_Build_Keys		: success(output('Yellowpages Keybuild finished.'));
accept_QA	:= yellowpages.Proc_Accept_To_QA	: success(output('Yellowpages keys accepted to QA'));

sequential(build_keys, accept_QA);
