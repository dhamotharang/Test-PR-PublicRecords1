#workunit('name', 'Corp Despray/DKC All');


despray_files 	:= corp.Despray_Corp_Out_Files	: success(output('desprayed all output files'));
dkc_keys 		:= corp.Out_Corp_All_Keys 		: success(output('dkc of all keys completed'));

sequential(despray_files, dkc_keys);