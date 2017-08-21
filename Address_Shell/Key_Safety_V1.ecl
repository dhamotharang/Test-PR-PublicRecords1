IMPORT Doxie, ut;

safetyCode := Address_Shell.Safety_V1();

EXPORT Key_Safety_V1 := INDEX(safetyCode, {GeoLink}, {safetyCode},
												'~thor_data400::key::address::' + Doxie.Version_SuperKey + '::safety_v1');