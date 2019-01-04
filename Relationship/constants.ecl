EXPORT Constants := MODULE

//Relationship Types
EXPORT Fragment   := 'FRAGMENT';
EXPORT RealEstate := 'REAL ESTATE';
EXPORT ECrashSV   := 'ECRASH SAME VEH';
EXPORT ECrashDV   := 'ECRASH DIFF VEH';
EXPORT Watercraft := 'WATERCRAFT';
EXPORT Aircraft   := 'AIRCRAFT';
EXPORT UCC        := 'UCC';
EXPORT SSNOnly    := 'SSN ONLY';
EXPORT PolicyOnly := 'POLICY ONLY';
EXPORT VehicleOnly := 'VEHICLE ONLY';
EXPORT ClaimOnly  := 'CLAIM ONLY';
EXPORT Business   := 'BUSINESS';
EXPORT Personal   := 'PERSONAL';
EXPORT TransClosure  := 'TRANS CLOSURE';
EXPORT Try2Recover := [SSNOnly,PolicyOnly,ClaimOnly,Watercraft,Aircraft,UCC,VehicleOnly,RealEstate,ECrashSV,Business];

//Relationship Sources
EXPORT cohabit 						:= 'COHABIT';
EXPORT coapt 							:= 'COAPT';
EXPORT copobox 						:= 'COPOBOX';
EXPORT cossn 							:= 'COSSN';
EXPORT copolicy 					:= 'COPOLICY';
EXPORT coclaim 						:= 'COCLAIM';
EXPORT coproperty 				:= 'COPROPERTY';
EXPORT bcoproperty 				:= 'BCOPROPERTY';
EXPORT coforeclosure 			:= 'COFORECLOSURE';
EXPORT bcoforeclosure 		:= 'BCOFORECLOSURE';
EXPORT colien 						:= 'COLIEN';
EXPORT bcolien 						:= 'BCOLIEN';
EXPORT cobankruptcy 			:= 'COBANKRUPTCY';
EXPORT bcobankruptcy 			:= 'BCOBANKRUPTCY';
EXPORT covehicle 					:= 'COVEHICLE';
EXPORT coexperian 				:= 'COEXPERIAN';
EXPORT cotransunion 			:= 'COTRANSUNION';
EXPORT coenclarity 				:= 'COENCLARITY';
EXPORT coecrash 					:= 'COECRASH';
EXPORT bcoecrash 					:= 'BCOECRASH';
EXPORT cowatercraft 			:= 'COWATERCRAFT';
EXPORT coaircraft 				:= 'COAIRCRAFT';
EXPORT comarriagedivorce 	:= 'COMARRIAGEDIVORCE';
EXPORT coucc 							:= 'COUCC';
EXPORT coclue							:= 'COCLUE';
EXPORT cocc								:= 'COCC';

SHARED relationship_sources := DATASET([
                        {cohabit, 'Possible Roommate'},
                        {coapt,  'Possible Roommate'},
                        {copobox,  'Possible Roommate'},
                        {cossn,   'Possibly associated to same SSN'},
                        {coproperty,  'Co-named on a property record'},
                        {bcoproperty,  'Coappeared On Property Transaction'},
                        {covehicle, 'Co-registered for vehicle'}, 
                        {coexperian, 'Co-named on a consumer inquiry'}, 
                        {cotransunion, 'Co-named on a consumer inquiry'}, 
                        {cowatercraft, 'Co-registered for watercraft'}, 
                        {coaircraft, 'Co-registered for aircraft'}, 
                        {comarriagedivorce, 'Co-named on a marriage/divorce record'}, 
                        {coenclarity, 'Possibly share office space'},
                        {coucc, 'Co-named on a UCC filing'},
                        {cobankruptcy, 'Co-named on a bankruptcy'},
                        {bcobankruptcy, 'Coappeared on a public records filing'},
                        {coforeclosure,  'Co-named on a foreclosure record'},
                        {bcoforeclosure, 'Coappeared on a public records filing'},
                        {colien, 'Co-named on a lien filing'}, 
                        {bcolien, 'Coappeared on a public records filing'},
                        {bcoecrash, bcoecrash}, // need to update with proper description if this  will be used
                        {coecrash, coecrash},   // need to update with proper description if this  will be used
                        {coclaim, coclaim},     // need to update with proper description if this  will be used
                        {copolicy, copolicy},   // need to update with proper description if this  will be used
                        {coclue, coclue},       // need to update with proper description if this  will be used
                        {cocc, cocc}           // need to update with proper description if this  will be used
                      ], {STRING source, STRING description});
  
EXPORT setRels := SET(relationship_sources, source);

dict_relsources := DICTIONARY(relationship_sources, {source => description});

EXPORT getRelationSourceDescription(STRING _source) := dict_relsources[_source].description;


END;