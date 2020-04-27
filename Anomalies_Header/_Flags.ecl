
Import _Control, VersionControl;


Export _Flags( String pInput_Name = '', String pBase_Name = '' ) := Module

    Export IsTesting := VersionControl._Flags.IsDataland;
    Export UseStandardizePersists := not IsTesting;


End;