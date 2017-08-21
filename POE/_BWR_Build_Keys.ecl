pversion := '';

#workunit('name',POE._Dataset().Name + ' Build Keys ' + pversion);

POE.Build_Keys(pversion).all;
POE.Build_Autokeys(pversion);