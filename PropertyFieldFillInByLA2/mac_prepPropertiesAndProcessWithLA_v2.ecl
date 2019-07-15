import PropertyFieldFillInByLA2;

/* 
  EXAMPLE EXECUTION OF LA.
    set_debug := 1;
    SomeStates := ['NY'];
    StatesLabel := 'NY';
    in_version := '20110729';
    mac_prepPropertiesAndProcessWithLA(in_version, SomeStates, StatesLabel, FilledInVars_NY_ADVO_BASE_with_Hedonics);
    output(count(FilledInVars_NY_ADVO_BASE_with_Hedonics),named('size_of_FilledInVars_NY_ADVO_BASE_with_Hedonics'));
*/
EXPORT mac_prepPropertiesAndProcessWithLA_v2(
                                          in_version
                                          , SomeStates
                                          , StatesLabel
                                          , FilledInVars_ADVO_BASE_with_Hedonics
       ) := MACRO


PersistFilename := '~thor_data400::persist::PropertyFieldFillInByLA2::getSingleResidentProperities';

ADVO_BASE_with_Hedonics:=PropertyFieldFillInByLA2.getSingleResidentProperitiesWithHedonicData(SomeStates, PersistFilename );
// ADVO_BASE_with_Hedonics := dataset(PersistFilename, PropertyFieldFillInByLA2.layouts.layout_BaseWithAverageHedonics,thor);


UniqueIdWithPropertyRec := RECORD
  // unsigned seqno := 0;
  recordof(ADVO_BASE_with_Hedonics)
END;

UniqueIdWithPropertyRec makeUniquePropertyID( UniqueIdWithPropertyRec l, UniqueIdWithPropertyRec r ) := TRANSFORM
   seqno :=
      IF( l.geolink <> r.geolink
          , 1
          , l.seqno+1
      );
   self.seqno := seqno;
   self.cleanaid := r.cleanaid;
   self := r;
   
END;


UniqueIdWithInPropertyDS :=
  iterate(
          sort(
               distribute(
                          project(ADVO_BASE_with_Hedonics, UniqueIdWithPropertyRec)
                          ,hash64(geolink)
               )
               ,geolink, cleanaid 
               ,local
          )
          ,makeUniquePropertyID(LEFT,RIGHT)
          ,local
  );


layout_PropertyFillInVariables := PropertyFieldFillInByLA2.layout_PropertyFillInVariables;

pversion := in_version + '_' + StatesLabel;
PropertyFieldFillInByLA2.mac_fillinPropertyVariables(pversion 
                                                    ,UniqueIdWithInPropertyDS
                                                    ,UniqueIdWithInPropertyDS
                                                    ,FilledInVars_ADVO_BASE_with_Hedonics
                                                   );

LAFilledIn_Filename := '~thor_data400::base::PropertyFieldFillinByLA2::'+in_version+'::FilledInVars_ADVO_BASE_with_Hedonics';
output(FilledInVars_ADVO_BASE_with_Hedonics,,LAFilledIn_Filename,compressed,OVERWRITE);

ENDMACRO;
