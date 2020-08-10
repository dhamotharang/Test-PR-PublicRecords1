IMPORT Risk_Indicators, iesp;

EXPORT ConstantsQuery := MODULE

    EXPORT ATTRIBUTE_RESPONSE_LAYOUT := iesp.duediligenceattributes.t_DueDiligenceAttributesResponse;

    //batch specific versions
    EXPORT VERSION_0 := 0;
    EXPORT VERSION_3 := 3;

    //xml specific versions
    EXPORT IND_REQ_ATTRIBUTE_V3 := 'DDAPERV3';
    EXPORT BUS_REQ_ATTRIBUTE_V3 := 'DDABUSV3';

    //request type
    EXPORT INDIVIDUAL := 'INDIVIDUAL';
    EXPORT BUSINESS := 'BUSINESS';
    EXPORT ATTRIBUTES := 'ATTRIBUTE';

    EXPORT VALID_IND_ATTRIBUTE_VERSIONS := [IND_REQ_ATTRIBUTE_V3];
    EXPORT VALID_BUS_ATTRIBUTE_VERSIONS := [BUS_REQ_ATTRIBUTE_V3];

    EXPORT INVALID := 'INVALID';
    
    EXPORT VALID_PRODUCT_DUE_DILIGENCE_ONLY := 'attributesonly';
    EXPORT VALID_PRODUCT_CITIZENSHIP_ONLY := 'citizenshiponly';
    EXPORT VALID_PRODUCT_DUE_DILIGENCE_AND_CITIZENSHIP := 'attributesandcitizenship';
    EXPORT VALID_PRODUCT_DUE_DILIGENCE_CUSTOM_ATTRIBUTES := 'customattributes';
    EXPORT VALID_PRODUCT_DUE_DILIGENCE_REPORT_DEFAULT := 'standard';
    
    EXPORT VALID_REQUESTED_PRODUCTS := [VALID_PRODUCT_DUE_DILIGENCE_ONLY, VALID_PRODUCT_CITIZENSHIP_ONLY, VALID_PRODUCT_DUE_DILIGENCE_AND_CITIZENSHIP, VALID_PRODUCT_DUE_DILIGENCE_CUSTOM_ATTRIBUTES, VALID_PRODUCT_DUE_DILIGENCE_REPORT_DEFAULT];
    
    EXPORT PRODUCT_REQUESTED_ENUM := ENUM(UNSIGNED1, EMPTY=0, DUEDILIGENCE_ONLY=1, CITIZENSHIP_ONLY=2, BOTH=3, CUSTOM_ATTRIBUTES=4);
    
    EXPORT DUEDILIGENCE_PRODUCTS := [PRODUCT_REQUESTED_ENUM.DUEDILIGENCE_ONLY, PRODUCT_REQUESTED_ENUM.BOTH, PRODUCT_REQUESTED_ENUM.CUSTOM_ATTRIBUTES];
    EXPORT CITIZENSHIP_PRODUCTS := [PRODUCT_REQUESTED_ENUM.CITIZENSHIP_ONLY, PRODUCT_REQUESTED_ENUM.BOTH];
    
    

    EXPORT DEFAULT_DPPA := 3;
    EXPORT DEFAULT_GLBA := 5;

    EXPORT DEFAULT_IS_FCRA := FALSE;

    EXPORT NUMBER_OF_INDIVIDUAL_ATTRIBUTES := 21;
    EXPORT NUMBER_OF_BUSINESS_ATTRIBUTES := 24;
    
    //modules
    EXPORT MODULE_ECONOMIC := 'ECONOMIC';
    EXPORT MODULE_GEOGRAPHIC := 'GEOGRAPHIC';
    EXPORT MODULE_IDENTITY := 'IDENTITY';
    EXPORT MODULE_LEGAL := 'LEGAL';
    EXPORT MODULE_NETWORK := 'NETWORK';
    EXPORT MODULE_OPERATING := 'OPERATING';
    
    
    //validation error messages
    EXPORT VALIDATION_INVALID_GLB := 'Not an allowable GLB permissible purpose';
    EXPORT VALIDATION_INVALID_DPPA := 'Not an allowable DPPA permissible purpose';
    EXPORT VALIDATION_INVALID_DD_ATTRIBUTE_REQUEST_WITH_CITIZENSHIP := 'Business attributes are not valid with a citizenship request';
    EXPORT VALIDATION_INVALID_PRODUCT_REQUEST_TYPE := 'Product Request Type is required or invalid. Product Request Type =';
    EXPORT VALIDATION_INVALID_DD_VERSION := 'Please enter a valid attributes version';
    EXPORT VALIDATION_INVALID_MODEL_NAME := 'Model is currently not supported.';
    EXPORT VALIDATION_INVALID_DD_CITIZENSHIP_COMBO := 'Attributes version is invalid and model is not supported.';
    EXPORT VALIDATION_INVALID_REQUEST := 'Invalid request. Could not determine which product(s) are being requested';
    EXPORT VALIDATION_NO_MODULES_REQUESTED := 'No attribute modules were requested.';
    
    EXPORT INTEGER DEFAULT_BS_VERSION := 52;
    EXPORT UNSIGNED8 DEFAULT_BS_OPTIONS :=(Risk_Indicators.iid_constants.BSOptions.IncludeFraudVelocity +
                                           Risk_Indicators.iid_constants.BSOptions.IncludeHHIDSummary +
                                           Risk_Indicators.iid_constants.BSOptions.TurnOffTumblings +
                                           Risk_Indicators.iid_constants.BSOptions.TurnOffRelativeProperty);

END;