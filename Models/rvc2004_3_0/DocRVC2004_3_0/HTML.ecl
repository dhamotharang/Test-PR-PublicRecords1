<html><head><title>Shellpoint Custom Model (previous_HE segment)</title></head><body>
<h1>Shellpoint Custom Model (previous_HE segment)(RVC2004_3_0)</h1><p>
<h2>Whole Model Information</h2>
This is a single scorecard model.</p>
<p>This model uses reason method AscendingNonZeroWithInquiry.</p>
LUCI made the following notes while compiling the .CSV: <ul>
<li>Line: 52, Severity: WARNING, Message: RC [C12] used with multiple Inds</li><li>Line: 52, Severity: WARNING, Message: RC [C13] used with multiple Inds</li><li>Line: 52, Severity: WARNING, Message: RC [Z01] used with multiple Inds</li><li>Line: 52, Severity: WARNING, Message: RC [Z03] used with multiple Inds</li>
</ul>
</body></html>
<h2>Exceptions</h2>There are also exception conditions in which the scorecards are bypassed, defined as follows:
<ul><li><b>RV5_Attr_200 - </b>
If <code>(real) ssndeceased = 1 or (real) subjectdeceased = 1</code> is true then the score is set to 200
 and a reason code of  is set.</li><li><b>RV5_Attr_222 - </b>
If <code>(real) confirmationsubjectfound = -998 or (real) confirmationsubjectfound < 1</code> is true then the score is set to 222
 and a reason code of  is set.</li></ul>
<h2>ScoreCard - SCORECARD_model13</h2>
This scorecard is a linear model.
<ul><li>The weights for each variable are computed as defined below</li><li>Combined_score is then calculated by adding the individual weights together</li>
<li>Raw_point is then calculated by adding the Combined_score to the Constant -1.78172567586037</li>
<li>The score is then processed according to the formula (700 + 20 * ((Raw_point - 0 - LN(0.049227)) / LN(2))).</li>
<li>The value is then rounded to the nearest integer.</li>
<li>If the value is less than 501 it is set to 501.</li>
<li>If the value is greater than 900 it is set to 900.</li>

<h3>Independant Variables</h3>
<p><b>CollateralStatus</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.175881297202286</td><td>Z01</td></tr><tr><td>Secured</td><td>Secured</td><td>0.175881297202286</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.175881297202286</td><td></td></tr><tr><td>Unsecured</td><td>Unsecured</td><td>-0.175769990917404</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.175881297202286</td><td>Z03</td></tr><tr><td></td><td>HIGH</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.175881297202286</td><td>Z03</td></tr>
</table></p>
<p><b>OutOfStatuteIndicator</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.517999357387536</td><td>Z01</td></tr><tr><td>N</td><td>N</td><td>0.517999357387536</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.517999357387536</td><td></td></tr><tr><td>Y</td><td>Y</td><td>-0.517699218854416</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.517999357387536</td><td>Z03</td></tr><tr><td></td><td>HIGH</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.517999357387536</td><td>Z03</td></tr>
</table></p>
<p><b>addrinputlengthofres</b> is defined in 7 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.380188696628816</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.380188696628816</td><td>C12</td></tr><tr><td>-999999999</td><td>85.5</td><td>-0.162252436093801</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.380188696628816</td><td>C13</td></tr><tr><td>85.5</td><td>175.5</td><td>-0.0744986191707646</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.380188696628816</td><td>C13</td></tr><tr><td>175.5</td><td>228.5</td><td>0.0134295817085936</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.380188696628816</td><td>C13</td></tr><tr><td>228.5</td><td>401.5</td><td>0.106913758369424</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.380188696628816</td><td>C13</td></tr><tr><td>401.5</td><td>HIGH</td><td>0.380188696628816</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.380188696628816</td><td></td></tr>
</table></p>
<p><b>addrprevioustimeoldest</b> is defined in 5 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.0766876845593337</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.0766876845593337</td><td>C12</td></tr><tr><td>-999999999</td><td>63.5</td><td>-0.243533121323617</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.0766876845593337</td><td>C13</td></tr><tr><td>63.5</td><td>293.5</td><td>0.0163999320923906</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.0766876845593337</td><td>C13</td></tr><tr><td>293.5</td><td>HIGH</td><td>0.0766876845593337</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.0766876845593337</td><td></td></tr>
</table></p>
<p><b>bankruptcycount</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.22054154165021</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.22054154165021</td><td>C12</td></tr><tr><td>-999999999</td><td>0.5</td><td>0.22054154165021</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.22054154165021</td><td></td></tr><tr><td>0.5</td><td>HIGH</td><td>-0.220487704235926</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.22054154165021</td><td>D31</td></tr>
</table></p>
<p><b>dayssince_LastPaymentDate</b> is defined in 10 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>2.78502174482666</td><td>Z01</td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>2.78502174482666</td><td></td></tr><tr><td>-999999999</td><td>20.5</td><td>2.78502174482666</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>2.78502174482666</td><td></td></tr><tr><td>20.5</td><td>22.5</td><td>2.47927717616396</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>2.78502174482666</td><td>Z06</td></tr><tr><td>22.5</td><td>31.5</td><td>2.289394242031</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>2.78502174482666</td><td>Z06</td></tr><tr><td>31.5</td><td>40.5</td><td>2.16059645912678</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>2.78502174482666</td><td>Z06</td></tr><tr><td>40.5</td><td>97.5</td><td>1.28419126267805</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>2.78502174482666</td><td>Z06</td></tr><tr><td>97.5</td><td>473</td><td>-0.801117736469187</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>2.78502174482666</td><td>Z06</td></tr><tr><td>473</td><td>1298</td><td>-1.56111814895788</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>2.78502174482666</td><td>Z06</td></tr><tr><td>1298</td><td>HIGH</td><td>-1.88830934823268</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>2.78502174482666</td><td>Z06</td></tr>
</table></p>
<p><b>derogcount</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.09127972345498</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.09127972345498</td><td>C12</td></tr><tr><td>-999999999</td><td>0.5</td><td>0.09127972345498</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.09127972345498</td><td></td></tr><tr><td>0.5</td><td>HIGH</td><td>-0.0912002663257225</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.09127972345498</td><td>D30</td></tr>
</table></p>
<p><b>inputprovidedphone</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.126065595425946</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.126065595425946</td><td>C12</td></tr><tr><td>-999999999</td><td>0.5</td><td>-0.126184162516679</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.126065595425946</td><td>F05</td></tr><tr><td>0.5</td><td>HIGH</td><td>0.126065595425946</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.126065595425946</td><td></td></tr>
</table></p>
<p><b>inquirycollections12month</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.230273226976335</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.230273226976335</td><td>C12</td></tr><tr><td>-999999999</td><td>0.5</td><td>0.230273226976335</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.230273226976335</td><td></td></tr><tr><td>0.5</td><td>HIGH</td><td>-0.230087456778504</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.230273226976335</td><td>I61</td></tr>
</table></p>

</ul>
