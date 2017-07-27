IMPORT VINA;

vinaDerivedModels := VINA.Derived.Models(VINA.key_vin);

EXPORT file_vina_derived_model := vinaDerivedModels : PERSIST('~thor_data400::persist::vina::derived_model');