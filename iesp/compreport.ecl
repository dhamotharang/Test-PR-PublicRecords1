export compreport := MODULE
			
export t_CompReportRequest := record (bpsreport.t_BpsReportRequest)
end;
		
export t_CompReportResponseEx := record
	bpsreport.t_BpsReportResponse response {xpath('response')};
end;
		

end;

