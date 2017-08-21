EXPORT Layouts := module

export layout_log := record
					string dataset_name;
					string version;
					string tag;
					string date_time;
					string job_name;
					string wuid;
			end;
export Report_Record	:= record
					string dataset_name;
					string version;
					string wuid;
					string14 Build_Start;
					string14 Prep_Start;
					string14 Prep_End;
					string14 Base_Start;
					string14 Base_End;
					string14 Key_Start;
					string14 Key_End;
					string14 Post_Start;
					string14 Post_End;
					string14 Build_End;
					string Build_Status;
			end;
			
export Process_Record	:=	record
				string dataset_name;
				string version;
				string packageName;
				string BuildType;
				string Build_Start;
				string Build_End;
				string Cert_Start;
				string Cert_End;
				string Processing_Days;
				string Build_Hours_Mins_Secs;
				string Deployment_Days;
				string Days_QA;
			end;
			

end;