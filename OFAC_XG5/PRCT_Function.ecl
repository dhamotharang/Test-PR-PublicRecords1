/* This function is used only in the PRCT environment. This function substitutes for the data that would normally be received from the Bridger gateway as PRCT
is not capable of making gateway calls. It uses a key to return a similar looking result to Gateway.SoapCall_BridgerSSXG5 when it is used to soapcall to Bridger. 
This function can never be used on the Boca side as it will be pointing at an empty key and no results will ever return. */

import dx_demowatchlistscreening, iesp, STD;

export PRCT_Function (DATASET(iesp.WsSearchCore.t_SearchRequest) searchReq) := FUNCTION
                                        

iesp.WsSearchCore.t_SearchResponse WatchlistTransform (iesp.WsSearchCore.t_SearchRequest le, recordof(dx_demowatchlistscreening.key_matches_entity_name) ri):= transform
          self.SearchResult :=	project(ri, transform(iesp.WsSearchCore.t_SearchResults,
          
                                        self.BlockID := 1;
                                        self.EntityRecords := project(left, transform(iesp.WsSearchCore.t_ResultEntityRecord,
                                                                      
                                                                      
                                                                      self.InputRecord.ID := le.Input.EntityRecords[1].ID;
                                                                      self.InputRecord.EntityType := ri.Input_Record_Entity_Type;
                                                                      self.InputRecord.Name.Full := ri.Input_Record_Name_Full;
                                                                      self.InputRecord.Name.Title := ri.Input_Record_Name_Title;
                                                                      self.InputRecord.Name.First := ri.Input_Record_Name_First;
                                                                      self.InputRecord.Name.Middle := ri.Input_Record_Name_Middle;
                                                                      self.InputRecord.Name.Last := ri.Input_Record_Name_Last;
                                                                      self.InputRecord.Name.Generation := ri.Input_Record_Name_Generation;
                                                                      
                                                                      self.Matches := project(left, transform(iesp.WsSearchCore.t_ResultMatch,
                                                                      
                                                                      self.Address.BestInputID := (integer)ri.Matches_Address_Best_Input_ID;
                                                                      self.Address.BestListID := (integer)ri.Matches_Address_Best_List_ID;
                                                                      
                                                                                              Address1 := Project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityAddress,
                                                                                                                  self.ID := (integer)ri.Matches_Address_Address_Details_ID_1;
                                                                                                                  self._Type := (integer)ri.Matches_Address_Address_Details_Type_1;
                                                                                                                  self.FullAddress := ri.Matches_Address_Address_Details_Full_Address_1;
                                                                                                                  self.StreetAddress1 := ri.Matches_Address_Address_Details_Street_Address1_1;
                                                                                                                  self.StreetAddress2 := ri.Matches_Address_Address_Details_Street_Address2_1;
                                                                                                                  self.City := ri.Matches_Address_Address_Details_City_1;
                                                                                                                  self.State := ri.Matches_Address_Address_Details_State_1;
                                                                                                                  self.PostalCode := ri.Matches_Address_Address_Details_Postal_Code_1;
                                                                                                                  self.Country := ri.Matches_Address_Address_Details_Country_1;
                                                                                                                  self.Notes := ri.Matches_Address_Address_Details_Notes_1;
                                                                                                                  ));
                                                                                                                  
                                                                                             Address2 := Project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityAddress,
                                                                                                                  self.ID := (integer)ri.Matches_Address_Address_Details_ID_2;
                                                                                                                  self._Type := (integer)ri.Matches_Address_Address_Details_Type_2;
                                                                                                                  self.FullAddress := ri.Matches_Address_Address_Details_Full_Address_2;
                                                                                                                  self.StreetAddress1 := ri.Matches_Address_Address_Details_Street_Address1_2;
                                                                                                                  self.StreetAddress2 := ri.Matches_Address_Address_Details_Street_Address2_2;
                                                                                                                  self.City := ri.Matches_Address_Address_Details_City_2;
                                                                                                                  self.State := ri.Matches_Address_Address_Details_State_2;
                                                                                                                  self.PostalCode := ri.Matches_Address_Address_Details_Postal_Code_2;
                                                                                                                  self.Country := ri.Matches_Address_Address_Details_Country_2;
                                                                                                                  self.Notes := ri.Matches_Address_Address_Details_Notes_2;
                                                                                                                  ));
                                                                                                                  
                                                                                            Address3 := Project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityAddress,
                                                                                                                  self.ID := (integer)ri.Matches_Address_Address_Details_ID_3;
                                                                                                                  self._Type := (integer)ri.Matches_Address_Address_Details_Type_3;
                                                                                                                  self.FullAddress := ri.Matches_Address_Address_Details_Full_Address_3;
                                                                                                                  self.StreetAddress1 := ri.Matches_Address_Address_Details_Street_Address1_3;
                                                                                                                  self.StreetAddress2 := ri.Matches_Address_Address_Details_Street_Address2_3;
                                                                                                                  self.City := ri.Matches_Address_Address_Details_City_3;
                                                                                                                  self.State := ri.Matches_Address_Address_Details_State_3;
                                                                                                                  self.PostalCode := ri.Matches_Address_Address_Details_Postal_Code_3;
                                                                                                                  self.Country := ri.Matches_Address_Address_Details_Country_3;
                                                                                                                  self.Notes := ri.Matches_Address_Address_Details_Notes_3;
                                                                                                                  ));
                                                                                                                  
                                                                                           Address4 := Project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityAddress,
                                                                                                                  self.ID := (integer)ri.Matches_Address_Address_Details_ID_4;
                                                                                                                  self._Type := (integer)ri.Matches_Address_Address_Details_Type_4;
                                                                                                                  self.FullAddress := ri.Matches_Address_Address_Details_Full_Address_4;
                                                                                                                  self.StreetAddress1 := ri.Matches_Address_Address_Details_Street_Address1_4;
                                                                                                                  self.StreetAddress2 := ri.Matches_Address_Address_Details_Street_Address2_4;
                                                                                                                  self.City := ri.Matches_Address_Address_Details_City_4;
                                                                                                                  self.State := ri.Matches_Address_Address_Details_State_4;
                                                                                                                  self.PostalCode := ri.Matches_Address_Address_Details_Postal_Code_4;
                                                                                                                  self.Country := ri.Matches_Address_Address_Details_Country_4;
                                                                                                                  self.Notes := ri.Matches_Address_Address_Details_Notes_4;
                                                                                                                  ));
                                                                                                                  
                                                                                          Address5 := Project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityAddress,
                                                                                                                  self.ID := (integer)ri.Matches_Address_Address_Details_ID_5;
                                                                                                                  self._Type := (integer)ri.Matches_Address_Address_Details_Type_5;
                                                                                                                  self.FullAddress := ri.Matches_Address_Address_Details_Full_Address_5;
                                                                                                                  self.StreetAddress1 := ri.Matches_Address_Address_Details_Street_Address1_5;
                                                                                                                  self.StreetAddress2 := ri.Matches_Address_Address_Details_Street_Address2_5;
                                                                                                                  self.City := ri.Matches_Address_Address_Details_City_5;
                                                                                                                  self.State := ri.Matches_Address_Address_Details_State_5;
                                                                                                                  self.PostalCode := ri.Matches_Address_Address_Details_Postal_Code_5;
                                                                                                                  self.Country := ri.Matches_Address_Address_Details_Country_5;
                                                                                                                  self.Notes := ri.Matches_Address_Address_Details_Notes_5;
                                                                                                                  ));
                                                                                                                  
                                                                                              AddressDetails := Address1 + Address2 + Address3 + Address4 + Address5;
                                                                                              self.Address.AddressDetails := AddressDetails(FullAddress <> '' or StreetAddress1 <> '' or City <> '' or State <> '' or Country <> '' or Notes <> '');
                                                                                              
                                                                                              self.Country.Best := ri.Matches_Country_Best;
                                                                                              self.Country.BestID := (integer)ri.Matches_Country_Best_ID;
                                                                                              self.Country.BestScore := (integer)ri.Matches_Country_Best_Score;
                                                                                              self.Country.BestType := ri.Matches_Country_Best_Type;
                                                                                              self.Country.Conflict := (boolean)ri.Matches_Country_Conflict;
                                                                                              self.Country.InputInstance := (integer)ri.Matches_Country_Input_Instance;
                                                                                              self.Country.InputType := ri.Matches_Country_Input_Type;
                                                                                      
                                                                                              self.Entity.EntityDetails.CheckSum := (integer)ri.Matches_Entity_Entity_Details_Check_Sum;
                                                                                              self.Entity.EntityDetails.Country := ri.Matches_Entity_Entity_Details_Country;
                                                                                              self.Entity.EntityDetails.Date := ri.Matches_Entity_Entity_Details_Date;
                                                                                              self.Entity.EntityDetails.Gender := ri.Matches_Entity_Entity_Details_Gender;
                                                                                              self.Entity.EntityDetails.Name.Full  := ri.Matches_Entity_Entity_Details_Name_Full;
                                                                                              self.Entity.EntityDetails.Name.Title  := ri.Matches_Entity_Entity_Details_Name_Title;
                                                                                              self.Entity.EntityDetails.Name.First  := ri.Matches_Entity_Entity_Details_Name_First;
                                                                                              self.Entity.EntityDetails.Name.Middle  := ri.Matches_Entity_Entity_Details_Name_Middle;
                                                                                              self.Entity.EntityDetails.Name.Last  := ri.Matches_Entity_Entity_Details_Name_Last;
                                                                                              self.Entity.EntityDetails.Name.Generation  := ri.Matches_Entity_Entity_Details_Name_Generation;
                                                                                              self.Entity.EntityDetails.Notes := ri.Matches_Entity_Entity_Details_Notes;
                                                                                              self.Entity.EntityDetails.Number := ri.Matches_Entity_Entity_Details_Number;
                                                                                              self.Entity.EntityDetails.Reason := ri.Matches_Entity_Entity_Details_Reason;
                                                                                              self.Entity.EntityDetails._Type := (integer)ri.Matches_Entity_Entity_Details_Type;
                                                                                              self.Entity.EntityUniqueID := ri.Matches_Entity_Entity_Unique_ID;
                                                                                              self.Entity.SearchCriteria := ri.Matches_Entity_Search_Criteria;
                                                                                              self.Entity.Name := ri.Matches_Entity_Name_Unicode;
                                                                                              self.Entity.Score := (integer)ri.Matches_Entity_Score;
                                                                                                                                                                                        
                                                                                              self.File.Build := ri.Matches_File_Build;
                                                                                              self.File.Custom := (boolean)ri.Matches_File_Custom;
                                                                                              self.File.ID := (integer)ri.Matches_File_ID;
                                                                                              self.File.Index := (integer)ri.Matches_File_Index;
                                                                                              self.File.Name := ri.Matches_File_Name;
                                                                                              self.File.Published := ri.Matches_File_Published;
                                                                                              self.File._Type := ri.Matches_File_Type;
                                                                                              
                                                                                              
                                                                                          IdentificationDetails := Project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityID,
                                                                                                                          self.ID := (integer)ri.Matches_ID_Identification_Details_ID;
                                                                                                                          self._Type := (integer)ri.Matches_ID_Identification_Details_Type;
                                                                                                                          self.Label := ri.Matches_ID_Identification_Details_Label;
                                                                                                                          self.Number := ri.Matches_ID_Identification_Details_Number;
                                                                                                                          self.Issuer := ri.Matches_ID_Identification_Details_Issuer;
                                                                                                                          self.IssueDate := ri.Matches_ID_Identification_Details_Issue_Date;
                                                                                                                          self.ExpDate := ri.Matches_ID_Identification_Details_Exp_Date;
                                                                                                                          self.Notes := ri.Matches_ID_Identification_Details_Notes;
                                                                                                                          ));
                                                                                                                          
                                                                                         self.Name.AddressInputInstance := (integer)ri.Matches_Name_Address_Input_Instance;
                                                                                         self.Name.Best := ri.Matches_Name_Best;
                                                                                         self.Name.BestScore := (integer)ri.Matches_Name_Best_Score;
                                                                                         self.Name.IndexMatch := (boolean)ri.Matches_Name_Index_Match;                                
                                                                                         self.Name.AltNames := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityValue,
                                                                                                                        self.ID := (integer)ri.Matches_Name_Alt_Names_ID;
                                                                                                                        self.Value := ri.Matches_Name_Alt_Names_Value;
                                                                                                                        ));
                                                                                              
                                                                                              AKAs1 := Project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityAKA,
                                                                                                               self.Full := ri.Matches_Name_AKAs_Full_1;
                                                                                                               self.Title := ri.Matches_Name_AKAs_Title_1;
                                                                                                               self.First := ri.Matches_Name_AKAs_First_1;
                                                                                                               self.Middle := ri.Matches_Name_AKAs_Middle_1;
                                                                                                               self.Last := ri.Matches_Name_AKAs_Last_1;
                                                                                                               self.Generation := ri.Matches_Name_AKAs_Generation_1;
                                                                                                               self.ID := (integer)ri.Matches_Name_AKAs_ID_1;
                                                                                                               self._Type := (integer)ri.Matches_Name_AKAs_Type_1;
                                                                                                               self.Category := (integer)ri.Matches_Name_AKAs_Category_1;
                                                                                                               self.Notes := ri.Matches_Name_AKAs_Notes_1;
                                                                                                               ));
                                                                                                               
                                                                                             AKAs2 := Project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityAKA,
                                                                                                               self.Full := ri.Matches_Name_AKAs_Full_2;
                                                                                                               self.Title := ri.Matches_Name_AKAs_Title_2;
                                                                                                               self.First := ri.Matches_Name_AKAs_First_2;
                                                                                                               self.Middle := ri.Matches_Name_AKAs_Middle_2;
                                                                                                               self.Last := ri.Matches_Name_AKAs_Last_2;
                                                                                                               self.Generation := ri.Matches_Name_AKAs_Generation_2;
                                                                                                               self.ID := (integer)ri.Matches_Name_AKAs_ID_2;
                                                                                                               self._Type := (integer)ri.Matches_Name_AKAs_Type_2;
                                                                                                               self.Category := (integer)ri.Matches_Name_AKAs_Category_2;
                                                                                                               self.Notes := ri.Matches_Name_AKAs_Notes_2;
                                                                                                               ));
                                                                                                               
                                                                                             AKAs3 := Project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityAKA,
                                                                                                               self.Full := ri.Matches_Name_AKAs_Full_3;
                                                                                                               self.Title := ri.Matches_Name_AKAs_Title_3;
                                                                                                               self.First := ri.Matches_Name_AKAs_First_3;
                                                                                                               self.Middle := ri.Matches_Name_AKAs_Middle_3;
                                                                                                               self.Last := ri.Matches_Name_AKAs_Last_3;
                                                                                                               self.Generation := ri.Matches_Name_AKAs_Generation_3;
                                                                                                               self.ID := (integer)ri.Matches_Name_AKAs_ID_3;
                                                                                                               self._Type := (integer)ri.Matches_Name_AKAs_Type_3;
                                                                                                               self.Category := (integer)ri.Matches_Name_AKAs_Category_3;
                                                                                                               self.Notes := ri.Matches_Name_AKAs_Notes_3;
                                                                                                               ));
                                                                                                               
                                                                                            AKAs4 := Project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityAKA,
                                                                                                               self.Full := ri.Matches_Name_AKAs_Full_4;
                                                                                                               self.Title := ri.Matches_Name_AKAs_Title_4;
                                                                                                               self.First := ri.Matches_Name_AKAs_First_4;
                                                                                                               self.Middle := ri.Matches_Name_AKAs_Middle_4;
                                                                                                               self.Last := ri.Matches_Name_AKAs_Last_4;
                                                                                                               self.Generation := ri.Matches_Name_AKAs_Generation_4;
                                                                                                               self.ID := (integer)ri.Matches_Name_AKAs_ID_4;
                                                                                                               self._Type := (integer)ri.Matches_Name_AKAs_Type_4;
                                                                                                               self.Category := (integer)ri.Matches_Name_AKAs_Category_4;
                                                                                                               self.Notes := ri.Matches_Name_AKAs_Notes_4;
                                                                                                               ));
                                                                                                               
                                                                                           AKAs5 := Project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityAKA,
                                                                                                               self.Full := ri.Matches_Name_AKAs_Full_5;
                                                                                                               self.Title := ri.Matches_Name_AKAs_Title_5;
                                                                                                               self.First := ri.Matches_Name_AKAs_First_5;
                                                                                                               self.Middle := ri.Matches_Name_AKAs_Middle_5;
                                                                                                               self.Last := ri.Matches_Name_AKAs_Last_5;
                                                                                                               self.Generation := ri.Matches_Name_AKAs_Generation_5;
                                                                                                               self.ID := (integer)ri.Matches_Name_AKAs_ID_5;
                                                                                                               self._Type := (integer)ri.Matches_Name_AKAs_Type_5;
                                                                                                               self.Category := (integer)ri.Matches_Name_AKAs_Category_5;
                                                                                                               self.Notes := ri.Matches_Name_AKAs_Notes_5;
                                                                                                               ));
                                                                                                               
                                                                                          AKAs6 := Project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityAKA,
                                                                                                               self.Full := ri.Matches_Name_AKAs_Full_6;
                                                                                                               self.Title := ri.Matches_Name_AKAs_Title_6;
                                                                                                               self.First := ri.Matches_Name_AKAs_First_6;
                                                                                                               self.Middle := ri.Matches_Name_AKAs_Middle_6;
                                                                                                               self.Last := ri.Matches_Name_AKAs_Last_6;
                                                                                                               self.Generation := ri.Matches_Name_AKAs_Generation_6;
                                                                                                               self.ID := (integer)ri.Matches_Name_AKAs_ID_6;
                                                                                                               self._Type := (integer)ri.Matches_Name_AKAs_Type_6;
                                                                                                               self.Category := (integer)ri.Matches_Name_AKAs_Category_6;
                                                                                                               self.Notes := ri.Matches_Name_AKAs_Notes_6;
                                                                                                               ));
                                                                                                               
                                                                                         AKAs7 := Project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityAKA,
                                                                                                               self.Full := ri.Matches_Name_AKAs_Full_7;
                                                                                                               self.Title := ri.Matches_Name_AKAs_Title_7;
                                                                                                               self.First := ri.Matches_Name_AKAs_First_7;
                                                                                                               self.Middle := ri.Matches_Name_AKAs_Middle_7;
                                                                                                               self.Last := ri.Matches_Name_AKAs_Last_7;
                                                                                                               self.Generation := ri.Matches_Name_AKAs_Generation_7;
                                                                                                               self.ID := (integer)ri.Matches_Name_AKAs_ID_7;
                                                                                                               self._Type := (integer)ri.Matches_Name_AKAs_Type_7;
                                                                                                               self.Category := (integer)ri.Matches_Name_AKAs_Category_7;
                                                                                                               self.Notes := ri.Matches_Name_AKAs_Notes_7;
                                                                                                               ));
                                                                                                               
                                                                                        AKAs8 := Project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityAKA,
                                                                                                               self.Full := ri.Matches_Name_AKAs_Full_8;
                                                                                                               self.Title := ri.Matches_Name_AKAs_Title_8;
                                                                                                               self.First := ri.Matches_Name_AKAs_First_8;
                                                                                                               self.Middle := ri.Matches_Name_AKAs_Middle_8;
                                                                                                               self.Last := ri.Matches_Name_AKAs_Last_8;
                                                                                                               self.Generation := ri.Matches_Name_AKAs_Generation_8;
                                                                                                               self.ID := (integer)ri.Matches_Name_AKAs_ID_8;
                                                                                                               self._Type := (integer)ri.Matches_Name_AKAs_Type_8;
                                                                                                               self.Category := (integer)ri.Matches_Name_AKAs_Category_8;
                                                                                                               self.Notes := ri.Matches_Name_AKAs_Notes_8;
                                                                                                               ));
                                                                                                               
                                                                                       AKAs9 := Project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityAKA,
                                                                                                               self.Full := ri.Matches_Name_AKAs_Full_9;
                                                                                                               self.Title := ri.Matches_Name_AKAs_Title_9;
                                                                                                               self.First := ri.Matches_Name_AKAs_First_9;
                                                                                                               self.Middle := ri.Matches_Name_AKAs_Middle_9;
                                                                                                               self.Last := ri.Matches_Name_AKAs_Last_9;
                                                                                                               self.Generation := ri.Matches_Name_AKAs_Generation_9;
                                                                                                               self.ID := (integer)ri.Matches_Name_AKAs_ID_9;
                                                                                                               self._Type := (integer)ri.Matches_Name_AKAs_Type_9;
                                                                                                               self.Category := (integer)ri.Matches_Name_AKAs_Category_9;
                                                                                                               self.Notes := ri.Matches_Name_AKAs_Notes_9;
                                                                                                               ));
                                                                                                               
                                                                                      AKAs10 := Project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityAKA,
                                                                                                               self.Full := ri.Matches_Name_AKAs_Full_10;
                                                                                                               self.Title := ri.Matches_Name_AKAs_Title_10;
                                                                                                               self.First := ri.Matches_Name_AKAs_First_10;
                                                                                                               self.Middle := ri.Matches_Name_AKAs_Middle_10;
                                                                                                               self.Last := ri.Matches_Name_AKAs_Last_10;
                                                                                                               self.Generation := ri.Matches_Name_AKAs_Generation_10;
                                                                                                               self.ID := (integer)ri.Matches_Name_AKAs_ID_10;
                                                                                                               self._Type := (integer)ri.Matches_Name_AKAs_Type_10;
                                                                                                               self.Category := (integer)ri.Matches_Name_AKAs_Category_10;
                                                                                                               self.Notes := ri.Matches_Name_AKAs_Notes_10;
                                                                                                               ));
                                                                                              
                                                                                              AKAS := AKAs1 + AKAs2 + AKAs3 + AKAs4 + AKAs5 + AKAs6 + AKAs7 + AKAs8 + AKAs9 + AKAs10;
                                                                                              
                                                                                              self.Name.AKAs := AKAS( Full <> '' or First <> '' or Middle <> '' or Last <> '' or Notes <> '');
                                                                                              

                                                                                   PhoneDetails := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityPhone,
                                                                                                           self.ID := (integer)ri.Matches_Phone_Phone_Details_ID;
                                                                                                           self._Type := (integer)ri.Matches_Phone_Phone_Details_Type;
                                                                                                           self.Number := ri.Matches_Phone_Phone_Details_Number;
                                                                                                           self.Notes := ri.Matches_Phone_Phone_Details_Notes;
                                                                                                           ));
                                                                                               
                                                                                              Codes1 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityValue,
                                                                                                                self.ID := (integer)ri.Matches_Codes_ID_1;
                                                                                                                self.Value := ri.Matches_Codes_Value_1;
                                                                                                                   ));                                                                                              
                                                                                              Codes2 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityValue,
                                                                                                                self.ID := (integer)ri.Matches_Codes_ID_2;
                                                                                                                self.Value := ri.Matches_Codes_Value_2;
                                                                                                                   ));                                                                                              
                                                                                              Codes3 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityValue,
                                                                                                                self.ID := (integer)ri.Matches_Codes_ID_3;
                                                                                                                self.Value := ri.Matches_Codes_Value_3;
                                                                                                                   ));                                                                                              
                                                                                              Codes4 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityValue,
                                                                                                                self.ID := (integer)ri.Matches_Codes_ID_4;
                                                                                                                self.Value := ri.Matches_Codes_Value_4; 
                                                                                                                   ));
                                                                                              Codes5 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityValue,
                                                                                                                self.ID := (integer)ri.Matches_Codes_ID_5;
                                                                                                                self.Value := ri.Matches_Codes_Value_5;
                                                                                                                   ));
                                                                                              Codes := Codes1 + Codes2 + Codes3 + Codes4 + Codes5;
                                                                                              
                                                                                              self.Codes := Codes(Value <> '');
                                                                                              
                                                                                              Terms1 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityValue,
                                                                                                                self.ID := (integer)ri.Matches_Terms_ID_1;
                                                                                                                self.Value := ri.Matches_Terms_Values_1;
                                                                                                                   ));                                                                                              
                                                                                              Terms2 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityValue,
                                                                                                                self.ID := (integer)ri.Matches_Terms_ID_2;
                                                                                                                self.Value := ri.Matches_Terms_Values_2;
                                                                                                                   ));                                                                                              
                                                                                              Terms3 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityValue,
                                                                                                                self.ID := (integer)ri.Matches_Terms_ID_3;
                                                                                                                self.Value := ri.Matches_Terms_Values_3;
                                                                                                                   ));                                                                                              
                                                                                              Terms4 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityValue,
                                                                                                                self.ID := (integer)ri.Matches_Terms_ID_4;
                                                                                                                self.Value := ri.Matches_Terms_Values_4; 
                                                                                                                )); 
                                                                                              Terms5 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityValue,
                                                                                                                self.ID := (integer)ri.Matches_Terms_ID_5;
                                                                                                                self.Value := ri.Matches_Terms_Values_5;
                                                                                                                   ));
                                                                                              Terms := Terms1 + Terms2 + Terms3 + Terms4 + Terms5;
                                                                                              
                                                                                              self.Terms := Terms(Value <> '');
                                                                                              
                                                                                              Cities1 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityValue,
                                                                                                                self.ID := (integer)ri.Matches_Cities_ID_1;
                                                                                                                self.Value := ri.Matches_Cities_Value_1;
                                                                                                                   ));                                                                                              
                                                                                              Cities2 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityValue,
                                                                                                                self.ID := (integer)ri.Matches_Cities_ID_2;
                                                                                                                self.Value := ri.Matches_Cities_Value_2;
                                                                                                                   ));                                                                                              
                                                                                              Cities3 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityValue,
                                                                                                                self.ID := (integer)ri.Matches_Cities_ID_3;
                                                                                                                self.Value := ri.Matches_Cities_Value_3;
                                                                                                                   ));                                                                                              
                                                                                              Cities4 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityValue,
                                                                                                                self.ID := (integer)ri.Matches_Cities_ID_4;
                                                                                                                self.Value := ri.Matches_Cities_Value_4; 
                                                                                                                )); 
                                                                                              Cities5 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityValue,
                                                                                                                self.ID := (integer)ri.Matches_Cities_ID_5;
                                                                                                                self.Value := ri.Matches_Cities_Value_5;
                                                                                                                   ));
                                                                                              Cities := Cities1 + Cities2 + Cities3 + Cities4 + Cities5;
                                                                                              
                                                                                              self.Cities := Cities(Value <> '');
                                                                                              
                                                                                             Ports1 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityValue,
                                                                                                                self.ID := (integer)ri.Matches_Ports_ID_1;
                                                                                                                self.Value := ri.Matches_Ports_Value_1;
                                                                                                                   ));                                                                                              
                                                                                              Ports2 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityValue,
                                                                                                                self.ID := (integer)ri.Matches_Ports_ID_2;
                                                                                                                self.Value := ri.Matches_Ports_Value_2;
                                                                                                                   ));                                                                                              
                                                                                              Ports3 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityValue,
                                                                                                                self.ID := (integer)ri.Matches_Ports_ID_3;
                                                                                                                self.Value := ri.Matches_Ports_Value_3;
                                                                                                                   ));                                                                                              
                                                                                              Ports4 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityValue,
                                                                                                                self.ID := (integer)ri.Matches_Ports_ID_4;
                                                                                                                self.Value := ri.Matches_Ports_Value_4; 
                                                                                                                )); 
                                                                                              Ports5 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityValue,
                                                                                                                self.ID := (integer)ri.Matches_Ports_ID_5;
                                                                                                                self.Value := ri.Matches_Ports_Value_5;
                                                                                                                   ));
                                                                                              Ports := Ports1 + Ports2 + Ports3 + Ports4 + Ports5;
                                                                                              
                                                                                              self.Ports := Ports(Value <> '');
                                                                                              
                                                                                              Descriptions1 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityDescription,
                                                                                                                self.ID := (integer)ri.Matches_Descriptions_ID_1;
                                                                                                                self._Type := (integer)ri.Matches_Descriptions_Type_1;
                                                                                                                self.Value := ri.Matches_Descriptions_Value_1;
                                                                                                                self.Notes := ri.Matches_Descriptions_Notes_1;
                                                                                                                   ));                                                                                                 
                                                                                              Descriptions2 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityDescription,
                                                                                                                self.ID := (integer)ri.Matches_Descriptions_ID_2;
                                                                                                                self._Type := (integer)ri.Matches_Descriptions_Type_2;
                                                                                                                self.Value := ri.Matches_Descriptions_Value_2;
                                                                                                                self.Notes := ri.Matches_Descriptions_Notes_2;
                                                                                                                   ));
                                                                                              Descriptions3 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityDescription,
                                                                                                                self.ID := (integer)ri.Matches_Descriptions_ID_3;
                                                                                                                self._Type := (integer)ri.Matches_Descriptions_Type_3;
                                                                                                                self.Value := ri.Matches_Descriptions_Value_3;
                                                                                                                self.Notes := ri.Matches_Descriptions_Notes_3;
                                                                                                                   ));
                                                                                              Descriptions4 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityDescription,
                                                                                                                self.ID := (integer)ri.Matches_Descriptions_ID_4;
                                                                                                                self._Type := (integer)ri.Matches_Descriptions_Type_4;
                                                                                                                self.Value := ri.Matches_Descriptions_Value_4;
                                                                                                                self.Notes := ri.Matches_Descriptions_Notes_4;
                                                                                                                   ));
                                                                                              Descriptions5 := project(left, transform(iesp.WsSearchCore.t_ResultMatchEntityDescription,
                                                                                                                self.ID := (integer)ri.Matches_Descriptions_ID_5;
                                                                                                                self._Type := (integer)ri.Matches_Descriptions_Type_5;
                                                                                                                self.Value := ri.Matches_Descriptions_Value_5;
                                                                                                                self.Notes := ri.Matches_Descriptions_Notes_5;
                                                                                                                   ));
                                                                                                                   
                                                                                          Descriptions := Descriptions1 + Descriptions2 + Descriptions3 + Descriptions4 + Descriptions5;
                                                                                          
                                                                                          self.Descriptions := Descriptions(Value <> '' or Notes <> '');
                                                                                              
                                                                                              
                                                                                              self := [];
                                                                                              ));
                                                                      self := [];
                                                                      ));
                                                                      

                                        self := [];
                                        )); 
  
  END;
  

Key_SearchResponse :=
join(searchReq, dx_demowatchlistscreening.key_matches_entity_name, KEYED(STD.Uni.ToUpperCase(left.Input.EntityRecords[1].Name.Full) = right.matches_entity_name or STD.Uni.ToUpperCase(left.Input.EntityRecords[1].Name.First + ' ' + if(left.Input.EntityRecords[1].Name.Middle = '', '', left.Input.EntityRecords[1].Name.Middle + ' ' )+ left.Input.EntityRecords[1].Name.Last) = right.matches_entity_name)  and right.matches_file_name IN SET(left.Config.DataFiles, Name),
WatchlistTransform(left,right));

return Key_SearchResponse;

END;
