   /*--SOAP--
<message name="SmallBusinessDataInvestigationReportService" wuTimeout="300000">
	<part name="SmallBusinessDataInvestigationReportRequest" type="tns:XmlDataSet" cols="110" rows="75"/>
</message>
*/

IMPORT AutoStandardI, BIPV2, IESP;

EXPORT SmallBizDataInvestigationReportService := 

  MACRO 
    /* ************************************************************************
     *                      About this Service                                *
     * Small Business Advocacy Center â€“ Data Investigation Process            *
     * The SBFE Certified Vendor License Agreement requires LNRS to support   *
     * the SBFE Universal Data Correction (UDC) Program, under which          *
     * â€œâ€¦small businesses, Owners and Guarantors have the ability to report   *
     * inaccuracies reflected on credit risk products.â€                       *
     *                                                                        *
     * If a small business feels that the data used in the credit decision is *
     * inaccurate, it may call the LexisNexis Small Business Advocacy Center  *
     * (SBAC) to request an investigation of the credit data.                 *
     *                                                                        *
     * If the data used in the credit decision comes from LN, the SBAC will   *
     * initiate an internal LN process to investigate the data in question,   *
     * and any issues affecting the accuracy of the reported data.            *
     *                                                                        *
     * This service outputs the raw Bankruptcy and Liens records from the     *
     * keys for the SBAC certer to generate a report that the customer can    *
     * dispute.                                                               *
     *                                                                        *
     * If the customer proves the data is incorrect, the SBAC will then work  *
     * have the records removed from the keys                                 *
     ************************************************************************ */
     
    /* ************************************************************************
     *                      WsECL                                             *
     ************************************************************************ */
    #WEBSERVICE(FIELDS('SmallBusinessDataInvestigationReportRequest'),HELP(DataInvestigation_Services.Constants.ROXIE_INFO));
    
    /* ************************************************************************
     *             Get the IESP service inputs                                *
     ************************************************************************ */  
    requestIn := DATASET([], iesp.smallbusinessdatainvestigation.t_SmallBusinessDataInvestigationReportRequest) : STORED('SmallBusinessDataInvestigationReportRequest', FEW);
    firstRow  := requestIn[1] : INDEPENDENT; // Since this is realtime and not batch, should only have one row on input.
    reportBy  := GLOBAL(firstRow.ReportBy);
    options   := GLOBAL(firstRow.Options);
    iesp.ECL2ESP.SetInputBaseRequest (firstRow);

    BIPV2.IDlayouts.l_xlink_ids2 initialize() := 
      TRANSFORM
        SELF.DotID  := reportBy.BusinessIds.DotId;
        SELF.EmpID  := reportBy.BusinessIds.EmpId;
        SELF.PowID  := reportBy.BusinessIds.PowId;
        SELF.ProxID := reportBy.BusinessIds.ProxId;
        SELF.SeleID := reportBy.BusinessIds.SeleId;
        SELF.OrgID  := reportBy.BusinessIds.OrgId;
        SELF.UltID  := reportBy.BusinessIds.UltId;     
      END;

    LinkIds := DATASET([initialize()]);
	  
    /* ************************************************************************
	   *                 Create Input module                                    *
	   **************************************************************************/
    
    NonFCRA_RawDataService_inmod := 
      MODULE (DataInvestigation_Services.IParam.DataInvestigationRawReport_IParams);
        EXPORT DATASET (BIPV2.IDlayouts.l_xlink_ids2) BusinessIds := LinkIds;
        EXPORT STRING1  FetchLevel := IF(options.BusinessIdFetchLevel = '', BIPV2.IDconstants.Fetch_Level_SELEID,options.BusinessIdFetchLevel) ;
      END;
    
    ds_KeyResults := DataInvestigation_Services.SmallBizDataInvestigationReportService_Records(NonFCRA_RawDataService_inmod);
    
    ds_Results := 
      PROJECT(ds_KeyResults, 
        TRANSFORM(iesp.smallbusinessdatainvestigation.t_SmallBusinessDataInvestigationReportResponse, 
          SELF.InputEcho := ReportBy; // Grab the exact input from the "search" ESDL
          SELF           := LEFT;
        ));

    OUTPUT(ds_Results,   NAMED('Results')); 
     
ENDMACRO;