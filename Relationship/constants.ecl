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
EXPORT coclue       := 'COCLUE';
EXPORT cocc         := 'COCC';
EXPORT setRels := [cohabit, coapt, copobox, cossn, copolicy, coclaim, coproperty, bcoproperty, coforeclosure, bcoforeclosure,
									 colien, bcolien, cobankruptcy, bcobankruptcy, covehicle, coexperian, cotransunion, coenclarity, coecrash,
									 bcoecrash, cowatercraft, coaircraft, comarriagedivorce, coucc, coclue, cocc];

END;