import ut,roxiekeybuild;

export Proc_Build_Key_pullSSN(string filedate) := function
  roxiekeybuild.MAC_SK_BuildProcess_v2_Local(key_pullSSN, '~thor_data400::key::pullSSN', '~thor_data400::key::pullSSN::'+filedate+'::ssn', a, true);
  roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::pullSSN', '~thor_data400::key::pullSSN::'+filedate+'::ssn', b, true);
  ut.MAC_SK_Move_v2('~thor_data400::key::pullSSN', 'Q', c);

	update_dops := roxiekeybuild.updateversion('PullSSNKeys',filedate,'kgummadi@seisint.com;christopher.brodeur@lexisnexis.com');
	
return sequential(a,b,c,update_dops);
end;