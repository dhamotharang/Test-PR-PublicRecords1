import doxie, ut;

export BuildKeyName(boolean isFCRA = false, string name) := function
	prefix :=  if(isFCRA, 
								'~thor_data400::key::bankruptcyv3::fcra::', 
								'~thor_data400::key::bankruptcyv3::');
	return prefix+name+'_'+doxie.Version_SuperKey;
end;