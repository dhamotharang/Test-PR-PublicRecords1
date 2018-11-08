EXPORT macAppendBIPIds(dIn, companyNameField, primRangeField = '', primNameField = '', secRangeField = '',
  cityField, stateField, zipField, feinField = '', phoneField = '', appendPrefix = '\'\'',
  scoreThreshold = '75', weightThreshold = '\'\'') := FUNCTIONMACRO

  IMPORT Business_Header_SS, BIPV2, SALT32;
  IMPORT Std;

  LOCAL rSearch := RECORD
    RECORDOF(dIn) OR {UNSIGNED6   bdid := 0;    UNSIGNED6   bdidScore := 0;};
    #IF(#TEXT(primRangeField) = '') STRING _primRange := ''; #END
    #IF(#TEXT(primNameField) = '') STRING _primName := ''; #END
    #IF(#TEXT(secRangeField) = '') STRING _secRange := ''; #END
    #IF(#TEXT(feinField) = '') UNSIGNED4 _fein := 0; #END
    #IF(#TEXT(phoneField) = '') STRING _phone  := ''; #END
  END;

  LOCAL searchParams  := PROJECT(dIn, rSearch);

  LOCAL rSearchOut := RECORD
    RECORDOF(rSearch);
    BIPV2.IDlayouts.l_xlink_ids;
  END;

  LOCAL matchSet := ['A' #IF(#TEXT(feinField) != '') ,'F' #END #IF(#TEXT(phoneField) != '') ,'P' #END];

  Business_Header_SS.MAC_Match_Flex
  (
    searchParams,
    matchSet,
    company_name_field := companyNameField,
    prange_field := #IF(#TEXT(primRangeField) != '')  primRangeField  #ELSE _primRange #END,
    pname_field := #IF(#TEXT(primNameField) != '')  primNameField  #ELSE _primName #END,
    zip_field := zipField,
    srange_field := #IF(#TEXT(secRangeField) != '')  secRangeField  #ELSE _secRange #END,
    state_field := stateField,
    phone_field :=  #IF(#TEXT(phoneField) != '')  phoneField  #ELSE _phone #END,
    fein_field :=   #IF(#TEXT(feinField) != '')   feinField   #ELSE _fein  #END,
    BDID_field := bdid,
    outrec := rSearchOut,
    bool_outrec_has_score := FALSE,
    BDID_Score_field := bdidScore,
    outfile := dSearchOut,
    pSetLinkingVersions := [BIPV2.IDconstants.xlink_version_BIP],
    score_threshold := scoreThreshold);

  LOCAL rOut := RECORD
    RECORDOF(dIn);
    UNSIGNED6   #EXPAND(appendPrefix + 'UltID');
    UNSIGNED6   #EXPAND(appendPrefix + 'OrgID');
    UNSIGNED6   #EXPAND(appendPrefix + 'SeleID');
    UNSIGNED6   #EXPAND(appendPrefix + 'ProxID');
    UNSIGNED6   #EXPAND(appendPrefix + 'PowID');
    UNSIGNED6   #EXPAND(appendPrefix + 'DotID');
    UNSIGNED6   #EXPAND(appendPrefix + 'EmpID');
    UNSIGNED6   #EXPAND(appendPrefix + 'Score');
    UNSIGNED6   #EXPAND(appendPrefix + 'Weight');
  END;
  
  LOCAL dOut := PROJECT(dSearchOut, TRANSFORM(rOut,
    _dScore   := DATASET([{LEFT.ultscore}, {LEFT.orgscore}, {LEFT.selescore}, {LEFT.proxscore}], {UNSIGNED6 score})(score <> 0);
    _score    := MIN(SET(_dScore, score));
    _dWeight  := DATASET([{LEFT.ultweight}, {LEFT.orgweight}, {LEFT.seleweight}, {LEFT.proxweight}], {UNSIGNED6 weight})(weight <> 0);
    _weight   := MIN(SET(_dWeight, weight));
    SELF.#EXPAND(appendPrefix + 'UltID')  := IF(_weight>=(INTEGER)weightThreshold, LEFT.UltID, 0);
    SELF.#EXPAND(appendPrefix + 'OrgID')  := IF(_weight>=(INTEGER)weightThreshold, LEFT.OrgID, 0);
    SELF.#EXPAND(appendPrefix + 'SeleID') := IF(_weight>=(INTEGER)weightThreshold, LEFT.SeleID, 0);
    SELF.#EXPAND(appendPrefix + 'ProxID') := IF(_weight>=(INTEGER)weightThreshold, LEFT.ProxID, 0);
    SELF.#EXPAND(appendPrefix + 'PowID')  := IF(_weight>=(INTEGER)weightThreshold, LEFT.POWID, 0);
    SELF.#EXPAND(appendPrefix + 'DotID')  := IF(_weight>=(INTEGER)weightThreshold, LEFT.DotID, 0);
    SELF.#EXPAND(appendPrefix + 'EmpID')  := IF(_weight>=(INTEGER)weightThreshold, LEFT.EmpID, 0);
    SELF.#EXPAND(appendPrefix + 'Score')  := IF(_weight>=(INTEGER)weightThreshold, _score, 0);
    SELF.#EXPAND(appendPrefix + 'Weight') := IF(_weight>=(INTEGER)weightThreshold, _weight, 0);
    SELF := LEFT));
  
  RETURN dOut;
ENDMACRO;
