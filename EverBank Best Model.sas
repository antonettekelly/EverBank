/*---------------------------------------------------------
  The options statement below should be placed
  before the data step when submitting this code.
---------------------------------------------------------*/
options VALIDMEMNAME=EXTEND VALIDVARNAME=ANY;


/*---------------------------------------------------------
  Before this code can run you need to fill in all the
  macro variables below.
---------------------------------------------------------*/
/*---------------------------------------------------------
  Start Macro Variables
---------------------------------------------------------*/
%let SOURCE_HOST=<Hostname>; /* The host name of the CAS server */
%let SOURCE_PORT=<Port>; /* The port of the CAS server */
%let SOURCE_LIB=<Library>; /* The CAS library where the source data resides */
%let SOURCE_DATA=<Tablename>; /* The CAS table name of the source data */
%let DEST_LIB=<Library>; /* The CAS library where the destination data should go */
%let DEST_DATA=<Tablename>; /* The CAS table name where the destination data should go */

/* Open a CAS session and make the CAS libraries available */
options cashost="&SOURCE_HOST" casport=&SOURCE_PORT;
cas mysess;
caslib _all_ assign;

/* Load ASTOREs into CAS memory */
proc casutil;
  Load casdata="00000051428-Kelly Mae Student UAS IS429 #C Best Model.sashdat" incaslib="Models" casout="00000051428-Kelly Mae Student UAS IS429 #C Best Model" outcaslib="casuser" replace;
Quit;

/* Apply the model */
proc cas;
  fcmpact.runProgram /
  inputData={caslib="&SOURCE_LIB" name="&SOURCE_DATA"}
  outputData={caslib="&DEST_LIB" name="&DEST_DATA" replace=1}
  routineCode = "

   /*------------------------------------------
   Generated SAS Scoring Code
     Date             : 09Jun2022:12:00:19
     Locale           : en_US
     Model Type       : Gradient Boosting
     Class variable   : contact
     Class variable   : day_of_week
     Class variable   : default
     Class variable   : education
     Class variable   : housing
     Class variable   : loan
     Class variable   : job
     Class variable   : month
     Class variable   : poutcome
     Class variable   : y
     Response variable: y
     ------------------------------------------*/
declare object 00000051428-Kelly Mae Student UAS IS429 #C Best Model(astore);
call 00000051428-Kelly Mae Student UAS IS429 #C Best Model.score('CASUSER','00000051428-Kelly Mae Student UAS IS429 #C Best Model');
   /*------------------------------------------*/
   /*_VA_DROP*/ drop 'I_y'n 'P_yNo'n 'P_yYes'n;
length 'I_y_9556'n $3;
      'I_y_9556'n='I_y'n;
'P_yNo_9556'n='P_yNo'n;
'P_yYes_9556'n='P_yYes'n;
   /*------------------------------------------*/
";

run;
Quit;

/* Persist the output table */
proc casutil;
  Save casdata="&DEST_DATA" incaslib="&DEST_LIB" casout="&DEST_DATA%str(.)sashdat" outcaslib="&DEST_LIB" replace;
Quit;
