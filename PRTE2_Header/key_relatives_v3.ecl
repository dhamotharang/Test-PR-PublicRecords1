import relationship,PRTE2_Header,data_services,doxie,RoxieKeybuild;

res:=Relationship.File_Relative(not(confidence IN ['NOISE','LOW']));
k1:= Relationship.functions_output.convertTitledToKey(res);

rels := dataset([   {'BCOBANKRUPTCY',27,1},  {'BCOECRASH',27,1},      {'BCOFORECLOSURE',27,1},
                    {'BCOLIEN',27,1},        {'BCOPROPERTY',27,1},    {'COAIRCRAFT',27,1},
                    {'COAPT',27,1},          {'COBANKRUPTCY',27,1},   {'COCC',27,1},
                    {'COCLAIM',27,1},        {'COCLUE',27,1},         {'COECRASH',27,1},
                    {'COENCLARITY',27,1},    {'COEXPERIAN',27,1},     {'COFORECLOSURE',27,1},
                    {'COHABIT',27,1},        {'COLIEN',27,1},         {'COMARRIAGEDIVORCE',27,1},
                    {'COPOBOX',27,1},        {'COPOLICY',27,1},       {'COPROPERTY',27,1},
                    {'COSSN',27,1},          {'COTRANSUNION',27,1},   {'COUCC',27,1},
                    {'COVEHICLE',27,1},      {'COWATERCRAFT',27,1}                                      ],{k1.rels});

fix:=project(k1,transform({k1},self.rels:=rels, self:=LEFT));

EXPORT Key_Relatives_v3 := INDEX(fix, 
{did1},
{fix},   
data_services.Data_Location.Relatives+'thor_data400::key::relatives_v3_' + doxie.version_superkey);
