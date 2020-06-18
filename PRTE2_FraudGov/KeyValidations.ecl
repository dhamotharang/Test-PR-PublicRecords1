import dops,prte2;
EXPORT KeyValidations(STRING current_version) := FUNCTION

key_validations :=  output(dops.ValidatePRCTFileLayout(current_version, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name, 'N'), named(Constants.dops_name+'Validation'));
                  
return key_validations;
end;