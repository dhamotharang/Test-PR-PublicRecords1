EXPORT File_WorldCheck_Premium_In_Rectified := 
				PROJECT(File_WorldCheck_Premium_In, TRANSFORM(Layout_WorldCheck_Premium,
						//self.Last_Name := Latin9ToUnicode(left.Last_Name);
						//self.First_Name := Latin9ToUnicode(left.First_Name);
						self.Aliases := Latin9ToUnicode(left.Aliases);
						self.Low_Quality_Aliases := Latin9ToUnicode(left.Low_Quality_Aliases);
						self.Alternate_Spelling := Latin9ToUnicode(left.Alternate_Spelling);
						//self.Companies := Latin9ToUnicode(left.Companies);
						self := LEFT)
				);